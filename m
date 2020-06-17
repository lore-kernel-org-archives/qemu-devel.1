Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEED2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CNliOncC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEED2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfuA-0000fP-Tu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhi-0003ls-0k; Wed, 17 Jun 2020 17:34:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhe-0005Dr-KZ; Wed, 17 Jun 2020 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429678; x=1623965678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=megqPJFM56PH7GfxtsYVlj7LtNTISymaYwWv1hDN270=;
 b=CNliOncCc+8SaQph97gLSLdwwA0/ql6ts4+26zGKIFxeJeqMmQRMRADx
 0GlvFY7jfKzUyoM8afFFbpCv8d6SQ5xQQv3nLFovwGr3JavumzY0ZVJju
 v+2HeCAhgUOWWMXh3u45deCfCjSOB7vMJ3yvVz8Qa4LDhy94rYOvCsAxE
 amqziUaP1xydk1Hqc6nj8VkarMpoNjLsY7DPL9gUlPza4ZvG00Mk1AsJf
 AP0UkOdvtEslFSisdGVs4fn63JgXSbLFTGYe/5BqRbsF6zGnAFmE/3Wcc
 K1Irz27nqlh/5usN16nTGp7U4kT+KNxAQhiPt40lmxQRLgk/NtMvXV7VL Q==;
IronPort-SDR: qOiAWjTvLj+1LitqeN28voJ/AfKNDkhDW3HvAeGC73xvIuC/s4GkEo32IT2dEXMFz/fCYrq6Ls
 Al/PFPoknZQh47n3Lod5F5E8qx5iXpKTpW9ZjhemWtQ5P2DkIVouSlbxlChpaaVOuu4Forqy9K
 NQOW2GLuWa5b6tWmCzDh810CFsDft2p0BigzvqmWE67BxwgI1SR4byeNHESLBbiFGCqWurd7mC
 XqiX2VXsxCbt/DrLCLk1CdNLwWat7YdO0GbB97tiYlyqd3mWOF9n5j3HzSYGs/KgsuBd8vNE+V
 7dQ=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:37 +0800
IronPort-SDR: +BA11JWlF5YGnfXhX0xtkM+ajebu992yb6KCjQfb85k1gXQUAhc4uW65IPb3cKYLCNVncjrMdu
 m+jdPrJTDZqsYxIF1+2vWnD42UK5FNTfQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:18 -0700
IronPort-SDR: /ApIvmCPzs9GNRDG4G/4Ev3b9ae6Q5PJOKKrn55T6weLWaeMApDtTkQExC1/gC8AqP1HFs2AP8
 mXSQxlT2uwnA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:35 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Date: Thu, 18 Jun 2020 06:34:02 +0900
Message-Id: <20200617213415.22417-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 hw/block/nvme.h      |  3 ++
 include/block/nvme.h | 75 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 4f0dac39ae..4fd155c409 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -63,6 +63,9 @@ typedef struct NvmeCQueue {
 
 typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
+    uint32_t        nsid;
+    uint8_t         csi;
+    QemuUUID        uuid;
 } NvmeNamespace;
 
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 6a58bac0c2..5a1e5e137c 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -50,6 +50,11 @@ enum NvmeCapMask {
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
@@ -101,6 +106,12 @@ enum NvmeCcMask {
     CC_IOCQES_MASK  = 0xf,
 };
 
+enum NvmeCcCss {
+    CSS_NVM_ONLY        = 0,
+    CSS_ALL_NSTYPES     = 6,
+    CSS_ADMIN_ONLY      = 7,
+};
+
 #define NVME_CC_EN(cc)     ((cc >> CC_EN_SHIFT)     & CC_EN_MASK)
 #define NVME_CC_CSS(cc)    ((cc >> CC_CSS_SHIFT)    & CC_CSS_MASK)
 #define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
@@ -109,6 +120,21 @@ enum NvmeCcMask {
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
@@ -482,10 +508,41 @@ typedef struct NvmeIdentify {
     uint64_t    rsvd2[2];
     uint64_t    prp1;
     uint64_t    prp2;
-    uint32_t    cns;
-    uint32_t    rsvd11[5];
+    uint8_t     cns;
+    uint8_t     rsvd4;
+    uint16_t    ctrlid;
+    uint16_t    nvmsetid;
+    uint8_t     rsvd3;
+    uint8_t     csi;
+    uint32_t    rsvd12[4];
 } NvmeIdentify;
 
+typedef struct NvmeNsIdDesc {
+    uint8_t     nidt;
+    uint8_t     nidl;
+    uint16_t    rsvd2;
+} NvmeNsIdDesc;
+
+enum NvmeNidType {
+    NVME_NIDT_EUI64             = 0x01,
+    NVME_NIDT_NGUID             = 0x02,
+    NVME_NIDT_UUID              = 0x03,
+    NVME_NIDT_CSI               = 0x04,
+};
+
+enum NvmeNidLength {
+    NVME_NIDL_EUI64             = 8,
+    NVME_NIDL_NGUID             = 16,
+    NVME_NIDL_UUID              = 16,
+    NVME_NIDL_CSI               = 1,
+};
+
+enum NvmeCsi {
+    NVME_CSI_NVM                = 0x00,
+};
+
+#define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
+
 typedef struct NvmeRwCmd {
     uint8_t     opcode;
     uint8_t     flags;
@@ -603,6 +660,7 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
     NVME_INVALID_NSID           = 0x000b,
     NVME_CMD_SEQ_ERROR          = 0x000c,
+    NVME_CMD_SET_CMB_REJECTED   = 0x002b,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -729,9 +787,14 @@ typedef struct NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum {
-    NVME_ID_CNS_NS             = 0x0,
-    NVME_ID_CNS_CTRL           = 0x1,
-    NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
+    NVME_ID_CNS_NS                = 0x0,
+    NVME_ID_CNS_CTRL              = 0x1,
+    NVME_ID_CNS_NS_ACTIVE_LIST    = 0x2,
+    NVME_ID_CNS_NS_DESC_LIST      = 0x03,
+    NVME_ID_CNS_CS_NS             = 0x05,
+    NVME_ID_CNS_CS_CTRL           = 0x06,
+    NVME_ID_CNS_CS_NS_ACTIVE_LIST = 0x07,
+    NVME_ID_CNS_IO_COMMAND_SET    = 0x1c,
 };
 
 typedef struct NvmeIdCtrl {
@@ -825,6 +888,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
 };
 
@@ -914,6 +978,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeNsIdDesc) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
 }
-- 
2.21.0


