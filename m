Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4FC22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4FC22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN8I-0006gx-5R
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYR-0000Fc-Br; Tue, 27 Oct 2020 06:50:15 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYM-0002Ak-Gf; Tue, 27 Oct 2020 06:50:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B64C65C016C;
 Tue, 27 Oct 2020 06:49:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=BsHZFGuz+xwU9
 6Sah49vopp9xJV6XgSDS6jMSgUVAYc=; b=I9jIFRccdhfWyoQGwdv5MLfxW+bTZ
 bg8Pgt3wM9lr4PDIx6TeIHwCw5iF4UswNhJLT7qV30RIfw60MycF9WKzFuAmF4Tv
 sRaSJq6R9EmotZoXJ3aoQCJzxzEAAAyCPD2+IMy8b9VOeBsU1f73OZUet/dAcIT2
 j3dEylpxuY4HIjDTeNtWNK0LR3kQLiB9u5EXT1wl1d2apWUVGVt91256fV8OphgX
 pLcrVP3QEO3M5t8dHgcYVNua0A55Wfqex3cp3KXARbGAhckHQwC+Q/L4+zS2V60w
 kxV3BaXn7zmBFz3lH1jVX+Ipd33oyoJ7i0FZJ1jI9GBtORplaQFebDe5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=BsHZFGuz+xwU96Sah49vopp9xJV6XgSDS6jMSgUVAYc=; b=Bt1Bj4MT
 zlyitFadnKLNUQs+m2rkGQgrvuKf5cVtWAUSP8oyBFE0qo/EQPJveq0aRv5FCbUE
 nAbsw5yS8doE795vbMOqTA3TAkOlpgU9PXhlAJ2EmpnWTXe/TLDin99x3wYS3PZO
 SoQRyrhVJrQ1NE0DTYdlV3UFWfu4tGSlfuC/e55bq2G0Hy6D55cEPzm2RB/hEiso
 B1DQfT55qMh4bHSw42hI0D8o69xq94Bp533gQ02vPKW20sGS0tOIB2W/lBAchYnj
 3pwILw2pp8E98fa+3iPVpz1CzH09UJLNzmd/D0wTNgJVSHeb3q2mreReYUAgBd7v
 n2yHrPLMYDEhzw==
X-ME-Sender: <xms:TfuXXwhndd88Z41BJ6rX8jEQIDCxG9l82-xv_WnJ8xBacEBSMYDcZA>
 <xme:TfuXX5Aq5NJELlwUWbDhlHlYZ4UL3b2GuRii_txc30Ie3iO6mSjQ52aHN-l2MZYoL
 vKWhVLCvHe4uZGbWWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepledtteefgeekgfeuvddtudffjeeivdejjedujeeileevkefhkedvfeelleduveff
 necuffhomhgrihhnpedvtdduledqtdekrdhorhhgnecukfhppeektddrudeijedrleekrd
 duledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:TfuXX4HXg91jpAtXijtc7uGbLYc2pXwQyFNzheQvQ2rGLFrqo8PSFg>
 <xmx:TfuXXxQUkJK-JRr0EN8WQylDVrg5-MH3aBpThRdJaY2eZmVLd2Z6zA>
 <xmx:TfuXX9xIFvAxBBxxCwo25TFM4ONO57SwwiQa-IL7glvJClAO9iW25A>
 <xmx:TfuXX_t-j7n3bWVP6m9jn3QO9ahk8_K1vf1oE572cFJaISYLIbvk6Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8F97F328006A;
 Tue, 27 Oct 2020 06:49:48 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 13/30] hw/block/nvme: add support for sgl bit bucket descriptor
Date: Tue, 27 Oct 2020 11:49:15 +0100
Message-Id: <20201027104932.558087-14-its@irrelevant.dk>
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

This adds support for SGL descriptor type 0x1 (bit bucket descriptor).
See the NVM Express v1.3d specification, Section 4.4 ("Scatter Gather
List (SGL)").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63d0a17bc5f0..4f08f55a76a0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -430,6 +430,10 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         uint8_t type = NVME_SGL_TYPE(segment[i].type);
 
         switch (type) {
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            if (req->cmd.opcode == NVME_CMD_WRITE) {
+                continue;
+            }
         case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
             break;
         case NVME_SGL_DESCR_TYPE_SEGMENT:
@@ -440,6 +444,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         dlen = le32_to_cpu(segment[i].len);
+
         if (!dlen) {
             continue;
         }
@@ -460,6 +465,11 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
         }
 
         trans_len = MIN(*len, dlen);
+
+        if (type == NVME_SGL_DESCR_TYPE_BIT_BUCKET) {
+            goto next;
+        }
+
         addr = le64_to_cpu(segment[i].addr);
 
         if (UINT64_MAX - addr < dlen) {
@@ -471,6 +481,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
             return status;
         }
 
+next:
         *len -= trans_len;
     }
 
@@ -540,7 +551,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
         seg_len = le32_to_cpu(sgld->len);
 
         /* check the length of the (Last) Segment descriptor */
-        if (!seg_len || seg_len & 0xf) {
+        if ((!seg_len || seg_len & 0xf) &&
+            (NVME_SGL_TYPE(sgld->type) != NVME_SGL_DESCR_TYPE_BIT_BUCKET)) {
             return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
         }
 
@@ -577,19 +589,27 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
         last_sgld = &segment[nsgld - 1];
 
-        /* if the segment ends with a Data Block, then we are done */
-        if (NVME_SGL_TYPE(last_sgld->type) == NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        /*
+         * If the segment ends with a Data Block or Bit Bucket Descriptor Type,
+         * then we are done.
+         */
+        switch (NVME_SGL_TYPE(last_sgld->type)) {
+        case NVME_SGL_DESCR_TYPE_DATA_BLOCK:
+        case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
             status = nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &len, req);
             if (status) {
                 goto unmap;
             }
 
             goto out;
+
+        default:
+            break;
         }
 
         /*
-         * If the last descriptor was not a Data Block, then the current
-         * segment must not be a Last Segment.
+         * If the last descriptor was not a Data Block or Bit Bucket, then the
+         * current segment must not be a Last Segment.
          */
         if (NVME_SGL_TYPE(sgld->type) == NVME_SGL_DESCR_TYPE_LAST_SEGMENT) {
             status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
@@ -2651,7 +2671,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
-    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
+                           NVME_CTRL_SGLS_BITBUCKET);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
     strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
-- 
2.29.1


