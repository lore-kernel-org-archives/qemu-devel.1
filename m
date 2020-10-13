Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A2AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A7D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fX35jyos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A7D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSS9W-0003cX-8c
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS4G-0005lI-1X; Tue, 13 Oct 2020 17:42:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5487bf209=dmitry.fomichev@wdc.com>)
 id 1kSS4A-0001p9-QD; Tue, 13 Oct 2020 17:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602625363; x=1634161363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2tvzvHlyWyqcpNkDR+W2zhp5lJ8kigB3/iLnx2zDj+I=;
 b=fX35jyosm0lW8FyRYjydUl0EGdSXBt0sWYM+BsY0RPiFDyyzyE85NcKa
 fvGqGVgspeAdy2zhruDwn4vIPYlesYmQFi5wCdbrqaaI1WPPJUVzFvyP7
 G703eidcg75GYT1C78kRCsL1k7+mL7ZyE1HBOCwJPTMACnOshwJGw86ZF
 FS/l7ASdyYbSV7xLSazW96zrBXK3HeVOKbcvVmDy3WFJoG8Gt3yF5Ng4B
 C0Tw2W3HnHOsjT5WLZguy3Ryf9fq1jeRmzT+Ev4tKdZllYn4X/1g3J1K5
 Rl/pG1inXtoVMX0yiVLBNSZX54uLzWTWNmQyrcgYVImqdDFC50/b2l2W0 w==;
IronPort-SDR: qqr3T9r9iv+3XsmeVL+sWmuNWzV/BaKDkBA0ujjuxDo4dHhckpQJf5LNutffXrR/whz484Y9az
 BKczfA/P5unKrhtVVrdnlqDLjT8y8KypTYNxrOcZraNA3iQRBJNq5V4gNPqVfOXMO+9AWpzwhF
 wi2Jq+mlCGn+ma7I6O2cCP7ZJeFc/G3Ha79lyNKxESBGwMGuYnnjNgqZNoOiz66k3/uUxHJbIh
 PBk3DOlWC2txL6pb0OW/AwIDad9Qv8sEy4sXBoF1P79wNXNk13b+Q2MgN5+c6KxJNRKNpbqX/f
 KV4=
X-IronPort-AV: E=Sophos;i="5.77,371,1596470400"; d="scan'208";a="154185943"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 05:42:41 +0800
IronPort-SDR: /384elzfAH/qNtMdmvMGUFPujIK704DGhDZ60BgGHRZII2FYvvLGp/qUJdUYDwXqFNRxb7cX7d
 fg60Ev+GO+OQE2xrs23i9x8YttBXB//+gdePGx1vHB0NF0IzHJw8GQUNg8vPbYj+WtpUrRTff0
 ZGBUG+p6WbaZ+bC3TMuN3jcOeHvQLu4B3hXWtbTHATcpzv5yDECBUQpHB1i6lgWq9cPvT8hRKk
 nelO44lI7yP20twD0HKgGzY+FvVnZd5IfH4uMRVHxWQpG2o5WlohRsLoOB6pQCUDf6KQ3s3QZx
 Jft2LF7MsGViUdPV61/1Sl8z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 14:29:14 -0700
IronPort-SDR: J4sqloMtH1iWVsgzR/sel2qw8NhGucBFo762gTkqJDJ3TYkLNa+zcmEI5a219DOQxAQ+vA841a
 KU19e3OHWUnwD+2o6tlQIYFTGAIHUgQeZbCEWKtVJ8C4cQeHm8q5ecH471sUu/mgMjHrMY0hqo
 fGOwMGTnVWc+vwt7niGQb5JllG/CUUmfx6LuPEbTtgV0YWWr1xVIZTY05zgMUxkuq5AsqgmKWQ
 3hWgpvpBZ1EjPTK4nXn66PqBsPe+lk7DzumwoeRnGdwXJYgSPvcLJYiXWFwOr4YF1FByGDfrZh
 3KY=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 14:42:39 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v6 10/11] hw/block/nvme: Separate read and write handlers
Date: Wed, 14 Oct 2020 06:42:11 +0900
Message-Id: <20201013214212.2152-11-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5487bf209=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:42:19
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

With ZNS support in place, the majority of code in nvme_rw() has
become read- or write-specific. Move these parts to two separate
handlers, nvme_read() and nvme_write() to make the code more
readable and to remove multiple is_write checks that so far existed
in the i/o path.

This is a refactoring patch, no change in functionality.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c       | 191 +++++++++++++++++++++++++-----------------
 hw/block/trace-events |   3 +-
 2 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 41caf35430..1186c16b50 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1162,10 +1162,10 @@ typedef struct NvmeReadFillCtx {
     uint32_t  post_rd_fill_nlb;
 } NvmeReadFillCtx;
 
-static uint16_t nvme_check_zone_read(NvmeNamespace *ns, NvmeZone *zone,
-                                     uint64_t slba, uint32_t nlb,
-                                     NvmeReadFillCtx *rfc)
+static uint16_t nvme_check_zone_read(NvmeNamespace *ns, uint64_t slba,
+                                     uint32_t nlb, NvmeReadFillCtx *rfc)
 {
+    NvmeZone *zone = nvme_get_zone_by_slba(ns, slba);
     NvmeZone *next_zone;
     uint64_t bndry = nvme_zone_rd_boundary(ns, zone);
     uint64_t end = slba + nlb, wp1, wp2;
@@ -1449,6 +1449,86 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    uint32_t fill_len;
+    uint64_t data_size = nvme_l2b(ns, nlb);
+    uint64_t data_offset, fill_ofs;
+    NvmeReadFillCtx rfc;
+    BlockBackend *blk = ns->blkconf.blk;
+    uint16_t status;
+
+    trace_pci_nvme_read(nvme_cid(req), nvme_nsid(ns), nlb, data_size, slba);
+
+    status = nvme_check_mdts(n, data_size);
+    if (status) {
+        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
+        goto invalid;
+    }
+
+    status = nvme_check_bounds(n, ns, slba, nlb);
+    if (status) {
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        goto invalid;
+    }
+
+    if (ns->params.zoned) {
+        status = nvme_check_zone_read(ns, slba, nlb, &rfc);
+        if (status != NVME_SUCCESS) {
+            trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
+            goto invalid;
+        }
+    }
+
+    status = nvme_map_dptr(n, data_size, req);
+    if (status) {
+        goto invalid;
+    }
+
+    if (ns->params.zoned) {
+        if (rfc.pre_rd_fill_nlb) {
+            fill_ofs = nvme_l2b(ns, rfc.pre_rd_fill_slba - slba);
+            fill_len = nvme_l2b(ns, rfc.pre_rd_fill_nlb);
+            nvme_fill_read_data(req, fill_ofs, fill_len,
+                                n->params.fill_pattern);
+        }
+        if (!rfc.read_nlb) {
+            /* No backend I/O necessary, only needed to fill the buffer */
+            req->status = NVME_SUCCESS;
+            return NVME_SUCCESS;
+        }
+        if (rfc.post_rd_fill_nlb) {
+            req->fill_ofs = nvme_l2b(ns, rfc.post_rd_fill_slba - slba);
+            req->fill_len = nvme_l2b(ns, rfc.post_rd_fill_nlb);
+        } else {
+            req->fill_len = 0;
+        }
+        slba = rfc.read_slba;
+        data_size = nvme_l2b(ns, rfc.read_nlb);
+    }
+
+    data_offset = nvme_l2b(ns, slba);
+
+    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                     BLOCK_ACCT_READ);
+    if (req->qsg.sg) {
+        req->aiocb = dma_blk_read(blk, &req->qsg, data_offset,
+                                  BDRV_SECTOR_SIZE, nvme_rw_cb, req);
+    } else {
+        req->aiocb = blk_aio_preadv(blk, data_offset, &req->iov, 0,
+                                    nvme_rw_cb, req);
+    }
+    return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_READ);
+    return status | NVME_DNR;
+}
+
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
@@ -1495,25 +1575,20 @@ invalid:
     return status | NVME_DNR;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
+static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req, bool append)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset, fill_ofs;
-
+    uint64_t data_offset;
     NvmeZone *zone;
-    uint32_t fill_len;
-    NvmeReadFillCtx rfc;
-    bool is_write = rw->opcode == NVME_CMD_WRITE || append;
-    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
-                      nvme_nsid(ns), nlb, data_size, slba);
+    trace_pci_nvme_write(nvme_cid(req), nvme_io_opc_str(rw->opcode),
+                         nvme_nsid(ns), nlb, data_size, slba);
 
     status = nvme_check_mdts(n, data_size);
     if (status) {
@@ -1530,29 +1605,21 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
     if (ns->params.zoned) {
         zone = nvme_get_zone_by_slba(ns, slba);
 
-        if (is_write) {
-            status = nvme_check_zone_write(n, ns, zone, slba, nlb, append);
-            if (status != NVME_SUCCESS) {
-                goto invalid;
-            }
-
-            if (append) {
-                slba = zone->w_ptr;
-            }
-
-            status = nvme_auto_open_zone(ns, zone);
-            if (status != NVME_SUCCESS) {
-                goto invalid;
-            }
-
-            req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
-        } else {
-            status = nvme_check_zone_read(ns, zone, slba, nlb, &rfc);
-            if (status != NVME_SUCCESS) {
-                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
-                goto invalid;
-            }
+        status = nvme_check_zone_write(n, ns, zone, slba, nlb, append);
+        if (status != NVME_SUCCESS) {
+            goto invalid;
         }
+
+        status = nvme_auto_open_zone(ns, zone);
+        if (status != NVME_SUCCESS) {
+            goto invalid;
+        }
+
+        if (append) {
+            slba = zone->w_ptr;
+        }
+
+        req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
     } else if (append) {
         trace_pci_nvme_err_invalid_opc(rw->opcode);
         status = NVME_INVALID_OPCODE;
@@ -1566,56 +1633,21 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
         goto invalid;
     }
 
-    if (ns->params.zoned) {
-        if (is_write) {
-            req->cqe.result64 = nvme_advance_zone_wp(ns, zone, nlb);
-        } else {
-            if (rfc.pre_rd_fill_nlb) {
-                fill_ofs = nvme_l2b(ns, rfc.pre_rd_fill_slba - slba);
-                fill_len = nvme_l2b(ns, rfc.pre_rd_fill_nlb);
-                nvme_fill_read_data(req, fill_ofs, fill_len,
-                                    n->params.fill_pattern);
-            }
-            if (!rfc.read_nlb) {
-                /* No backend I/O necessary, only needed to fill the buffer */
-                req->status = NVME_SUCCESS;
-                return NVME_SUCCESS;
-            }
-            if (rfc.post_rd_fill_nlb) {
-                req->fill_ofs = nvme_l2b(ns, rfc.post_rd_fill_slba - slba);
-                req->fill_len = nvme_l2b(ns, rfc.post_rd_fill_nlb);
-            } else {
-                req->fill_len = 0;
-            }
-            slba = rfc.read_slba;
-            data_size = nvme_l2b(ns, rfc.read_nlb);
-        }
-    }
-
     data_offset = nvme_l2b(ns, slba);
 
-    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
+    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                     BLOCK_ACCT_WRITE);
     if (req->qsg.sg) {
-        if (is_write) {
-            req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
-                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-        } else {
-            req->aiocb = dma_blk_read(blk, &req->qsg, data_offset,
-                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-        }
+        req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
+                                   BDRV_SECTOR_SIZE, nvme_rw_cb, req);
     } else {
-        if (is_write) {
-            req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
-                                         nvme_rw_cb, req);
-        } else {
-            req->aiocb = blk_aio_preadv(blk, data_offset, &req->iov, 0,
-                                        nvme_rw_cb, req);
-        }
+        req->aiocb = blk_aio_pwritev(blk, data_offset, &req->iov, 0,
+                                     nvme_rw_cb, req);
     }
     return NVME_NO_COMPLETE;
 
 invalid:
-    block_acct_invalid(blk_get_stats(blk), acct);
+    block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
     return status | NVME_DNR;
 }
 
@@ -2096,10 +2128,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE_ZEROES:
         return nvme_write_zeroes(n, req);
     case NVME_CMD_ZONE_APPEND:
-        return nvme_rw(n, req, true);
+        return nvme_write(n, req, true);
     case NVME_CMD_WRITE:
+        return nvme_write(n, req, false);
     case NVME_CMD_READ:
-        return nvme_rw(n, req, false);
+        return nvme_read(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
         return nvme_zone_mgmt_send(n, req);
     case NVME_CMD_ZONE_MGMT_RECV:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 962084e40c..7ee90a50c3 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -40,7 +40,8 @@ pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2,
 pci_nvme_map_sgl(uint16_t cid, uint8_t typ, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
-pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
+pci_nvme_read(uint16_t cid, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
+pci_nvme_write(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
 pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
-- 
2.21.0


