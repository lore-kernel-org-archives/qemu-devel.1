Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEpx-0006q8-Ht
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eXEpt-0008VX-Fh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:22:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eXEpt-0008V5-81
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 18:22:09 -0500
Date: Fri, 5 Jan 2018 01:21:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1515108094-11508-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] isa/piix: move to mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

This device is only used on mips, move to the correct maintainer
section.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0255113..ab30f1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -175,6 +175,7 @@ F: include/hw/intc/mips_gic.h
 F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
 F: disas/mips.c
+F: hw/isa/piix4.c
=20
 Moxie
 M: Anthony Green <green@moxielogic.com>
@@ -849,7 +850,6 @@ F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
-F: hw/isa/piix4.c
 F: hw/isa/lpc_ich9.c
 F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
--=20
MST
