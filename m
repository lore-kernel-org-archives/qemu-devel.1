Received: from eggs.gnu.org ([209.51.188.92]:41365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goZx5-0006bV-GJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1goZx4-0001T3-KJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 15:25:47 -0500
MIME-Version: 1.0
References: <20181207090135.7651-1-luc.michel@greensocs.com>
	<20181207090135.7651-8-luc.michel@greensocs.com>
	<CAMo8Bf+siB=vdjK+WPKvRCqKS59OVGOcAoH0HtN6VSvFyOc9gQ@mail.gmail.com>
	<CAFEAcA9uVMs8aGTcbUpz+EGGyFBXtCNVMT-_t5eYPBjJF_4Rrw@mail.gmail.com>
In-Reply-To: <CAFEAcA9uVMs8aGTcbUpz+EGGyFBXtCNVMT-_t5eYPBjJF_4Rrw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 29 Jan 2019 12:25:34 -0800
Message-ID: <CAMo8BfL7AVGwmXnBVf_RN8eUBshv+fYrkFhgZQ5UB_4bJ8Ss0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 07/16] gdbstub: add multiprocess support
 to (f|s)ThreadInfo and ThreadExtraInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Tue, Jan 29, 2019 at 2:05 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > Starting with this commit it is no longer possible to kill QEMU
> > with the 'kill' command from the gdb. This was a nice feature,
> > was this removal intentional, or is it just an implementation
> > bug?
>
> That sounds like a bug. I think with the multiprocess extensions
> available gdb may switch from killing using the 'k' packet to using
> the 'vKill;pid' packet, which we don't implement? Looking at
> what gdb is sending ('set debug remote 1' turns on logging in
> gdb of remote protocol packets) would let us check that theory.

That's correct:

(gdb) kill
Kill the program being debugged? (y or n) y
Sending packet: $vKill;1#6e...Ack
Packet received:
Packet vKill (kill) is NOT supported
Can't kill process

> It's not clear how our implementation should deal with being asked
> to kill just one process if we have more than one, though...

I'll send a fix that restores previous behavior in case of a single
inferior process.

-- 
Thanks.
-- Max
