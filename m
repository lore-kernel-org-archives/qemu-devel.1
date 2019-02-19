Received: from eggs.gnu.org ([209.51.188.92]:51237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tt-00008W-VZ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tt-0004AB-9a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0tt-00049s-16
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56A1878EAD
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:37:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:49 +0100
Message-Id: <1550565421-10944-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/14] MAINTAINERS: Add missing entries for the
 sun4u machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e4f70a..feb9095 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1096,9 +1096,13 @@ Sun4u
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
