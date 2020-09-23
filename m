Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C388C206B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YA0tYJpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C388C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9dg-0003Qs-PM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9O1-0004xk-9j; Wed, 23 Sep 2020 14:21:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9Ny-00087W-Gh; Wed, 23 Sep 2020 14:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600886184; x=1632422184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xdpXusWybkFA9Rs2pAr0H5eIRfH4rvQ8cawqr2z0APg=;
 b=YA0tYJpgoqDQP/9yg3N+VLCstVAeDTyJMxN26S0LGZZuCfDZAwmQxD8v
 P4TWHHXHjTN/zHj+DCM8zM7qeuzN3kOVS6WAhh74AbFOQABoSRpS2Szd9
 WfugraCDBL1QqTQe40KXdPLGHI8C7kTOgxFHsXmjvYRW5EN3Pp88EaAZ0
 5S1JtCiSD3DKEJFUJ1Q05VCH0Fhz2ojs+DtoTYKCnlMO3bPDNM5weX4pT
 JsvPVVKTnvndTZRYGjfc7BQdUGQ+1l9bGi+sPUAQYYKCS5E1r1mUDzP8L
 4jq5RiRZs+ZNsd+pywXNq2fmMCrUhSI2vcMcwaNBQQBKEw2YP86qhbO3p A==;
IronPort-SDR: Tb5UpFutWoOLVk58sMUaY4fWVHvq9ZLdmamcDOjcTryWuECtPbB2+yjPauRC+8SxqJXcWaGoNI
 Pn2suUtWZgGhyadgF3JPjm9zP1EB0tqdVhedD+0HVoKQgcjR/HNIG+1L5A7qsNGM9e8dsImJrN
 l+aFhTsJ9bzkDnDNkJrAEMKSTyyIF0SSomhv7n9c7/7jeuhG2cjBURVs/cgsbVPb7eN5xpR0GC
 XE/32gpA4peZaiatcKHq1jqmpnRf+kW0ab6QLzOTcqp1IBxNaX8WpwJCusJ/cA2ZPyED6MbFba
 hmw=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="251496343"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 02:36:18 +0800
IronPort-SDR: A53e7vhDOdMU0ZB8ACiu9S71PJr/EdtdvJQtUcuYoVU3xul4OHsqBeaxQ4gfkkk2RkkTYopIzc
 21Q9NwRksUsg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 11:07:01 -0700
IronPort-SDR: q6ZWsI8gXxGsKy7C783rzTgwK84Yf0iJu2I43vgl0RVHKxJm01VpkTgiH32g/bfDLcWEMEKTuB
 oDopo5bDRXyw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 11:20:52 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v4 03/14] hw/block/nvme: Introduce the Namespace Types
 definitions
Date: Thu, 24 Sep 2020 03:20:10 +0900
Message-Id: <20200923182021.3724-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5287de305=dmitry.fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:20:48
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

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c      |  2 +-
 hw/block/nvme.h      |  3 ++
 include/block/nvme.h | 74 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7807f296d3..96cd520feb 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1259,7 +1259,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
      * here.
      */
     ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
-    ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
+    ns_descrs->uuid.hdr.nidl = NVME_NIDL_UUID;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
     return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 52ba794f2e..c1deac9667 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -64,6 +64,9 @@ typedef struct NvmeCQueue {
 
 typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
+    uint32_t        nsid;
+    uint8_t         csi;
+    QemuUUID        uuid;
 } NvmeNamespace;
 
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 71126ae1ff..74cc11782e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -51,6 +51,11 @@ enum NvmeCapMask {
     CAP_PMR_MASK       = 0x1,
 };
 
+enum NvmeCapCssBits {
+    CAP_CSS_NVM        = 0x01,
+    CAP_CSS_CSI_SUPP   = 0x40,
+};
+
 #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
 #define NVME_CAP_CQR(cap)   (((cap) >> CAP_CQR_SHIFT)    & CAP_CQR_MASK)
 #define NVME_CAP_AMS(cap)   (((cap) >> CAP_AMS_SHIFT)    & CAP_AMS_MASK)
@@ -102,6 +107,12 @@ enum NvmeCcMask {
     CC_IOCQES_MASK  = 0xf,
 };
 
+enum NvmeCcCss {
+    CSS_NVM_ONLY        = 0,
+    CSS_CSI             = 6,
+    CSS_ADMIN_ONLY      = 7,
+};
+
 #define NVME_CC_EN(cc)     ((cc >> CC_EN_SHIFT)     & CC_EN_MASK)
 #define NVME_CC_CSS(cc)    ((cc >> CC_CSS_SHIFT)    & CC_CSS_MASK)
 #define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
@@ -110,6 +121,21 @@ enum NvmeCcMask {
 #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
 #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
 
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
@@ -524,8 +550,13 @@ typedef struct QEMU_PACKED NvmeIdentify {
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
@@ -645,6 +676,7 @@ enum NvmeStatusCodes {
     NVME_MD_SGL_LEN_INVALID     = 0x0010,
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
+    NVME_CMD_SET_CMB_REJECTED   = 0x002b,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -771,11 +803,15 @@ typedef struct QEMU_PACKED NvmePSD {
 
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
@@ -922,6 +958,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
     NVME_FID_MAX                    = 0x100,
 };
@@ -1006,18 +1043,26 @@ typedef struct QEMU_PACKED NvmeIdNsDescr {
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
@@ -1068,6 +1113,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
-- 
2.21.0


