Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD4C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C71220878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSf4H-0005X4-OC
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0I-0003Cx-Np; Wed, 14 Oct 2020 07:31:34 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0F-0006Xq-13; Wed, 14 Oct 2020 07:31:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 76F1558018A;
 Wed, 14 Oct 2020 07:31:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=ULDJNRRL9rxMO
 pED3cBBbKaPxb/XdfXkspELpMRsd84=; b=KMUrHdJhevJihueRsa1tFkqJHtQZP
 laSkAiCDoflNZqZE5HXmkj5zt6Lh9HaCYH+HlaQqiO10oTO98jbNIpBcAAfIy1f1
 p1EQo2/Ykj5ETbrTLRHXtecKCoUjK8Qp5vlmnr9kQ6NY7yryJZ7t06CIevtCjYCZ
 HLqa+a+u+1gqsCsIpdC2F+VUzONV+kND2SnJoLvyGOVYQ5k+MEaEa7vzJGr5va6O
 yYL9Kc+TAq+a6tEiau8ATqoBW8mm6ajES14l9kistOWpwRl08EFrngt2CmmLl4tv
 hP7QTXNpZ4dM497zsYKF+v4cmDVkttmx5ETxq6mkM5TmS7SlfymQqTcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ULDJNRRL9rxMOpED3cBBbKaPxb/XdfXkspELpMRsd84=; b=e2/sGXlV
 krgJjNQSE1tlpe3kgw87ja6wYig6XCultrwXKtNaG3Vj7mNT4XkMCiqijWdKVbp1
 hq1Wn4wEEu2ZmYfpTQbsSHHhjseWQ+/3vxneWrynr0t7qIormuRLjxW12aNR4cdP
 qx4oJoY/W1N0EyvdnQkkKkoKz6OKLyoEs7U/+XoNtoDxxAef/Dk0p/aluefm6995
 hbqRzwhaGbbFVDgxYS8++23ENuoJEnXpUnLSd4SAF1+EkkH4SMzf0kBV9MCTjVNC
 Hv8qUor/ZaG4tLpGJcQbsi4vzbyrMND5NGU9R+z9DsRB+zE7mqJ1BKRILEGliRBq
 6zVJGWAPkyrHuw==
X-ME-Sender: <xms:kOGGXz2NSSyfWnGjCPfHjNVTfxaIgTM8SHejhvE95GAhscp0WvEMpg>
 <xme:kOGGXyENaFIqHKjKGLO_oMp79Szfim8FPFspgfiJUt_ifOhJ7pWouQvo6hd7mnzvu
 Cbrh1HBQmRjAwdTe8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepieduheefjeetgeeufeefkefhlefgkeehteffgfetjeegkeeugfdtudejuedugeei
 necuffhomhgrihhnpehuuhhiugdruggrthgrnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:kOGGXz6V5UE9koYmS9QMXdergOB9eh674_zb68oaHpJHDq_0zlC2dQ>
 <xmx:kOGGX42r4fCVawxVW3THmaFIKnWstKqe4c9LdFnbfkdBAFROQQ9GgQ>
 <xmx:kOGGX2F9dvjLrN0NrLTg4DQVKmrvDk9Mc76X6SRGN5JhP5MA-4Z-Tw>
 <xmx:kOGGX7672Fxesa94gVleesL_gdGqpC1ikxIfDA8DDBKKqhLFeWX8Yg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 013333064682;
 Wed, 14 Oct 2020 07:31:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] hw/block/nvme: add uuid namespace parameter
Date: Wed, 14 Oct 2020 13:31:15 +0200
Message-Id: <20201014113122.388849-3-its@irrelevant.dk>
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
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add the 'uuid' nvme-ns device parameter such that users who requires a
persistent namespace UUID can explicitly specify it.

If not specified, the property will autogenerate an UUID for each QEMU
invocation.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme-ns.h |  1 +
 hw/block/nvme-ns.c |  1 +
 hw/block/nvme.c    | 12 ++++--------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 44bf6271b744..8951fc5e86b8 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    QemuUUID uuid;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 475c6fe44084..dff3e308e31b 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -130,6 +130,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8d0d96f42e61..aaea0436fd05 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1632,6 +1632,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
+    NvmeNamespace *ns;
 
     struct data {
         struct {
@@ -1648,21 +1649,16 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
     memset(list, 0x0, sizeof(list));
 
-    /*
-     * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
-     * structure, a Namespace UUID (nidt = 0x3) must be reported in the
-     * Namespace Identification Descriptor. Add a very basic Namespace UUID
-     * here.
-     */
     ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
-    stl_be_p(&ns_descrs->uuid.v, nsid);
+    memcpy(ns_descrs->uuid.v, ns->params.uuid.data, 16);
 
     return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
-- 
2.28.0


