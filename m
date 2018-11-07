Received: from eggs.gnu.org ([2001:4830:134:3::10]:35886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKLP6-00030Z-7e
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKLOz-0001TM-M1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gKLOx-0000dl-H7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:37 -0500
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Wed,  7 Nov 2018 11:49:20 +0100
Message-Id: <20181107104921.20536-3-lhrazky@redhat.com>
In-Reply-To: <20181107104921.20536-1-lhrazky@redhat.com>
References: <20181107104921.20536-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice v3 2/3] QXL interface: deprecate
 spice_qxl_set_max_monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Replace it by spice_qxl_set_device_info. Note we can't use
monitors_count for what's stored in max_monitors, because monitors_count
denotes the length of the device_display_ids array, which
spice_qxl_set_max_monitors doesn't touch.

Signed-off-by: Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD <lhrazky@redhat.com>
---
 server/red-qxl.c   | 1 +
 server/spice-qxl.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/server/red-qxl.c b/server/red-qxl.c
index 0ea424cd..6ffd8286 100644
--- a/server/red-qxl.c
+++ b/server/red-qxl.c
@@ -888,6 +888,7 @@ void spice_qxl_set_device_info(QXLInstance *instance,
     }
=20
     instance->st->monitors_count =3D device_display_id_count;
+    instance->st->max_monitors =3D device_display_id_count;
 }
=20
 void red_qxl_init(RedsState *reds, QXLInstance *qxl)
diff --git a/server/spice-qxl.h b/server/spice-qxl.h
index 547d3d93..e7af5e5e 100644
--- a/server/spice-qxl.h
+++ b/server/spice-qxl.h
@@ -101,9 +101,9 @@ void spice_qxl_monitors_config_async(QXLInstance *ins=
tance, QXLPHYSICAL monitors
                                      int group_id, uint64_t cookie);
 /* since spice 0.12.3 */
 void spice_qxl_driver_unload(QXLInstance *instance);
-/* since spice 0.12.6 */
+/* since spice 0.12.6, deprecated since 0.14.2, spice_qxl_set_device_inf=
o replaces it */
 void spice_qxl_set_max_monitors(QXLInstance *instance,
-                                unsigned int max_monitors);
+                                unsigned int max_monitors) SPICE_GNUC_DE=
PRECATED;
 /* since spice 0.13.1 */
 void spice_qxl_gl_scanout(QXLInstance *instance,
                           int fd,
--=20
2.19.1
