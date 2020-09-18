Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A43C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3D7208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3D7208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNC0-0007WO-Gw
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7U-0004mR-Ia; Fri, 18 Sep 2020 16:36:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7R-0004xL-Dd; Fri, 18 Sep 2020 16:36:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id A012D58020D;
 Fri, 18 Sep 2020 16:36:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 7YBWV6J4lxbVs/HZtfNeaF83ffTw6mUk7XA+4NL+CCo=; b=yhNDX00gcf+0A9Hy
 xJOLqExP4GkjH+K9Ijx9BIH+NTHhwJK0XU6l5EMcOvGakB7YGr1auye/ziAelNB6
 cQIHKYgGf1vfvidpNTL50S95HQC6qvgE4n/0lLsxJ0MFAbFO6YUXj66Hel5yeUmb
 c88cMnMelryjO49AMwapMFWq9ft06FHi9uI3q1G+DeABwFA0U4YZeKvbaSY6dQjl
 OEL25ytPdIfZUnZmPIxN0bPEnPKIZ3GVa857maauF+AliYtgHbwyic5ybzgKQSqY
 KDqGKYlxTZ9ksPaB5Zx/c4SjDDk5jcQC+e55xU2Cz0ySmy3LaDrR5kCTkecwmnmo
 ec/8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=7YBWV6J4lxbVs/HZtfNeaF83ffTw6mUk7XA+4NL+C
 Co=; b=AXq9tQoUyGUSwMStVnZoYMpM5tW/KjuBOh+YfmlUa2utT0djd4txm8S0K
 NKI7G2iRet5nYz47LTTa0/3hAzVjH/ytQTiLRTQkYG2Gu4lO1dfSjFFyjw4NEFw9
 bJrzqi5peL7xu19DADv6rvWK1I+uN/0AdJ8IksW6XPp+FWvb+75/9go31dvAlyc3
 E6ZaIKIxhNhbar3UArvzyZqQJd+KMK0h+O2S9x8vW4F/TorZLisxIWVZ4OnS9r8e
 V6MtV2+OMvBDspiAJrryyTOnx8K/XRZz8UEhIT4zUCE80NneViy4dbFHe9jZpeQ6
 GHfQoe3WWnyN96MdF9xqEaFub+XNg==
X-ME-Sender: <xms:UBplX3OzS82HU2UFi0iJxGwcIH-00GJUGedrrl9gnGRt1vM1DBQHdw>
 <xme:UBplXx_Wbty0L6qfBSkdRoYndSNYTMeiq-R-vgPdJWQstms2pkX50y-AVL3CPaXvm
 hr_nAIw3KbzbQCOMHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepteevuedugeevieehgeeileeufeetvddtkeetfeelgeehudfhjeeuledvhfff
 tdegnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepud
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:UBplX2Rdha0lb5cqyQ54LxNDO2He7J3xWll5ef4fYW3QiZjimBVwBg>
 <xmx:UBplX7sHxMiSM8BlkmKz6Tp6UlmCtwP7mly7hqYIah2t-FRVlteOUw>
 <xmx:UBplX_cQESFNhLdQEpKmrbZydC2FEdnuX-onf2S25_LsOgWUUFlbRg>
 <xmx:UBplX-xmliLTw9IZkgRT2PJK7MLqOjCpjX3j8LYMnvoIFz1N3cYKkuc2yQ0>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C13AF306467E;
 Fri, 18 Sep 2020 16:36:30 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] hw/block/nvme: alignment style fixes
Date: Fri, 18 Sep 2020 22:36:09 +0200
Message-Id: <20200918203621.602915-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Style fixes.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 78c3ac80fd4c..10568cbf8761 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -634,7 +634,7 @@ static void nvme_rw_cb(void *opaque, int ret)
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-         BLOCK_ACCT_FLUSH);
+                     BLOCK_ACCT_FLUSH);
     req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
 
     return NVME_NO_COMPLETE;
@@ -663,7 +663,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
+                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
 }
 
@@ -803,7 +803,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 }
 
 static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
-    uint16_t sqid, uint16_t cqid, uint16_t size)
+                         uint16_t sqid, uint16_t cqid, uint16_t size)
 {
     int i;
     NvmeCQueue *cq;
@@ -1058,7 +1058,8 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
 }
 
 static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
-    uint16_t cqid, uint16_t vector, uint16_t size, uint16_t irq_enabled)
+                         uint16_t cqid, uint16_t vector, uint16_t size,
+                         uint16_t irq_enabled)
 {
     int ret;
 
@@ -1118,7 +1119,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 
     cq = g_malloc0(sizeof(*cq));
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
-        NVME_CQ_FLAGS_IEN(qflags));
+                 NVME_CQ_FLAGS_IEN(qflags));
 
     /*
      * It is only required to set qs_created when creating a completion queue;
@@ -1520,7 +1521,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         }
 
         if (((n->temperature >= n->features.temp_thresh_hi) ||
-            (n->temperature <= n->features.temp_thresh_low)) &&
+             (n->temperature <= n->features.temp_thresh_low)) &&
             NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
             nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
                                NVME_AER_INFO_SMART_TEMP_THRESH,
@@ -1770,9 +1771,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     n->cqe_size = 1 << NVME_CC_IOCQES(n->bar.cc);
     n->sqe_size = 1 << NVME_CC_IOSQES(n->bar.cc);
     nvme_init_cq(&n->admin_cq, n, n->bar.acq, 0, 0,
-        NVME_AQA_ACQS(n->bar.aqa) + 1, 1);
+                 NVME_AQA_ACQS(n->bar.aqa) + 1, 1);
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
-        NVME_AQA_ASQS(n->bar.aqa) + 1);
+                 NVME_AQA_ASQS(n->bar.aqa) + 1);
 
     nvme_set_timestamp(n, 0ULL);
 
@@ -1782,7 +1783,7 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 }
 
 static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
-    unsigned size)
+                           unsigned size)
 {
     if (unlikely(offset & (sizeof(uint32_t) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_mmiowr_misaligned32,
@@ -1925,7 +1926,7 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
                        "invalid write to PMRSWTP register, ignored");
         return;
     case 0xE14: /* TODO PMRMSC */
-         break;
+        break;
     default:
         NVME_GUEST_ERR(pci_nvme_ub_mmiowr_invalid,
                        "invalid MMIO write,"
@@ -2101,7 +2102,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 }
 
 static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
-    unsigned size)
+                            unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
 
@@ -2125,7 +2126,7 @@ static const MemoryRegionOps nvme_mmio_ops = {
 };
 
 static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
-    unsigned size)
+                           unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
     stn_le_p(&n->cmbuf[addr], size, data);
-- 
2.28.0


