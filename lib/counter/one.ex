defmodule Counter.One do
  use GenServer

  def start_link(_state \\ 0) do
    IO.inspect("starting", label: "Counter.One")
    success = GenServer.start_link(__MODULE__, 0)
    IO.inspect("started", label: "Counter.One")
    success
  end

  @impl true
  def init(state) do
    work(state)
    schedule_work()
    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    work(state)
    schedule_work()
    {:noreply, state + 1}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 1000)
  end

  def work(state) do
    case state do
      22 -> raise "I'm Counter.One and I'm gonna error now"
      _ -> IO.inspect("working and my state  is #{state}", label: "Counter.One")
    end
  end
end
