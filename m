Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BB5238D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB5238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe8Z-0006Em-Ab
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvt-0005pc-LP; Tue, 22 Sep 2020 04:45:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvn-0000ta-LC; Tue, 22 Sep 2020 04:45:53 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4C0AB5803D4;
 Tue, 22 Sep 2020 04:45:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=BuVWf7K7r6D5W
 APDM9OnOb8xHbu3nSIobz6Rw3eQCes=; b=RkYpwS6aYBDoyWZXago9d6U87MI5E
 Xqt8Kbartlz8Xj2Ijpg2sjVu/KK1wjRQGZuhBsLtH0WoKEGPW9zmCrn8mSaH2UUG
 TkVbjE5dI7WYJXqd1vvpvt919FdooRJSByxnE9h00uuQWEYY1tlA+1VMVeSDWJ4G
 BMXCzHduDV63A48OdM1C5j+u09ZpF+s7vfKjL9Cwk8FM78lKXhJyQfQvFpHrMNId
 HntD11QVCEwtE4ZNf1GJh92zayhpNWuv4vRZyjNQ/7EZW5DX0oG6CksCDUl1cZoO
 LJM2S+9NmpLzn3ZnJ5+aiDNXWEPF8ru5XmoY4S4pcOUIfG+Th1xfkiNtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=BuVWf7K7r6D5WAPDM9OnOb8xHbu3nSIobz6Rw3eQCes=; b=f3D7TmMX
 8niFzhl8BHaF9pfayqjtTg498LoCe1kGLirUN3cig5fKHh/tUDgGDXTmJefECZED
 o47pIUMj1CCwvnBn9sSdc0GJ57gsHIpQsjl3Tm6iThFcoNoOd+Rjmwb1d6t3E5Dx
 UOelv7//g0Dd/lZ/Xtt7EnzzkpXPrZEqxn9r+KCIZYgaGSuHymQrRQyGzK/2epzx
 kX2nhEclasA1YZiiFllY6AWbMpxjrR2BuxzYJXb8d9yTvhHEiu6cARIlw1qTq4dd
 TuSseorw8U2itiXsmi32h6NBnXsGhw4yJziOa7VwTGEbNTqCWA+xo324bbh22hCf
 pPCmpI1pyCkxtA==
X-ME-Sender: <xms:uLlpX7pfcKjP3Sv8bOKfaNwNEOVhnqrGUCMNQffhFeYvB9eiE9-iHg>
 <xme:uLlpX1r6R4E_QzT4HdAOi9ksKmVe39wo5cZ_OHGdXhfWUCFjzLFqn8JD0MSK0urDo
 if-TVuYaa04_Q2gIGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:uLlpX4PM6oQKU8Y879GQtE8h8EDhihHb6hAGViiXhWDYhG7ABdekyQ>
 <xmx:uLlpX-4xXvNUuM2UR9CmWtfV6JERcuIivbU00dKlZiTjFAgRVnND7g>
 <xmx:uLlpX67aouf3y2XJFRdaY2zmLcnXPsMQt4hZwQ5GSDZ_QX2cw2icSw>
 <xmx:ublpXxbPbIYYxuNR-p58qlcYY7cqd_VJiRhUX-lOJ_E5RaQemnY5Mw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8293D3064686;
 Tue, 22 Sep 2020 04:45:43 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/17] hw/block/nvme: add a lba to bytes helper
Date: Tue, 22 Sep 2020 10:45:22 +0200
Message-Id: <20200922084533.1273962-7-its@irrelevant.dk>
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
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add the nvme_l2b helper and use it for converting NLB and SLBA to byte
counts and offsets.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.h |  6 ++++++
 hw/block/nvme.c | 12 ++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 52ba794f2e9a..1675c1e0755c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -77,6 +77,12 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
     return nvme_ns_lbaf(ns)->ds;
 }
 
+/* convert an LBA to the equivalent in bytes */
+static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
+{
+    return lba << nvme_ns_lbads(ns);
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bc8690fa7aaa..25b34b3701db 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -644,12 +644,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset = slba << data_shift;
-    uint32_t count = nlb << data_shift;
+    uint64_t offset = nvme_l2b(ns, slba);
+    uint32_t count = nvme_l2b(ns, nlb);
     uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
@@ -674,10 +672,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
-    uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
-    uint64_t data_size = (uint64_t)nlb << data_shift;
-    uint64_t data_offset = slba << data_shift;
+    uint64_t data_size = nvme_l2b(ns, nlb);
+    uint64_t data_offset = nvme_l2b(ns, slba);
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
-- 
2.28.0


