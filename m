Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B38C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806122085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806122085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe00-00006x-D4
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvw-0005qB-Qt; Tue, 22 Sep 2020 04:45:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvp-0000u0-TR; Tue, 22 Sep 2020 04:45:56 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id CAEF35803CD;
 Tue, 22 Sep 2020 04:45:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 Ojy83Nfc2GnYW6RcGNKZq2aKjh/wCl/T5NTokRsgWx8=; b=n/HS6x1QspMBCVK7
 Rk55RT0OZrKajajLHyKiWP/9lIn+fussrSdirFYtE6SHWY1m2EsaEdwXfdONSDA9
 llFHp6Yo8Z2KdX37XEXr5Uwh5vI1nrr/1Zao5fMcY52nHG51agkK5PldJERywyNy
 1zUSOO96BpgCNzuiVL7B3wuYEi/gzE/+0H3AzXvn7NQMbGLoCgQuKeV6CSnpQt+Y
 7JWd/9cFhnfuG4VblTMFnSBtYhlZvlvYDjjcUf5SWge1fsE2w8NkfGt6NAzkPGBb
 TPf8houNBBaxLoUCIOGr+AeTpoCY82ri+gfjjx3TBgPaQVEAxd302d7nQlcrwyUa
 M4/REg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=Ojy83Nfc2GnYW6RcGNKZq2aKjh/wCl/T5NTokRsgW
 x8=; b=VxdSCLi7ZOeAuBah2xV8NjoIr/716LqPpzpvys7janY9X+42nQusucXLe
 JCoOj2DiAY9Z3el1LFpzo7xO1DeD5+8C7dXV4HZcvfxe8tFcWbCpO2ORXNuOLE/4
 h+Sv3hdlkN2J8uBfZMz1avnx9tWATT6nr3UZGSOhFFkP7vtIw3s+GkQ99eSwHx/O
 N5zHAgICJzEGTmOXrR0kMMIfe52HAlx8KbkLEXklxMwZQ7cFPLXcZuaCXUVhwV19
 atw/YBAkdbeOTgVVJCqpiNKkSoHLK4Zxybr6TxDWVfh+c4rTtK8jjbe7stwBDiUp
 3D7b6ziVRaAHtZaYDYO9s9V1bgKmQ==
X-ME-Sender: <xms:vLlpX9g4mTJNs8FUM90Is-x4It8bIUN1cdssY68fiRBXCUPQZhrxbA>
 <xme:vLlpXyBgZTOQRXEo_UbeSlIkbIVCz2MW0T3N-XgUYaNzu2_GZtCx7-WHXHPWjEmRE
 1xZ7p-Kz71_dbc5ADY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:vLlpX9EFZ0sO6oJrUmyiURdF-mqQ26RO7Nz63VpQCNbHHQJwaXXB5w>
 <xmx:vLlpXySspokKsyqGWRWqA1INwdJDfIe_-W6vYWvbueJhjS6OsC8Ygw>
 <xmx:vLlpX6xnE4B-CWygPxU46zL2VRhfaaGkGjGD1eJu4XtZXcdp7_hGeQ>
 <xmx:vLlpX5kEly15CLLzcmCbpxoANoEfB2a0STMlmDdXycwmzHrDV7Q-WvV257s>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id A561B306467E;
 Tue, 22 Sep 2020 04:45:46 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/17] hw/block/nvme: add symbolic command name to trace
 events
Date: Tue, 22 Sep 2020 10:45:24 +0200
Message-Id: <20200922084533.1273962-9-its@irrelevant.dk>
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

Add the symbolic command name to the pci_nvme_{io,admin}_cmd and
pci_nvme_rw trace events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.h       | 28 ++++++++++++++++++++++++++++
 hw/block/nvme.c       |  8 +++++---
 hw/block/trace-events |  6 +++---
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1675c1e0755c..ce9e931420d7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -32,6 +32,34 @@ typedef struct NvmeRequest {
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
+static inline const char *nvme_adm_opc_str(uint8_t opc)
+{
+    switch (opc) {
+    case NVME_ADM_CMD_DELETE_SQ:        return "NVME_ADM_CMD_DELETE_SQ";
+    case NVME_ADM_CMD_CREATE_SQ:        return "NVME_ADM_CMD_CREATE_SQ";
+    case NVME_ADM_CMD_GET_LOG_PAGE:     return "NVME_ADM_CMD_GET_LOG_PAGE";
+    case NVME_ADM_CMD_DELETE_CQ:        return "NVME_ADM_CMD_DELETE_CQ";
+    case NVME_ADM_CMD_CREATE_CQ:        return "NVME_ADM_CMD_CREATE_CQ";
+    case NVME_ADM_CMD_IDENTIFY:         return "NVME_ADM_CMD_IDENTIFY";
+    case NVME_ADM_CMD_ABORT:            return "NVME_ADM_CMD_ABORT";
+    case NVME_ADM_CMD_SET_FEATURES:     return "NVME_ADM_CMD_SET_FEATURES";
+    case NVME_ADM_CMD_GET_FEATURES:     return "NVME_ADM_CMD_GET_FEATURES";
+    case NVME_ADM_CMD_ASYNC_EV_REQ:     return "NVME_ADM_CMD_ASYNC_EV_REQ";
+    default:                            return "NVME_ADM_CMD_UNKNOWN";
+    }
+}
+
+static inline const char *nvme_io_opc_str(uint8_t opc)
+{
+    switch (opc) {
+    case NVME_CMD_FLUSH:            return "NVME_NVM_CMD_FLUSH";
+    case NVME_CMD_WRITE:            return "NVME_NVM_CMD_WRITE";
+    case NVME_CMD_READ:             return "NVME_NVM_CMD_READ";
+    case NVME_CMD_WRITE_ZEROES:     return "NVME_NVM_CMD_WRITE_ZEROES";
+    default:                        return "NVME_NVM_CMD_UNKNOWN";
+    }
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 638e3b1ccac8..bae43276bd6f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -678,7 +678,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
 
-    trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode), nlb,
+                      data_size, slba);
 
     status = nvme_check_mdts(n, data_size);
     if (status) {
@@ -727,7 +728,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
 
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
-                          req->cmd.opcode);
+                          req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
     if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
         trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
@@ -1584,7 +1585,8 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode);
+    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode,
+                             nvme_adm_opc_str(req->cmd.opcode));
 
     switch (req->cmd.opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 5589db4a014f..024786f4833c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -36,9 +36,9 @@ pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
-pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
-pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
-pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
+pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
+pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" '%s' nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
 pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
-- 
2.28.0


