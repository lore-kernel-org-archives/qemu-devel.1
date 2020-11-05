Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50463C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97F52074B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HdBECzRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97F52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVTm-0004cl-OZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 21:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPV-0007gL-Ip; Wed, 04 Nov 2020 21:54:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPS-0002bI-Bl; Wed, 04 Nov 2020 21:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544838; x=1636080838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ppyMgq050tOprIgbi9IDz8nw1YexhJOX71OXLYK6SQ=;
 b=HdBECzRJVX/4bH22diAy2Jml7X8aKKUqjhHKVeMRT2wbtb7wkPoc9KYC
 joEv7ex27eTFL4d9v89JJ7z3/Wh1slboFrKY9cx737mCeLTZsscGB0bWh
 UBQc6HIXtD941RT2GxoGtTYY76GNxS5pQBBUU9Dv82dF8PonIWotU4Thb
 xjYreH6wRgaOhOwixLO0FOQm8JN2nPP6Nf4Hs5rpPyU2iL0TR/Y8ut+9y
 IpdQF6O1LODbamdcMANGFea7mgAV1zOFD6dqu/gzsV7EgoNSCCYn/Tr7A
 /OUiV6UlMXC562SE4Cqg/eXwxPKQSnMPVIzBD1h4/m7BzDKYeaeJXaA2A A==;
IronPort-SDR: MJP4ryfYfM29rzgaFS4L4GnA6FI0rh0bfJZji6tsgDxI7bWusQATwO7YG0HL63oaIcKLG1OG/b
 m2txkS+oZFrfN00gDqKuPrleyLGxIce4b1OwMWxkGVS76/UsdLXypPg9nC9n8kfbb6ya5MYDA/
 gUIM7D/e674+gLsU0QPHhWrj3Q9u90/ubs1Ww12raPuON6jGjsROFjJ307maXS04NyTz7DdlUT
 Rwo6Vy8VbSXdtGw98lw+h5vaQUHelg1Xkojt40jL9qecQWhaCnhZkMd0dFYILdy1eDmXhxqQNy
 pp4=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335135"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:53:57 +0800
IronPort-SDR: MkEjsJAJcW3oPD46xYw2jahZSXCnPamd3FKrZNriRelwazNbxCXkFLyHoi3jEaYnvSHdYeO5/7
 lHouUEo+sRC/JsgohSa7iLC8kciVcLMLuRUTkdlnQSiOwe9jnv2cNCELk24Yupe3RlCTB4ukp8
 aON0RscOdDYoT8Nph2AYM2oiHsJfM81kFWuHSl2tLDYmnKUKPAU2/7WYj4tWg0KdhixTMLwlXz
 UFR2pYPWmK+fBpn98b+01WNFX/HU2n/Of2S4Oj5pO7sNkZkFfBANhI+sXytmWjntMrzDy/5Sx/
 NeRAJbkOlBqvdvLr8rpXDIis
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:04 -0800
IronPort-SDR: Oe0lj0G8pXHRHo1gD175rLf0mejN3JQYubXraKXlwWYzRbncv7ZyDpKtC1U36LjyYjMT2l/O7s
 bp9SIRxpNgZI4JS5uwozl6O+hR7rj1MZk2XghFXbPBHgCbd0fahdtsUCYqAduoNchnqQpUdFhl
 h9BNppQHY1nzpsG03uDsGoTqIBYuKy1bEMhmuzNuba3IHeT6pVH0oQTBZzdfGB7G7GlY9FUdzE
 iqWwrR2Aiie3TwSabrLiradrhUGQzbV286CFrodbAD3B7VIiz4hQTiXSV/OyjuaSm+NSN8lc7w
 bww=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:53:55 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 05/12] hw/block/nvme: Add support for Namespace Types
Date: Thu,  5 Nov 2020 11:53:35 +0900
Message-Id: <20201105025342.9037-6-dmitry.fomichev@wdc.com>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Define the structures and constants required to implement
Namespace Types support.

Namespace Types introduce a new command set, "I/O Command Sets",
that allows the host to retrieve the command sets associated with
a namespace. Introduce support for the command set and enable
detection for the NVM Command Set.

The new workflows for identify commands rely heavily on zero-filled
identify structs. E.g., certain CNS commands are defined to return
a zero-filled identify struct when an inactive namespace NSID
is supplied.

Add a helper function in order to avoid code duplication when
reporting zero-filled identify structures.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme-ns.h    |   1 +
 include/block/nvme.h  |  66 +++++++++++----
 hw/block/nvme-ns.c    |   2 +
 hw/block/nvme.c       | 188 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   7 ++
 5 files changed, 219 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index a38071884a..d795e44bab 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,6 +31,7 @@ typedef struct NvmeNamespace {
     int64_t      size;
     NvmeIdNs     id_ns;
     const uint32_t *iocs;
+    uint8_t      csi;
 
     NvmeNamespaceParams params;
 } NvmeNamespace;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f62cc90d49..af23514713 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -84,6 +84,7 @@ enum NvmeCapMask {
 
 enum NvmeCapCss {
     NVME_CAP_CSS_NVM        = 1 << 0,
+    NVME_CAP_CSS_CSI_SUPP   = 1 << 6,
     NVME_CAP_CSS_ADMIN_ONLY = 1 << 7,
 };
 
@@ -117,9 +118,25 @@ enum NvmeCcMask {
 
 enum NvmeCcCss {
     NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_CSI        = 0x6,
     NVME_CC_CSS_ADMIN_ONLY = 0x7,
 };
 
+#define NVME_SET_CC_EN(cc, val)     \
+    (cc |= (uint32_t)((val) & CC_EN_MASK) << CC_EN_SHIFT)
+#define NVME_SET_CC_CSS(cc, val)    \
+    (cc |= (uint32_t)((val) & CC_CSS_MASK) << CC_CSS_SHIFT)
+#define NVME_SET_CC_MPS(cc, val)    \
+    (cc |= (uint32_t)((val) & CC_MPS_MASK) << CC_MPS_SHIFT)
+#define NVME_SET_CC_AMS(cc, val)    \
+    (cc |= (uint32_t)((val) & CC_AMS_MASK) << CC_AMS_SHIFT)
+#define NVME_SET_CC_SHN(cc, val)    \
+    (cc |= (uint32_t)((val) & CC_SHN_MASK) << CC_SHN_SHIFT)
+#define NVME_SET_CC_IOSQES(cc, val) \
+    (cc |= (uint32_t)((val) & CC_IOSQES_MASK) << CC_IOSQES_SHIFT)
+#define NVME_SET_CC_IOCQES(cc, val) \
+    (cc |= (uint32_t)((val) & CC_IOCQES_MASK) << CC_IOCQES_SHIFT)
+
 enum NvmeCstsShift {
     CSTS_RDY_SHIFT      = 0,
     CSTS_CFS_SHIFT      = 1,
@@ -534,8 +551,13 @@ typedef struct QEMU_PACKED NvmeIdentify {
     uint64_t    rsvd2[2];
     uint64_t    prp1;
     uint64_t    prp2;
-    uint32_t    cns;
-    uint32_t    rsvd11[5];
+    uint8_t     cns;
+    uint8_t     rsvd10;
+    uint16_t    ctrlid;
+    uint16_t    nvmsetid;
+    uint8_t     rsvd11;
+    uint8_t     csi;
+    uint32_t    rsvd12[4];
 } NvmeIdentify;
 
 typedef struct QEMU_PACKED NvmeRwCmd {
@@ -656,6 +678,7 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_INVALID_PRP_OFFSET     = 0x0013,
+    NVME_CMD_SET_CMB_REJECTED   = 0x002b,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -782,11 +805,15 @@ typedef struct QEMU_PACKED NvmePSD {
 
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
-enum {
-    NVME_ID_CNS_NS             = 0x0,
-    NVME_ID_CNS_CTRL           = 0x1,
-    NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
-    NVME_ID_CNS_NS_DESCR_LIST  = 0x3,
+enum NvmeIdCns {
+    NVME_ID_CNS_NS                = 0x00,
+    NVME_ID_CNS_CTRL              = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST    = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST     = 0x03,
+    NVME_ID_CNS_CS_NS             = 0x05,
+    NVME_ID_CNS_CS_CTRL           = 0x06,
+    NVME_ID_CNS_CS_NS_ACTIVE_LIST = 0x07,
+    NVME_ID_CNS_IO_COMMAND_SET    = 0x1c,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
@@ -934,6 +961,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
     NVME_FID_MAX                    = 0x100,
 };
@@ -1018,18 +1046,26 @@ typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t rsvd2[2];
 } NvmeIdNsDescr;
 
-enum {
-    NVME_NIDT_EUI64_LEN =  8,
-    NVME_NIDT_NGUID_LEN = 16,
-    NVME_NIDT_UUID_LEN  = 16,
+enum NvmeNsIdentifierLength {
+    NVME_NIDL_EUI64             = 8,
+    NVME_NIDL_NGUID             = 16,
+    NVME_NIDL_UUID              = 16,
+    NVME_NIDL_CSI               = 1,
 };
 
 enum NvmeNsIdentifierType {
-    NVME_NIDT_EUI64 = 0x1,
-    NVME_NIDT_NGUID = 0x2,
-    NVME_NIDT_UUID  = 0x3,
+    NVME_NIDT_EUI64             = 0x01,
+    NVME_NIDT_NGUID             = 0x02,
+    NVME_NIDT_UUID              = 0x03,
+    NVME_NIDT_CSI               = 0x04,
 };
 
+enum NvmeCsi {
+    NVME_CSI_NVM                = 0x00,
+};
+
+#define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
+
 /*Deallocate Logical Block Features*/
 #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
 #define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
@@ -1080,8 +1116,8 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
 }
 #endif
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index de735eb9f3..c0362426cc 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -41,6 +41,8 @@ static void nvme_ns_init(NvmeNamespace *ns)
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
+    ns->csi = NVME_CSI_NVM;
+
     /* no thin provisioning */
     id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 48adbe84f5..bb82dd9975 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1327,7 +1327,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog log = {};
@@ -1342,8 +1342,15 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
     switch (NVME_CC_CSS(n->bar.cc)) {
     case NVME_CC_CSS_NVM:
         src_iocs = nvme_cse_iocs_nvm;
+        /* fall through */
     case NVME_CC_CSS_ADMIN_ONLY:
         break;
+    case NVME_CC_CSS_CSI:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            src_iocs = nvme_cse_iocs_nvm;
+            break;
+        }
     }
 
     memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
@@ -1369,6 +1376,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     uint8_t  lid = dw10 & 0xff;
     uint8_t  lsp = (dw10 >> 8) & 0xf;
     uint8_t  rae = (dw10 >> 15) & 0x1;
+    uint8_t  csi = le32_to_cpu(cmd->cdw14) >> 24;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
@@ -1402,7 +1410,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
-        return nvme_cmd_effects(n, len, off, req);
+        return nvme_cmd_effects(n, csi, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1516,6 +1524,13 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint8_t id[NVME_IDENTIFY_DATA_SIZE] = {};
+
+    return nvme_dma(n, id, sizeof(id), DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_pci_nvme_identify_ctrl();
@@ -1524,11 +1539,23 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+
+    trace_pci_nvme_identify_ctrl_csi(c->csi);
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    NvmeIdNs *id_ns, inactive = { 0 };
     uint32_t nsid = le32_to_cpu(c->nsid);
 
     trace_pci_nvme_identify_ns(nsid);
@@ -1539,23 +1566,46 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 
     ns = nvme_ns(n, nsid);
     if (unlikely(!ns)) {
-        id_ns = &inactive;
-    } else {
-        id_ns = &ns->id_ns;
+        return nvme_rpt_empty_id_struct(n, req);
     }
 
-    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
+    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+
+    trace_pci_nvme_identify_ns_csi(nsid, c->csi);
+
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    if (c->csi == NVME_CSI_NVM) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    static const int data_len = NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
-    uint32_t *list;
-    uint16_t ret;
-    int j = 0;
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+    uint32_t *list_ptr = (uint32_t *)list;
+    int i, j = 0;
 
     trace_pci_nvme_identify_nslist(min_nsid);
 
@@ -1569,20 +1619,61 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    list = g_malloc0(data_len);
-    for (int i = 1; i <= n->num_namespaces; i++) {
-        if (i <= min_nsid || !nvme_ns(n, i)) {
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
             continue;
         }
-        list[j++] = cpu_to_le32(i);
+        if (ns->params.nsid <= min_nsid) {
+            continue;
+        }
+        list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
         }
     }
-    ret = nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DEVICE,
-                   req);
-    g_free(list);
-    return ret;
+
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
+}
+
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t min_nsid = le32_to_cpu(c->nsid);
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+    uint32_t *list_ptr = (uint32_t *)list;
+    int i, j = 0;
+
+    trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
+
+    /*
+     * Same as in nvme_identify_nslist(), 0xffffffff/0xfffffffe are invalid.
+     */
+    if (min_nsid >= NVME_NSID_BROADCAST - 1) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    if (c->csi != NVME_CSI_NVM) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+        if (ns->params.nsid <= min_nsid) {
+            continue;
+        }
+        list_ptr[j++] = cpu_to_le32(ns->params.nsid);
+        if (j == data_len / sizeof(uint32_t)) {
+            break;
+        }
+    }
+
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
@@ -1590,13 +1681,17 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
-    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
 
     struct data {
         struct {
             NvmeIdNsDescr hdr;
-            uint8_t v[16];
+            uint8_t v[NVME_NIDL_UUID];
         } uuid;
+        struct {
+            NvmeIdNsDescr hdr;
+            uint8_t v;
+        } csi;
     };
 
     struct data *ns_descrs = (struct data *)list;
@@ -1612,19 +1707,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    memset(list, 0x0, sizeof(list));
-
     /*
      * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
      * structure, a Namespace UUID (nidt = 0x3) must be reported in the
      * Namespace Identification Descriptor. Add the namespace UUID here.
      */
     ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
-    ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
-    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDT_UUID_LEN);
+    ns_descrs->uuid.hdr.nidl = NVME_NIDL_UUID;
+    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDL_UUID);
 
-    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
-                    DMA_DIRECTION_FROM_DEVICE, req);
+    ns_descrs->csi.hdr.nidt = NVME_NIDT_CSI;
+    ns_descrs->csi.hdr.nidl = NVME_NIDL_CSI;
+    ns_descrs->csi.v = ns->csi;
+
+    return nvme_dma(n, list, sizeof(list), DMA_DIRECTION_FROM_DEVICE, req);
+}
+
+static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE] = {};
+    static const int data_len = sizeof(list);
+
+    trace_pci_nvme_identify_cmd_set();
+
+    NVME_SET_CSI(*list, NVME_CSI_NVM);
+    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
@@ -1634,12 +1741,20 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
         return nvme_identify_ns(n, req);
+    case NVME_ID_CNS_CS_NS:
+        return nvme_identify_ns_csi(n, req);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
+    case NVME_ID_CNS_CS_CTRL:
+        return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
         return nvme_identify_nslist(n, req);
+    case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
+        return nvme_identify_nslist_csi(n, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
+    case NVME_ID_CNS_IO_COMMAND_SET:
+        return nvme_identify_cmd_set(n, req);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1820,7 +1935,9 @@ defaults:
         if (iv == n->admin_cq.vector) {
             result |= NVME_INTVC_NOCOALESCING;
         }
-
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = 0;
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1961,6 +2078,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, req);
+    case NVME_COMMAND_SET_PROFILE:
+        if (dw11 & 0x1ff) {
+            trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
+            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
+        }
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -2117,8 +2240,12 @@ static void nvme_select_ns_iocs(NvmeCtrl *n)
             continue;
         }
         ns->iocs = nvme_cse_iocs_none;
-        if (NVME_CC_CSS(n->bar.cc) != NVME_CC_CSS_ADMIN_ONLY) {
-            ns->iocs = nvme_cse_iocs_nvm;
+        switch (ns->csi) {
+        case NVME_CSI_NVM:
+            if (NVME_CC_CSS(n->bar.cc) != NVME_CC_CSS_ADMIN_ONLY) {
+                ns->iocs = nvme_cse_iocs_nvm;
+            }
+            break;
         }
     }
 }
@@ -2859,6 +2986,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
+    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_CSI_SUPP);
     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_ADMIN_ONLY);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index e67e96c2b5..8b29423132 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -48,8 +48,12 @@ pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
+pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns_csi(uint32_t ns, uint8_t csi) "nsid=%"PRIu32", csi=0x%"PRIx8""
 pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_nslist_csi(uint16_t ns, uint8_t csi) "nsid=%"PRIu16", csi=0x%"PRIx8""
+pci_nvme_identify_cmd_set(void) "identify i/o command set"
 pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 pci_nvme_getfeat(uint16_t cid, uint32_t nsid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" nsid 0x%"PRIx32" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
@@ -103,6 +107,8 @@ pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
 pci_nvme_err_invalid_log_page_offset(uint64_t ofs, uint64_t size) "must be <= %"PRIu64", got %"PRIu64""
+pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
@@ -159,6 +165,7 @@ pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for
 pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.21.0


