Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F1C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F8E214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F8E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpGW-00060f-KT
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1izoxd-0002x6-Bi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1izoxa-0007Kr-NH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1izoxa-0007H3-Bf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:45:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 016LiakZ128862
 for <qemu-devel@nongnu.org>; Thu, 6 Feb 2020 16:45:17 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y0mpnnspc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 16:45:17 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Thu, 6 Feb 2020 21:45:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Feb 2020 21:45:12 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 016LjA9k64159958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 21:45:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6471AE053;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ED5AAE04D;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu,  6 Feb 2020 21:45:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 196E8E0287; Thu,  6 Feb 2020 22:45:09 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: [RFC PATCH v2 6/7] vfio-ccw: Refactor ccw irq handler
Date: Thu,  6 Feb 2020 22:45:08 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206214509.16434-1-farman@linux.ibm.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20020621-0008-0000-0000-000003506F4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020621-0009-0000-0000-00004A710495
Message-Id: <20200206214509.16434-7-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-06_04:2020-02-06,
 2020-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=2 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060158
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it easier to add new ones in the future.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v1->v2:
     - Make irq parameter unsigned [CH]
     - Remove extraneous %m from error_report calls [CH]

 hw/vfio/ccw.c | 57 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d2408f3357..044441a277 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -335,22 +335,36 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
+static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
+                                           unsigned int irq,
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
+        error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
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
@@ -358,37 +372,48 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
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
+static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
+                                             unsigned int irq)
 {
     Error *err = NULL;
+    EventNotifier *notifier;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        break;
+    default:
+        error_report("vfio: Unsupported device irq(%d)", irq);
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
@@ -591,7 +616,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_region_err;
     }
 
-    vfio_ccw_register_io_notifier(vcdev, &err);
+    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
     if (err) {
         goto out_notifier_err;
     }
@@ -620,7 +645,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
-    vfio_ccw_unregister_io_notifier(vcdev);
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
     vfio_put_group(group);
-- 
2.17.1


