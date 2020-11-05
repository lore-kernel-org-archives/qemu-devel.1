Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50457C388F9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38FE20728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pQvM/MCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38FE20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVQq-0000yM-Ox
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 21:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPT-0007ck-Rz; Wed, 04 Nov 2020 21:53:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPQ-0002ZQ-Fo; Wed, 04 Nov 2020 21:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544836; x=1636080836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G3kD64FZFQBNwCAKQ6g+YVeLzgd0PXwIYGnld+o7ZrQ=;
 b=pQvM/MCTeImrqC1wCC4G42sFb6+xtdPDGaOe8QZ1Pf6jvEpX8zu6d3/1
 dDodZ1KhFKkL6ijxjToehoavXs1/0Zv+QcZAO8sMqRqrk4wYU9QdYTfTa
 /QaDhZv+dXdBPc/uxReyVhBliVLwc6rS0FBoJU73Q1GjwiARoG+JY3N01
 /vE7rt1qihncn19h6aUuLcG2wgedSLhCoTRQx9dI66f8jk99B849+L7cJ
 kCTx0LQW6+Kdq1TUdS338xexvA9/NdacF1JDCoM0loOKJI4caEJNR8YYM
 J4NAVpIVv9woRqeW+IPG8tCNMXNPzyk6NXYjN9fvg1KsL+bP2eFvmU5HR Q==;
IronPort-SDR: X2qVPAmSmmEDgww7bOD0vgM8j7zN0vO8b/oeUXN1Lh3GZRAbEwtsMOwEyjboA76ZRFCfAfr2hq
 oBDe1hvwgsLlGAwcxhz9zYjTDzGRWnwRox7NN5qQNa7eFe80mRvqnpbNVFZb8aRDTL+VNfKkKO
 m23POMDih5m3n0rjnrZb9b1wclROeCVPsdGk0wjYaWi9uq2lPJUa5cGLwX0VJMC3hJ5jHThThM
 BQl0bWl7NMwVu8jVpvDwNV+Grc+wDwS4OMPQYOnC+n7nRKG7/Bj37dClY0+BHWNaYz3Gkt4VEA
 fAQ=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335132"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:53:54 +0800
IronPort-SDR: 2YKm3WaD4y37Sc1UuKlquTX2nFhY2MiDwtMpx8S7uNsVWCiWoeZfj3EDF+dvlHmu0ro0bhZ+qJ
 ApwkgEYyyv33FalJTa7e++HmY5vJQqUe6RbhqT4Y5LgR3UnajgO4jnlKRQyJ+/vQO6c1EbiXVZ
 gaap8wcl50o4vEZi8XiFLIHJ81jHlZYNj2FeknsFzjBOFjAwzVPyASAwlcmMXIkxVw1GeqQRtl
 R3uiQ+aMW0A1jhl60/9u2jO3jw7c78U7h7dNNtKt4Ay1l5ypRB7sNZP7JU0TQNKJtct3PxBDHu
 j8ICCz0JVecfO0Bx4QuiwB4b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:02 -0800
IronPort-SDR: sT1aWF3FHJ1YViTGHTR/4TFINfuXVDbgqTdR6iCqAzimcaKn0cfBRwksT1me9goFiO7l/DOCdV
 kS00vVlHr4KWDSgXMqNF04hi8Fmu+Gbf/YSEoicaQcr5N3chG75eefIYf61Won4tEAPaI47Dv9
 xg8XWNImBLzy2AtbSIJmqUz8mGfII3lGJVua21K636rmeeCzSmrzZJO0otNffVoH7Im1rRlbBS
 jEDqDBrS11AlLdMiqf5aeiljlq6pYtVoBcF0utlOQqdMB72XYbnHX4lVMozmDey2DRIRAULqRD
 +dY=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:53:53 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 04/12] hw/block/nvme: Merge nvme_write_zeroes() with
 nvme_write()
Date: Thu,  5 Nov 2020 11:53:34 +0900
Message-Id: <20201105025342.9037-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=571894d84=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:53:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_write() now handles WRITE, WRITE ZEROES and ZONE_APPEND.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Acked-by: Klaus Jensen <its@irrelevant.dk>
---
 hw/block/nvme.c       | 72 +++++++++++++++++--------------------------
 hw/block/trace-events |  1 -
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 770e42a066..48adbe84f5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1001,32 +1001,7 @@ invalid:
     return status | NVME_DNR;
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
-{
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-    NvmeNamespace *ns = req->ns;
-    uint64_t slba = le64_to_cpu(rw->slba);
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset = nvme_l2b(ns, slba);
-    uint32_t count = nvme_l2b(ns, nlb);
-    uint16_t status;
-
-    trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb);
-
-    status = nvme_check_bounds(n, ns, slba, nlb);
-    if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return status;
-    }
-
-    block_acct_start(blk_get_stats(req->ns->blkconf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(req->ns->blkconf.blk, offset, count,
-                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
-    return NVME_NO_COMPLETE;
-}
-
-static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool wrz)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
@@ -1040,10 +1015,12 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_write(nvme_cid(req), nvme_io_opc_str(rw->opcode),
                          nvme_nsid(ns), nlb, data_size, slba);
 
-    status = nvme_check_mdts(n, data_size);
-    if (status) {
-        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        goto invalid;
+    if (!wrz) {
+        status = nvme_check_mdts(n, data_size);
+        if (status) {
+            trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
+            goto invalid;
+        }
     }
 
     status = nvme_check_bounds(n, ns, slba, nlb);
@@ -1052,21 +1029,28 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    status = nvme_map_dptr(n, data_size, req);
-    if (status) {
-        goto invalid;
-    }
-
     data_offset = nvme_l2b(ns, slba);
 
-    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
-                     BLOCK_ACCT_WRITE);
-    if (req->qsg.sg) {
-        req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
-                                   BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+    if (!wrz) {
+        status = nvme_map_dptr(n, data_size, req);
+        if (status) {
+            goto invalid;
+        }
+
+        block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                         BLOCK_ACCT_WRITE);
+        if (req->qsg.sg) {
+            req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
+                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+        } else {
+            req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
+                                         nvme_rw_cb, req);
+        }
     } else {
-        req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
-                                     nvme_rw_cb, req);
+        block_acct_start(blk_get_stats(blk), &req->acct, 0, BLOCK_ACCT_WRITE);
+        req->aiocb = blk_aio_pwrite_zeroes(blk, data_offset, data_size,
+                                           BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
+                                           req);
     }
     return NVME_NO_COMPLETE;
 
@@ -1100,9 +1084,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
+        return nvme_write(n, req, true);
     case NVME_CMD_WRITE:
-        return nvme_write(n, req);
+        return nvme_write(n, req, false);
     case NVME_CMD_READ:
         return nvme_read(n, req);
     default:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 540c600931..e67e96c2b5 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -43,7 +43,6 @@ pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opna
 pci_nvme_read(uint16_t cid, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_write(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
-pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
-- 
2.21.0


