Received: from eggs.gnu.org ([2001:4830:134:3::10]:49975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTPKS-0004Es-NA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTPKN-0003Ct-OZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:13:36 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:44993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dTPKN-00039P-GY
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:13:31 -0400
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<0fbb03b7-d701-765a-6de8-54b6bb5ec1ec@vivier.eu>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <3dd8627d-e967-eb7d-d8ae-436065793983@physik.fu-berlin.de>
Date: Fri, 7 Jul 2017 11:13:24 +0200
MIME-Version: 1.0
In-Reply-To: <0fbb03b7-d701-765a-6de8-54b6bb5ec1ec@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org, glaubitz@debian.org

On 07/07/2017 11:05 AM, Laurent Vivier wrote:> I think unwind_gusa() should be moved after the get_sigfram() (in both> cases), because r15  can be updated and
the sigframe base lost.
Tried the change. "dpkg-reconfigure tzdata" now crashes differently:

Current default time zone: 'Europe/Berlin'
Local time is now:      Fri Jul  7 11:11:52 CEST 2017.
Universal Time is now:  Fri Jul  7 09:11:52 UTC 2017.

Unhandled trap: 0x180
pc=0xf6fff39a sr=0x00000100 pr=0x00512c28 fpscr=0x00080004
spc=0x00000000 ssr=0x00000000 gbr=0xf6585470 vbr=0x00000000
sgr=0x00000000 dbr=0x00000000 delayed_pc=0xf6fff3ac fpul=0x00000002
r0=0xffffffe0 r1=0x00000470 r2=0x00afc048 r3=0x00000004
r4=0x0000000a r5=0x00bbdc18 r6=0x00000001 r7=0x00000001
r8=0x00bbdc18 r9=0x00bbdc18 r10=0x00000001 r11=0x0041728c
r12=0x0000000a r13=0x0041744c r14=0x0058a384 r15=0x00000470
r16=0x00000000 r17=0x00000000 r18=0x00000000 r19=0x00000000
r20=0x00000000 r21=0x00000000 r22=0x00000000 r23=0x00000000
(sid-sh4-sbuild)root@nofan:/#

The crash on terminal resize is still present, too.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
