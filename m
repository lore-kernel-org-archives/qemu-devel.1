Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBCFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9EB207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9EB207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMfS-00045E-QG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXx-0008PS-HR; Tue, 27 Oct 2020 06:49:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXv-00026u-MT; Tue, 27 Oct 2020 06:49:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id A13935C0135;
 Tue, 27 Oct 2020 06:49:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 m1ehdjgfVHCBJVdC62PV/BMR7tjm+mOF8zi6eM10Icg=; b=ASJOiBqF5Tfs1oJK
 z5xwfSY2Bn+WVq4UBg+clzav4kyXPugEetqPFfEkPH+l9T7NRxY3yFvd7F1ISzJ6
 XrjJYduVcWTPxlZRLYNj1AMsewjQDOydSsURMMVuPLdDPFkQ1ibdo0G1awfiqRxc
 G5EkixjYzj9BfcqqMb5ZptmmX5myCf+pGleYasxHtrl8Gb0UP0O0Ahvv047u5MBs
 Bqg7ZKQa7yagyGQ0UtzBiBI9HGCBzzndaiUaCtuH7OLEVQ70lrBWu+jXiVuLzeNw
 41wjnogXd/Fh+KJ15J/da6abavpy01+MRv0r+Bo6ZOwRi9sKJoVL9g2YLcYsqvp/
 sAqwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=m1ehdjgfVHCBJVdC62PV/BMR7tjm+mOF8zi6eM10I
 cg=; b=DJRZwfCaWP4HuOgKPtowbZqTldTG6ymLM1OKis5xBlQUkuGHFYlMebgDv
 BbQ86ZiskiDkYTXJTrFrI7dAmL/17nvKXZJmZFhd9muZOMm0O7+o4+Kav+/ncOY/
 D4U9Nya2xtIbxWClqaPi+NARS9UX4z/0w1seegGkVKgg04eD4sJMK/nGQYsoCw7P
 J7qxRnk6CZQ+JFJr7pbWL7qjBsIzMKT5innRLADBt/BFQZiYuTQWsIf5I5WvZWQg
 a+qbO4ANCtVWsx0yI1rbcKyvZIiuzH31tVT0eOTImhVo+WABeFNCQjhJxqeYLKaM
 UgcS/Z/5VYQRvhiyUtnbnjxHPBijQ==
X-ME-Sender: <xms:RPuXX8aDaoKqEXaq72_XEsScN-v0GR5up11T8fW_tTRhmr0QmAICeg>
 <xme:RPuXX3YbPLBtFr1zNEcCP_uoiVn3kyklMky0NYQNIi4pmC9XVj8gYHObm4sqzgDgu
 Kr3zz2KgM6UgU8GzpI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:RPuXX28NbKaa9R0b0XF4kWEnCJeUhCFSqOiJSnB5ROB9SsOrrlROUQ>
 <xmx:RPuXX2reStkKq4bSxEC1uqDsrhTbBayV7sE7Yp0tYUui-0AAmt-bCw>
 <xmx:RPuXX3qzr_ra9vH_B7EnVsvg2faY1FyIWdgliMMp-2ZLQFPDWKykVg>
 <xmx:RPuXX4kx47V3k0G2redEIuOk3ka-doPE66h4i4JwPRWTj0DdEOsX1w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7C18B3280060;
 Tue, 27 Oct 2020 06:49:39 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/30] hw/block/nvme: alignment style fixes
Date: Tue, 27 Oct 2020 11:49:07 +0100
Message-Id: <20201027104932.558087-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Style fixes.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0ac9d856632e..d6d8324fa1de 100644
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
@@ -1515,7 +1516,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         }
 
         if (((n->temperature >= n->features.temp_thresh_hi) ||
-            (n->temperature <= n->features.temp_thresh_low)) &&
+             (n->temperature <= n->features.temp_thresh_low)) &&
             NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPERATURE) {
             nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
                                NVME_AER_INFO_SMART_TEMP_THRESH,
@@ -1765,9 +1766,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     n->cqe_size = 1 << NVME_CC_IOCQES(n->bar.cc);
     n->sqe_size = 1 << NVME_CC_IOSQES(n->bar.cc);
     nvme_init_cq(&n->admin_cq, n, n->bar.acq, 0, 0,
-        NVME_AQA_ACQS(n->bar.aqa) + 1, 1);
+                 NVME_AQA_ACQS(n->bar.aqa) + 1, 1);
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
-        NVME_AQA_ASQS(n->bar.aqa) + 1);
+                 NVME_AQA_ASQS(n->bar.aqa) + 1);
 
     nvme_set_timestamp(n, 0ULL);
 
@@ -1777,7 +1778,7 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 }
 
 static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
-    unsigned size)
+                           unsigned size)
 {
     if (unlikely(offset & (sizeof(uint32_t) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_mmiowr_misaligned32,
@@ -1920,7 +1921,7 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
                        "invalid write to PMRSWTP register, ignored");
         return;
     case 0xE14: /* TODO PMRMSC */
-         break;
+        break;
     default:
         NVME_GUEST_ERR(pci_nvme_ub_mmiowr_invalid,
                        "invalid MMIO write,"
@@ -2096,7 +2097,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 }
 
 static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
-    unsigned size)
+                            unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
 
@@ -2120,7 +2121,7 @@ static const MemoryRegionOps nvme_mmio_ops = {
 };
 
 static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
-    unsigned size)
+                           unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
     stn_le_p(&n->cmbuf[addr], size, data);
-- 
2.29.1


