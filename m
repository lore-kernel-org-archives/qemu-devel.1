Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D0C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD57B206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD57B206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxEn-0000Tv-Pl
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jVx9I-00084k-BC; Tue, 05 May 2020 08:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1jVx9H-0000ck-8n; Tue, 05 May 2020 08:58:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 045CYn2D098946; Tue, 5 May 2020 08:58:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30s28ga09x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 08:58:09 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045CmGxF137619;
 Tue, 5 May 2020 08:58:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30s28ga05v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 08:58:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045CttJx011482;
 Tue, 5 May 2020 12:58:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 30s0g5pya7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:58:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 045CumTF63177132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2020 12:56:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB7E1A4055;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B45CDA405B;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  5 May 2020 12:57:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 2352DE092D; Tue,  5 May 2020 14:57:57 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v4 6/6] vfio-ccw: Add support for the CRW region and IRQ
Date: Tue,  5 May 2020 14:57:57 +0200
Message-Id: <20200505125757.98209-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505125757.98209-1-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-05_07:2020-05-04,
 2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=2
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 08:42:20
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Farhan Ali <alifm@linux.ibm.com>

The crw region can be used to obtain information about
Channel Report Words (CRW) from vfio-ccw driver.

Currently only channel-path related CRWs are passed to
QEMU from vfio-ccw driver.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---

Notes:
    v3->v4:
     - Merge region patch into IRQ patch [CH]
     - Rework the testing/clearing notifier and reading region [CH]
    
    v2->v3:
     - Remove "size==0" check in CRW notifier [CH]
     - Remove intermediate rsc/erc variables, use css_queue_crw_cont() [CH]
     - s/crw0/crw/ [CH]
    
    v1->v2:
     - Add a loop to continually read region while data is
       present, queueing CRWs as found [CH]
    
    v0->v1: [EF]
     - Fixed copy/paste error in error message (s/schib/CRW)
     - Check vcdev->crw_region before registering the irq,
       in case host kernel does not have matching support
     - Split the refactoring changes to an earlier (new) patch
       (and don't remove the "num_irqs" check in the register
       routine, but adjust it to the check the input variable)
     - Don't revert the cool vfio_set_irq_signaling() stuff
     - Unregister CRW IRQ before IO IRQ in unrealize
     - s/crw1/crw0/

 hw/vfio/ccw.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 3ca2d83a30..5b620f97c3 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -44,7 +44,11 @@ struct VFIOCCWDevice {
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
+    uint64_t crw_region_size;
+    uint64_t crw_region_offset;
+    struct ccw_crw_region *crw_region;
     EventNotifier io_notifier;
+    EventNotifier crw_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
 };
@@ -261,6 +265,44 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_crw_read(VFIOCCWDevice *vcdev)
+{
+    struct ccw_crw_region *region = vcdev->crw_region;
+    CRW crw;
+    int size;
+
+    /* Keep reading CRWs as long as data is returned */
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
+        css_crw_add_to_queue(crw);
+    } while (1);
+}
+
+static void vfio_ccw_crw_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+
+    while (event_notifier_test_and_clear(&vcdev->crw_notifier)) {
+        vfio_ccw_crw_read(vcdev);
+    }
+}
+
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
@@ -347,6 +389,10 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
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
@@ -398,6 +444,9 @@ static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
     case VFIO_CCW_IO_IRQ_INDEX:
         notifier = &vcdev->io_notifier;
         break;
+    case VFIO_CCW_CRW_IRQ_INDEX:
+        notifier = &vcdev->crw_notifier;
+        break;
     default:
         error_report("vfio: Unsupported device irq(%d)", irq);
         return;
@@ -475,10 +524,24 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         vcdev->schib_region = g_malloc(info->size);
     }
 
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_CRW, &info);
+
+    if (!ret) {
+        vcdev->crw_region_size = info->size;
+        if (sizeof(*vcdev->crw_region) != vcdev->crw_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the CRW region");
+            goto out_err;
+        }
+        vcdev->crw_region_offset = info->offset;
+        vcdev->crw_region = g_malloc(info->size);
+    }
+
     g_free(info);
     return;
 
 out_err:
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -488,6 +551,7 @@ out_err:
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
+    g_free(vcdev->crw_region);
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
@@ -603,6 +667,14 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
@@ -627,6 +699,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_ccw_put_device(vcdev);
-- 
2.17.1


