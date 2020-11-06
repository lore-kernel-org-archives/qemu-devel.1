Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C4AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C4A20702
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cG42IeA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C4A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBPa-0007BN-0G
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBOD-0005K7-MM; Fri, 06 Nov 2020 18:43:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBO6-0003Sk-Fr; Fri, 06 Nov 2020 18:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604706203; x=1636242203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6G60QSjZ5krlPLtstuo7O4+ni+lcVZttvDGIQYGvErY=;
 b=cG42IeA1rmUDUD3gBVRdLEUIroEPdNGAR15ddGgjpwLhjH1cTEEUaIim
 6HhcyDSm7u8S+Oa2cmbNIfTsybd+6YE3wcV1OpfCGxL5b9fTRwDH4DMbL
 3r5JGIQInGbFiIXVGUiyN+yk056jjpjadg/aVDGd6naumX+rubE7EFqVN
 1TAlnbfIlLeAac0g6JBwybr63hLlxpoUrNY93LT9VxCJfy9gsL9x07KTD
 ZP2JNdno0jRglnO8Qq1DgHRqqLuQQLchJtNujSyIe33BWHjWOclyYSWFb
 kSz0yW81rY4EYF0cJjtvFIfnWcRCESHot8ImVeKlKQz+90gjNDfm87hJc Q==;
IronPort-SDR: eVRk/l04tD7WHMybTbrYI5IrnyBFtqPqGh3biCRtDeuTreDZXsna9tk5MM8bHTcbnhpFeFXVNU
 sClJoGDgf8Dg2jULTJKzL3H3HKxr9vfrxRg6YyIaBxkSXgpe+/huvxAIf44JVZPXZC+7HR6VPt
 Tf0+S7yUPAJopj8c+wbdqI19UesYoQEfFTswgWTvo4fNl1MI+URZQiBusO2EhsFm8ET69dSSXK
 00A6D8dgglg7GfA45AmQR/OnYQhShaMHW2dbDYhK3n/jihXaW0nFSaAKghzynI7jrq0S9JtEoo
 enE=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="153267058"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:43:20 +0800
IronPort-SDR: lPsAgmjEEX/sBbM6gJ4ThCQKCGwphh5CBKGobB7LSWSwSJswjOaVlkqIuTQZWeanpgc99VawWD
 kMiZmIcK2r4LeXJq3Z69PA3grh8KcE3uvDhsgmmS7bLUOgtntTK12PFNPNhXsRha/eEV6TA+Gi
 TbuZUWbsQyyRphiKXcyHbfsD571VdARODI7JpGJQhMHRH43akHvHT2jJEy/Mcn/B4T2A6KdokI
 YWqdu6XpGDNENIodF/0LWXXdX9i8x7IN+y2Q0S7IfTIarRZwzsPuW+2K+9KU6veDtUNBxT+Y9x
 Vs7H/9k+kNmKV8648wKmg8gt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2020 15:28:11 -0800
IronPort-SDR: jvqQwdkAZ804dQyqbFI+ZB9JkyifRd4C+4Ajm3NfSanxXjjw4LGo13/fDelabpFNG3cAnHz5Cx
 XPOIHzeZwee28OtYY0MNaeBopwOe6/3C7Pu/i59uw6G9uKwxutXprug2quaPwRaH61ONGlkLit
 TLCNUFT6yKVE8S7qf6vsb6smEaseBUhwM8cnq8b6PB/azIwyway5XEVcUmdpABR8z1RJpgOHvr
 HQYO00JtUXmLbCQDMoexEns8vUw/iZNK2FLFwqmgoiJWWKQzCqBcGxgxKYdZuoEu+mP9hovLHh
 Vvg=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2020 15:43:17 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v10 03/12] hw/block/nvme: Separate read and write handlers
Date: Sat,  7 Nov 2020 08:42:56 +0900
Message-Id: <20201106234305.21339-4-dmitry.fomichev@wdc.com>
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


