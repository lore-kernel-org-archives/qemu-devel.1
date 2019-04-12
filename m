Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8CDC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D74A2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvK0-0006n0-7x
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:30:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFP-0001c0-Dt
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFN-0002HW-RA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFN-0002Gr-G7; Fri, 12 Apr 2019 08:25:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC100307C940;
	Fri, 12 Apr 2019 12:25:32 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 845425D9CC;
	Fri, 12 Apr 2019 12:25:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:07 +0200
Message-Id: <20190412122523.24111-2-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 12 Apr 2019 12:25:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 01/17] s390 vfio-ccw:
 Add bootindex property and IPLB data
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122507._ZwvoDxTR9fMSTN648ycoybSLGF-oCh18gder2ouho8@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Add bootindex property and iplb data for vfio-ccw devices. This allows us=
 to
forward boot information into the bios for vfio-ccw devices.

Refactor s390_get_ccw_device() to return device type. This prevents us fr=
om
having to use messy casting logic in several places.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
[thuth: fixed "typedef struct VFIOCCWDevice" build failure with clang]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                 |  1 +
 hw/s390x/ipl.c              | 61 ++++++++++++++++++++++++++++---------
 hw/s390x/s390-ccw.c         |  9 ++++++
 hw/vfio/ccw.c               |  6 ++--
 include/hw/s390x/s390-ccw.h |  1 +
 include/hw/s390x/vfio-ccw.h | 28 +++++++++++++++++
 6 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/s390x/vfio-ccw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..f7976aa43d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1445,6 +1445,7 @@ S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
+F: include/hw/s390x/vfio-ccw.h
 T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 51b272e190..d0cc06a05f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -19,6 +19,7 @@
 #include "hw/loader.h"
 #include "hw/boards.h"
 #include "hw/s390x/virtio-ccw.h"
+#include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
 #include "ipl.h"
@@ -303,16 +304,36 @@ static void s390_ipl_set_boot_menu(S390IPLState *ip=
l)
     ipl->qipl.boot_menu_timeout =3D cpu_to_be32(splash_time);
 }
=20
-static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
+#define CCW_DEVTYPE_NONE        0x00
+#define CCW_DEVTYPE_VIRTIO      0x01
+#define CCW_DEVTYPE_VIRTIO_NET  0x02
+#define CCW_DEVTYPE_SCSI        0x03
+#define CCW_DEVTYPE_VFIO        0x04
+
+static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev =3D NULL;
+    int tmp_dt =3D CCW_DEVTYPE_NONE;
=20
     if (dev_st) {
+        VirtIONet *virtio_net_dev =3D (VirtIONet *)
+            object_dynamic_cast(OBJECT(dev_st), TYPE_VIRTIO_NET);
         VirtioCcwDevice *virtio_ccw_dev =3D (VirtioCcwDevice *)
             object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->pare=
nt),
                                 TYPE_VIRTIO_CCW_DEVICE);
+        VFIOCCWDevice *vfio_ccw_dev =3D (VFIOCCWDevice *)
+            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
+
         if (virtio_ccw_dev) {
             ccw_dev =3D CCW_DEVICE(virtio_ccw_dev);
+            if (virtio_net_dev) {
+                tmp_dt =3D CCW_DEVTYPE_VIRTIO_NET;
+            } else {
+                tmp_dt =3D CCW_DEVTYPE_VIRTIO;
+            }
+        } else if (vfio_ccw_dev) {
+            ccw_dev =3D CCW_DEVICE(vfio_ccw_dev);
+            tmp_dt =3D CCW_DEVTYPE_VFIO;
         } else {
             SCSIDevice *sd =3D (SCSIDevice *)
                 object_dynamic_cast(OBJECT(dev_st),
@@ -325,9 +346,13 @@ static CcwDevice *s390_get_ccw_device(DeviceState *d=
ev_st)
=20
                 ccw_dev =3D (CcwDevice *)object_dynamic_cast(OBJECT(scsi=
_ccw),
                                                            TYPE_CCW_DEVI=
CE);
+                tmp_dt =3D CCW_DEVTYPE_SCSI;
             }
         }
     }
+    if (devtype) {
+        *devtype =3D tmp_dt;
+    }
     return ccw_dev;
 }
=20
@@ -335,20 +360,22 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl=
)
 {
     DeviceState *dev_st;
     CcwDevice *ccw_dev =3D NULL;
+    SCSIDevice *sd;
+    int devtype;
=20
     dev_st =3D get_boot_device(0);
     if (dev_st) {
-        ccw_dev =3D s390_get_ccw_device(dev_st);
+        ccw_dev =3D s390_get_ccw_device(dev_st, &devtype);
     }
=20
     /*
      * Currently allow IPL only from CCW devices.
      */
     if (ccw_dev) {
-        SCSIDevice *sd =3D (SCSIDevice *) object_dynamic_cast(OBJECT(dev=
_st),
-                                                            TYPE_SCSI_DE=
VICE);
-
-        if (sd) {
+        switch (devtype) {
+        case CCW_DEVTYPE_SCSI:
+            sd =3D (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
+                                                           TYPE_SCSI_DEV=
ICE);
             ipl->iplb.len =3D cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =3D
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEAD=
ER_LEN);
@@ -358,20 +385,24 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl=
)
             ipl->iplb.scsi.channel =3D cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno =3D cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid =3D ccw_dev->sch->ssid & 3;
-        } else {
-            VirtIONet *vn =3D (VirtIONet *) object_dynamic_cast(OBJECT(d=
ev_st),
-                                                              TYPE_VIRTI=
O_NET);
-
+            break;
+        case CCW_DEVTYPE_VFIO:
+            ipl->iplb.len =3D cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            ipl->iplb.pbt =3D S390_IPL_TYPE_CCW;
+            ipl->iplb.ccw.devno =3D cpu_to_be16(ccw_dev->sch->devno);
+            ipl->iplb.ccw.ssid =3D ccw_dev->sch->ssid & 3;
+            break;
+        case CCW_DEVTYPE_VIRTIO_NET:
+            ipl->netboot =3D true;
+            /* Fall through to CCW_DEVTYPE_VIRTIO case */
+        case CCW_DEVTYPE_VIRTIO:
             ipl->iplb.len =3D cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             ipl->iplb.blk0_len =3D
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN=
);
             ipl->iplb.pbt =3D S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno =3D cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid =3D ccw_dev->sch->ssid & 3;
-
-            if (vn) {
-                ipl->netboot =3D true;
-            }
+            break;
         }
=20
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
@@ -530,7 +561,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_r=
eset reset_type)
         !ipl->netboot &&
         ipl->iplb.pbt =3D=3D S390_IPL_TYPE_CCW &&
         is_virtio_scsi_device(&ipl->iplb)) {
-        CcwDevice *ccw_dev =3D s390_get_ccw_device(get_boot_device(0));
+        CcwDevice *ccw_dev =3D s390_get_ccw_device(get_boot_device(0), N=
ULL);
=20
         if (ccw_dev &&
             cpu_to_be16(ccw_dev->sch->devno) =3D=3D ipl->iplb.ccw.devno =
&&
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index cad91ee626..f5f025d1b6 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -124,6 +124,14 @@ static void s390_ccw_unrealize(S390CCWDevice *cdev, =
Error **errp)
     g_free(cdev->mdevid);
 }
=20
+static void s390_ccw_instance_init(Object *obj)
+{
+    S390CCWDevice *dev =3D S390_CCW_DEVICE(obj);
+
+    device_add_bootindex_property(obj, &dev->bootindex, "bootindex",
+                                  "/disk@0,0", DEVICE(obj), NULL);
+}
+
 static void s390_ccw_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -137,6 +145,7 @@ static void s390_ccw_class_init(ObjectClass *klass, v=
oid *data)
 static const TypeInfo s390_ccw_info =3D {
     .name          =3D TYPE_S390_CCW,
     .parent        =3D TYPE_CCW_DEVICE,
+    .instance_init =3D s390_ccw_instance_init,
     .instance_size =3D sizeof(S390CCWDevice),
     .class_size    =3D sizeof(S390CCWDeviceClass),
     .class_init    =3D s390_ccw_class_init,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c44d13cc50..31dd3a2a87 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,12 +21,12 @@
 #include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
=20
-#define TYPE_VFIO_CCW "vfio-ccw"
-typedef struct VFIOCCWDevice {
+struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
     uint64_t io_region_size;
@@ -35,7 +35,7 @@ typedef struct VFIOCCWDevice {
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
-} VFIOCCWDevice;
+};
=20
 static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
                                   const char *msg)
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7d15a1a5d4..901d805d79 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
     CcwDevice parent_obj;
     CssDevId hostid;
     char *mdevid;
+    int32_t bootindex;
 } S390CCWDevice;
=20
 typedef struct S390CCWDeviceClass {
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
new file mode 100644
index 0000000000..ee5250d0d7
--- /dev/null
+++ b/include/hw/s390x/vfio-ccw.h
@@ -0,0 +1,28 @@
+/*
+ * vfio based subchannel assignment support
+ *
+ * Copyright 2017, 2019 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_VFIO_CCW_H
+#define HW_VFIO_CCW_H
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/ccw-device.h"
+
+#define TYPE_VFIO_CCW "vfio-ccw"
+#define VFIO_CCW(obj) \
+        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
+
+#define TYPE_VFIO_CCW "vfio-ccw"
+typedef struct VFIOCCWDevice VFIOCCWDevice;
+
+#endif
--=20
2.21.0


