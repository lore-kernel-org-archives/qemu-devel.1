Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC3C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A642620773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A642620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNPBC-00033Z-8T
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuB-0000Xj-NW; Tue, 29 Sep 2020 19:19:31 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:59917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu9-00008U-CO; Tue, 29 Sep 2020 19:19:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 7C4D7EB6;
 Tue, 29 Sep 2020 19:19:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=lLWIYy5Nac5ZM
 W2eRDZjjpMxYppJ2wzvImlA/zmiNkQ=; b=MBDGTxImkfb3yoTLuxaqu5xgDMJi3
 zIqgKvxnBr1ys+bpZ1umONJKP8M1ewvv8JwG7pLChAG2kQCZsKVg6Ge8thSURqC/
 v8Ne6Kzn6UZgHkJSP0oqeZA16mKOIxRECm/Olnk0PnalI2320K5NIpjprqp/evKS
 h4tTZEinHHiQCPseEJBToSZDT8RjKS8el31E9Tv+CC6V7SvKd0C0/CQ6tnykow9G
 b3x3Nr9AFGkFajtMX2otv2zhhN6TT8gkQmvyFRdsvWqUfAsEDaTxsBVNSkS4JZpU
 kDZiBe3IZ/68dcjWPuuJi9Ew/eSsm+x9oo1YWwQKI5KPwdK2QRP0A2UMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=lLWIYy5Nac5ZMW2eRDZjjpMxYppJ2wzvImlA/zmiNkQ=; b=XT3vWRsO
 gNOz1KJ1s4T0FH48KKMBzUr/q2rR99lrP5BYnhaqffuOktqj1JF+7bfK2lIH0GoA
 g0Y9/akfITmZwDymr8BUUfB+D36/VNzzOA532vOtxADeQvyRSU+3e7712DwE1jgO
 igSw1Vo01UBLOFjiPqAcaRdXX1U+56To7SS/NwQnbDstyZtnahxmQlKstOiNaYof
 ADpMAsqtc25eawXRSe4RQPn7Ee9jgLQkI49vJ1T539raePODYRelvtkKHpknCLuZ
 F8Bkifu7WfG0r8MvCA/Aj85oFBhoN/z+Wnkti6E+Mrqmbp4qrAsCbGe1gzaVHjg/
 ob0qhcYxCpDtRQ==
X-ME-Sender: <xms:_sBzX0zGdAKzGqMK71b65tu9FAlKFJFxoeYLpAbhsNRbMy2SajaAyQ>
 <xme:_sBzX4TS5vOOuu8nI3gHYNFX06xqv-7caEUgsc3RcP_eOUroR24JvPf5ITb36NB1W
 EiczUXOGtAjb3TD8AM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepvdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:_sBzX2WSersJCDcLZli6Inc-fITh2SOk77uW2qxhUoFl9ujIjRYw6Q>
 <xmx:_sBzXyh_tsKxyhCCwgIZIeOuorl5cTuVJw5ilSZ2LLKw7X8kzHbgoQ>
 <xmx:_sBzX2DYFQNoGeK4a4qpeyLjxOVngn-3uxaQJXhOs_LDAuT8pc8LqA>
 <xmx:_sBzX95HlhYyfdGQX-zGWpWUulMJq6tf1T0JXD5gE7ouCdPfjJ3BnlNQjF0>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id AF0823280064;
 Tue, 29 Sep 2020 19:19:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/14] hw/block/nvme: consolidate read,
 write and write zeroes
Date: Wed, 30 Sep 2020 01:19:08 +0200
Message-Id: <20200929231917.433586-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Consolidate the read/write and write zeroes functions.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h       | 11 ++++++++
 include/block/nvme.h  |  2 ++
 hw/block/nvme.c       | 65 +++++++++++++++----------------------------
 hw/block/trace-events |  3 +-
 4 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e080a2318a50..ccf52ac7bb82 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -36,6 +36,17 @@ typedef struct NvmeRequest {
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
+static inline bool nvme_req_is_write(NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+    case NVME_CMD_WRITE_ZEROES:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static inline const char *nvme_adm_opc_str(uint8_t opc)
 {
     switch (opc) {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 7a30cf285ae0..999b4f8ae0d4 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -438,6 +438,8 @@ typedef struct QEMU_PACKED NvmeCmd {
     uint32_t    cdw15;
 } NvmeCmd;
 
+#define NVME_CMD_OPCODE_DATA_TRANSFER_MASK 0x3
+
 #define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
 #define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 27af2f0b38d5..795c7e7c529f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -997,48 +997,19 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
     return nvme_do_aio(ns->blkconf.blk, 0, 0, req);
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset = nvme_l2b(ns, slba);
-    uint32_t count = nvme_l2b(ns, nlb);
+    size_t len = nvme_l2b(ns, nlb);
+
     uint16_t status;
 
-    trace_pci_nvme_write_zeroes(nvme_cid(req), nvme_nsid(ns), slba, nlb);
-
-    status = nvme_check_bounds(n, ns, slba, nlb);
-    if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return status;
-    }
-
-    return nvme_do_aio(ns->blkconf.blk, offset, count, req);
-}
-
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
-{
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-    NvmeNamespace *ns = req->ns;
-    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
-    uint64_t slba = le64_to_cpu(rw->slba);
-
-    uint64_t data_size = nvme_l2b(ns, nlb);
-    uint64_t data_offset = nvme_l2b(ns, slba);
-    enum BlockAcctType acct = req->cmd.opcode == NVME_CMD_WRITE ?
-        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
-    uint16_t status;
-
-    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode),
-                      nvme_nsid(ns), nlb, data_size, slba);
-
-    status = nvme_check_mdts(n, data_size);
-    if (status) {
-        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        goto invalid;
-    }
+    trace_pci_nvme_rwz(nvme_cid(req), nvme_io_opc_str(rw->opcode),
+                       nvme_nsid(ns), nlb, len, slba);
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
@@ -1046,15 +1017,26 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    status = nvme_map_dptr(n, data_size, req);
-    if (status) {
-        goto invalid;
+    if (req->cmd.opcode & NVME_CMD_OPCODE_DATA_TRANSFER_MASK) {
+        status = nvme_check_mdts(n, len);
+        if (status) {
+            trace_pci_nvme_err_mdts(nvme_cid(req), len);
+            goto invalid;
+        }
+
+        status = nvme_map_dptr(n, len, req);
+        if (status) {
+            goto invalid;
+        }
     }
 
-    return nvme_do_aio(ns->blkconf.blk, data_offset, data_size, req);
+    return nvme_do_aio(ns->blkconf.blk, nvme_l2b(ns, slba), len, req);
 
 invalid:
-    block_acct_invalid(blk_get_stats(ns->blkconf.blk), acct);
+    block_acct_invalid(blk_get_stats(ns->blkconf.blk),
+                       nvme_req_is_write(req) ? BLOCK_ACCT_WRITE :
+                       BLOCK_ACCT_READ);
+
     return status;
 }
 
@@ -1082,10 +1064,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, req);
+        return nvme_rwz(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 9e7507c5abde..b18056c49836 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -40,9 +40,8 @@ pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2,
 pci_nvme_map_sgl(uint16_t cid, uint8_t typ, uint64_t len) "cid %"PRIu16" type 0x%"PRIx8" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
-pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
+pci_nvme_rwz(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t len, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" len %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
-pci_nvme_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
-- 
2.28.0


