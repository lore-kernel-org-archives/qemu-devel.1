Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A07DC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D39A20818
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D39A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSaQ-0005zA-Db
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsB-0001Zm-HF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRs9-00023w-9n
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31202
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRs6-0001Rm-V8; Tue, 01 Oct 2019 19:48:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlP46078942; Tue, 1 Oct 2019 19:47:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcc4f00u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:34 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlXRH079208;
 Tue, 1 Oct 2019 19:47:34 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcc4f00tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:33 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlYh029380;
 Tue, 1 Oct 2019 23:47:33 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 2v9y59fahc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:33 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlWUG49021242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:32 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41CA32805A;
 Tue,  1 Oct 2019 23:47:32 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2602E28058;
 Tue,  1 Oct 2019 23:47:32 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:32 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/97] virtio-balloon: fix QEMU 4.0 config size migration
 incompatibility
Date: Tue,  1 Oct 2019 18:45:17 -0500
Message-Id: <20191001234616.7825-39-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The virtio-balloon config size changed in QEMU 4.0 even for existing
machine types.  Migration from QEMU 3.1 to 4.0 can fail in some
circumstances with the following error:

  qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10 read: a1 device: 1 cmask: ff wmask: c0 w1cmask:0

This happens because the virtio-balloon config size affects the VIRTIO
Legacy I/O Memory PCI BAR size.

Introduce a qdev property called "qemu-4-0-config-size" and enable it
only for the QEMU 4.0 machine types.  This way <4.0 machine types use
the old size, 4.0 uses the larger size, and >4.0 machine types use the
appropriate size depending on enabled virtio-balloon features.

Live migration to and from old QEMUs to QEMU 4.1 works again as long as
a versioned machine type is specified (do not use just "pc"!).

Originally-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190710141440.27635-1-stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2bbadb08ce272d65e1f78621002008b07d1e0f03)
 Conflicts:
	hw/core/machine.c
* drop context dep. on 0a71966253c
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/machine.c                  |  5 ++++-
 hw/virtio/virtio-balloon.c         | 28 +++++++++++++++++++++++++---
 include/hw/virtio/virtio-balloon.h |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index eb34f53a85..55b08f1466 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,7 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
-GlobalProperty hw_compat_4_0[] = {};
+GlobalProperty hw_compat_4_0[] = {
+    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
+};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
 GlobalProperty hw_compat_3_1[] = {
@@ -39,6 +41,7 @@ GlobalProperty hw_compat_3_1[] = {
     { "usb-tablet", "serial", "42" },
     { "virtio-blk-device", "discard", "false" },
     { "virtio-blk-device", "write-zeroes", "false" },
+    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 2112874055..5579260fd4 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -615,6 +615,22 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
     return 0;
 }
 
+static size_t virtio_balloon_config_size(VirtIOBalloon *s)
+{
+    uint64_t features = s->host_features;
+
+    if (s->qemu_4_0_config_size) {
+        return sizeof(struct virtio_balloon_config);
+    }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return sizeof(struct virtio_balloon_config);
+    }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        return offsetof(struct virtio_balloon_config, poison_val);
+    }
+    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
@@ -635,7 +651,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
     }
 
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
-    memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
+    memcpy(config_data, &config, virtio_balloon_config_size(dev));
 }
 
 static int build_dimm_list(Object *obj, void *opaque)
@@ -679,7 +695,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     uint32_t oldactual = dev->actual;
     ram_addr_t vm_ram_size = get_current_ram_size();
 
-    memcpy(&config, config_data, sizeof(struct virtio_balloon_config));
+    memcpy(&config, config_data, virtio_balloon_config_size(dev));
     dev->actual = le32_to_cpu(config.actual);
     if (dev->actual != oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
@@ -766,7 +782,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
     int ret;
 
     virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
-                sizeof(struct virtio_balloon_config));
+                virtio_balloon_config_size(s));
 
     ret = qemu_add_balloon_handler(virtio_balloon_to_target,
                                    virtio_balloon_stat, s);
@@ -897,6 +913,12 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    /* QEMU 4.0 accidentally changed the config size even when free-page-hint
+     * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
+     * property retains this quirk for QEMU 4.1 machine types.
+     */
+    DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
+                     qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 1afafb12f6..5a99293a45 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -71,6 +71,8 @@ typedef struct VirtIOBalloon {
     int64_t stats_poll_interval;
     uint32_t host_features;
     PartiallyBalloonedPage *pbp;
+
+    bool qemu_4_0_config_size;
 } VirtIOBalloon;
 
 #endif
-- 
2.17.1


