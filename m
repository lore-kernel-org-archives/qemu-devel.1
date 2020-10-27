Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1988CC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE0D22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE0D22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNEW-00027g-Cp
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYr-0000ms-G1; Tue, 27 Oct 2020 06:50:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002JB-B1; Tue, 27 Oct 2020 06:50:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 937955C0197;
 Tue, 27 Oct 2020 06:50:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=A4GD/Yb9/5lUT
 /SHMt1GI32RHbHrczIUIXosgHiyk80=; b=jZOSlflvPAyvyNEHIZjCAEvZ0Aolr
 HReKreZnzRhQIQJ5/bM4tfEfKXZ4I9N0/gPfMwYsyshCbWogm86wjapllhei8WrD
 4hYYlmM5F6hbo7x4cEoXCF8EKdM5SEDrhfLIjWWpE3/7C4VHPa1gQipEPfC8pYL2
 PgqBVvE3X9TZjI0fCCi7EDMoec/9MvhM5idPRgU1WxiEAvdNCo5RCoLEM6kB3fI+
 vmrT6YFardx9DY6Xqq9iD3FPSpW6z3a8bnkRp+nNmyththfreQ6rRLJMr2dXNQC1
 lD9pjHINRGusP0Y1wCBuZeVC7X0S+/+WKpMl7XUP8I1rs8MKufBJG4Q/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=A4GD/Yb9/5lUT/SHMt1GI32RHbHrczIUIXosgHiyk80=; b=ZUl2UMG4
 PHPUNrLQ5xNlT8/+mf25e1SCoGuTMv3ziqf6O58HBxGaE4EBcdESSxCFO/Wt86TS
 uEEtXd1/hQASLTcwJCjgDx7xP4yl40RhELWIV986dOjStObUIdWRslHaPgNzbHkS
 wuN9WBWchIs8VHClpWlgz9KNg6F3qjpVKNX29JrlYD8DGQ7+0eadoyKZfjAcvFHg
 Zu7Q1Tkh4MRBdUG5dZ/wUYlo/5Tw4d0I/Oj4nJs1lSVqwPGgNrPpdGz2NUcFaoXg
 iuwjXS67u8KatHw/WoMKEnrsAuAZrEBn0eb6EowFd7ih+njTmnxZSXT6IT6RNx7C
 OZCS7OR68tZacw==
X-ME-Sender: <xms:X_uXXw4x0LlybBMJ4A_MvLG3odhhi8BX3FOV_3o9LNZfTFjTFrWkbA>
 <xme:X_uXXx6Tlc4St3tcDIzrlcypfKwt24T6Nh_UTnQJlMMARObgel80Ye5UoKxnIt0sR
 UqSGCDpsRBJsuN-8vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:X_uXX_fv5PJ1gmsgceksH1-OgYJFbsCh9bo9Bam1zZjrb6m1GNBNzw>
 <xmx:X_uXX1KCqcl1ugNm_oCusJ4KyE0NbB6WOXHQ2VL1B52rxRHj78ZRPQ>
 <xmx:X_uXX0LtHaTzvCAgVHqFhqTQ5bpngPe-ltwJRj1HYgBoNiS9sb2vWw>
 <xmx:X_uXX5EN1d5wQ4Egy_I7n33Tz9W50pFQD-pwvpO2OLpvaCpm3Tt2HA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7E8773280067;
 Tue, 27 Oct 2020 06:50:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 28/30] hw/block/nvme: fix prp mapping status codes
Date: Tue, 27 Oct 2020 11:49:30 +0100
Message-Id: <20201027104932.558087-29-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

Address 0 is not an invalid address. Remove those invalikd checks.

Unaligned PRP2 and PRP list entries should result in Invalid PRP Offset
status code and not Invalid Field. Fix that.

See NVMe Express v1.3d, Section 4.3 ("Physical Region Page Entry and
List").

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 include/block/nvme.h  |  1 +
 hw/block/nvme.c       | 20 +++++---------------
 hw/block/trace-events |  4 +---
 3 files changed, 7 insertions(+), 18 deletions(-)

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
index b8c6be63186f..2896bb49b9c0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -327,11 +327,6 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
 
     trace_pci_nvme_map_prp(trans_len, len, prp1, prp2, num_prps);
 
-    if (unlikely(!prp1)) {
-        trace_pci_nvme_err_invalid_prp();
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
     if (nvme_addr_is_cmb(n, prp1)) {
         qemu_iovec_init(iov, num_prps);
     } else {
@@ -345,11 +340,6 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
 
     len -= trans_len;
     if (len) {
-        if (unlikely(!prp2)) {
-            trace_pci_nvme_err_invalid_prp2_missing();
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
         if (len > n->page_size) {
             uint64_t prp_list[n->max_prp_ents];
             uint32_t nents, prp_trans;
@@ -370,9 +360,9 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
                 uint64_t prp_ent = le64_to_cpu(prp_list[i]);
 
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
-                    if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
+                    if (unlikely(prp_ent & (n->page_size - 1))) {
                         trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
-                        return NVME_INVALID_FIELD | NVME_DNR;
+                        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
                     }
 
                     if (prp_list_in_cmb != nvme_addr_is_cmb(n, prp_ent)) {
@@ -391,9 +381,9 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
                     prp_ent = le64_to_cpu(prp_list[i]);
                 }
 
-                if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
+                if (unlikely(prp_ent & (n->page_size - 1))) {
                     trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
-                    return NVME_INVALID_FIELD | NVME_DNR;
+                    return NVME_INVALID_PRP_OFFSET | NVME_DNR;
                 }
 
                 trans_len = MIN(len, n->page_size);
@@ -408,7 +398,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_pci_nvme_err_invalid_prp2_align(prp2);
-                return NVME_INVALID_FIELD | NVME_DNR;
+                return NVME_INVALID_PRP_OFFSET | NVME_DNR;
             }
             status = nvme_map_addr(n, qsg, iov, prp2, len);
             if (status) {
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cab9913b1f2d..c1537e3ac0b0 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -97,10 +97,8 @@ pci_nvme_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRI
 pci_nvme_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type 0x%"PRIx8""
 pci_nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
-pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
+pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-pci_nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
-pci_nvme_err_invalid_prp(void) "invalid PRP"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
-- 
2.29.1


