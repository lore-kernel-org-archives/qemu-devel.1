Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D855C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1A620728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lvfFt+vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1A620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVRh-00022m-0K
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 21:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPP-0007U1-Ux; Wed, 04 Nov 2020 21:53:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPN-0002ZQ-IU; Wed, 04 Nov 2020 21:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544833; x=1636080833;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6G60QSjZ5krlPLtstuo7O4+ni+lcVZttvDGIQYGvErY=;
 b=lvfFt+vS4BzFCbMnIV3/M7jzeMzi2m9itdXZCoNrtVZ26aoSYdp3NSTR
 F9BFl+jQdnE5U2kice+GLWSrzpyVltVDmADxGPRVhQiMxb6qoLCvc2EsC
 mQglNnb017eiFuvJX1beXwndRr26rvhb1TolJKihUD4u1yG5t3oT2aQgz
 Q/CRbBFJEzIALHA2I4lokxDqL+p9YhJ4mszsrP+hjULtIbSCRiheD8D8S
 N5o3TBXwonnteL+XqqfxNHeHTBcRlE43Mg5Nqob98r3oCLCcnzWnG5w3p
 X/7eQ3qEyU60yaYxGc0No548rSsCrPkMsBc1z98E+ndU1bCX016Nwi7p0 A==;
IronPort-SDR: 7kpFo/f5OeUGnN2gdfbLVvDRui1zMWQBMrZULmTwg0AKyqtOWoWPJeGI/s0/w+m7uYNCnqCh9o
 8piT0bjU8YqfsNjC8pDkLZ7wIAe4n70lxPoTfztt1quZqZH2Fy9bG1SRK6QUQKCrxNRGFi4+9q
 1ToD+/L78Aw0pD5GNSn74Js5eR/tAUZQ4ySwiJql+Fw8xwQmaDEG8xinMyzbZwxZLXBQq1GE+m
 HQhF7tKwHyqoHpHfbbYxrUGI3kR/UrpiXhRKfqOrlFcmBqIx8DtFGgHwNuYE//onlp8f7efrFJ
 zn0=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335130"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:53:52 +0800
IronPort-SDR: hR9K5NIQnMsc8+wbDklh/WCb02v7nnOKLgDwf7rRT7X5a9JbzIt/PfKAZJ6QKo51okZbXpexvi
 qxRxJtppqnpNgpVfsTlDZcIrl7nqHjvkbtBUJ7YCnt+XLQvtfz2f9g9lUpShHM9vITS+at5iaF
 i46qh9FcJqKw7ZiaizJmbkE4YHGWDxSwI+eUd+DenUOVq3cncCP4aa1bbDeLKSMqaGqmaUzkgJ
 FE/iydjmP+baOfm9WIt6wXWgYeDwt/dzAyaV3xE1IIzXcNsyogAcpDfTF1wbXzQWppQQrELWNU
 3v90wcXRuI4Kr7j+R7lMPVFg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:39:59 -0800
IronPort-SDR: 1ejDSofpMYdE8WL497RTRoOuebINrCiV7yS57z34XjSW53HWijFgNG/S5hnq8IR6UT3nGnC3Ur
 nWMPnRdfrDigw6ThgjSPFOGoMrYJD704Bf6SH3Hh6CcB6b/h9LskKsx2fkBW4kvrDfyhLs9MHn
 mKP5/VUY+Iz5V5s2q/KlZc2lXdy7wxaEBE0kokbmWfaHZCv3cyWvHi32Z+/t0y2tpnamDBfZnw
 rJ57fbZ/M2JRCxjTr+kl/nP+Q/+PwKwMweH0IZEPewWGE9IZwvHPKFUJ0FzDeJ8bI6pL7PZgO5
 U20=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:53:50 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 03/12] hw/block/nvme: Separate read and write handlers
Date: Thu,  5 Nov 2020 11:53:33 +0900
Message-Id: <20201105025342.9037-4-dmitry.fomichev@wdc.com>
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

With ZNS support in place, the majority of code in nvme_rw() has
become read- or write-specific. Move these parts to two separate
handlers, nvme_read() and nvme_write() to make the code more
readable and to remove multiple is_write checks that so far existed
in the i/o path.

This is a refactoring patch, no change in functionality.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Acked-by: Klaus Jensen <its@irrelevant.dk>
---
 hw/block/nvme.c       | 91 ++++++++++++++++++++++++++++++-------------
 hw/block/trace-events |  3 +-
 2 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ed3f38f01d..770e42a066 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -953,6 +953,54 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
+    uint64_t data_size = nvme_l2b(ns, nlb);
+    uint64_t data_offset;
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
+    status = nvme_map_dptr(n, data_size, req);
+    if (status) {
+        goto invalid;
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
@@ -978,22 +1026,19 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_write(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
-
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset = nvme_l2b(ns, slba);
-    enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
-        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    uint64_t data_offset;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
-    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
-                      nvme_nsid(ns), nlb, data_size, slba);
+    trace_pci_nvme_write(nvme_cid(req), nvme_io_opc_str(rw->opcode),
+                         nvme_nsid(ns), nlb, data_size, slba);
 
     status = nvme_check_mdts(n, data_size);
     if (status) {
@@ -1012,29 +1057,22 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    block_acct_start(blk_get_stats(blk), &req->acct, data_size, acct);
+    data_offset = nvme_l2b(ns, slba);
+
+    block_acct_start(blk_get_stats(blk), &req->acct, data_size,
+                     BLOCK_ACCT_WRITE);
     if (req->qsg.sg) {
-        if (acct == BLOCK_ACCT_WRITE) {
-            req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
-                                       BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-        } else {
-            req->aiocb = dma_blk_read(blk, &req->qsg, data_offset,
-                                      BDRV_SECTOR_SIZE, nvme_rw_cb, req);
-        }
+        req->aiocb = dma_blk_write(blk, &req->qsg, data_offset,
+                                   BDRV_SECTOR_SIZE, nvme_rw_cb, req);
     } else {
-        if (acct == BLOCK_ACCT_WRITE) {
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
-    block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
-    return status;
+    block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
+    return status | NVME_DNR;
 }
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
@@ -1064,8 +1102,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_WRITE_ZEROES:
         return nvme_write_zeroes(n, req);
     case NVME_CMD_WRITE:
+        return nvme_write(n, req);
     case NVME_CMD_READ:
-        return nvme_rw(n, req);
+        return nvme_read(n, req);
     default:
         assert(false);
     }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 33832a2021..540c600931 100644
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


