Received: from eggs.gnu.org ([2001:4830:134:3::10]:37670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhf-00084K-TI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhc-0000w9-Nm
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:35 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:59086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqhc-0000sK-DG
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:32 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.157])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7B8DFD6D44
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:40:30 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:23 +0100
Message-Id: <20181211223823.13770-13-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 12/12] spapr: change default CPU type to
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97a5e3c9929f..705d3f4057b0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3938,7 +3938,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     hc->unplug =3D spapr_machine_device_unplug;
=20
     smc->dr_lmb_enabled =3D true;
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path =3D spapr_get_fw_dev_path;
--=20
2.17.2
