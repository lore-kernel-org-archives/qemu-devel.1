Received: from eggs.gnu.org ([209.51.188.92]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2JQ9-0008MB-28
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2JQ4-00085t-AZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2JQ4-00085E-3w
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:36:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F33E55D674
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 17:36:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Mar 2019 18:36:22 +0100
Message-Id: <20190308173622.21386-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vfio-pci: enable by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com

CONFIG_VFIO_PCI was not "default y" - and once you do that, it is also im=
portant
to disable it if PCI is not there.

Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
index ebda9fdf22..34da2a3cfd 100644
--- a/hw/vfio/Kconfig
+++ b/hw/vfio/Kconfig
@@ -4,8 +4,9 @@ config VFIO
=20
 config VFIO_PCI
     bool
+    default y
     select VFIO
-    depends on LINUX
+    depends on LINUX && PCI
=20
 config VFIO_CCW
     bool
--=20
2.20.1
