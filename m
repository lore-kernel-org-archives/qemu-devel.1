Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2858CC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9C521548
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QOJitT/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9C521548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaPl-0006UK-Oy
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaH0-0008QE-Tv; Sun, 13 Sep 2020 18:15:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaGy-0001Cc-9K; Sun, 13 Sep 2020 18:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035300; x=1631571300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CW0BVyR6bNeY+qG0q1AfuS103n9Or4k7uMLgxuXCl2Y=;
 b=QOJitT/SZKA04m6uhbDDW/I+JsDGTxDCGdJ2A3/g9nU+1pmQbs4/bVK/
 bCqYawUzZiDFzV5yn1fJ8+OsIHArNMS/D6dxjA0gv9xEmBxN7Q8sSm56P
 Xi8mh9ZJMV3LVu3PJ2xQsk97vyuJk4d8JvSDbanELn/XCPD2Nq3hvQEFD
 g3jEb/1fIYwdrxdYjmoCcjW7RSUb0Br0lFIuBDVqn0JpcQMQXoiQNwA7W
 aW3q5UsFEoXwBWYo0n1J84Ft/vQjpxz26PjPaqZN87V/gANDf30XURB1W
 fxiG4SdINW/tfE2hOuK1hRLXkcU2IC2M7X0FGo/rBStKsfwVqKem1hoCv g==;
IronPort-SDR: 8NuMPSx5iBRN8ro0V3NGyyWny9YYQsERkPnWMgJxONX/XeQeUUAuKOCJ4ZECOVfN9kY/yfDxgY
 lRiUDS7URwWzkxGeUZ2l7keQPkzhKPTwlsVW/UCC5u+edclpSxrpTf9QarY4EAFvZ5vxMZ9FrQ
 HHNty63lNtBfA/Ev7UxcM+PoSfCEHWXybnRp1Qt78jR+CsYGn70VSBmD7KbdM4TtTwNypTy6WQ
 0qVLkQmJrafyctcN/y1R+EZ4rnirfOtXZMhuAKfejL0fFJkXEVBE43k1DOpFXf/djjr93evM3O
 eBk=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179055"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:14:59 +0800
IronPort-SDR: 0vhRDtTU9KXL2tuwHnU1QQ2CYH28sP3zoVJSREaMWN1/HkDm9GA2ecw8BQkygZISuSqF/Zh9l2
 JwP85ujQvhVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:02:11 -0700
IronPort-SDR: Iu0gcLpvtd7KUW3SzF3Cbo8dRtA+aOqBjr/ztgP9P6jLInySgpucO9qbuB6lwqgABNWvQyS105
 YMXFHFxPDNqA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:14:58 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 07/15] hw/block/nvme: Add support for active/inactive
 namespaces
Date: Mon, 14 Sep 2020 07:14:28 +0900
Message-Id: <20200913221436.22844-8-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
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
index d01c1c1e06..c740cbcf1f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1220,7 +1220,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1238,11 +1239,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1260,6 +1266,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     ns = &n->namespaces[nsid - 1];
     assert(nsid == ns->nsid);
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
     }
@@ -1267,7 +1277,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
@@ -1292,7 +1303,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+        if (i < min_nsid || (only_active && !n->namespaces[i].attached)) {
             continue;
         }
         list[j++] = cpu_to_le32(i + 1);
@@ -1306,7 +1317,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return ret;
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
@@ -1325,7 +1337,8 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
 
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+        if (i < min_nsid || c->csi != n->namespaces[i].csi ||
+            (only_active && !n->namespaces[i].attached)) {
             continue;
         }
         list[j++] = cpu_to_le32(i + 1);
@@ -1417,17 +1430,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
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
@@ -1869,6 +1890,7 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 {
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
+    int i;
 
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
@@ -1955,6 +1977,18 @@ static int nvme_start_ctrl(NvmeCtrl *n)
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


