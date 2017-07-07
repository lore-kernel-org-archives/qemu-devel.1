Received: from eggs.gnu.org ([2001:4830:134:3::10]:43552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTOjI-0002Kz-CV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTOjF-000753-8l
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:35:12 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dTOjF-00072v-0y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:35:09 -0400
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
	<51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
	<313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
Message-ID: <3349c01e-1f1a-2111-28c2-70fb5cc077cd@physik.fu-berlin.de>
Date: Fri, 7 Jul 2017 10:35:02 +0200
MIME-Version: 1.0
In-Reply-To: <313d3f03-f487-4881-5f0a-6dd150f1ebdc@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/07/2017 10:30 AM, John Paul Adrian Glaubitz wrote:
> The scripts which are run here can be found as /var/lib/dpkg/info/tzdata.{config,postinst).
> I don't know yet which command in particular triggers the crash.
Interesting. It crashes for me immediately after resizing the terminal window with:

(sid-sh4-sbuild)root@nofan:/# Unhandled trap: 0x180
pc=0xf6ffe9fa sr=0x00000101 pr=0x004a73c2 fpscr=0x00080000
spc=0x00000000 ssr=0x00000000 gbr=0xf6646470 vbr=0x00000000
sgr=0x00000000 dbr=0x00000000 delayed_pc=0xf6ffea14 fpul=0x00000000
r0=0xfffffffc r1=0xf6ffea1c r2=0x00000000 r3=0x00000134
r4=0x00000001 r5=0xf6ffeac0 r6=0x00000000 r7=0x00000000
r8=0x00000000 r9=0x0041a050 r10=0xf677e4b8 r11=0xf6ffea40
r12=0xf677ec54 r13=0x00000000 r14=0x0041a0a4 r15=0xf6ffea1c
r16=0x00000000 r17=0x00000000 r18=0x00000000 r19=0x00000000
r20=0x00000000 r21=0x00000000 r22=0x00000000 r23=0x00000000
root@nofan:~>

I did not enter any commands. Just chrooting into the chroot, the resizing the
terminal window was enough.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
