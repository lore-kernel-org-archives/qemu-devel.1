Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA0C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1EC20731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k7orfZzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1EC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHESV-0008TU-JD
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQ5-00043m-AK; Sat, 12 Sep 2020 18:54:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEQ2-0005R7-Lw; Sat, 12 Sep 2020 18:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951294; x=1631487294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JSDNzq2YRZFWgQQ5laOdIp5GgR3BkqG8oSkdubzhgO8=;
 b=k7orfZzwdxVmDo2P241OplY7+E8YpDTqnGfTEHp1ygWzisVYMQT1da79
 rqMi+l0NuwCX6ZDHGaHfbR4TfPRBOWUR11DuxSGRvJCZ0nCxrCwRA7YRv
 WLSHLF8BlWZxewJmnicoDlDTut67/KyTZkUpY2VYW2xLSa1bHBnKzpZcv
 34f2t0tZPgqm3choaWu88JS3dFps2iJ4y0naocVq31thrQbJTzoreor8L
 a3jsPOAa/uJxA9ZG0v7e+Z120Cj1VAQJ7jGzZj7PTZtZWaaLy0cBjt14o
 Ky2BVyCXIEcG2MXSZs3uEhxicnySOYCmewLVfeLAN4PX8oFE5fb+bLGVJ w==;
IronPort-SDR: XVzY9q64VtWmkb7aY0/IQFTembI9SBFExHg0DdW/s0KW/WPpipnvH1g6DOYqWogLauHhy9Xv1X
 5ixedDMOizWglftvbAuDwKy9vpchiuezE++sFVFu/c/ArNn37ZeIr7rmtrIRD59HUAloC3crWL
 wqvZoLx7XE8h1ehZT4rClprNX1P+fGbS9bcGqI5FI8dXDpRl5GVPoJqlTvWxwy53DKf0eTuMgL
 z+Aie1UHqCNFcHjxkSBbbYoEnVqEXPMz45gNZkwbU/L8HlqMhHK7B5u69IHEGB6R59I6tVsAft
 LiU=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834852"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:54:52 +0800
IronPort-SDR: WmDt/lo5i97H9Ju0jc5sqGeGzzLAamFMHRObdK56/M49zhMqvbYMsC3hLKwxKyfvcpWdNQv5HI
 +bRHSsMpToGQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:13 -0700
IronPort-SDR: 1d7E9fjzi06GMMTpiOhiQduQYRQmMi29ITMUOBEZeXp0MQxLW7i9Gti2HUY48IsEGoK1WYlHp4
 fqpxtzQUG1IQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:54:51 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 07/15] hw/block/nvme: Add support for active/inactive
 namespaces
Date: Sun, 13 Sep 2020 07:54:22 +0900
Message-Id: <20200912225430.1772-8-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niklas Cassel <niklas.cassel@wdc.com>

In NVMe, a namespace is active if it exists and is attached to the
controller.

CAP.CSS (together with the I/O Command Set data structure) defines what
command sets are supported by the controller.

CC.CSS (together with Set Profile) can be set to enable a subset of the
available command sets. The namespaces belonging to a disabled command set
will not be able to attach to the controller, and will thus be inactive.

E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should be
marked as inactive.

The identify namespace, the identify namespace CSI specific, and the namespace
list commands have two different versions, one that only shows active
namespaces, and the other version that shows existing namespaces, regardless
of whether the namespace is attached or not.

Add an attached member to struct NvmeNamespace, and implement the missing CNS
commands.

The added functionality will also simplify the implementation of namespace
management in the future, since namespace management can also attach and
detach namespaces.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c      | 54 ++++++++++++++++++++++++++++++++++++--------
 hw/block/nvme.h      |  1 +
 include/block/nvme.h | 20 +++++++++-------
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 004f1c9578..6dd6bf9183 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1193,7 +1193,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1211,11 +1212,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
     ns = &n->namespaces[nsid - 1];
     assert(nsid == ns->nsid);
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    }
+
     return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     NvmeNamespace *ns;
@@ -1233,6 +1239,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     ns = &n->namespaces[nsid - 1];
     assert(nsid == ns->nsid);
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
     }
@@ -1240,7 +1250,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
@@ -1265,7 +1276,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+        if (i < min_nsid || (only_active && !n->namespaces[i].attached)) {
             continue;
         }
         list[j++] = cpu_to_le32(i + 1);
@@ -1279,7 +1290,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return ret;
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
@@ -1298,7 +1310,8 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+        if (i < min_nsid || c->csi != n->namespaces[i].csi ||
+            (only_active && !n->namespaces[i].attached)) {
             continue;
         }
         list[j++] = cpu_to_le32(i + 1);
@@ -1390,17 +1403,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+        return nvme_identify_ns(n, req, true);
     case NVME_ID_CNS_CS_NS:
-        return nvme_identify_ns_csi(n, req);
+        return nvme_identify_ns_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT:
+        return nvme_identify_ns(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT:
+        return nvme_identify_ns_csi(n, req, false);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_CS_CTRL:
         return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+        return nvme_identify_nslist(n, req, true);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist_csi(n, req);
+        return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT_LIST:
+        return nvme_identify_nslist(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT_LIST:
+        return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
     case NVME_ID_CNS_IO_COMMAND_SET:
@@ -1842,6 +1863,7 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 {
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
+    int i;
 
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
@@ -1928,6 +1950,18 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
         NVME_AQA_ASQS(n->bar.aqa) + 1);
 
+    for (i = 0; i < n->num_namespaces; i++) {
+        n->namespaces[i].attached = false;
+        switch (n->namespaces[i].csi) {
+        case NVME_CSI_NVM:
+            if (NVME_CC_CSS(n->bar.cc) == CSS_NVM_ONLY ||
+                NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+                n->namespaces[i].attached = true;
+            }
+            break;
+        }
+    }
+
     nvme_set_timestamp(n, 0ULL);
 
     QTAILQ_INIT(&n->aer_queue);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 252e2d5921..dec337bbf9 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -66,6 +66,7 @@ typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
     uint32_t        nsid;
     uint8_t         csi;
+    bool            attached;
     QemuUUID        uuid;
 } NvmeNamespace;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f2cff5aa6b..53b0463a2a 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -806,14 +806,18 @@ typedef struct QEMU_PACKED NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum NvmeIdCns {
-    NVME_ID_CNS_NS                = 0x00,
-    NVME_ID_CNS_CTRL              = 0x01,
-    NVME_ID_CNS_NS_ACTIVE_LIST    = 0x02,
-    NVME_ID_CNS_NS_DESCR_LIST     = 0x03,
-    NVME_ID_CNS_CS_NS             = 0x05,
-    NVME_ID_CNS_CS_CTRL           = 0x06,
-    NVME_ID_CNS_CS_NS_ACTIVE_LIST = 0x07,
-    NVME_ID_CNS_IO_COMMAND_SET    = 0x1c,
+    NVME_ID_CNS_NS                    = 0x00,
+    NVME_ID_CNS_CTRL                  = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST        = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST         = 0x03,
+    NVME_ID_CNS_CS_NS                 = 0x05,
+    NVME_ID_CNS_CS_CTRL               = 0x06,
+    NVME_ID_CNS_CS_NS_ACTIVE_LIST     = 0x07,
+    NVME_ID_CNS_NS_PRESENT_LIST       = 0x10,
+    NVME_ID_CNS_NS_PRESENT            = 0x11,
+    NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
+    NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
+    NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
-- 
2.21.0


