Received: from eggs.gnu.org ([209.51.188.92]:46464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aK-0002lZ-5f
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gn1aI-0002Xa-Mp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36392 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gn1aI-0002W8-D7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:31:50 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 25 Jan 2019 14:31:33 +0100
Message-Id: <1548423098-31864-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] MAINTAINERS: Update MIPS sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove Stefan Markovic as a reviewer for MIPS directories and
files, as he left Wave Computing.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af339b8..060db23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -206,7 +206,6 @@ MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
@@ -365,7 +364,6 @@ F: target/arm/kvm.c
 MIPS
 M: James Hogan <jhogan@kernel.org>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/kvm.c
=20
@@ -890,7 +888,6 @@ MIPS Machines
 Jazz
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
 F: hw/display/jazz_led.c
@@ -899,14 +896,12 @@ F: hw/dma/rc4030.c
 Malta
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_malta.c
=20
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -914,14 +909,12 @@ F: hw/net/mipsnet.c
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
@@ -931,7 +924,6 @@ F: include/hw/isa/vt82c686.h
 Boston
 M: Paul Burton <pburton@wavecomp.com>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -2203,7 +2195,6 @@ F: disas/i386.c
 MIPS target
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
-R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: tcg/mips/
 F: disas/mips.c
--=20
2.7.4
