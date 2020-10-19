Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2180022257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2180022257
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTRr-0004OV-It
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUTNL-0002dr-Fk; Mon, 19 Oct 2020 07:30:53 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:49459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kUTNH-0006ek-CT; Mon, 19 Oct 2020 07:30:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id F2022989;
 Mon, 19 Oct 2020 07:30:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 19 Oct 2020 07:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=3025gyAlex//nT/Znu+Noa3oS+
 1eeq2JEkzF8+uy0Qw=; b=SSazKyVsmWhTr8OYQ/N6fX+u+VsPxhAFavajkgHzvh
 +G84LUYHvq24mB4X/NwiM1rM4d1aHkErhCvmjFT95PJSadHdlqduqp/EvLsk/+Tp
 C/lFLsNRtohQCr1+pfaFwRWgqkaxWgztArUViO9KAcDmU2X/AdD0+5r47yI9ccpu
 mOM2KvIh2TlWSbxnCQRRarN6eOrt2xGIDp+TZpT4PRh5HBL6yn963wydQt+AVQpy
 n7ZcLmq5NXbTCMDGcE8TMDbzLxIGbXJp0drZtVpq3BPrKsp9OM6XE3U5HAgKMKbO
 JS3EFNeUXx3CquPAJ7B40N4t6F1w8tzLWRybWJEEsRyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3025gyAlex//nT/Zn
 u+Noa3oS+1eeq2JEkzF8+uy0Qw=; b=S5xfSIrk/ESbkhyJZUMgpfgEMjBb9XFgC
 9KesBSEl/wYPSo8V2Lg7YSaHOQgfK4iadHR/yxCIJ+7oS6Objg4DdpZXfN6zByxf
 noqxvExeGJEpWIJoD97KL0u1Pzv/04IU1uRNVqFunk74KkxeAOP7NpL5SBEnKl7b
 7ZiE4SQBpITEgS0sarrhZKS9BLm1yWL4ypw/ypRUZ53c13HEWn/anwYtRAkEpr3L
 RbmnDaHp/5Xih7yliyElELx3OJKbr/PxgYzkfcEkEEdokCS8mt8nBM/+4ompnV20
 7DuFMQfkVSm3Z1Mc2lhnSoWF2lWa/LCckDH/mnqILmxtPmkaQ2ffg==
X-ME-Sender: <xms:4niNX-bpZ3Xqz_-GHueA0MVd_rYnZG4Hj7SEQKX429Le1wo_x5_DCA>
 <xme:4niNXxZXYbVCxLq0W0nN7YWfZsgjGZbj8Ys-wxRS-WICvZvpYupz1CjNBdsj4Ddk8
 HsvdDDSGWTbcmAPJ0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
 kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:4niNX48wWAI8JeRGDqRumREpwJFUVCBENkPS29mHxj1SBK0aXHhBvQ>
 <xmx:4niNXwqT5EVmRShlHNyuKygk9DnLRafFaKDdGT3dCa2YZZbkD16Drg>
 <xmx:4niNX5pb6ZNXfQ0PJ0QCCXGquzGwfU4oQ895tOuYMlbDi-QGlwPA7g>
 <xmx:43iNXyC2_2vwHa6YYl6IhxWBSMSkr3bnAEW54-EcnMBMwg0u5M2tOJEpzgg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 331753064684;
 Mon, 19 Oct 2020 07:30:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: fix prp mapping status codes
Date: Mon, 19 Oct 2020 13:30:39 +0200
Message-Id: <20201019113039.76146-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.18; envelope-from=its@irrelevant.dk;
 helo=wnew4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:30:44
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

Differentiate between missing PRPs and misaligned PRPs, return the
relevant status code and streamline the trace event naming.

See NVMe Express v1.3d, Section 4.3 ("Physical Region Page Entry and
List").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h  |  1 +
 hw/block/nvme.c       | 22 ++++++++++++++++------
 hw/block/trace-events |  5 +++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 6de2d5aa75a9..8a46d9cf015f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -655,6 +655,7 @@ enum NvmeStatusCodes {
     NVME_MD_SGL_LEN_INVALID     = 0x0010,
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
+    NVME_INVALID_PRP_OFFSET     = 0x0013,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d30ca69dcf1..785a87af0138 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -328,7 +328,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
     trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
 
     if (unlikely(!prp1)) {
-        trace_pci_nvme_err_invalid_prp();
+        trace_pci_nvme_err_invalid_prp1_missing();
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -370,11 +370,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
                 uint64_t prp_ent = le64_to_cpu(prp_list[i]);
 
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
-                    if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
-                        trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                    if (unlikely(!prp_ent)) {
+                        trace_pci_nvme_err_invalid_prplist_ent_missing();
                         return NVME_INVALID_FIELD | NVME_DNR;
                     }
 
+                    if (unlikely(prp_ent & (n->page_size - 1))) {
+                        trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
+                    }
+
                     if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
                         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
                     }
@@ -391,11 +396,16 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
                     prp_ent = le64_to_cpu(prp_list[i]);
                 }
 
-                if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
-                    trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                if (unlikely(!prp_ent)) {
+                    trace_pci_nvme_err_invalid_prplist_ent_missing();
                     return NVME_INVALID_FIELD | NVME_DNR;
                 }
 
+                if (unlikely(prp_ent & (n->page_size - 1))) {
+                    trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                    return NVME_INVALID_PRP_OFFSET | NVME_DNR;
+                }
+
                 trans_len = MIN(len, n->page_size);
                 status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
                 if (status) {
@@ -408,7 +418,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_pci_nvme_err_invalid_prp2_align(prp2);
-                return NVME_INVALID_FIELD | NVME_DNR;
+                return NVME_INVALID_PRP_OFFSET | NVME_DNR;
             }
             status = nvme_map_addr(n, qsg, iov, prp2, len);
             if (status) {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cab9913b1f2d..2bafbed256e8 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -97,10 +97,11 @@ pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRI
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
-pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
+pci_nvme_err_invalid_prp1_missing(void) "PRP1 is null"
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
-pci_nvme_err_invalid_prp(void) "invalid PRP"
+pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry not page aligned: 0x%"PRIx64""
+pci_nvme_err_invalid_prplist_ent_missing(void) "PRP list entry is null and more data to be transferred"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
-- 
2.28.0


