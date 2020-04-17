Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE39221E8
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 02:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE39221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPGrL-0004gy-Hb
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 22:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq9-0003aT-6c
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jPGq8-0002Dq-0x
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7552
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jPGq7-0002DS-SX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 22:34:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03H2YCX0121482
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:47 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30f1w1amk4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 22:34:47 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
 Fri, 17 Apr 2020 03:34:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 17 Apr 2020 03:34:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03H2YfjG51707964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2020 02:34:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E7DBA4060;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17CEEA4054;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Apr 2020 02:34:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 810B7E089A; Fri, 17 Apr 2020 04:34:40 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 7/7] vfio-ccw: Add support for the CRW irq
Date: Fri, 17 Apr 2020 04:34:40 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417023440.70514-1-farman@linux.ibm.com>
References: <20200417023440.70514-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041702-0016-0000-0000-00000305ED1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041702-0017-0000-0000-00003369F3EC
Message-Id: <20200417023440.70514-8-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-16_10:2020-04-14,
 2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004170014
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
    v2->v3:
     - Remove "size==0" check in CRW notifier [CH]
     - Remove intermediate rsc/erc variables, use css_queue_crw_cont() [CH]
     - s/crw0/crw/ [CH]
    
    v1->v2:
     - Add a loop to continually read region while data is
       present, queueing CRWs as found [CH]
    
    v0->v1: [EF]
     - Check vcdev->crw_region before registering the irq,
       in case host kernel does not have matching support
     - Split the refactoring changes to an earlier (new) patch
       (and don't remove the "num_irqs" check in the register
       routine, but adjust it to the check the input variable)
     - Don't revert the cool vfio_set_irq_signaling() stuff
     - Unregister CRW IRQ before IO IRQ in unrealize
     - s/crw1/crw0/

 hw/vfio/ccw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ee3415a64a..cb4a331ced 100644
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
@@ -264,6 +265,39 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_crw_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+    struct ccw_crw_region *region = vcdev->crw_region;
+    CRW crw;
+    int size;
+
+    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
+        return;
+    }
+
+    do {
+        memset(region, 0, sizeof(*region));
+        size = pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
+                     vcdev->crw_region_offset);
+
+        if (size == -1) {
+            error_report("vfio-ccw: Read crw region failed with errno=%d",
+                         errno);
+            break;
+        }
+
+        if (region->crw == 0) {
+            /* No more CRWs to queue */
+            break;
+        }
+
+        memcpy(&crw, &region->crw, sizeof(CRW));
+
+        css_queue_crw_cont(crw);
+    } while (1);
+}
+
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
@@ -350,6 +384,10 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         notifier = &vcdev->io_notifier;
         fd_read = vfio_ccw_io_notifier_handler;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        fd_read = vfio_ccw_crw_notifier_handler;
+        break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
         return;
@@ -401,6 +439,9 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
     case VFIO_CCW_IO_IRQ_INDEX:
         notifier = &vcdev->io_notifier;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -621,6 +662,14 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
@@ -645,6 +694,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
-- 
2.17.1


