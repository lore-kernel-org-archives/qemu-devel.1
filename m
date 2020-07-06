Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE99C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FDD20708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FDD20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKSl-0001t3-Di
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNt-0001hw-R7; Mon, 06 Jul 2020 02:13:45 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNr-0000wf-OQ; Mon, 06 Jul 2020 02:13:45 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C7EA4BF858;
 Mon,  6 Jul 2020 06:13:16 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 11/18] hw/block/nvme: add remaining mandatory controller
 parameters
Date: Mon,  6 Jul 2020 08:12:56 +0200
Message-Id: <20200706061303.246057-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706061303.246057-1-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 02:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add support for any remaining mandatory controller operating parameters
(features).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c       | 56 ++++++++++++++++++++++++++++++++++++++-----
 hw/block/trace-events |  2 ++
 include/block/nvme.h  | 10 +++++++-
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8fce2ebf69e7..2d85e853403f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -71,6 +71,20 @@
             " in %s: " fmt "\n", __func__, ## __VA_ARGS__); \
     } while (0)
 
+static const bool nvme_feature_support[NVME_FID_MAX] = {
+    [NVME_ARBITRATION]              = true,
+    [NVME_POWER_MANAGEMENT]         = true,
+    [NVME_TEMPERATURE_THRESHOLD]    = true,
+    [NVME_ERROR_RECOVERY]           = true,
+    [NVME_VOLATILE_WRITE_CACHE]     = true,
+    [NVME_NUMBER_OF_QUEUES]         = true,
+    [NVME_INTERRUPT_COALESCING]     = true,
+    [NVME_INTERRUPT_VECTOR_CONF]    = true,
+    [NVME_WRITE_ATOMICITY]          = true,
+    [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
+    [NVME_TIMESTAMP]                = true,
+};
+
 static void nvme_process_sq(void *opaque);
 
 static uint16_t nvme_cid(NvmeRequest *req)
@@ -1070,8 +1084,20 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
     uint32_t result;
+    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
+    uint16_t iv;
 
-    switch (dw10) {
+    static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
+        [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
+    };
+
+    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
+
+    if (!nvme_feature_support[fid]) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (fid) {
     case NVME_TEMPERATURE_THRESHOLD:
         result = 0;
 
@@ -1101,6 +1127,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = (n->params.max_ioqpairs - 1) |
             ((n->params.max_ioqpairs - 1) << 16);
         trace_pci_nvme_getfeat_numq(result);
+        break;
+    case NVME_INTERRUPT_VECTOR_CONF:
+        iv = dw11 & 0xffff;
+        if (iv >= n->params.max_ioqpairs + 1) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result = iv;
+        if (iv == n->admin_cq.vector) {
+            result |= NVME_INTVC_NOCOALESCING;
+        }
+
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         result = n->features.async_config;
@@ -1108,8 +1146,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
     default:
-        trace_pci_nvme_err_invalid_getfeat(dw10);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        result = nvme_feature_default[fid];
+        break;
     }
 
     req->cqe.result = cpu_to_le32(result);
@@ -1138,8 +1176,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
+    uint8_t fid = NVME_GETSETFEAT_FID(dw10);
 
-    switch (dw10) {
+    trace_pci_nvme_setfeat(nvme_cid(req), fid, dw11);
+
+    if (!nvme_feature_support[fid]) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (fid) {
     case NVME_TEMPERATURE_THRESHOLD:
         if (NVME_TEMP_TMPSEL(dw11) != NVME_TEMP_TMPSEL_COMPOSITE) {
             break;
@@ -1186,8 +1231,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
     default:
-        trace_pci_nvme_err_invalid_setfeat(dw10);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
     return NVME_SUCCESS;
 }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 091af16ca7d7..42e62f4649f8 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,8 @@ pci_nvme_identify_ctrl(void) "identify controller"
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
+pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
+pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" cdw11 0x%"PRIx32""
 pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
 pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
 pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 0dce15af6bcf..cd396111b2f5 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -662,6 +662,7 @@ enum NvmeStatusCodes {
     NVME_FW_REQ_RESET           = 0x010b,
     NVME_INVALID_QUEUE_DEL      = 0x010c,
     NVME_FID_NOT_SAVEABLE       = 0x010d,
+    NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FID_NOT_NSID_SPEC      = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
     NVME_CONFLICTING_ATTRS      = 0x0180,
@@ -866,6 +867,7 @@ enum NvmeIdCtrlLpa {
 #define NVME_CTRL_SGLS_ADDR_OFFSET         (0x1 << 20)
 
 #define NVME_ARB_AB(arb)    (arb & 0x7)
+#define NVME_ARB_AB_NOLIMIT 0x7
 #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
 #define NVME_ARB_MPW(arb)   ((arb >> 16) & 0xff)
 #define NVME_ARB_HPW(arb)   ((arb >> 24) & 0xff)
@@ -873,6 +875,8 @@ enum NvmeIdCtrlLpa {
 #define NVME_INTC_THR(intc)     (intc & 0xff)
 #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
 
+#define NVME_INTVC_NOCOALESCING (0x1 << 16)
+
 #define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
 #define NVME_TEMP_THSEL_OVER   0x0
 #define NVME_TEMP_THSEL_UNDER  0x1
@@ -899,9 +903,13 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
-    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
+    NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
+    NVME_FID_MAX                    = 0x100,
 };
 
+#define NVME_GETSETFEAT_FID_MASK 0xff
+#define NVME_GETSETFEAT_FID(dw10) (dw10 & NVME_GETSETFEAT_FID_MASK)
+
 typedef struct NvmeRangeType {
     uint8_t     type;
     uint8_t     attributes;
-- 
2.27.0


