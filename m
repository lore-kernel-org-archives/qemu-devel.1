Received: from eggs.gnu.org ([2001:4830:134:3::10]:45226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITE-0004Jd-AA
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT7-0002Bi-MU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT7-0002AN-9Q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DA9680F7D
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:42 +0200
Message-Id: <1497962468-22936-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 15/41] qdev: Rename DEFINE_PROP_DEFAULT() to
 DEFINE_PROP_SIGNED()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The rename prepares for the patch after next's DEFINE_PROP_UNSIGNED().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-16-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/fdc.c               | 18 +++++++++---------
 hw/net/e1000e.c              |  6 +++---
 include/hw/qdev-properties.h | 26 +++++++++++++-------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2e629b3..28f6b6e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -511,7 +511,7 @@ typedef struct FloppyDrive {
 static Property floppy_drive_properties[] =3D {
     DEFINE_PROP_UINT32("unit", FloppyDrive, unit, -1),
     DEFINE_BLOCK_PROPERTIES(FloppyDrive, conf),
-    DEFINE_PROP_DEFAULT("drive-type", FloppyDrive, type,
+    DEFINE_PROP_SIGNED("drive-type", FloppyDrive, type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
@@ -2805,13 +2805,13 @@ static Property isa_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("driveB", FDCtrlISABus, state.qdev_for_drives[1].b=
lk),
     DEFINE_PROP_BIT("check_media_rate", FDCtrlISABus, state.check_media_=
rate,
                     0, true),
-    DEFINE_PROP_DEFAULT("fdtypeA", FDCtrlISABus, state.qdev_for_drives[0=
].type,
+    DEFINE_PROP_SIGNED("fdtypeA", FDCtrlISABus, state.qdev_for_drives[0]=
.type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1=
].type,
+    DEFINE_PROP_SIGNED("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1]=
.type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
+    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
                         FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
@@ -2862,13 +2862,13 @@ static const VMStateDescription vmstate_sysbus_fd=
c =3D{
 static Property sysbus_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("driveA", FDCtrlSysBus, state.qdev_for_drives[0].b=
lk),
     DEFINE_PROP_DRIVE("driveB", FDCtrlSysBus, state.qdev_for_drives[1].b=
lk),
-    DEFINE_PROP_DEFAULT("fdtypeA", FDCtrlSysBus, state.qdev_for_drives[0=
].type,
+    DEFINE_PROP_SIGNED("fdtypeA", FDCtrlSysBus, state.qdev_for_drives[0]=
.type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fdtypeB", FDCtrlSysBus, state.qdev_for_drives[1=
].type,
+    DEFINE_PROP_SIGNED("fdtypeB", FDCtrlSysBus, state.qdev_for_drives[1]=
.type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
+    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
                         FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
@@ -2891,10 +2891,10 @@ static const TypeInfo sysbus_fdc_info =3D {
=20
 static Property sun4m_fdc_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", FDCtrlSysBus, state.qdev_for_drives[0].bl=
k),
-    DEFINE_PROP_DEFAULT("fdtype", FDCtrlSysBus, state.qdev_for_drives[0]=
.type,
+    DEFINE_PROP_SIGNED("fdtype", FDCtrlSysBus, state.qdev_for_drives[0].=
type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type=
,
                         FloppyDriveType),
-    DEFINE_PROP_DEFAULT("fallback", FDCtrlISABus, state.fallback,
+    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
                         FLOPPY_DRIVE_TYPE_144, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6e23493..0e0a1dc 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -645,12 +645,12 @@ static PropertyInfo e1000e_prop_disable_vnet,
=20
 static Property e1000e_properties[] =3D {
     DEFINE_NIC_PROPERTIES(E1000EState, conf),
-    DEFINE_PROP_DEFAULT("disable_vnet_hdr", E1000EState, disable_vnet, f=
alse,
+    DEFINE_PROP_SIGNED("disable_vnet_hdr", E1000EState, disable_vnet, fa=
lse,
                         e1000e_prop_disable_vnet, bool),
-    DEFINE_PROP_DEFAULT("subsys_ven", E1000EState, subsys_ven,
+    DEFINE_PROP_SIGNED("subsys_ven", E1000EState, subsys_ven,
                         PCI_VENDOR_ID_INTEL,
                         e1000e_prop_subsys_ven, uint16_t),
-    DEFINE_PROP_DEFAULT("subsys", E1000EState, subsys, 0,
+    DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
                         e1000e_prop_subsys, uint16_t),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 85e6899..0560380 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -37,7 +37,7 @@ extern PropertyInfo qdev_prop_arraylen;
         .offset    =3D offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
         }
-#define DEFINE_PROP_DEFAULT(_name, _state, _field, _defval, _prop, _type=
) { \
+#define DEFINE_PROP_SIGNED(_name, _state, _field, _defval, _prop, _type)=
 { \
         .name      =3D (_name),                                         =
  \
         .info      =3D &(_prop),                                        =
  \
         .offset    =3D offsetof(_state, _field)                         =
  \
@@ -107,19 +107,19 @@ extern PropertyInfo qdev_prop_arraylen;
         }
=20
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_int32, int32_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_size, uint64_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
=20
 /*
  * Please avoid pointer properties.  If you must use them, you must
@@ -153,17 +153,17 @@ extern PropertyInfo qdev_prop_arraylen;
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto=
)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
 #define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
                         BlockdevOnError)
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_DEFAULT(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
=20
--=20
2.7.5
