Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2868C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4195D20715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195D20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeOK-0001CA-1X
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwL-0006Tr-11; Tue, 22 Sep 2020 04:46:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwH-0000vD-OP; Tue, 22 Sep 2020 04:46:20 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7F6DB580365;
 Tue, 22 Sep 2020 04:45:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=hDDxUxZwn/ah/
 Nkopk7l/Be61TqKuWyIVAS7lFd4F5o=; b=avAA1nnslcaARikRzynf2CxlZlTsR
 4oeWQVvLauoltbAHyxS36jKrdoN0o/yqV1sTw22bryjFGBJY9gAYUSgwTEPhsuay
 AofPYYAo1T5ZDXayga0NZIAMCpYDWAMshrW/7BCF8wEalOCAg/i/qwQE9z0GBsqj
 Uhi6Nm8MncKqHW1S2rrk4b/+aXmEZpaK3AxdTPnRf3DIEd/TZ/JEmz5R9tC0PDEq
 wHRJ4Vdb9tBV/XYrrVg4l5ObjiMhWwQcbjCJkWfVyN8g1bLxC2CedJwrYwmqSU3S
 aMgdsszFY4egZXdBnMNU7bZMqvMfCr57lnD8QDrAiNe5xSdgl5NtepfaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=hDDxUxZwn/ah/Nkopk7l/Be61TqKuWyIVAS7lFd4F5o=; b=lNiqgPnG
 DpXJiQDjXzYNHHXox+QDk2en3HmWTy3urEAkaFfW7Z89K1m6FTTj+Ty8asMm2eMp
 RfKidLVSZdijTdGu7toMmO1xIitmiZYq9Psel69rXSmn1y2qxp24PJoa+iLGZu/E
 l49qeE02s04uBk2hw2Ufa+ddQRuRdX0F1TmpZQAiL04PGguWIkEKTjq+kUlKLXgG
 Zj0zaj201c1BU34iHsiEpZe7tSk63N48LlzNmyvk4/MvmlmQ561h0uz7UZ4BrTWQ
 a75yLEfLytmVFh5/jEa6y0eggXeVYI4BRFJv9PGnM3F7EP4TYe+KXGhMQrIsyLQ6
 gzN2c+Do+sed8A==
X-ME-Sender: <xms:xLlpX6qFkfMV_h7R-R4hklhUC0JmUS0KevaPoQNG1u0q-eWtipZzpA>
 <xme:xLlpX4rBul8Z4-KB288BVi8U0iBpryLOf5b73hiKZf8xucljxi-2V4oPgl6ZvR8CU
 Jf-iZpgeNxkTJZ0qig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepledtteefgeekgfeuvddtudffjeeivdejjedujeeileevkefhkedvfeelleduveff
 necuffhomhgrihhnpedvtdduledqtdekrdhorhhgnecukfhppeektddrudeijedrleekrd
 duledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:xLlpX_O7_ppS1XViNrsCmS3OUlbmPe-SZ4m7MGnHWYkW63yFT6LxkQ>
 <xmx:xLlpX57EOR5J-exMPqRCOKxFkppwfhgvMnyObR3mjTtL3sLIXsBt7w>
 <xmx:xLlpX55vKkcFHfWVD8BivT1wy0ymO4m_VuijepSiASWIWDmpzf7lYg>
 <xmx:xLlpXzuH8NkMO3eD4SYHZTWBGgKV3MDfZqv0Igmyuh8mX8bQ7cL5OjegOuw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8944C306467E;
 Tue, 22 Sep 2020 04:45:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/17] hw/block/nvme: add support for sgl bit bucket
 descriptor
Date: Tue, 22 Sep 2020 10:45:29 +0200
Message-Id: <20200922084533.1273962-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
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
index c5d09ff1edf5..1fdd5c9c5ab0 100644
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
@@ -2656,7 +2676,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(n->num_namespaces);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
-    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
+                           NVME_CTRL_SGLS_BITBUCKET);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
     strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
-- 
2.28.0


