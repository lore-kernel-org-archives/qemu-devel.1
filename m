Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178FF2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178FF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZM6n-0008B9-6R
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 18:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jZM5k-0007gO-3h; Thu, 14 May 2020 18:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jZM5i-00070Q-O6; Thu, 14 May 2020 18:12:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04EM349Q188899; Thu, 14 May 2020 18:12:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310tjpnc4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 18:12:30 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EMCCgG014839;
 Thu, 14 May 2020 18:12:30 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310tjpnc3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 18:12:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EM6BG6016675;
 Thu, 14 May 2020 22:12:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 3100ubce61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 22:12:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04EMCPqu61931542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 22:12:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA73352050;
 Thu, 14 May 2020 22:12:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7BF765204F;
 Thu, 14 May 2020 22:12:24 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if PV
Date: Fri, 15 May 2020 00:11:55 +0200
Message-Id: <20200514221155.32079-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_07:2020-05-14,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140193
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 18:12:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio specification tells that the device is to present
VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
device "can only access certain memory addresses with said access
specified and/or granted by the platform". This is the case for a
protected VMs, as the device can access only memory addresses that are
in pages that are currently shared (only the guest can share/unsare its
pages).

No VM, however, starts out as a protected VM, but some VMs may be
converted to protected VMs if the guest decides so.

Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
the property iommu_on is a minor disaster. Since the correctness of the
paravirtualized virtio devices depends (and thus in a sense the
correctness of the hypervisor) it, then the hypervisor should have the
last word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or
not.

Currently presenting a PV guest with a (paravirtualized) virtio-ccw
device has catastrophic consequences for the VM (after the hypervisors
access to protected memory). This is especially grave in case of device
hotplug (because in this case the guest is more likely to be in the
middle of something important).

Let us manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
for virtio-ccw devices, i.e. force it before we start the protected VM.
If the VM should cease to be protected, the original value is restored.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

NOTES:

* Doing more system_resets() is a big hack.  We should look into this.
* The user interface implications of this patch are also an ugly can of
worms. We need to discuss them.


v1 --> v2:
* Use the default or user supplied iommu_on flag when when !PV
* Use virtio functions for feature manipulation

Link to v1:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg683775.html

Unfortunately the v1 did not see much discussion because we had more
pressing issues.

---
 hw/s390x/s390-virtio-ccw.c |  2 ++
 hw/s390x/virtio-ccw.c      | 14 ++++++++++++++
 hw/s390x/virtio-ccw.h      |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f660070d22..705e6b153a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -330,6 +330,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
     migrate_del_blocker(pv_mig_blocker);
     error_free_or_abort(&pv_mig_blocker);
     qemu_balloon_inhibit(false);
+    subsystem_reset();
 }
 
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -382,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     if (rc) {
         goto out_err;
     }
+    subsystem_reset();
     return rc;
 
 out_err:
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 64f928fc7d..67d5bc68ba 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -874,6 +874,20 @@ static void virtio_ccw_reset(DeviceState *d)
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
     VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
+    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
+
+    /*
+     * An attempt to use a paravirt device without VIRTIO_F_IOMMU_PLATFORM
+     * in PV, has catastrophic consequences for the VM. Let's force
+     * VIRTIO_F_IOMMU_PLATFORM not already specified.
+     */
+    if (ms->pv && !virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
+        dev->forced_iommu_platform = true;
+    } else if (!ms->pv && dev->forced_iommu_platform) {
+        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
+        dev->forced_iommu_platform = false;
+    }
 
     virtio_ccw_reset_virtio(dev, vdev);
     if (vdc->parent_reset) {
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3453aa1f98..34ff7b0b4e 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -99,6 +99,7 @@ struct VirtioCcwDevice {
     IndAddr *summary_indicator;
     uint64_t ind_bit;
     bool force_revision_1;
+    bool forced_iommu_platform;
 };
 
 /* The maximum virtio revision we support. */

base-commit: 0ffd3d64bd1bb8b84950e52159a0062fdab34628
-- 
2.17.1


