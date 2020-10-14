Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D070C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CF620725
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CF620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSf40-0005Fs-6e
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0I-0003Ce-5P; Wed, 14 Oct 2020 07:31:34 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0E-0006XZ-GZ; Wed, 14 Oct 2020 07:31:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 368CE580191;
 Wed, 14 Oct 2020 07:31:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=7OjmeYYNxp5gG
 fcnZDvOFvrWT/xn3J2K+mRdzwcuc04=; b=rrA8HxpWpJexXgxgg9AjHJZsqxtm1
 S5d7cN1fR5FsxIbNAM7xm6E0AyoHhWRpZfKUhiqBwxr0ODoI6y2oXBku0tAdFoSQ
 Ye95sFX2cwY+JSloL1bfXQE3PvUOGakC115fBU7hdLIDk4fgc8SchbBLugSNBUjR
 +NetDGslEdql1/QJ6K4H2/YnX/nCdEWNtwWybUCXPpsz51g9I0tz977ND9wKJY5m
 g6GRsmtX4ulrLgyYLrGtmqOg/sDWHBEg2w0tlpJeH2RulP6J27ieGAM1Ooje57KD
 MiRmn9K0w93koKKos5D6VkJb1YJPxi7AAQT+p0eJ+g44WyjWxv+rKde8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=7OjmeYYNxp5gGfcnZDvOFvrWT/xn3J2K+mRdzwcuc04=; b=A954HoDO
 E9dU6utE7gG6+r3b1T1W8UWIPWcsiSROzkBRWHxT4niJPMqq8DCrw32hseQNWSgM
 holF8hTE4Xr+PoQT9b9kKarhlWgT8Hp2Zl/jMCaVEx4XoGJS0dmffdyHJN5t1uFp
 pnPoAWz1uIjoTAofNqRw3Yl+/vSQVUR5oiotpCSvW4EBPz8PCofDhXdN/3uXuXUl
 O5nLplUoe6zCFVTejTFZLKEXgcucUSdhtZwi7+S1s7Uvo9x6tE9hKrDOI23vTwsr
 4gqFdnW4efB+L3iWEwoGUgwOy+TEblHebdiQXn6uQOaLrix8yauj4MPZX6ThRsr9
 Vmr6OQ0y6kv1pg==
X-ME-Sender: <xms:juGGX6-lsETsXQ-qzYHaM2jgzTIMTQLuVwbYDYkA7K3GY9W0_N1JvA>
 <xme:juGGX6vhW7sivhijHdPATArZnmsrAykE1HdqrDPgjKuJ6xGIAqDjRQvVYjDJ7XJhO
 W4tosgUhXmeguSd3VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:juGGXwAQ453cwI-1AUG6uUWd9_ENrDWDyzY8isHbzIL2_0BnuNlN9w>
 <xmx:juGGXyc88T5RG6ieSGHcnZBNpk7NGTAYOJuNIl-gXG0XS5qqo2KLmA>
 <xmx:juGGX_Nq-QphCPqOkqyZP31t8oXyQR4vPYJFcDvGseQx1k4WfMZ7LQ>
 <xmx:juGGX6cs_Z1WsQDcjXpCWER9w6heI-s3CuCrHOQ3PqZZnXpGO25u0Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7CBC63064674;
 Wed, 14 Oct 2020 07:31:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] hw/block/nvme: add commands supported and effects log
 page
Date: Wed, 14 Oct 2020 13:31:14 +0200
Message-Id: <20201014113122.388849-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014113122.388849-1-its@irrelevant.dk>
References: <20201014113122.388849-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This is to support for the Commands Supported and Effects log page. See
NVM Express Spec 1.3d, sec. 5.14.1.5 ("Commands Supported and Effects")

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 25 +++++++++++++--
 hw/block/nvme.c      | 74 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 2249d77c2129..f71376072762 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -737,6 +737,24 @@ typedef struct QEMU_PACKED NvmeSmartLog {
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
@@ -749,6 +767,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_EFFECTS        = 0x05,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -860,8 +879,9 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
-    NVME_LPA_NS_SMART = 1 << 0,
-    NVME_LPA_EXTENDED = 1 << 2,
+    NVME_LPA_NS_SMART     = 1 << 0,
+    NVME_LPA_EFFECTS_LOG  = 1 << 1,
+    NVME_LPA_EXTENDED     = 1 << 2,
 };
 
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
@@ -1068,5 +1088,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
 }
 #endif
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b4f47448575b..8d0d96f42e61 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -112,6 +112,46 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
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
@@ -1331,6 +1371,36 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
+                                 NvmeRequest *req)
+{
+    const NvmeEffectsLog *effects;
+
+    uint32_t trans_len;
+
+    if (off >= sizeof(NvmeEffectsLog)) {
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
@@ -1374,6 +1444,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_EFFECTS:
+        return nvme_effects_log(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -2810,7 +2882,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED | NVME_LPA_EFFECTS_LOG;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
-- 
2.28.0


