Received: from eggs.gnu.org ([2001:4830:134:3::10]:41497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQxo2-0002lH-3t
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQxnz-0002Kk-38
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:18 -0500
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:60820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQxny-0002IP-Sw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:15 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 76E46B2819
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 16:58:08 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 16:58:02 +0100
Message-ID: <151361268274.29357.7778552806095274865.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr_pci: use warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

These two are definitely warnings. Let's use the appropriate API.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c      |    6 +++---
 hw/ppc/spapr_pci_vfio.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 88797b3d3622..695c82091140 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1696,9 +1696,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     /* DMA setup */
     if (((sphb->page_size_mask & qemu_getrampagesize()) == 0)
         && kvm_enabled()) {
-        error_report("System page size 0x%lx is not enabled in page_size_mask "
-                     "(0x%"PRIx64"). Performance may be slow",
-                     qemu_getrampagesize(), sphb->page_size_mask);
+        warn_report("System page size 0x%lx is not enabled in page_size_mask "
+                    "(0x%"PRIx64"). Performance may be slow",
+                    qemu_getrampagesize(), sphb->page_size_mask);
     }
 
     for (i = 0; i < windows_supported; ++i) {
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 8448e0b0247d..1f775ea93dc6 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -50,7 +50,7 @@ static Property spapr_phb_vfio_properties[] = {
 static void spapr_phb_vfio_instance_init(Object *obj)
 {
     if (!qtest_enabled()) {
-        error_report("spapr-pci-vfio-host-bridge is deprecated");
+        warn_report("spapr-pci-vfio-host-bridge is deprecated");
     }
 }
 
