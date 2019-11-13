Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486AC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD746206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 19:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD746206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxwq-00073o-Jg
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 14:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iUxuf-0005ny-P7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iUxue-0000sm-2O
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:02:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iUxud-0000rN-Qh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 14:02:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xADIlWWs132905
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 14:02:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w8ny0c1e5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 14:02:40 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Wed, 13 Nov 2019 19:02:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Nov 2019 19:02:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xADJ2Ywj50790484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 19:02:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78981A406B;
 Wed, 13 Nov 2019 19:02:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35FD5A4059;
 Wed, 13 Nov 2019 19:02:34 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.55])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Nov 2019 19:02:34 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels tests
Date: Wed, 13 Nov 2019 20:02:33 +0100
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19111319-0012-0000-0000-000003635EDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111319-0013-0000-0000-0000219ED4FE
Message-Id: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-13_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130159
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: thuth@redhat.com, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PONG device accept two commands: PONG_READ and PONG_WRITE
which allow to read from and write to an internal buffer of
1024 bytes.

The QEMU device is named ccw-pong.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/Makefile.objs  |   1 +
 hw/s390x/ccw-pong.c     | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/pong.h |  47 ++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 hw/s390x/ccw-pong.c
 create mode 100644 include/hw/s390x/pong.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index ee91152..3a83438 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) += tod-kvm.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o s390-mchk.o
 obj-y += s390-ccw.o
+obj-y += ccw-pong.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
 obj-y += s390-sei.o
diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
new file mode 100644
index 0000000..e7439d5
--- /dev/null
+++ b/hw/s390x/ccw-pong.c
@@ -0,0 +1,186 @@
+/*
+ * CCW PING-PONG
+ *
+ * Copyright 2019 IBM Corp.
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/css-bridge.h"
+#include "hw/qdev-properties.h"
+#include "hw/s390x/pong.h"
+
+#define PONG_BUF_SIZE 0x1000
+static char buf[PONG_BUF_SIZE] = "Hello world\n";
+
+static inline int pong_rw(CCW1 *ccw, char *p, int len, bool dir)
+{
+    int ret;
+
+    ret = address_space_rw(&address_space_memory, ccw->cda,
+                           MEMTXATTRS_UNSPECIFIED,
+                           (unsigned char *)buf, len, dir);
+
+    return (ret == MEMTX_OK) ? -EIO : 0;
+}
+
+/* Handle READ ccw commands from guest */
+static int handle_payload_read(CcwPONGDevice *dev, CCW1 *ccw)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(dev);
+    int len;
+
+    if (!ccw->cda) {
+        return -EFAULT;
+    }
+
+    if (ccw->count > PONG_BUF_SIZE) {
+        len = PONG_BUF_SIZE;
+        ccw_dev->sch->curr_status.scsw.count = ccw->count - PONG_BUF_SIZE;
+    } else {
+        len = ccw->count;
+        ccw_dev->sch->curr_status.scsw.count = 0;
+    }
+
+    return pong_rw(ccw, buf, len, 1);
+}
+
+/*
+ * Handle WRITE ccw commands to write data to client
+ * The SCSW count is set to the number of bytes not transfered.
+ */
+static int handle_payload_write(CcwPONGDevice *dev, CCW1 *ccw)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(dev);
+    int len;
+
+    if (!ccw->cda) {
+        ccw_dev->sch->curr_status.scsw.count = ccw->count;
+        return -EFAULT;
+    }
+
+    if (ccw->count > PONG_BUF_SIZE) {
+        len = PONG_BUF_SIZE;
+        ccw_dev->sch->curr_status.scsw.count = ccw->count - PONG_BUF_SIZE;
+    } else {
+        len = ccw->count;
+        ccw_dev->sch->curr_status.scsw.count = 0;
+    }
+
+    return pong_rw(ccw, buf, len, 0);
+}
+
+static int pong_ccw_cb(SubchDev *sch, CCW1 ccw)
+{
+    int rc = 0;
+    CcwPONGDevice *dev = sch->driver_data;
+
+    switch (ccw.cmd_code) {
+    case PONG_WRITE:
+        rc = handle_payload_write(dev, &ccw);
+        break;
+    case PONG_READ:
+        rc = handle_payload_read(dev, &ccw);
+        break;
+    default:
+        rc = -ENOSYS;
+        break;
+    }
+
+    if (rc == -EIO) {
+        /* I/O error, specific devices generate specific conditions */
+        SCHIB *schib = &sch->curr_status;
+
+        sch->curr_status.scsw.dstat = SCSW_DSTAT_UNIT_CHECK;
+        sch->sense_data[0] = 0x40;    /* intervention-req */
+        schib->scsw.ctrl &= ~SCSW_ACTL_START_PEND;
+        schib->scsw.ctrl &= ~SCSW_CTRL_MASK_STCTL;
+        schib->scsw.ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                   SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+    }
+    return rc;
+}
+
+static void pong_ccw_realize(DeviceState *ds, Error **errp)
+{
+    uint16_t chpid;
+    CcwPONGDevice *dev = CCW_PONG(ds);
+    CcwDevice *cdev = CCW_DEVICE(ds);
+    CCWDeviceClass *cdk = CCW_DEVICE_GET_CLASS(cdev);
+    SubchDev *sch;
+    Error *err = NULL;
+
+    sch = css_create_sch(cdev->devno, errp);
+    if (!sch) {
+        return;
+    }
+
+    sch->driver_data = dev;
+    cdev->sch = sch;
+    chpid = css_find_free_chpid(sch->cssid);
+
+    if (chpid > MAX_CHPID) {
+        error_setg(&err, "No available chpid to use.");
+        goto out_err;
+    }
+
+    sch->id.reserved = 0xff;
+    sch->id.cu_type = CCW_PONG_CU_TYPE;
+    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
+                                CCW_PONG_CHPID_TYPE);
+    sch->do_subchannel_work = do_subchannel_work_virtual;
+    sch->ccw_cb = pong_ccw_cb;
+
+    cdk->realize(cdev, &err);
+    if (err) {
+        goto out_err;
+    }
+
+    css_reset_sch(sch);
+    return;
+
+out_err:
+    error_propagate(errp, err);
+    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+    cdev->sch = NULL;
+    g_free(sch);
+}
+
+static Property pong_ccw_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pong_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = pong_ccw_properties;
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    dc->realize = pong_ccw_realize;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo pong_ccw_info = {
+    .name = TYPE_CCW_PONG,
+    .parent = TYPE_CCW_DEVICE,
+    .instance_size = sizeof(CcwPONGDevice),
+    .class_init = pong_ccw_class_init,
+    .class_size = sizeof(CcwPONGClass),
+};
+
+static void pong_ccw_register(void)
+{
+    type_register_static(&pong_ccw_info);
+}
+
+type_init(pong_ccw_register)
diff --git a/include/hw/s390x/pong.h b/include/hw/s390x/pong.h
new file mode 100644
index 0000000..6358e2d
--- /dev/null
+++ b/include/hw/s390x/pong.h
@@ -0,0 +1,47 @@
+/*
+ *  ccw-attached PONG definitions
+ *
+ * Copyright 2019 IBM Corp.
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390X_PONG_CCW_H
+#define HW_S390X_PONG_CCW_H
+
+#include "hw/sysbus.h"
+#include "hw/s390x/css.h"
+#include "hw/s390x/ccw-device.h"
+
+#define CCW_PONG_CU_TYPE 0x0007
+#define CCW_PONG_CHPID_TYPE 0x09
+
+#define TYPE_CCW_PONG "ccw-pong"
+
+/* Local Channel Commands */
+#define PONG_WRITE 0x21         /* Write */
+#define PONG_READ  0x22         /* Read buffer */
+
+#define CCW_PONG(obj) \
+     OBJECT_CHECK(CcwPONGDevice, (obj), TYPE_CCW_PONG)
+#define CCW_PONG_CLASS(klass) \
+     OBJECT_CLASS_CHECK(CcwPONGClass, (klass), TYPE_CCW_PONG)
+#define CCW_PONG_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(CcwPONGClass, (obj), TYPE_CCW_PONG)
+
+typedef struct CcwPONGDevice {
+    CcwDevice parent_obj;
+} CcwPONGDevice;
+
+typedef struct CcwPONGClass {
+    CCWDeviceClass parent_class;
+
+    void (*init)(CcwPONGDevice *, Error **);
+    int (*read_payload)(CcwPONGDevice *);
+    int (*write_payload)(CcwPONGDevice *, uint8_t);
+} CcwPONGClass;
+
+#endif
-- 
2.7.4


