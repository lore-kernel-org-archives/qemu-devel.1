Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eygXw-0002vE-Ae
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eygXv-0000Do-G5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eygXv-0000DZ-CU
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:25:03 -0400
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
	<CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
Date: Wed, 21 Mar 2018 17:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
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

On 21/03/2018 17:23, Howard Spoelstra wrote:
> warning: FTH: (10844): *** Fault tolerant heap shim applied to current
> process. This is usually due to previous crashes. ***
> [New Thread 10844.0x1224]
> [New Thread 10844.0x2a30]
> [New Thread 10844.0x2594]
> [New Thread 10844.0x32a8]
> 
> Thread 1 hit Breakpoint 1, aio_context_set_poll_params (ctx=0xc14a9b0,
> max_ns=32768, grow=0, shrink=0, errp=0x362f968)
>     at util/aio-win32.c:413
> 413     in util/aio-win32.c
> (gdb) s
> error_setg_internal (errp=0x362f968, src=0xe166e0 <__func__.58569+32>
> "util/aio-win32.c", line=413,
>     func=0xe16740 <__func__.59050> "aio_context_set_poll_params",
>     fmt=0xe16708 <__func__.58569+72> "AioContext polling is not
> implemented on Windows") at util/error.c:91
> 91      util/error.c: No such file or directory.
> (gdb) s
> 94      in util/error.c

Great!  Now do "bt".

Paolo
