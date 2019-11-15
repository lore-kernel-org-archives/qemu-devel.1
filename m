Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C16EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F73020723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 03:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVSbE-0003Kn-Ah
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 22:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iVSYM-0000vU-DT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iVSYK-0002Dj-PJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:45:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55582
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iVSYK-0002Cn-L8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 22:45:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAF3YTXM118046
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9jtv6qhd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 22:35:29 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 15 Nov 2019 03:34:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Nov 2019 03:34:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAF3Ycba52953192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 03:34:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EAC352052;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3565E5204F;
 Fri, 15 Nov 2019 03:34:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id A9836E02BB; Fri, 15 Nov 2019 04:34:37 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [RFC PATCH v1 8/8] vfio-ccw: Add support for the CRW irq
Date: Fri, 15 Nov 2019 04:34:37 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115033437.37926-1-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19111503-4275-0000-0000-0000037DDC76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111503-4276-0000-0000-00003891447D
Message-Id: <20191115033437.37926-9-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_07:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
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

From: Farhan Ali <alifm@linux.ibm.com>

The CRW irq will be used by vfio-ccw to notify the userspace
about any CRWs the userspace needs to handle. Let's add support
for it.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v0->v1: [EF]
     - Check vcdev->crw_region before registering the irq,
       in case host kernel does not have matching support
     - Split the refactoring changes to an earlier (new) patch
       (and don't remove the "num_irqs" check in the register
       routine, but adjust it to the check the input variable)
     - Don't revert the cool vfio_set_irq_signaling() stuff
     - Unregister CRW IRQ before IO IRQ in unrealize
     - s/crw1/crw0/

 hw/vfio/ccw.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index b16526d5de..b3f4120118 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -48,6 +48,7 @@ struct VFIOCCWDevice {
     uint64_t crw_region_offset;
     struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
+    EventNotifier crw_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
 };
@@ -259,6 +260,34 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_crw_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+    struct ccw_crw_region *region = vcdev->crw_region;
+    CRW crw;
+    int size;
+    uint8_t erc;
+    uint16_t rsid;
+
+    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
+        return;
+    }
+
+    memset(region, 0, sizeof(*region));
+    size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
+                 vcdev->crw_region_offset);
+
+    if (size == -1) {
+        error_report("vfio-ccw: Read crw region failed with errno=%d", errno);
+        return;
+    }
+
+    memcpy(&crw, &region->crw0, sizeof(CRW));
+    erc = crw.flags & 0x003f;
+    rsid = crw.rsid;
+    css_queue_crw(CRW_RSC_CHP, erc, 0, 0, rsid);
+}
+
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
@@ -349,6 +378,10 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev, int irq,
         notifier = &vcdev->io_notifier;
         fd_read = vfio_ccw_io_notifier_handler;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        fd_read = vfio_ccw_crw_notifier_handler;
+        break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d) fd: %m", irq);
         return;
@@ -398,6 +431,9 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev, int irq)
     case VFIO_CCW_IO_IRQ_INDEX:
         notifier = &vcdev->io_notifier;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d) fd: %m", irq);
         return;
@@ -618,6 +654,14 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_notifier_err;
     }
 
+    if (vcdev->crw_region) {
+        vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX, &err);
+        if (err) {
+            vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
+            goto out_notifier_err;
+        }
+    }
+
     return;
 
 out_notifier_err:
@@ -642,6 +686,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
-- 
2.17.1


