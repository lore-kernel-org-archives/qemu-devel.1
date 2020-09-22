Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D75C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CB0221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CB0221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe3f-0002WU-8E
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvr-0005pF-OE; Tue, 22 Sep 2020 04:45:53 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvl-0000tU-I8; Tue, 22 Sep 2020 04:45:51 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id DE6DB5803D2;
 Tue, 22 Sep 2020 04:45:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 x4vv+T40p0jIO6OxlpnmqniLdnLaguKjuccD9y2E7Qg=; b=U7teNELb0YjpIDLN
 vahRUDDdBF8CAOZlsL9F9wWAeEO0mOwORc9u5sI3ZjOiEaUhIIGuUVI/Ox9LGiR5
 vbIj3uVO0A2Qde0+Ez5VPkA/YkI6gk2ihdMCsmBdjcXk/5RBrDo8UD14x0cFb23/
 VclrZMO5QbhXE8X1p5eVzdFIyqSmncH0rfWxdqAPaklsdH8z83L2NuL6F/eCVR/q
 ouJ0RyFcMxpVJ/dLkLrt/ctFqZD7PkJ9C9ZmOMnBSShcrPoRVvtLjx7MOABa1H39
 ayussnPgcMKMF83ufiCZd1AhyvrVEPqq11riUs+RK6StcIxTrAIzGK+lZGx7J7z+
 27TfGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=x4vv+T40p0jIO6OxlpnmqniLdnLaguKjuccD9y2E7
 Qg=; b=VG1EOJjYF7cm63F6Xjb5LuRmbrAz7omXwzXeYgq4iYaApf3i1jxPVwOzP
 Cb7ZJej6s7Nu3jdXA9Mw0h25I/mo2OgBTbJ1rP9276nEyaFJMMk5uLtNwZ6m94Mq
 bzNUAhkamCBphMSesGnxKX8tyHbK5PRpPSE2xezEMr/ogbJtPgi0iXB9G7Ca+kry
 n/riU7s6uBhrdIUC8lD5CA/wqbr+L5LQgKYqvClBgX32B34YR1seXTTI2v9nG943
 l0x5QDzofNZ++wkRbE9JvqSQ3voaMXqWQaxAOH/0OCA+3YjMVHwZ+UGWjDzhRu1Z
 JsE8XOpcyubGrHLweDXYJ6zEXusgQ==
X-ME-Sender: <xms:t7lpXyVbEuWVVImPgHIsnsZWwK4HQTjklpcn6ySHJEl5pIBVolYPZw>
 <xme:t7lpX-koxmpBKTH3vCaM2eWO_zDkQIVbU4sOhHj4rFOUkchHBrgp1QejIwtTqhL7l
 hnlvGJ2zUHCVliFQro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedvne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:t7lpX2YZTTtTrapsX9AS6f0Qj3DY6oDadWQx4_Quz6uvA8aQIix5pA>
 <xmx:t7lpX5XgkKcZL_jfSiQAeFWhvohTpA7tmS1EFRHaSH8RtrXhX0zsPg>
 <xmx:t7lpX8lBFf6akWLI1Qv57g983Dzosu-5nvlaitGDlhIa_uJJycPPww>
 <xmx:t7lpX24nraIiQnYU5apKm-l-2ZehZXCSIhiV6GIf29y8ln_574sjIr-XcuY>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E36B2306467E;
 Tue, 22 Sep 2020 04:45:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/17] hw/block/nvme: alignment style fixes
Date: Tue, 22 Sep 2020 10:45:21 +0200
Message-Id: <20200922084533.1273962-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index a76a6464d6a1..bc8690fa7aaa 100644
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


