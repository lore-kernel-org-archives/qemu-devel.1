Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B682F2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B682F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwMhf-0007TU-1H
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgk-00065b-K6
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11210
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1jwMgi-0004GZ-QE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:29:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06H95gRn165317
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32ax78rcu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:50 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H9CMOA188166
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:29:49 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32ax78rctj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 05:29:49 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H975P7002799;
 Fri, 17 Jul 2020 09:29:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 328rbqt2jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2020 09:29:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06H9SMZ159375920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 09:28:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDE63AE04D;
 Fri, 17 Jul 2020 09:29:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54F4EAE045;
 Fri, 17 Jul 2020 09:29:45 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.17.123])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jul 2020 09:29:45 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC v2 1/3] virtio: add vhost-user-fs-ccw device
Date: Fri, 17 Jul 2020 11:29:27 +0200
Message-Id: <20200717092929.19453-2-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717092929.19453-1-mhartmay@linux.ibm.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-17_04:2020-07-17,
 2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=1
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170070
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:29:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Halil Pasic <pasic@linux.ibm.com>

Wire up the CCW device for vhost-user-fs.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 hw/s390x/Makefile.objs       |  1 +
 hw/s390x/vhost-user-fs-ccw.c | 73 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 hw/s390x/vhost-user-fs-ccw.c

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a46a1c7894e0..c4086ec3171e 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -20,6 +20,7 @@ obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-ccw-blk.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
+obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs-ccw.o
 endif
 obj-y += css-bridge.o
 obj-y += ccw-device.o
diff --git a/hw/s390x/vhost-user-fs-ccw.c b/hw/s390x/vhost-user-fs-ccw.c
new file mode 100644
index 000000000000..88a7a11a34b4
--- /dev/null
+++ b/hw/s390x/vhost-user-fs-ccw.c
@@ -0,0 +1,73 @@
+/*
+ * Ccw transport wiring for vhost-user-fs
+ *
+ * Copyright 2020 IBM Corp.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "hw/virtio/vhost-user-fs.h"
+#include "virtio-ccw.h"
+
+typedef struct VHostUserFSCcw {
+    VirtioCcwDevice parent_obj;
+    VHostUserFS vdev;
+} VHostUserFSCcw;
+
+#define TYPE_VHOST_USER_FS_CCW "vhost-user-fs-ccw"
+#define VHOST_USER_FS_CCW(obj) \
+        OBJECT_CHECK(VHostUserFSCcw, (obj), TYPE_VHOST_USER_FS_CCW)
+
+
+static Property vhost_user_fs_ccw_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_fs_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
+}
+
+static void vhost_user_fs_ccw_instance_init(Object *obj)
+{
+    VHostUserFSCcw *dev = VHOST_USER_FS_CCW(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_FS);
+}
+
+static void vhost_user_fs_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = vhost_user_fs_ccw_realize;
+    device_class_set_props(dc,vhost_user_fs_ccw_properties);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo vhost_user_fs_ccw = {
+    .name          = TYPE_VHOST_USER_FS_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VHostUserFSCcw),
+    .instance_init = vhost_user_fs_ccw_instance_init,
+    .class_init    = vhost_user_fs_ccw_class_init,
+};
+
+static void vhost_user_fs_ccw_register(void)
+{
+    type_register_static(&vhost_user_fs_ccw);
+}
+
+type_init(vhost_user_fs_ccw_register)
-- 
2.25.4


