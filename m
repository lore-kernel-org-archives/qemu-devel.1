Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C8C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D262076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V91rBy5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D262076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKIj-00043M-C7
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDp-0005f2-91; Thu, 29 Oct 2020 22:32:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDk-0006cy-Ln; Thu, 29 Oct 2020 22:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025172; x=1635561172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sJfeCQHJ4b6kZ7bQQ3zkoS9KoX1KA99USQyP+uPAQOw=;
 b=V91rBy5zW0TfdFobMzfBgfvtJlF7Qcn9/0oXhq4WAaZaad8xlCUhhxTF
 SEMBMyo0/L2rrVzqcfeJBy3w8+fCD/34wr1cN61H45CjxW3y98B3X3JH3
 hQUnrPvX4A85f9DnRM99/KU3QMAeFa+JrnID4nf+Y+OqEzqIBftYpYZCI
 xMQyqzCsFnSN+73OcQUGDsaU46ZuED18TfzjYFZfUwmxuLyYdQOvgM+g1
 FDMd3q7c7WweNxBLWJTdJKHU8+ZMCY1YYG1yVQ7P6QpaEEGPPvYyo4u5M
 Yw1owleiIlitq7jqT/CUJ5q2zXMYOQVKRBKyV5VSSgu/Wdi/4/9YTfYXA A==;
IronPort-SDR: fhKMsVZX5edwhJokBs7u+21t4dWjzv6EpOR0uHC1vixWs+ddZ1TAAdUfsuyIgaEbWejl2umBle
 IW8qt/qCyMjxWN8UETP7UtYLcupDgxB2BnDujZdzm7ey8diXQoxgTYzHBIgpazArohzhH1uLNT
 YJrUaXsGDcQOFquKLNmCHygNTqHEoQQoniu9/6h3yBj2QtovbBKhxBW4dlzXxdNYpm61VvrZSx
 uROqw9DIWAWY9akmbFIxHpp3uhbcB3zB/t7v72N0eZVyrkWDFON5IEu4N+/SEuxQC1P3ep07oA
 Czc=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748051"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:32:50 +0800
IronPort-SDR: nTD7ZzpNzf6EajYeXFt/asRvgZXlYOWjXzmKWpWXVpMttrBasMnCjAlIqmFekYUGFIPhkIuTgV
 4EeXkjw8+1Cmn9S/Ix7tjvFHSYNNHTfr8aKQ5ZdZYOJaXfC1B+Ul5oDxA/J376wQmxv+KW/5Zl
 LoQLb36DzRbwrGSOJ4bfRIUwArNQDeVR0sTAl8J8Pqo35iBFNbqau1znyG8PmmkvJ6pkOi5Bdw
 9Kg4DMMbV6aKH043olduDmvvhvSJHc3nVIH3DchNwzwKFgj7Bdn6G6S72rFCKSAWcyPpoe3rpr
 tz8ARZcCsQ54Ar5+h/rWJQ+9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:17:55 -0700
IronPort-SDR: zLveBajxHZpUiOO261ZfWfJlClHLWKyJrbRgm/HfcflCfHSRn6/y4Oqgv4TvA0KDDGnHDhmdsL
 yQGOV9tIkPRlev++LaYQBkMUbHrTd6sqdFvLXqKqwj6a8NF4yxQXMlk10ue6Z1m1tWGG1Np2l/
 jh76CSXDSH6q00E9ORhoFppxb81ZOzaLN6UcRQmtmgAlfrjv+FoIvmvCMX48iKGEtHIVkAAihx
 0ppsWfzJ7gMEUpxd8L7jSccPEkgc62l7AIHI+viQMZdCZJhY1ozvNk999H2UrKZSWrIWZohflm
 6MA=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:32:49 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 01/11] hw/block/nvme: Add Commands Supported and Effects log
Date: Fri, 30 Oct 2020 11:32:32 +0900
Message-Id: <20201030023242.5204-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
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

This log page becomes necessary to implement to allow checking for
Zone Append command support in Zoned Namespace Command Set.

This commit adds the code to report this log page for NVM Command
Set only. The parts that are specific to zoned operation will be
added later in the series.

All incoming admin and i/o commands are now only processed if their
corresponding support bits are set in this log. This provides an
easy way to control what commands to support and what not to
depending on set CC.CSS.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme-ns.h    |  1 +
 hw/block/nvme.c       | 96 +++++++++++++++++++++++++++++++++++++++----
 hw/block/trace-events |  1 +
 include/block/nvme.h  | 19 +++++++++
 4 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 83734f4606..ea8c2f785d 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -29,6 +29,7 @@ typedef struct NvmeNamespace {
     int32_t      bootindex;
     int64_t      size;
     NvmeIdNs     id_ns;
+    const uint32_t *iocs;
 
     NvmeNamespaceParams params;
 } NvmeNamespace;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9d30ca69dc..9fed061a9d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -111,6 +111,28 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
 };
 
+static const uint32_t nvme_cse_acs[256] = {
+    [NVME_ADM_CMD_DELETE_SQ]        = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_CREATE_SQ]        = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_GET_LOG_PAGE]     = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_DELETE_CQ]        = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_CREATE_CQ]        = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_IDENTIFY]         = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_ABORT]            = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
+};
+
+static const uint32_t nvme_cse_iocs_none[256];
+
+static const uint32_t nvme_cse_iocs_nvm[256] = {
+    [NVME_CMD_FLUSH]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE_ZEROES]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_WRITE]                = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_READ]                 = NVME_CMD_EFF_CSUPP,
+};
+
 static void nvme_process_sq(void *opaque);
 
 static uint16_t nvme_cid(NvmeRequest *req)
@@ -1032,10 +1054,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
-    if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
-        return NVME_INVALID_OPCODE | NVME_DNR;
-    }
-
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
@@ -1045,6 +1063,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (!(req->ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
@@ -1054,8 +1077,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, req);
     default:
-        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
+        assert(false);
     }
 }
 
@@ -1291,6 +1313,37 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+                                 uint64_t off, NvmeRequest *req)
+{
+    NvmeEffectsLog log = {};
+    const uint32_t *src_iocs = NULL;
+    uint32_t trans_len;
+
+    if (off >= sizeof(log)) {
+        trace_pci_nvme_err_invalid_log_page_offset(off, sizeof(log));
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    switch (NVME_CC_CSS(n->bar.cc)) {
+    case NVME_CC_CSS_NVM:
+        src_iocs = nvme_cse_iocs_nvm;
+    case NVME_CC_CSS_ADMIN_ONLY:
+        break;
+    }
+
+    memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
+
+    if (src_iocs) {
+        memcpy(log.iocs, src_iocs, sizeof(log.iocs));
+    }
+
+    trans_len = MIN(sizeof(log) - off, buf_len);
+
+    return nvme_dma(n, ((uint8_t *)&log) + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -1334,6 +1387,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_CMD_EFFECTS:
+        return nvme_cmd_effects(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1920,6 +1975,11 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode,
                              nvme_adm_opc_str(req->cmd.opcode));
 
+    if (!(nvme_cse_acs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
+        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     switch (req->cmd.opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
         return nvme_del_sq(n, req);
@@ -1942,8 +2002,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, req);
     default:
-        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
+        assert(false);
     }
 }
 
@@ -2031,6 +2090,23 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
     n->bar.cc = 0;
 }
 
+static void nvme_select_ns_iocs(NvmeCtrl *n)
+{
+    NvmeNamespace *ns;
+    int i;
+
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+        ns->iocs = nvme_cse_iocs_none;
+        if (NVME_CC_CSS(n->bar.cc) != NVME_CC_CSS_ADMIN_ONLY) {
+            ns->iocs = nvme_cse_iocs_nvm;
+        }
+    }
+}
+
 static int nvme_start_ctrl(NvmeCtrl *n)
 {
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
@@ -2129,6 +2205,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 
     QTAILQ_INIT(&n->aer_queue);
 
+    nvme_select_ns_iocs(n);
+
     return 0;
 }
 
@@ -2737,7 +2815,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_CSE | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index fac5995d94..3ea6c29926 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -104,6 +104,7 @@ pci_nvme_err_invalid_prp(void) "invalid PRP"
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_invalid_log_page_offset(uint64_t ofs, uint64_t size) "must be <= %"PRIu64", got %"PRIu64""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 6de2d5aa75..4779495b7d 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -744,10 +744,27 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
 };
 
+typedef struct NvmeEffectsLog {
+    uint32_t    acs[256];
+    uint32_t    iocs[256];
+    uint8_t     resv[2048];
+} NvmeEffectsLog;
+
+enum {
+    NVME_CMD_EFF_CSUPP      = 1 << 0,
+    NVME_CMD_EFF_LBCC       = 1 << 1,
+    NVME_CMD_EFF_NCC        = 1 << 2,
+    NVME_CMD_EFF_NIC        = 1 << 3,
+    NVME_CMD_EFF_CCC        = 1 << 4,
+    NVME_CMD_EFF_CSE_MASK   = 3 << 16,
+    NVME_CMD_EFF_UUID_SEL   = 1 << 19,
+};
+
 enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_CMD_EFFECTS    = 0x05,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -860,6 +877,7 @@ enum NvmeIdCtrlFrmw {
 
 enum NvmeIdCtrlLpa {
     NVME_LPA_NS_SMART = 1 << 0,
+    NVME_LPA_CSE      = 1 << 1,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
@@ -1059,6 +1077,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.21.0


