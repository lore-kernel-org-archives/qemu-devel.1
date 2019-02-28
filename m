Received: from eggs.gnu.org ([209.51.188.92]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnx-0001qX-0C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnv-0007po-Qp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnv-0007eX-DI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:52 +0100
Message-Id: <1551356875-30676-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] MAINTAINERS: Add some missing entries for
 the sun4m machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These files / devices are only used by SPARC machines, so we can sort
them into the corresponding category in the MAINTAINERS file.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c217d8..5a6db6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1103,12 +1103,15 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.u=
k>
 S: Maintained
 F: hw/sparc/sun4m.c
 F: hw/sparc/sun4m_iommu.c
+F: hw/display/cg3.c
+F: hw/display/tcx.c
 F: hw/dma/sparc32_dma.c
 F: hw/misc/eccmemctl.c
-F: hw/misc/slavio_misc.c
+F: hw/*/slavio_*.c
+F: include/hw/nvram/sun_nvram.h
 F: include/hw/sparc/sparc32_dma.h
-F: pc-bios/openbios-sparc32
 F: include/hw/sparc/sun4m_iommu.h
+F: pc-bios/openbios-sparc32
=20
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
--=20
1.8.3.1
