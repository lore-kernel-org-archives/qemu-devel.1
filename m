Received: from eggs.gnu.org ([2001:4830:134:3::10]:38707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVbnu-0003fD-GH
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dVbnp-0007V2-LJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:57:06 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:57626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dVbnp-0007UZ-EK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:57:01 -0400
Date: Thu, 13 Jul 2017 12:56:52 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170713105652.GC25275@physik.fu-berlin.de>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
	<3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
	<b7f8b2dd-a154-fc14-7be1-1cdbe248d350@twiddle.net>
	<20170713090908.GA25275@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713090908.GA25275@physik.fu-berlin.de>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On Thu, Jul 13, 2017 at 11:09:08AM +0200, John Paul Adrian Glaubitz wrote:
> Just as a heads-up: The current set of patches as they are present in
> the tgt-sh4 branch on git://github.com/rth7680/qemu.git are a HUGE
> improvement for qemu-sh4 user mode. Several packages which previously
> crashed during build or use can now be used properly!

The only thing that still doesn't work is GHC, unfortunately:

(sid-sh4-sbuild)root@nofan:/# ghc Main.hs 
/bin/bash: warning: setlocale: LC_ALL: cannot change locale
(en_US.UTF-8)
[1 of 1] Compiling Main             ( Main.hs, Main.o )
^C
(sid-sh4-sbuild)root@nofan:/# ghc Main.hs 
/bin/bash: warning: setlocale: LC_ALL: cannot change locale
(en_US.UTF-8)
[1 of 1] Compiling Main             ( Main.hs, Main.o )
^C
(sid-sh4-sbuild)root@nofan:/# ghc Main.hs 
/bin/bash: warning: setlocale: LC_ALL: cannot change locale
(en_US.UTF-8)
[1 of 1] Compiling Main             ( Main.hs, Main.o )
^C
(sid-sh4-sbuild)root@nofan:/# ghc Main.hs 
/bin/bash: warning: setlocale: LC_ALL: cannot change locale
(en_US.UTF-8)
ghc: internal error: scavenge_static: strange closure 8
    (GHC version 8.0.1 for sh4_unknown_linux)
    Please report this as a GHC bug:
    http://www.haskell.org/ghc/reportabug
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted
(sid-sh4-sbuild)root@nofan:/#

It either hangs, so I had to use "Ctrl+C" or it segfaulted.

Sometimes it would crash with:

(sid-sh4-sbuild)root@nofan:/# ghc Main.hs 
/bin/bash: warning: setlocale: LC_ALL: cannot change locale
(en_US.UTF-8)
Unhandled trap: 0x180
pc=0x07019782 sr=0x00000000 pr=0x0668c52c fpscr=0x00080000
spc=0x00000000 ssr=0x00000000 gbr=0x7f5ae680 vbr=0x00000000
sgr=0x00000000 dbr=0x00000000 delayed_pc=0x0668c52c fpul=0x05f7595c
r0=0x07019780 r1=0x7d9f90d8 r2=0x00019780 r3=0x00009780
r4=0x00000001 r5=0x0000001e r6=0x70000000 r7=0x00000080
r8=0x00000001 r9=0x00000000 r10=0x7f5ae694 r11=0x00000000
r12=0x07099840 r13=0x7f4fe000 r14=0x7ffff4cc r15=0x7ffff4c8
r16=0x00000000 r17=0x00000000 r18=0x00000000 r19=0x00000000
r20=0x00000000 r21=0x00000000 r22=0x00000000 r23=0x00000000
(sid-sh4-sbuild)root@nofan:/#

Source file is available here [1]. In order to be able to install,
you need to bind-mount /proc into the chroot first:

mount -o bind /proc /path/to/sid-sh4-sbuild/proc/

Adrian

> [1] https://people.debian.org/~glaubitz/Main.hs

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
