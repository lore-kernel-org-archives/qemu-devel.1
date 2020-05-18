Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F71C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB67207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB67207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaisy-0000Yw-TI
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1jairo-0007c5-Er; Mon, 18 May 2020 12:43:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35934
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1jairn-0006xt-2H; Mon, 18 May 2020 12:43:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04IGXmsr126142; Mon, 18 May 2020 12:43:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c229ac2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 12:43:48 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IGhlOP154777;
 Mon, 18 May 2020 12:43:48 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c229abj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 12:43:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04IGhKMY009884;
 Mon, 18 May 2020 16:43:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma01fra.de.ibm.com with ESMTP id 313x4mr014-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 16:43:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04IGhhJI62390518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 16:43:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55F4BA4062;
 Mon, 18 May 2020 16:43:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE0F6A405B;
 Mon, 18 May 2020 16:43:42 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.158.244])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2020 16:43:42 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v3 1/1] s390x: css: pong, channel subsystem test device
Date: Mon, 18 May 2020 18:43:41 +0200
Message-Id: <1589820221-23538-2-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589820221-23538-1-git-send-email-pmorel@linux.ibm.com>
References: <1589820221-23538-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=3
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 10:31:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a test device for channel subsystem.
Most of the CSS instructions are handled by the common code.

The PONG_READ and PONG_WRITE CCW commands allow to test the
SSCH instruction with both read and write commands.

It is also possible to define the Control Unit type
with the cu_type property.
Currently only the kvm-unit-test css test uses the PONG device.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 default-configs/s390x-softmmu.mak |   1 +
 hw/s390x/Kconfig                  |   3 +
 hw/s390x/Makefile.objs            |   1 +
 hw/s390x/ccw-pong.c               | 134 ++++++++++++++++++++++++++++++
 include/hw/s390x/pong.h           |  48 +++++++++++
 5 files changed, 187 insertions(+)
 create mode 100644 hw/s390x/ccw-pong.c
 create mode 100644 include/hw/s390x/pong.h

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index f2287a133f..72711912cd 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -7,6 +7,7 @@
 #CONFIG_VFIO_CCW=n
 #CONFIG_VIRTIO_PCI=n
 #CONFIG_WDT_DIAG288=n
+#CONFIG_CCW_TESTDEV=n
 
 # Boards:
 #
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 5e7d8a2bae..041ede333e 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -10,3 +10,6 @@ config S390_CCW_VIRTIO
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
+
+config CCW_TESTDEV
+    default y if TEST_DEVICES
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 568bab9711..f839e28fb6 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -35,3 +35,4 @@ obj-$(CONFIG_KVM) += pv.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
+obj-y += ccw-pong.o
diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
new file mode 100644
index 0000000000..292124721d
--- /dev/null
+++ b/hw/s390x/ccw-pong.c
@@ -0,0 +1,134 @@
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
+static char buf[PONG_BUF_SIZE];
+
+static int pong_ccw_cb(SubchDev *sch, CCW1 ccw)
+{
+    int rc = 0;
+    static int value;
+    int len;
+
+    len = (ccw.count > PONG_BUF_SIZE) ? PONG_BUF_SIZE : ccw.count;
+    switch (ccw.cmd_code) {
+    case PONG_WRITE:
+        rc = ccw_dstream_read_buf(&sch->cds, buf, len);
+        value = atol(buf);
+        break;
+    case PONG_READ:
+        sprintf(buf, "%08x", value + 1);
+        rc = ccw_dstream_write_buf(&sch->cds, buf, len);
+        break;
+    default:
+        rc = -ENOSYS;
+        break;
+    }
+
+    sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
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
+    sch->id.cu_type = dev->cu_type;
+    css_sch_build_virtual_schib(sch, (uint8_t)chpid, CCW_PONG_CHPID_TYPE);
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
+    DEFINE_PROP_UINT16("cu_type", CcwPONGDevice, cu_type, CCW_PONG_CU_TYPE),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pong_ccw_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pong_ccw_properties);
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    dc->realize = pong_ccw_realize;
+    dc->hotpluggable = false;
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
index 0000000000..b14af7ca86
--- /dev/null
+++ b/include/hw/s390x/pong.h
@@ -0,0 +1,48 @@
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
+#define CCW_PONG_CU_TYPE    0xc0ca
+#define CCW_PONG_CHPID_TYPE 0xd0
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
+    uint16_t cu_type;
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
2.25.1


