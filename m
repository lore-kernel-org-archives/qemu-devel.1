Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BEB22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEB22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYQN-000770-2p
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7Y-0004Xn-1C; Thu, 24 Sep 2020 16:45:40 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7Q-0007my-2C; Thu, 24 Sep 2020 16:45:39 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4A42B58050C;
 Thu, 24 Sep 2020 16:45:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=PrCna6ZwTkQ8L
 DzZcN0skhp9euqg56QTIHlhBWBuKfQ=; b=Tp8cW5RePxxz3YE+XW4Ru8L5Xxzk+
 CNz51TniyX/MGDaB/JlqdAQSITWsF6q7pY8yGqpS7IkAy4N8ZKvzsloUJjc5KzAZ
 xXLcDHrQQLWDVg6MpbcfDieXqofExT9IteT9V96O5aBYjkmbJBT08nx/axjXJkUH
 mZJ9CRDanmOndlOU7OBd10kzokY4riTgULrYl6BlSTB8GAYjc3opILS/SMp8ISaI
 ZZ/JxjX2idRaboSF/V+u7UtPjP3bdEZXsx9GC0CHH0XjQ0MN2kFjzvXVtpvKIb48
 zOMk2QWZaV4GUBOz2bqpKCrBQWUmh2loIPuTL9pYZKLw5oejYi3qMJZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=PrCna6ZwTkQ8LDzZcN0skhp9euqg56QTIHlhBWBuKfQ=; b=Ug5+tTuj
 IeVMgC0u32ACfU7UGIoZ+ey5FNK8XExyUkr5DGWyHlZ+MKhoX7Cu9JgRBC9CmMB8
 5KAZmrSeeWgHsQsrOshLeJ25JvaRUus+aJdU/kv6Xyf/8csOjzMuOyp3RdeqTVP+
 2XSJfsbks4GT3myzw2FVGGA22OG69U2sZaBCcpGweoh5oed08vgjtea6FEk/ljuP
 q46mfiTD5qeiLWm4ickGmK2EiCW+iaIcE/HoJmXqzbXS40Zfw+bH4L3vGSIFsZsT
 tOfu+/NdjRoXFrmT9yPrqEJJ/EUl0I5h5SYsuPAWBFa4d3KrLWDKqzbKSglP7vxZ
 rl6Jjq64YCbY3Q==
X-ME-Sender: <xms:aQVtX1_apW2H8Fr2ucC9M5bs1hJNSYbhcqk5D1vTt-XXq4lptUrdVA>
 <xme:aQVtX5twWavpe5z34JN84l2y-j3LcnNVS5YWR-X8zS1M_Q14kwvHBdQny9Itwd7UJ
 i9C1nvA-OXCWce8vT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:aQVtXzCMhIC25djcyKqvZH63vt7Ys2Kj62Y77gVqYhk1pXcf97Nlsw>
 <xmx:aQVtX5c8hu8jEcWsvpUqHto3IFy7jOE4jpUUYEEErBKXRUfMIyPWaQ>
 <xmx:aQVtX6M6D6AQfkbIGwgW90Gv1oE0D343KsCbC6MP4QT7hWApT67ZLg>
 <xmx:agVtXx26iywRQR8BixviLYmneHn4mrZZo1h9hqMs0qcWjeluZUUReA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 94A883064674;
 Thu, 24 Sep 2020 16:45:28 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] hw/block/nvme: support namespace types
Date: Thu, 24 Sep 2020 22:45:08 +0200
Message-Id: <20200924204516.1881843-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Implement support for TP 4056 ("Namespace Types"). This adds the 'iocs'
(I/O Command Set) device parameter to the nvme-ns device.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |   3 +
 hw/block/nvme-ns.h    |  11 +-
 hw/block/nvme.h       |   3 +
 include/block/nvme.h  |  58 +++++++++--
 block/nvme.c          |   4 +-
 hw/block/nvme-ns.c    |  21 +++-
 hw/block/nvme.c       | 228 ++++++++++++++++++++++++++++++++++--------
 hw/block/trace-events |   6 +-
 8 files changed, 275 insertions(+), 59 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 9a5c67f10b5d..890990510b14 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -19,6 +19,9 @@ nvme-ns Options
        -drive id=pstate,file=pstate.img,format=raw
        -device nvme-ns,pstate=pstate,...
 
+  `iocs`; The "I/O Command Set" associated with the namespace. E.g. 0x0 for the
+     NVM Command Set (the default), or 0x2 for the Zoned Namespace Command Set.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 51141796909f..06c0bc8b32a4 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  iocs;
     uint8_t  lbads;
 } NvmeNamespaceParams;
 
@@ -29,7 +30,8 @@ typedef struct NvmeNamespace {
     BlockConf    blkconf;
     int32_t      bootindex;
     int64_t      size;
-    NvmeIdNs     id_ns;
+    uint8_t      iocs;
+    void         *id_ns[NVME_IOCS_MAX];
 
     struct {
         BlockBackend *blk;
@@ -56,9 +58,14 @@ static inline uint32_t nvme_nsid(NvmeNamespace *ns)
     return -1;
 }
 
+static inline NvmeIdNsNvm *nvme_ns_id_nvm(NvmeNamespace *ns)
+{
+    return ns->id_ns[NVME_IOCS_NVM];
+}
+
 static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
 {
-    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
     return &id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index ccf52ac7bb82..f66ed9ab7eff 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -123,6 +123,7 @@ typedef struct NvmeFeatureVal {
     };
     uint32_t    async_config;
     uint32_t    vwc;
+    uint32_t    iocsci;
 } NvmeFeatureVal;
 
 typedef struct NvmeCtrl {
@@ -150,6 +151,7 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint64_t    starttime_ms;
     uint16_t    temperature;
+    uint64_t    iocscs[512];
 
     HostMemoryBackend *pmrdev;
 
@@ -165,6 +167,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    void            *id_ctrl_iocss[NVME_IOCS_MAX];
     NvmeFeatureVal  features;
 } NvmeCtrl;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 5a5e19f6bedc..792fccf8c81f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -82,6 +82,11 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
                                                             << CAP_PMR_SHIFT)
 
+enum NvmeCapCss {
+    NVME_CAP_CSS_NVM = 1 << 0,
+    NVME_CAP_CSS_CSI = 1 << 6,
+};
+
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
     CC_CSS_SHIFT    = 4,
@@ -112,6 +117,7 @@ enum NvmeCcMask {
 
 enum NvmeCcCss {
     NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_ALL        = 0x6,
     NVME_CC_CSS_ADMIN_ONLY = 0x7,
 };
 
@@ -383,6 +389,11 @@ enum NvmePmrmscMask {
 #define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
     (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
 
+enum NvmeCommandSet {
+    NVME_IOCS_NVM = 0x0,
+    NVME_IOCS_MAX = 0x1,
+};
+
 enum NvmeSglDescriptorType {
     NVME_SGL_DESCR_TYPE_DATA_BLOCK          = 0x0,
     NVME_SGL_DESCR_TYPE_BIT_BUCKET          = 0x1,
@@ -531,8 +542,13 @@ typedef struct QEMU_PACKED NvmeIdentify {
     uint64_t    rsvd2[2];
     uint64_t    prp1;
     uint64_t    prp2;
-    uint32_t    cns;
-    uint32_t    rsvd11[5];
+    uint8_t     cns;
+    uint8_t     rsvd3;
+    uint16_t    cntid;
+    uint16_t    nvmsetid;
+    uint8_t     rsvd4;
+    uint8_t     csi;
+    uint32_t    rsvd11[4];
 } NvmeIdentify;
 
 typedef struct QEMU_PACKED NvmeRwCmd {
@@ -624,8 +640,15 @@ typedef struct QEMU_PACKED NvmeAerResult {
 } NvmeAerResult;
 
 typedef struct QEMU_PACKED NvmeCqe {
-    uint32_t    result;
-    uint32_t    rsvd;
+    union {
+        struct {
+            uint32_t    dw0;
+            uint32_t    dw1;
+        };
+
+        uint64_t qw0;
+    };
+
     uint16_t    sq_head;
     uint16_t    sq_id;
     uint16_t    cid;
@@ -673,6 +696,10 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_IOCS_NOT_SUPPORTED     = 0x0127,
+    NVME_IOCS_NOT_ENABLED       = 0x0128,
+    NVME_IOCS_COMB_REJECTED     = 0x0129,
+    NVME_INVALID_IOCS           = 0x0126,
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
@@ -734,6 +761,8 @@ typedef struct QEMU_PACKED NvmeSmartLog {
     uint8_t     reserved2[320];
 } NvmeSmartLog;
 
+#define NVME_ACS_MAX 256
+
 typedef struct QEMU_PACKED NvmeEffectsLog {
     uint32_t acs[256];
     uint32_t iocs[256];
@@ -782,10 +811,14 @@ typedef struct QEMU_PACKED NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum {
-    NVME_ID_CNS_NS             = 0x0,
-    NVME_ID_CNS_CTRL           = 0x1,
-    NVME_ID_CNS_NS_ACTIVE_LIST = 0x2,
-    NVME_ID_CNS_NS_DESCR_LIST  = 0x3,
+    NVME_ID_CNS_NS                  = 0x00,
+    NVME_ID_CNS_CTRL                = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST      = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST       = 0x03,
+    NVME_ID_CNS_NS_IOCS             = 0x05,
+    NVME_ID_CNS_CTRL_IOCS           = 0x06,
+    NVME_ID_CNS_NS_ACTIVE_LIST_IOCS = 0x07,
+    NVME_ID_CNS_IOCS                = 0x1c,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
@@ -935,6 +968,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
     NVME_FID_MAX                    = 0x100,
 };
@@ -983,7 +1017,7 @@ typedef struct QEMU_PACKED NvmeLBAF {
 
 #define NVME_NSID_BROADCAST 0xffffffff
 
-typedef struct QEMU_PACKED NvmeIdNs {
+typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint64_t    nsze;
     uint64_t    ncap;
     uint64_t    nuse;
@@ -1011,7 +1045,7 @@ typedef struct QEMU_PACKED NvmeIdNs {
     NvmeLBAF    lbaf[16];
     uint8_t     rsvd192[192];
     uint8_t     vs[3712];
-} NvmeIdNs;
+} NvmeIdNsNvm;
 
 typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t nidt;
@@ -1023,12 +1057,14 @@ enum {
     NVME_NIDT_EUI64_LEN =  8,
     NVME_NIDT_NGUID_LEN = 16,
     NVME_NIDT_UUID_LEN  = 16,
+    NVME_NIDT_CSI_LEN   =  1,
 };
 
 enum NvmeNsIdentifierType {
     NVME_NIDT_EUI64 = 0x1,
     NVME_NIDT_NGUID = 0x2,
     NVME_NIDT_UUID  = 0x3,
+    NVME_NIDT_CSI   = 0x4,
 };
 
 /*Deallocate Logical Block Features*/
@@ -1081,7 +1117,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7d8..b5cc0185c298 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -336,7 +336,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->dw0),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
@@ -503,7 +503,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     union {
         NvmeIdCtrl ctrl;
-        NvmeIdNs ns;
+        NvmeIdNsNvm ns;
     } *id;
     NvmeLBAF *lbaf;
     uint16_t oncs;
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 9a63004c000a..68b2ce3d17c5 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -57,10 +57,15 @@ static int nvme_blk_truncate(BlockBackend *blk, size_t len, Error **errp)
 
 static void nvme_ns_init(NvmeNamespace *ns)
 {
-    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns;
+
+    ns->id_ns[NVME_IOCS_NVM] = g_new0(NvmeIdNsNvm, 1);
+    id_ns = nvme_ns_id_nvm(ns);
+
+    ns->iocs = ns->params.iocs;
 
     if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
-        ns->id_ns.dlfeat = 0x9;
+        id_ns->dlfeat = 0x9;
     }
 
     id_ns->lbaf[0].ds = ns->params.lbads;
@@ -170,6 +175,14 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    switch (ns->params.iocs) {
+    case NVME_IOCS_NVM:
+        break;
+    default:
+        error_setg(errp, "unsupported iocs");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -194,7 +207,8 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
          * With a pstate file in place we can enable the Deallocated or
          * Unwritten Logical Block Error feature.
          */
-        ns->id_ns.nsfeat |= 0x4;
+        NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+        id_ns->nsfeat |= 0x4;
     }
 
     if (nvme_register_namespace(n, ns, errp)) {
@@ -241,6 +255,7 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
     DEFINE_PROP_DRIVE("pstate", NvmeNamespace, pstate.blk),
+    DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, NVME_IOCS_NVM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 21f558f75559..f5578ea3bd63 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -102,6 +102,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
     [NVME_WRITE_ATOMICITY]          = true,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
     [NVME_TIMESTAMP]                = true,
+    [NVME_COMMAND_SET_PROFILE]      = true,
 };
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
@@ -111,6 +112,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
+    [NVME_COMMAND_SET_PROFILE]      = NVME_FEAT_CAP_CHANGE,
 };
 
 #define NVME_EFFECTS_ADMIN_INITIALIZER                 \
@@ -143,13 +145,15 @@ static const NvmeEffectsLog nvme_effects_admin_only = {
     },
 };
 
-static const NvmeEffectsLog nvme_effects = {
-    .acs = {
-        NVME_EFFECTS_ADMIN_INITIALIZER,
-    },
+static const NvmeEffectsLog nvme_effects[NVME_IOCS_MAX] = {
+    [NVME_IOCS_NVM] = {
+        .acs = {
+            NVME_EFFECTS_ADMIN_INITIALIZER,
+        },
 
-    .iocs = {
-        NVME_EFFECTS_NVM_INITIALIZER,
+        .iocs = {
+            NVME_EFFECTS_NVM_INITIALIZER,
+        },
     },
 };
 
@@ -861,7 +865,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.dw0;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -921,7 +925,8 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb)
 {
-    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
+    NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+    uint64_t nsze = le64_to_cpu(id_ns->nsze);
 
     if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
         return NVME_LBA_RANGE | NVME_DNR;
@@ -1111,7 +1116,8 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        NvmeIdNsNvm *id_ns = nvme_ns_id_nvm(ns);
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb, id_ns->nsze);
         goto invalid;
     }
 
@@ -1157,9 +1163,10 @@ invalid:
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    uint8_t opc = req->cmd.opcode;
 
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
-                          req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
+                          opc, nvme_io_opc_str(req->cmd.opcode));
 
     if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1174,6 +1181,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (!(nvme_effects[req->ns->iocs].iocs[opc] & NVME_EFFECTS_CSUPP)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
@@ -1412,6 +1423,7 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
     const NvmeEffectsLog *effects;
 
     uint32_t trans_len;
+    uint8_t csi = le32_to_cpu(req->cmd.cdw14) >> 24;
 
     if (off > sizeof(NvmeEffectsLog)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1423,7 +1435,17 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
         break;
 
     case NVME_CC_CSS_NVM:
-        effects = &nvme_effects;
+        effects = &nvme_effects[NVME_IOCS_NVM];
+        break;
+
+    case NVME_CC_CSS_ALL:
+        if (!(n->iocscs[n->features.iocsci] & (1 << csi))) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        assert(csi < NVME_IOCS_MAX);
+
+        effects = &nvme_effects[csi];
         break;
 
     default:
@@ -1593,39 +1615,94 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                   NvmeRequest *req)
 {
+    NvmeIdCtrl empty = { 0 };
+    NvmeIdCtrl *id_ctrl = &empty;
+
     trace_pci_nvme_identify_ctrl();
 
-    return nvme_dma(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
+    switch (cns) {
+    case NVME_ID_CNS_CTRL:
+        id_ctrl = &n->id_ctrl;
+
+        break;
+
+    case NVME_ID_CNS_CTRL_IOCS:
+        if (!(n->iocscs[n->features.iocsci] & (1 << csi))) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        assert(csi < NVME_IOCS_MAX);
+
+        if (n->id_ctrl_iocss[csi]) {
+            id_ctrl = n->id_ctrl_iocss[csi];
+        }
+
+        break;
+
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return nvme_dma(n, (uint8_t *)id_ctrl, sizeof(*id_ctrl),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                 NvmeRequest *req)
 {
+    NvmeIdNsNvm empty = { 0 };
+    void *id_ns = &empty;
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
-    NvmeIdNs *id_ns, inactive = { 0 };
     uint32_t nsid = le32_to_cpu(c->nsid);
 
-    trace_pci_nvme_identify_ns(nsid);
+    trace_pci_nvme_identify_ns(nsid, csi);
 
     if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
     ns = nvme_ns(n, nsid);
-    if (unlikely(!ns)) {
-        id_ns = &inactive;
-    } else {
-        id_ns = &ns->id_ns;
+    if (ns) {
+        switch (cns) {
+        case NVME_ID_CNS_NS:
+            id_ns = ns->id_ns[NVME_IOCS_NVM];
+            if (!id_ns) {
+                return NVME_INVALID_IOCS | NVME_DNR;
+            }
+
+            break;
+
+        case NVME_ID_CNS_NS_IOCS:
+            if (csi == NVME_IOCS_NVM) {
+                break;
+            }
+
+            if (csi >= NVME_IOCS_MAX) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            id_ns = ns->id_ns[csi];
+            if (!id_ns) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            break;
+
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
     }
 
-    return nvme_dma(n, (uint8_t *)id_ns, sizeof(NvmeIdNs),
+    return nvme_dma(n, (uint8_t *)id_ns, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, uint8_t cns, uint8_t csi,
+                                     NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
@@ -1634,7 +1711,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     uint16_t ret;
     int j = 0;
 
-    trace_pci_nvme_identify_nslist(min_nsid);
+    trace_pci_nvme_identify_nslist(min_nsid, csi);
 
     /*
      * Both 0xffffffff (NVME_NSID_BROADCAST) and 0xfffffffe are invalid values
@@ -1646,11 +1723,21 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
+    if (cns == NVME_ID_CNS_NS_ACTIVE_LIST_IOCS && !csi) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     list = g_malloc0(data_len);
     for (int i = 1; i <= n->num_namespaces; i++) {
-        if (i <= min_nsid || !nvme_ns(n, i)) {
+        NvmeNamespace *ns = nvme_ns(n, i);
+        if (i <= min_nsid || !ns) {
             continue;
         }
+
+        if (cns == NVME_ID_CNS_NS_ACTIVE_LIST_IOCS && csi && csi != ns->iocs) {
+            continue;
+        }
+
         list[j++] = cpu_to_le32(i);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1666,6 +1753,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
+    NvmeNamespace *ns;
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
 
     struct data {
@@ -1673,6 +1761,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
             NvmeIdNsDescr hdr;
             uint8_t v[16];
         } uuid;
+
+        struct {
+            NvmeIdNsDescr hdr;
+            uint8_t v;
+        } iocs;
     };
 
     struct data *ns_descrs = (struct data *)list;
@@ -1683,7 +1776,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1699,25 +1793,45 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
+    ns_descrs->iocs.hdr.nidt = NVME_NIDT_CSI;
+    ns_descrs->iocs.hdr.nidl = NVME_NIDT_CSI_LEN;
+    stb_p(&ns_descrs->iocs.v, ns->iocs);
+
     return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_identify_iocs(NvmeCtrl *n, uint16_t cntid,
+                                   NvmeRequest *req)
+{
+    return nvme_dma(n, (uint8_t *) n->iocscs, sizeof(n->iocscs),
+                    DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
 
+    trace_pci_nvme_identify(nvme_cid(req), le32_to_cpu(c->nsid),
+                            le16_to_cpu(c->cntid), c->cns, c->csi,
+                            le16_to_cpu(c->nvmsetid));
+
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+    case NVME_ID_CNS_NS_IOCS:
+        return nvme_identify_ns(n, c->cns, c->csi, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, req);
+    case NVME_ID_CNS_CTRL_IOCS:
+        return nvme_identify_ctrl(n, c->cns, c->csi, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+    case NVME_ID_CNS_NS_ACTIVE_LIST_IOCS:
+        return nvme_identify_nslist(n, c->cns, c->csi, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
+    case NVME_ID_CNS_IOCS:
+        return nvme_identify_iocs(n, c->cntid, req);
     default:
-        trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
+        trace_pci_nvme_err_invalid_identify_cns(c->cns);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
@@ -1726,7 +1840,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.dw0 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1911,6 +2025,9 @@ defaults:
             result |= NVME_INTVC_NOCOALESCING;
         }
 
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = cpu_to_le32(n->features.iocsci & 0x1ff);
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1918,7 +2035,8 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.dw0 = cpu_to_le32(result);
+
     return NVME_SUCCESS;
 }
 
@@ -1941,6 +2059,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = NULL;
+    NvmeIdNsNvm *id_ns;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -2017,7 +2136,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                     continue;
                 }
 
-                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                id_ns = nvme_ns_id_nvm(ns);
+                if (NVME_ID_NS_NSFEAT_DULBE(id_ns->nsfeat)) {
                     ns->features.err_rec = dw11;
                 }
             }
@@ -2033,6 +2153,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 
         for (int i = 1; i <= n->num_namespaces; i++) {
             ns = nvme_ns(n, i);
+
             if (!ns) {
                 continue;
             }
@@ -2063,14 +2184,34 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                     ((dw11 >> 16) & 0xFFFF) + 1,
                                     n->params.max_ioqpairs,
                                     n->params.max_ioqpairs);
-        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
-                                      ((n->params.max_ioqpairs - 1) << 16));
+        req->cqe.dw0 = cpu_to_le32((n->params.max_ioqpairs - 1) |
+                                   ((n->params.max_ioqpairs - 1) << 16));
         break;
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config = dw11;
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, req);
+    case NVME_COMMAND_SET_PROFILE:
+        if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ALL) {
+            uint16_t iocsci = dw11 & 0x1ff;
+            uint64_t iocsc = n->iocscs[iocsci];
+
+            for (int i = 1; i <= n->num_namespaces; i++) {
+                ns = nvme_ns(n, i);
+                if (!ns) {
+                    continue;
+                }
+
+                if (!(iocsc & (1 << ns->iocs))) {
+                    return NVME_IOCS_COMB_REJECTED | NVME_DNR;
+                }
+            }
+
+            n->features.iocsci = iocsci;
+        }
+
+        break;
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -2217,6 +2358,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
 
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
         return -1;
@@ -2256,28 +2399,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) <
-                 NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
+                 NVME_CTRL_CQES_MIN(id_ctrl->cqes))) {
         trace_pci_nvme_err_startfail_cqent_too_small(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOCQES(n->bar.cc) >
-                 NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
+                 NVME_CTRL_CQES_MAX(id_ctrl->cqes))) {
         trace_pci_nvme_err_startfail_cqent_too_large(
                     NVME_CC_IOCQES(n->bar.cc),
                     NVME_CTRL_CQES_MAX(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) <
-                 NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
+                 NVME_CTRL_SQES_MIN(id_ctrl->sqes))) {
         trace_pci_nvme_err_startfail_sqent_too_small(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MIN(n->bar.cap));
         return -1;
     }
     if (unlikely(NVME_CC_IOSQES(n->bar.cc) >
-                 NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
+                 NVME_CTRL_SQES_MAX(id_ctrl->sqes))) {
         trace_pci_nvme_err_startfail_sqent_too_large(
                     NVME_CC_IOSQES(n->bar.cc),
                     NVME_CTRL_SQES_MAX(n->bar.cap));
@@ -2738,6 +2881,8 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
+    n->iocscs[0] = 1 << NVME_IOCS_NVM;
+    n->features.iocsci = 0;
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -2942,7 +3087,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
-    NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_CSS(n->bar.cap, (NVME_CAP_CSS_NVM | NVME_CAP_CSS_CSI));
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
@@ -3002,6 +3147,11 @@ static void nvme_exit(PCIDevice *pci_dev)
     if (n->pmrdev) {
         host_memory_backend_set_mapped(n->pmrdev, false);
     }
+
+    for (int i = 0; i < NVME_IOCS_MAX; i++) {
+        g_free(n->id_ctrl_iocss[i]);
+    }
+
     msix_uninit_exclusive_bar(pci_dev);
 }
 
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 774513469274..b002eb7c8a5c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -48,10 +48,12 @@ pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize,
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
+pci_nvme_identify(uint16_t cid, uint32_t nsid, uint16_t cntid, uint8_t cns, uint8_t csi, uint16_t nvmsetid) "cid %"PRIu16" nsid %"PRIu32" cntid 0x%"PRIx16" cns 0x%"PRIx8" csi 0x%"PRIx8" nvmsetid %"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
-pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
-pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns(uint32_t ns, uint8_t csi) "nsid %"PRIu32" csi 0x%"PRIx8""
+pci_nvme_identify_nslist(uint32_t ns, uint8_t csi) "nsid %"PRIu32" csi 0x%"PRIx8""
 pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_io_cmd_set(uint16_t cid) "cid %"PRIu16""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 pci_nvme_getfeat(uint16_t cid, uint32_t nsid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" nsid 0x%"PRIx32" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
 pci_nvme_setfeat(uint16_t cid, uint32_t nsid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" nsid 0x%"PRIx32" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""
-- 
2.28.0


