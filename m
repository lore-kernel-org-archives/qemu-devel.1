Received: from eggs.gnu.org ([2001:4830:134:3::10]:43202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eydYM-0001jm-5J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1eydYL-0006wu-2H
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:13:18 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:47091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1eydYK-0006wZ-SX
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:13:17 -0400
Received: by mail-ot0-x232.google.com with SMTP id g97-v6so5483070otg.13
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 06:13:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 21 Mar 2018 14:13:15 +0100
Message-ID: <CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

> Can you get a backtrace on the Windows system?  Perhaps by putting a
> breakpoint in aio_context_set_poll_params.
>
> Paolo

I built qemu-master RC0 with --enable-debug. This is what a bt provides:

(gdb) attach 9692
Attaching to program `c:\qemu-master\qemu-system-ppc.exe', process 9692
[New Thread 9692.0x670]
[New Thread 9692.0x238c]
[New Thread 9692.0xb94]
[New Thread 9692.0x10bc]
[New Thread 9692.0x90c]
[New Thread 9692.0x29a0]
(gdb) thread apply all bt full

Thread 6 (Thread 9692.0x29a0):
#0  0x00007ff980ec3811 in ?? ()
No symbol table info available.
#1  0x00007ff980ef020b in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 5 (Thread 9692.0x90c):
#0  0x00007ff980ebff04 in ?? ()
No symbol table info available.
#1  0x00007ff97d673b7f in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 4 (Thread 9692.0x10bc):
#0  0x00007ff980ec3794 in ?? ()
No symbol table info available.
#1  0x00007ff980e549dd in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 3 (Thread 9692.0xb94):
#0  0x00007ff980ec3794 in ?? ()
---Type <return> to continue, or q <return> to quit---
No symbol table info available.
#1  0x00007ff980e549dd in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 2 (Thread 9692.0x238c):
#0  0x00007ff980ec3794 in ?? ()
No symbol table info available.
#1  0x00007ff980e549dd in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)

Thread 1 (Thread 9692.0x670):
#0  0x00007ff980ec09d4 in ?? ()
No symbol table info available.
#1  0x00007ff97d6ba9c6 in ?? ()
No symbol table info available.
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb)

Best,
Howard
