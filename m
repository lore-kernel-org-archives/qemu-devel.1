Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2993AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2DE22268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="auwWx2XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2DE22268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKsL-0001FC-Sy
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkN-0000D5-Cw; Sun, 18 Oct 2020 22:18:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKkI-0004JR-7i; Sun, 18 Oct 2020 22:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073878; x=1634609878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fuuX0wK/clVu0dfU7G8Ccc31uXLe2PXHzQgnXocAqvc=;
 b=auwWx2XW/0wdLHPz74djJ1C5DzCTZSi3tUBQrfAgJIU2joM2QMRFwE4a
 AwOhdeV+NcfvwYuiWtK66PewsTDkLn7ykPVvJCz+7lhEbFVnQPBCLEtzD
 6ssOg6qGtmVx76jKNbh12lCg1zZ+kHOhcCCP0ThEnMyX2f9wAjHY/qix1
 v0Qm78kxOnS5F+GEe/dOCBG+tCZC0BCuVVi7wIuhQYJ4PZKH2tfZyuf64
 ryFulz8dWj0izc4fuWwDtjOPjrogCcrMew+dDeRs+M0PybyNNDMDPmOqx
 H2Ui+4Yoq+jjWghS31UTBvOO+jvMsnWuqVBtbT0e1WDLsJ9iJIEI9oUSu w==;
IronPort-SDR: rNIabVQcA/2g0lN5ineLvbPoIJI8Y86Bcblpj8W586GfG38Xv5bS8IEY6cGFNMQ/8fgt2WT+B1
 IvThZSoizW5miD2Ouhrb0Z1hK+X0fcA2YMuXnGNrYauQkcWH5MK+nXYwThdp/AzoGAmkoGtfE4
 ZO7UhxTN5EU4fO+NAjkPvPrI9/SutAd7N7zyy+3dPnP2pbgkadhArGmf9fU/51As3Wu5mkWqlk
 txJn132O50XA2JSYXenEYD29FJJYU1wDVsC5PLRAogx7zFUJEQMRNSuBVji2lfnocPIYhgf025
 ruI=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="150207989"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:17:56 +0800
IronPort-SDR: B+0C1gidDlU6cOvx4JD/Yg9rc+Al8q+XO7Ty+k8NmRyWk848gs9RGYiTzWYDNGJRbfRSSG/QCq
 iBB0CKl1zz4nmuFTTAc1WUEEgJh2imfeWQs2/OEHvCQJJr5qD8w6zEPlJWBB2PiGObr5mAgx5h
 GRACu7v2wku0ZHJkKNPTRO2HmZszfUMl1SGwgG7D0FRUEh0Ozn1PH4cjPiXCeU+4Se1qdUytJJ
 iCUn59uSm5e6fY/J73OR/PJ9PJFMoSEnJTSNs5g2DQY15ftdCombA5byndsr1kHyfZm8MlaudI
 CewLBFAtxDRPbqem+nwu7LIB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 19:03:33 -0700
IronPort-SDR: 5R869P/8XumV35KmKMYAuaAvKoD4zmNMbekQXwW4N3g9xzFXKJ5eTlS+mRtZ2YA/twOKvdUDBH
 GH97WweMYH7hY2IBS46FrV2f9Rfn4/E59eRhK9qP1TLFoIDUh6/HN4wXJt2T3RPqs8GTr9UCfJ
 yxasPjEKMJIpwUCPm4wl2zLfzrVwVWXq/6zCJtyio3Zyp8aUEq9ToFeYQcsdwAmTn+f9DADa0A
 v3DICXTEyECdCmbBDXy5pwjtYaXSIeI97jos0CU3tqMgKT8r+XwCGhl6xk6QKK7UFryx0KYqOH
 RwI=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 19:17:54 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v7 11/11] hw/block/nvme: Merge nvme_write_zeroes() with
 nvme_write()
Date: Mon, 19 Oct 2020 11:17:26 +0900
Message-Id: <20201019021726.12048-12-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5541069a6=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:17:33
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
---
 hw/block/nvme.c       | 95 +++++++++++++------------------------------
 hw/block/trace-events |  1 -
 2 files changed, 28 insertions(+), 68 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5ec4ce5e28..aa929d1edf 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1529,53 +1529,7 @@ invalid:
     return status | NVME_DNR;
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
-{
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-    NvmeNamespace *ns = req->ns;
-    uint64_t slba = le64_to_cpu(rw->slba);
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
-    NvmeZone *zone;
-    uint64_t offset = nvme_l2b(ns, slba);
-    uint32_t count = nvme_l2b(ns, nlb);
-    BlockBackend *blk = ns->blkconf.blk;
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
-    if (ns->params.zoned) {
-        zone = nvme_get_zone_by_slba(ns, slba);
-
-        status = nvme_check_zone_write(n, ns, zone, slba, nlb, false);
-        if (status != NVME_SUCCESS) {
-            goto invalid;
-        }
-
-        status = nvme_auto_open_zone(ns, zone);
-        if (status != NVME_SUCCESS) {
-            goto invalid;
-        }
-
-        req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
-    }
-
-    block_acct_start(blk_get_stats(blk), &req->acct, 0, BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(blk, offset, count,
-                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
-    return NVME_NO_COMPLETE;
-
-invalid:
-    block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
-    return status | NVME_DNR;
-}
-
-static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append)
+static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append, bool wrz)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
@@ -1590,10 +1544,12 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append)
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
@@ -1628,21 +1584,26 @@ static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append)
 
     data_offset = nvme_l2b(ns, slba);
 
-    status = nvme_map_dptr(n, data_size, req);
-    if (status) {
-        goto invalid;
-    }
+    if (!wrz) {
+        status = nvme_map_dptr(n, data_size, req);
+        if (status) {
+            goto invalid;
+        }
 
-    data_offset = nvme_l2b(ns, slba);
-
-    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
-                     BLOCK_ACCT_WRITE);
-    if (req->qsg.sg) {
-        req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
-                                   BDRV_SECTOR_SIZE, nvme_rw_cb, req);
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
 
@@ -2126,11 +2087,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
+        return nvme_write(n, req, false, true);
     case NVME_CMD_ZONE_APPEND:
-        return nvme_write(n, req, true);
+        return nvme_write(n, req, true, false);
     case NVME_CMD_WRITE:
-        return nvme_write(n, req, false);
+        return nvme_write(n, req, false, false);
     case NVME_CMD_READ:
         return nvme_read(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 7ee90a50c3..5a3cd4c5dc 100644
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


