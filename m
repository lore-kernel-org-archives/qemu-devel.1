Received: from eggs.gnu.org ([2001:4830:134:3::10]:56544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dY1Lt-0000uq-Vc
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dY1Lt-0006ZL-5i
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:38:10 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Thu, 20 Jul 2017 10:38:07 +0800
Message-ID: <CAOE=1Z0yXiscZWibFpUjaqZj7vK06nrWcnaWvga4B2Kw+Eta+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Why "trace event does not exist"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I want to add new trace-event and log it, so I add into $QEMU/trace-event
like this:

io_mem_init(void) ""
>

and after configure, $QEMU/build/trace-events-all also have this.
then I add code like this into $QEMU/exec.c

trace_io_mem_init();
>

then I `make` and `make install`.

But when I run `qemu-system-x86_64 -D /qemu.log -trace events=/qemu-events
...`
it warn me that:

qemu-system-x86_64:/qemu-events:1: WARNING: trace event 'io_mem_init' does
> not exist


and no io_mem_init log output. Why and what should I do to add this log?
Thank you~
