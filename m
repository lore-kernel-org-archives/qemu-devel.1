Received: from eggs.gnu.org ([2001:4830:134:3::10]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eydhf-0002CD-OE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eydhZ-0004Tq-LA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:22:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eydhZ-0004TD-GR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:22:49 -0400
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
Date: Wed, 21 Mar 2018 14:22:45 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 21/03/2018 14:13, Howard Spoelstra wrote:
>> Can you get a backtrace on the Windows system?  Perhaps by putting a
>> breakpoint in aio_context_set_poll_params.
>>
>> Paolo
> 
> I built qemu-master RC0 with --enable-debug. This is what a bt provides:

I am not sure what is happening here, but it is obviously not too
helpful. :(  Perhaps "gdb --args qemu-system-ppc.exe ..." is better?

Thanks,

Paolo

> (gdb) attach 9692
> Attaching to program `c:\qemu-master\qemu-system-ppc.exe', process 9692
> [New Thread 9692.0x670]
> [New Thread 9692.0x238c]
> [New Thread 9692.0xb94]
> [New Thread 9692.0x10bc]
> [New Thread 9692.0x90c]
> [New Thread 9692.0x29a0]
> (gdb) thread apply all bt full
> 
> Thread 6 (Thread 9692.0x29a0):
> #0  0x00007ff980ec3811 in ?? ()
> No symbol table info available.
> #1  0x00007ff980ef020b in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Thread 5 (Thread 9692.0x90c):
> #0  0x00007ff980ebff04 in ?? ()
> No symbol table info available.
> #1  0x00007ff97d673b7f in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Thread 4 (Thread 9692.0x10bc):
> #0  0x00007ff980ec3794 in ?? ()
> No symbol table info available.
> #1  0x00007ff980e549dd in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Thread 3 (Thread 9692.0xb94):
> #0  0x00007ff980ec3794 in ?? ()
> ---Type <return> to continue, or q <return> to quit---
> No symbol table info available.
> #1  0x00007ff980e549dd in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Thread 2 (Thread 9692.0x238c):
> #0  0x00007ff980ec3794 in ?? ()
> No symbol table info available.
> #1  0x00007ff980e549dd in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Thread 1 (Thread 9692.0x670):
> #0  0x00007ff980ec09d4 in ?? ()
> No symbol table info available.
> #1  0x00007ff97d6ba9c6 in ?? ()
> No symbol table info available.
> Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> (gdb)
> 
> Best,
> Howard
> 
