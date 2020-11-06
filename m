Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5AFC4741F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD3A20704
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l7KDs29A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3A20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbBRa-00025H-U1
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBO6-0005HG-6e; Fri, 06 Nov 2020 18:43:22 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=dmitry.fomichev@wdc.com>)
 id 1kbBO0-0003Sw-Na; Fri, 06 Nov 2020 18:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604706197; x=1636242197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QT37Zg41FIq+qHt+V884jfsn9aB/8VuGenGA9udWlZc=;
 b=l7KDs29AeTNNXts8csgrD6uDlz/JrhYcnoWeBKc5f23gLcsHxKqrXD6o
 gN/tG+ZiS8U1MZKtn+ySoOYXP/pLTPpv3G2JT/sb+UGx7eiZiKH3aRT+a
 Yf1XqgdbpjN/XEV09YwjUAIYl0d7ejNdPrLd+CQvuBKq0chLVwhj68ur+
 uod7/ZL6O8P2eYwxocHkzvHtRrtl00lL4zKQpxxq/yW1vWG+JApOofL/5
 vlTcuEcykCDrn/Ze2VRXQnt18zbytTAMH9cveV1jjZykePvLTuBTK7dc6
 3bbKwoGrbyJvlmfLd8lneJ457nTBbXfG8jEhTWIyBn3+4urK+jnkqLgzj A==;
IronPort-SDR: 81+kl1r7m6LDIR3axyDMjVeIizd0jZrbbvGCKuGpcRzh83DA6c2PaXRU+i9zthHaPcGAOnq6Hd
 IPNGN5Dl3btr4bsdNciRRKt1sP+6GjsRSPLJfer9D0e7yunXVsteLJcCi/aGf1FP/Kcw/4SkJG
 Ii78bbYURxFWP/apuuVX7npTRuh4+TYNkmbfYgPtacZ4dg85/YaIGVRWjq4I7l6vs57emTEsXu
 gGX+9eaxdY6UPJ7Mh4XOVJ2NRXTyaoKyL8w1EiXbPXcfW+a4+1yUnFP6HylEXzzop573EI422K
 TTI=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="153267054"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:43:15 +0800
IronPort-SDR: n0vIwh34sROd3Hncr+haq3jvc/K/iqogn2oLdu4s6mtPNNT8ZnhPzqyNlKdylrLVtTHSQhEhtb
 rJF8xwy1vDxxcTkmjcToXf3XcMLu+rrevou6Xt/BlnznEHu8F7TiiYfiZlFTQ4tKS5EQ9uZvHq
 M92UFlwexroA85kiK081ZElkKcjAxpB/nhuRPQPhriGPflzETdAIhfnMzl/Fq0YDtlXVFmDPkK
 QLQB7iI+EOrvWpw+jEUPs3qR6ptOXqc5dsEQtNPwcySYV7h0xTSUrnXgrd1vZBviKXemSG8tIB
 LrhhQ7EPrSC3xxTAFIsvFdRx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2020 15:28:06 -0800
IronPort-SDR: G07voAA+T9YumCnFk5rA/byfV//uGuP0ilQOqUpgloPFg1bwjSpPocLHg/LcuJFDn/gWqcPKn2
 +bG2rOwMS3XoY/cApAC+/xXFqP2vFxzFTGGr4a6gLx66et+V4mW8KIAVVFy5yNg4n+LX3pP9GR
 I8GGJu87ck0rq7+ylFpEGbzzxZhsAHbdpY3U52bKQ2Fmh3crcBA7K6DXtWPjcuwxhVBXDfyu9L
 cVGdsgrwMOCJY0Oi0nyo0Gy/siyCe8xDYh00Cp/bmTVNg3/9Vwv+ZdaTRBx/fhEAFJ7bBWKskY
 Zns=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Nov 2020 15:43:12 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v10 01/12] hw/block/nvme: Add Commands Supported and Effects
 log
Date: Sat,  7 Nov 2020 08:42:54 +0900
Message-Id: <20201106234305.21339-2-dmitry.fomichev@wdc.com>
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
 include/block/nvme.h  | 19 +++++++++
 hw/block/nvme.c       | 96 +++++++++++++++++++++++++++++++++++++++----
 hw/block/trace-events |  1 +
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
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8a46d9cf01..f62cc90d49 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -745,10 +745,27 @@ enum NvmeSmartWarn {
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
@@ -861,6 +878,7 @@ enum NvmeIdCtrlFrmw {
 
 enum NvmeIdCtrlLpa {
     NVME_LPA_NS_SMART = 1 << 0,
+    NVME_LPA_CSE      = 1 << 1,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
@@ -1060,6 +1078,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 065e763e4f..702f7cc2e3 100644
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
@@ -1022,10 +1044,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
-    if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
-        return NVME_INVALID_OPCODE | NVME_DNR;
-    }
-
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
@@ -1035,6 +1053,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1044,8 +1067,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, req);
     default:
-        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
+        assert(false);
     }
 }
 
@@ -1282,6 +1304,37 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
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
@@ -1325,6 +1378,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_CMD_EFFECTS:
+        return nvme_cmd_effects(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1912,6 +1967,11 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1934,8 +1994,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, req);
     default:
-        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
-        return NVME_INVALID_OPCODE | NVME_DNR;
+        assert(false);
     }
 }
 
@@ -2023,6 +2082,23 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
@@ -2121,6 +2197,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 
     QTAILQ_INIT(&n->aer_queue);
 
+    nvme_select_ns_iocs(n);
+
     return 0;
 }
 
@@ -2728,7 +2806,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_CSE | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 72abbbc2b4..33832a2021 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -102,6 +102,7 @@ pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PR
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_invalid_log_page_offset(uint64_t ofs, uint64_t size) "must be <= %"PRIu64", got %"PRIu64""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
-- 
2.21.0


