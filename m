Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA56C4741F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1B82087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hDXKIku1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1B82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBUs-0005Tk-TM
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOF-0005Ll-Mq; Fri, 06 Nov 2020 18:43:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOB-0003Tq-Uq; Fri, 06 Nov 2020 18:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604706208; x=1636242208;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G3kD64FZFQBNwCAKQ6g+YVeLzgd0PXwIYGnld+o7ZrQ=;
 b=hDXKIku1ytFXPVMEpKNccP0xxJQCd8rzV5Jcb3F+Zf6/SrZmTPT3nDbD
 5N8HemvSPOSAcq/GhXGnvjXFvWoU1DykCDvHLRRhYzIful7NmxWKPBx4j
 kbFaX2FPpdT5dNamcfzjHZlpaY4FV8Bz09YjfRx/GHacK9I/YuuUDUOME
 foIrym1UIwzZY8Ni1dQ3pVTxubFt3PhKfVVSHv2R8ostmi9yPSkeQOStI
 /AiAWC/vJ1YT7AZKMgDPVJZKGt4AeyI17ZahKonMOtrxMMUec+DHXppfn
 jzQZkHYRBYcJt4L0CekrthZkeJtFCA4AF+Qo0sDzqA9NjuWfPkgFNJQbO A==;
IronPort-SDR: MIbK2XfzX3Aj9jr3cKRczTgNhxYNgzjUEin1UxmU4ok8qnSqfV4Y9EWEcf9QGFJEaw4s+uI/hA
 2iDIrYXBmSdz6q2MiJ6kCyT1wfU98F3b9Anmj2cMIBd1oVAuDYJ1SumB0m2toCmLJadT4TAit4
 I+thKvI19AVcFF+2++DnoO6uJie64PEe6SO6jA2QwSVnOLUUiCh8N84X62LyT8k+EPQjwzAM+I
 ubTjWlwCZpafiuOSNl4xqWqSRozOiKOf/lNgMbY5cKOIAVZAOI39EnoJhK0agShonBmB6j3Jvm
 wIc=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="153267061"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:43:23 +0800
IronPort-SDR: gxAxOcDNIxokSlWuSZ6a2m/QAIdrDTOIlLXYiyfER92JDrcD9nXxyiJMwA9jfFO365Chp88IOy
 KvRmEzD+4tEqgfNeYaQ1Ss3midfs8iK80sAxQOiZxkn+Vd8Fx7r00edunO+gz8W/rwx0fqFgVN
 EHCdAUye2+sHnw/+5x9gGS6yI3TSQelb/XKb3FcKgMyUSwuo6ZZ9QQ+FxlY6MEgiYYgo2HyNUC
 3x0FPMlCT+0G+kbUzdWPIBa8sNKQzQUFPIkQQPh9ul7ZCmywTnYcLcHWcCUlxE5fpgqPcMl11e
 wHB2B1R9KNMyRr1rXORV/bv7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2020 15:28:14 -0800
IronPort-SDR: 3bfwp0CI24LlCyo+hLjKBDRQ9mJhajMPgm+NF5ZDmO1Atutzmgo5eZ2qFzBFSOLH+mbtZXct5y
 PiDqJWrJRPho08x0H8Qzxb+OR6YPL2bQ455+JWqtyiu/LHThJtKnRTYw2cYaKxbBSUvsT9GOeJ
 BlopNpWnOfBMVoLJR326JoXQ919aq3pO+d+6kLoVNuJCLpWz1O+/LNn+f3vQiQfbEQDIDzKgU4
 +PrFJIuhHVlcrCspaIOJALKw++SHyjSdsU4EMB7nPTuTGfekcxT5FmoM1KsSrW1apkgRhxVLFJ
 53U=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2020 15:43:20 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v10 04/12] hw/block/nvme: Merge nvme_write_zeroes() with
 nvme_write()
Date: Sat,  7 Nov 2020 08:42:57 +0900
Message-Id: <20201106234305.21339-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
References: <20201106234305.21339-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=572b21b8d=dmitry.fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 18:43:12
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


