Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356FEC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E9A2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 04:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E9A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVT6e-0002Im-2P
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 23:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iVT5h-0001gY-Gn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iVT5g-0000mS-BI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:20:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59602
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iVT5g-0000mE-6i
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 23:20:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAF3YThV117964
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:25 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtv6qd7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:23 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 15 Nov 2019 03:34:41 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 03:34:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAF3YcYC54525998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 03:34:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C75DA405C;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 417EDA4054;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id A70A7E02B8; Fri, 15 Nov 2019 04:34:37 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [RFC PATCH v1 7/8] vfio-ccw: Refactor ccw irq handler
Date: Fri, 15 Nov 2019 04:34:36 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115033437.37926-1-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111503-0012-0000-0000-00000363C327
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111503-0013-0000-0000-0000219F3EE0
Message-Id: <20191115033437.37926-8-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_07:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=2
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=833
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150029
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it easier to add new ones in the future.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 55 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2b1a83b94c..b16526d5de 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -334,22 +334,35 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
+static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev, int irq,
+                                           Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
     struct vfio_irq_info *irq_info;
     size_t argsz;
     int fd;
+    EventNotifier *notifier;
+    IOHandler *fd_read;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        fd_read = vfio_ccw_io_notifier_handler;
+        break;
+    default:
+        error_setg(errp, "vfio: Unsupported device irq(%d) fd: %m", irq);
+        return;
+    }
 
-    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
-        error_setg(errp, "vfio: unexpected number of io irqs %u",
+    if (vdev->num_irqs < irq + 1) {
+        error_setg(errp, "vfio: unexpected number of irqs %u",
                    vdev->num_irqs);
         return;
     }
 
     argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
-    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
+    irq_info->index = irq;
     irq_info->argsz = argsz;
     if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
               irq_info) < 0 || irq_info->count < 1) {
@@ -357,37 +370,47 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
         goto out_free_info;
     }
 
-    if (event_notifier_init(&vcdev->io_notifier, 0)) {
+    if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
-                         "vfio: Unable to init event notifier for IO");
+                         "vfio: Unable to init event notifier for irq (%d)", irq);
         goto out_free_info;
     }
 
-    fd = event_notifier_get_fd(&vcdev->io_notifier);
-    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
+    fd = event_notifier_get_fd(notifier);
+    qemu_set_fd_handler(fd, fd_read, NULL, vcdev);
 
-    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+    if (vfio_set_irq_signaling(vdev, irq, 0,
                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
-        event_notifier_cleanup(&vcdev->io_notifier);
+        event_notifier_cleanup(notifier);
     }
 
 out_free_info:
     g_free(irq_info);
 }
 
-static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
+static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev, int irq)
 {
     Error *err = NULL;
+    EventNotifier *notifier;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        break;
+    default:
+        error_report("vfio: Unsupported device irq(%d) fd: %m", irq);
+        return;
+    }
 
-    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+    if (vfio_set_irq_signaling(&vcdev->vdev, irq, 0,
                                VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
     }
 
-    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
+    qemu_set_fd_handler(event_notifier_get_fd(notifier),
                         NULL, NULL, vcdev);
-    event_notifier_cleanup(&vcdev->io_notifier);
+    event_notifier_cleanup(notifier);
 }
 
 static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
@@ -590,7 +613,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_region_err;
     }
 
-    vfio_ccw_register_io_notifier(vcdev, &err);
+    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
     if (err) {
         goto out_notifier_err;
     }
@@ -619,7 +642,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
-    vfio_ccw_unregister_io_notifier(vcdev);
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
     vfio_put_group(group);
-- 
2.17.1


