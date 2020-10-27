Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF63C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4422265
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4422265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMpu-0002u3-99
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXy-0008RN-Pt; Tue, 27 Oct 2020 06:49:46 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXw-00028D-Rz; Tue, 27 Oct 2020 06:49:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 170415C0174;
 Tue, 27 Oct 2020 06:49:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 1CgY6FpsRKbIZOE/l4/3zb/okTMnN6xKzBoAXOypNnU=; b=bMv5GMn3+3AnkGNf
 hmrXQc4TyBv9TD1iyNGjC1zF5vedMltcOAInrgrB6eDt5KkWF6sOKuVtxlmuS7Jc
 lqInzUBYOhp+aoPidimN1BZMj1y5IoLR+Cy8dfN7eTVJwj/4Hw8JvPQUb3fMAIZm
 xCef8qNgOfGZG2Wl53mTaVFHvYPlW3+WVWlk0PvY5pNDBbxK7rCgWXHBB0Y5IdsC
 u8u6J9LY9p1N7BtfXo00XoQZiAb1BzZ2M+8J91H9ShlewaaLt+6U1AbTpXqo/8t/
 VkCI414YENSHJ5Ot+O83q9fQ8qXmyDB06cnbdBX4B7ThlZP8e7BikK4r/k3jGUXk
 EkJ+5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=1CgY6FpsRKbIZOE/l4/3zb/okTMnN6xKzBoAXOypN
 nU=; b=dJMLk0/6q0+6s2trR38OEnOI12hpuHXYI7vuh2ONvoCkcAMgzqJtG21ba
 ltZpNAniYHCNvUipBBNK+IQIQ3GDXksLQ8IfImVkK0NtSfvAN9m30z/4lYj+awmX
 BXd0lc5LaDJAKmW6JtI/TC+6BOHmAlGmJVs+m8y5dKom1a6vXLIvREU//ngPZMhS
 XXEgwVQPsKGo8bPAkjC0ZGrDgiMkORhgugdpJmKWf1QA4hojE1ZCUzEljH93HV1k
 jxbZdddd216pmZzXrFY44phFZX3j+FA8iCCE78AkaZFVKjvIvXFHgNMtE1X0D/OS
 iInvJj1uie5IpBT4Gy0qyUZfmP6Ww==
X-ME-Sender: <xms:R_uXXzG2sXsesGSQdpX8c8enti9rqCTdtJHGUJWQpXS4Voxppj51eQ>
 <xme:R_uXXwW1fA9GZqkEBFanwhQlcc3KrzjKof4kWDsbAOtUQk9xyERCIy_EbZEoIDm-7
 E7qeqA0mdJW80NjPak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:R_uXX1Lpt9D73GQZkQf_PF7WLfELirfC52OBTLF-q8bUC4WOr5ZzCQ>
 <xmx:R_uXXxFwaZLXA36ffO-aXzRgpY4S8BGWhwtzQoNpIjxR7Ma8KaqmVA>
 <xmx:R_uXX5XBg1tJC0kwm3O5vLxk6bB30r29MsrGBp2JVEtC1fT9LncvSQ>
 <xmx:SPuXX_y3uDL1k0fQLIXXMuawg942moDCrCD7_QNbz9y6IWlHfpuPYg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E11F8328005E;
 Tue, 27 Oct 2020 06:49:42 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/30] hw/block/nvme: add symbolic command name to trace events
Date: Tue, 27 Oct 2020 11:49:10 +0100
Message-Id: <20201027104932.558087-9-its@irrelevant.dk>
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
index 158843c14a29..961e6ffc5b67 100644
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
@@ -1579,7 +1580,8 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 
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
2.29.1


