Received: from eggs.gnu.org ([209.51.188.92]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnI-0001KC-Q8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnH-0007PN-ID
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnH-0007O9-Ar
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:43 +0100
Message-Id: <1551356875-30676-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] MAINTAINERS: Add missing entries for the
 sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f9f9d7..22e0293 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1100,9 +1100,13 @@ Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
-F: pc-bios/openbios-sparc64
+F: hw/sparc64/sun4u_iommu.c
+F: include/hw/sparc/sun4u_iommu.h
 F: hw/pci-host/sabre.c
 F: include/hw/pci-host/sabre.h
+F: hw/pci-bridge/simba.c
+F: include/hw/pci-bridge/simba.h
+F: pc-bios/openbios-sparc64
=20
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
--=20
1.8.3.1
