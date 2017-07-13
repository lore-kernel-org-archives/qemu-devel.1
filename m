Received: from eggs.gnu.org ([2001:4830:134:3::10]:41084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVlnz-0003Dy-KP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVlnv-0002PW-Ov
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:37:51 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVlnv-0002PG-JI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:37:47 -0400
Received: by mail-qk0-x243.google.com with SMTP id 16so9818477qkg.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 14:37:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
	<3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
	<20170713090908.GA25275@physik.fu-berlin.de>
	<20170713105652.GC25275@physik.fu-berlin.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a18f211f-ea06-51ed-3961-55dbecdbc766@twiddle.net>
Date: Thu, 13 Jul 2017 11:37:40 -1000
MIME-Version: 1.0
In-Reply-To: <20170713105652.GC25275@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/13/2017 12:56 AM, John Paul Adrian Glaubitz wrote:
> It either hangs, so I had to use "Ctrl+C" or it segfaulted.
> 
> Sometimes it would crash with:
> 
> (sid-sh4-sbuild)root@nofan:/# ghc Main.hs
> /bin/bash: warning: setlocale: LC_ALL: cannot change locale
> (en_US.UTF-8)
> Unhandled trap: 0x180
> pc=0x07019782 sr=0x00000000 pr=0x0668c52c fpscr=0x00080000
> spc=0x00000000 ssr=0x00000000 gbr=0x7f5ae680 vbr=0x00000000
> sgr=0x00000000 dbr=0x00000000 delayed_pc=0x0668c52c fpul=0x05f7595c
> r0=0x07019780 r1=0x7d9f90d8 r2=0x00019780 r3=0x00009780
> r4=0x00000001 r5=0x0000001e r6=0x70000000 r7=0x00000080
> r8=0x00000001 r9=0x00000000 r10=0x7f5ae694 r11=0x00000000
> r12=0x07099840 r13=0x7f4fe000 r14=0x7ffff4cc r15=0x7ffff4c8
> r16=0x00000000 r17=0x00000000 r18=0x00000000 r19=0x00000000
> r20=0x00000000 r21=0x00000000 r22=0x00000000 r23=0x00000000
> (sid-sh4-sbuild)root@nofan:/#
> 
> Source file is available here [1]. In order to be able to install,
> you need to bind-mount /proc into the chroot first:
> 
> mount -o bind /proc /path/to/sid-sh4-sbuild/proc/
> 
> Adrian
> 
>> [1] https://people.debian.org/~glaubitz/Main.hs

I can reproduce this non-reproducible behaviour.

Unfortunately with something as complex as ghc this doesn't help much.  I hope 
you can find something smaller that produces a similar problem...


r~
