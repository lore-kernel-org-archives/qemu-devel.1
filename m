Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93734C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDEB20773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDEB20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNP3K-0006ct-Gq
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuE-0000ba-Bs; Tue, 29 Sep 2020 19:19:34 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuC-00008v-7L; Tue, 29 Sep 2020 19:19:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 3E465F56;
 Tue, 29 Sep 2020 19:19:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=bQBaNVsviUuNq
 Z4cWVhi6pXtTyURdFG4wBBhMYKvQ84=; b=P6Ywob8A1079YPpErF0Ma2a+PXuBo
 NDYIpBypFzHkArPBMYDCW/6asqMNMBh6rpoJAju0R+w+2aykZFIEp82C/Ii3asm2
 Xj9eeckoM45V1ppx9b6GZLQNVjWZSStZJVfB443LPxk7xhm1BPsspBHO5FyTixsY
 XZiw+R5JKTGmKmCOO2wgZQRCqL0oWsMlQxYKREafcIMHHfjvnajHcZ4yn7pX6Utb
 eMqLk1T39ED++MkVSNjb9EXIIb7LzZ+wR58lE0f/l5bLJqvHfEEB79Iu4mvVp5Z7
 XERd+Rwr0dfxy41XlmpLyRCUOZC0lsIlLvnOoCGOv/t6nGKyJeNkcRGTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=bQBaNVsviUuNqZ4cWVhi6pXtTyURdFG4wBBhMYKvQ84=; b=tUBeeAd7
 4Fxf5E07j1MiGrDW1cAXHj4CAPk8h9Xmv+PRyf8GcOVWl3qLpNrOi1JbvwosN3zO
 /+TWIBFNBw3UrWajhgS9oO9e6LkUfjk6sR3vBF6MjvES1RCZhBzcKEWVvPBjkGCi
 9VlvwFabJEPykW71XZxTC8Kdzxr+U1zYCjqXh4kslTyb9y+dEiPptcOS8PFNZf8O
 NuuFnzEVepsuP5A6+VC0dMY0X47ttap6b81Wvn9QS4XUqBeNqA9I45ow2sYjnvgN
 HeH1OfPXfjWfYKyrc6S94OntjJOj7eK/9JShS8ixNKeplGbzMjMcwNq75oEKaKxA
 g64/I728iE6rNA==
X-ME-Sender: <xms:AcFzX1jNw5ii3fR9oMWq8qOEJu2dnJMIEKaJ6kZZ9SQP9b_co0LZPA>
 <xme:AcFzX6Ca8dr2gL2vc111DPRfmJaXunzjCE2swJuHM-qv2fBYcooysR-MKJo6-Avgv
 T8EjIM_iv7mHUJ6dD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepvdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:AcFzX1HuqowntGG_ylX2duRvpqz71sk7i5tP0yrBQK7N3wozM2vPaA>
 <xmx:AcFzX6Sqc6wbDONlMaoWtjmufSNBPdlSL7SZzjbH66jCM4C1cBH2iQ>
 <xmx:AcFzXyzEAhznhZKR6IPW92DZF6Kla-S7e5xAUDbhBH0na1qjUvmkqQ>
 <xmx:AcFzX5k4nwgWMnwGv4aFEuFql--6jpnNX3reY9eGdqbxKrIKiGkU1uOHS44>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5DA113280064;
 Tue, 29 Sep 2020 19:19:28 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/14] hw/block/nvme: add commands supported and effects
 log page
Date: Wed, 30 Sep 2020 01:19:10 +0200
Message-Id: <20200929231917.433586-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This is to support for the Commands Supported and Effects log page. See
NVM Express Spec 1.3d, sec. 5.14.1.5 ("Commands Supported and Effects")

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 21 +++++++++++++
 hw/block/nvme.c      | 75 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index abd49d371e63..5a5e19f6bedc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -734,6 +734,24 @@ typedef struct QEMU_PACKED NvmeSmartLog {
     uint8_t     reserved2[320];
 } NvmeSmartLog;
 
+typedef struct QEMU_PACKED NvmeEffectsLog {
+    uint32_t acs[256];
+    uint32_t iocs[256];
+    uint8_t  rsvd2048[2048];
+} NvmeEffectsLog;
+
+enum {
+    NVME_EFFECTS_CSUPP      = 1 <<  0,
+    NVME_EFFECTS_LBCC       = 1 <<  1,
+    NVME_EFFECTS_NCC        = 1 <<  2,
+    NVME_EFFECTS_NIC        = 1 <<  3,
+    NVME_EFFECTS_CCC        = 1 <<  4,
+    NVME_EFFECTS_CSE_SINGLE = 1 << 16,
+    NVME_EFFECTS_CSE_MULTI  = 1 << 17,
+    NVME_EFFECTS_CSE_MASK   = 3 << 16,
+    NVME_EFFECTS_UUID_SEL   = 1 << 19,
+};
+
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
     NVME_SMART_TEMPERATURE            = 1 << 1,
@@ -746,6 +764,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_EFFECTS        = 0x05,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -857,6 +876,7 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
+    NVME_LPA_EFFECTS_LOG  = 1 << 1,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
@@ -1064,5 +1084,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
 }
 #endif
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index be5a0a7dfa09..0bc19a1e3688 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -81,6 +81,7 @@
 #define NVME_TEMPERATURE_WARNING 0x157
 #define NVME_TEMPERATURE_CRITICAL 0x175
 #define NVME_NUM_FW_SLOTS 1
+#define NVME_MAX_ADM_IO_CMDS 0xFF
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -112,6 +113,46 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
 };
 
+#define NVME_EFFECTS_ADMIN_INITIALIZER                 \
+    [NVME_ADM_CMD_DELETE_SQ]    = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_CREATE_SQ]    = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_GET_LOG_PAGE] = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_DELETE_CQ]    = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_CREATE_CQ]    = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_IDENTIFY]     = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_ABORT]        = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_SET_FEATURES] = NVME_EFFECTS_CSUPP | \
+                                  NVME_EFFECTS_CCC |   \
+                                  NVME_EFFECTS_NIC |   \
+                                  NVME_EFFECTS_NCC,    \
+    [NVME_ADM_CMD_GET_FEATURES] = NVME_EFFECTS_CSUPP,  \
+    [NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_EFFECTS_CSUPP
+
+#define NVME_EFFECTS_NVM_INITIALIZER                   \
+    [NVME_CMD_FLUSH]            = NVME_EFFECTS_CSUPP | \
+                                  NVME_EFFECTS_LBCC,   \
+    [NVME_CMD_WRITE]            = NVME_EFFECTS_CSUPP | \
+                                  NVME_EFFECTS_LBCC,   \
+    [NVME_CMD_READ]             = NVME_EFFECTS_CSUPP,  \
+    [NVME_CMD_WRITE_ZEROES]     = NVME_EFFECTS_CSUPP | \
+                                  NVME_EFFECTS_LBCC
+
+static const NvmeEffectsLog nvme_effects_admin_only = {
+    .acs = {
+        NVME_EFFECTS_ADMIN_INITIALIZER,
+    },
+};
+
+static const NvmeEffectsLog nvme_effects = {
+    .acs = {
+        NVME_EFFECTS_ADMIN_INITIALIZER,
+    },
+
+    .iocs = {
+        NVME_EFFECTS_NVM_INITIALIZER,
+    },
+};
+
 static void nvme_process_sq(void *opaque);
 
 static uint16_t nvme_cid(NvmeRequest *req)
@@ -1382,6 +1423,36 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
+                                 NvmeRequest *req)
+{
+    const NvmeEffectsLog *effects;
+
+    uint32_t trans_len;
+
+    if (off > sizeof(NvmeEffectsLog)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (NVME_CC_CSS(n->bar.cc)) {
+    case NVME_CC_CSS_ADMIN_ONLY:
+        effects = &nvme_effects_admin_only;
+        break;
+
+    case NVME_CC_CSS_NVM:
+        effects = &nvme_effects;
+        break;
+
+    default:
+        return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
+    }
+
+    trans_len = MIN(sizeof(NvmeEffectsLog) - off, buf_len);
+
+    return nvme_dma(n, (uint8_t *)effects + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -1425,6 +1496,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_EFFECTS:
+        return nvme_effects_log(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -2858,7 +2931,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_EFFECTS_LOG | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
-- 
2.28.0


