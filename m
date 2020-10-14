Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F3C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB9B20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSf9r-0000bf-QG
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0L-0003ET-Gf; Wed, 14 Oct 2020 07:31:37 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0H-0006Y5-8e; Wed, 14 Oct 2020 07:31:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 562A1580194;
 Wed, 14 Oct 2020 07:31:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=AQYSyktvinTCQ
 /dZKUDRpfDCfSIgHLgVH5NoS6n2PBI=; b=UapUyxh8eTx5ZlMwTJPmTDRIPQBxa
 lL3Ms4nEnNJG/bKbePiPxrzpqpiEjMXbC8nngQkc3W0/eCouMdOh6uXJD/mtax+B
 g+vRJdzyuea7Km7cN5uEj+Qbo9rZiBrGYdAy9Mw9wfzDA0Yahaqy5hD1r+X7gBne
 XOZjzdVZJh8USOUClKoXmLNWc9WHP3ry9CyLVmmiIehoNpwJwzATDQ/qyAo5iMI/
 5MWIDfMnu8j9xiHK22h604JLs4T4AfGd6teelLbTe7fptl7o5U8hZXbVmofZK3X4
 lezeSX5xfUy03oeI0vA3vMOmsWYQgcSORj1MCpoRzrm24DQS0joHClqZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=AQYSyktvinTCQ/dZKUDRpfDCfSIgHLgVH5NoS6n2PBI=; b=Vj1ULqMu
 rlvpvsyT8XYphswvy+UjYV7ToVz1FNP9bfeTaV7oYo0A0pwRVdl5hF8bSEjW4ybp
 qYUxCyVNHE7c1jtsk677rrNrulsnJg5tyE5vnFprReZPtgpwYWXYJGNmVeI8fDm7
 4uxQg6VAjeyi6m5NgUpF0NeQ8IVt86KJbxNxgB+6wd70OtvKZ7q8y6BYmJ3D9aSO
 ZI89ilMxIvRrM3PJsljnXTG40u1zPK13skLXbhuB72STeNeNjFiJP6M5nyO7xJPL
 /83YURforeSA8z2oZ8jF8oKZnkyUGVXqRBxx3Gpj3/a8mBbBjGID9uWZPrC3wyQj
 JIXE6WASFwiP/A==
X-ME-Sender: <xms:keGGX9WSgZzMJkMKwSFfcibLejgYZNX4vus3LoLIthJBoKAE5JZztg>
 <xme:keGGX9n-aGexI913dV-pk4AKT21V8q7w0geFKkxJMpmQkPbd3c-DkNmenXF_-13U9
 NIClvsuatY_3FQ2VgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepieduheefjeetgeeufeefkefhlefgkeehteffgfetjeegkeeugfdtudejuedugeei
 necuffhomhgrihhnpehuuhhiugdruggrthgrnecukfhppeektddrudeijedrleekrddule
 dtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihht
 shesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:keGGX5bQF3J6r51EQiC9WTZkie3tIM4ihqo8Z4RMP90E6Fkbus7Wsg>
 <xmx:keGGXwUAtpytI2efWxi04iISV0ugw-iR0c3px0wS2kfVKkc2_hfADQ>
 <xmx:keGGX3lEYtT__HBhPHp0iDl7nSjgu-hRO2Z4MONXJ2j6Ih7srHvDfw>
 <xmx:keGGX1ZX_dO6cbiXuoZkNsqBPrj48jzqUbfdBl4132nj1DUjEn_BXA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 60EC23064685;
 Wed, 14 Oct 2020 07:31:28 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] hw/block/nvme: support namespace types
Date: Wed, 14 Oct 2020 13:31:16 +0200
Message-Id: <20201014113122.388849-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014113122.388849-1-its@irrelevant.dk>
References: <20201014113122.388849-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Implement support for TP 4056 ("Namespace Types"). This adds the 'iocs'
(I/O Command Set) device parameter to the nvme-ns device.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |   3 +
 hw/block/nvme-ns.h    |  11 ++-
 hw/block/nvme.h       |   3 +
 include/block/nvme.h  |  52 +++++++---
 block/nvme.c          |   4 +-
 hw/block/nvme-ns.c    |  21 +++-
 hw/block/nvme.c       | 225 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   6 +-
 8 files changed, 267 insertions(+), 58 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 56d393884e7a..619bd9ce4378 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -3,6 +3,9 @@ NVM Express Controller
 
 The nvme device (-device nvme) emulates an NVM Express Controller.
 
+  `iocs`; The "I/O Command Set" associated with the namespace. E.g. 0x0 for the
+     NVM Command Set (the default), or 0x2 for the Zoned Namespace Command Set.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 8951fc5e86b8..5eb135a0b73f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  iocs;
     QemuUUID uuid;
 } NvmeNamespaceParams;
 
@@ -29,7 +30,8 @@ typedef struct NvmeNamespace {
     BlockConf    blkconf;
     int32_t      bootindex;
     int64_t      size;
-    NvmeIdNs     id_ns;
+    uint8_t      iocs;
+    void         *id_ns[NVME_IOCS_MAX];
 
     NvmeNamespaceParams params;
 
@@ -47,9 +49,14 @@ static inline uint32_t nvme_nsid(NvmeNamespace *ns)
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
index e080a2318a50..5c1de0ef16e7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -112,6 +112,7 @@ typedef struct NvmeFeatureVal {
     };
     uint32_t    async_config;
     uint32_t    vwc;
+    uint32_t    iocsci;
 } NvmeFeatureVal;
 
 typedef struct NvmeCtrl {
@@ -139,6 +140,7 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
     uint64_t    starttime_ms;
     uint16_t    temperature;
+    uint64_t    iocscs[512];
 
     HostMemoryBackend *pmrdev;
 
@@ -154,6 +156,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    void            *id_ctrl_iocss[NVME_IOCS_MAX];
     NvmeFeatureVal  features;
 } NvmeCtrl;
 
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f71376072762..443f5c7e8376 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -84,6 +84,7 @@ enum NvmeCapMask {
 
 enum NvmeCapCss {
     NVME_CAP_CSS_NVM        = 1 << 0,
+    NVME_CAP_CSS_CSI        = 1 << 6,
     NVME_CAP_CSS_ADMIN_ONLY = 1 << 7,
 };
 
@@ -117,6 +118,7 @@ enum NvmeCcMask {
 
 enum NvmeCcCss {
     NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_ALL        = 0x6,
     NVME_CC_CSS_ADMIN_ONLY = 0x7,
 };
 
@@ -388,6 +390,11 @@ enum NvmePmrmscMask {
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
@@ -534,8 +541,13 @@ typedef struct QEMU_PACKED NvmeIdentify {
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
@@ -627,8 +639,15 @@ typedef struct QEMU_PACKED NvmeAerResult {
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
@@ -676,6 +695,10 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_IOCS_NOT_SUPPORTED     = 0x0129,
+    NVME_IOCS_NOT_ENABLED       = 0x012a,
+    NVME_IOCS_COMB_REJECTED     = 0x012b,
+    NVME_INVALID_IOCS           = 0x012c,
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
@@ -785,10 +808,14 @@ typedef struct QEMU_PACKED NvmePSD {
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
@@ -939,6 +966,7 @@ enum NvmeFeatureIds {
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
     NVME_TIMESTAMP                  = 0xe,
+    NVME_COMMAND_SET_PROFILE        = 0x19,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80,
     NVME_FID_MAX                    = 0x100,
 };
@@ -987,7 +1015,7 @@ typedef struct QEMU_PACKED NvmeLBAF {
 
 #define NVME_NSID_BROADCAST 0xffffffff
 
-typedef struct QEMU_PACKED NvmeIdNs {
+typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint64_t    nsze;
     uint64_t    ncap;
     uint64_t    nuse;
@@ -1015,7 +1043,7 @@ typedef struct QEMU_PACKED NvmeIdNs {
     NvmeLBAF    lbaf[16];
     uint8_t     rsvd192[192];
     uint8_t     vs[3712];
-} NvmeIdNs;
+} NvmeIdNsNvm;
 
 typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t nidt;
@@ -1027,12 +1055,14 @@ enum {
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
@@ -1085,7 +1115,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
diff --git a/block/nvme.c b/block/nvme.c
index b48f6f258819..1d230c3cd4cf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -331,7 +331,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
 {
     uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
     if (status) {
-        trace_nvme_error(le32_to_cpu(c->result),
+        trace_nvme_error(le32_to_cpu(c->dw0),
                          le16_to_cpu(c->sq_head),
                          le16_to_cpu(c->sq_id),
                          le16_to_cpu(c->cid),
@@ -498,7 +498,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     union {
         NvmeIdCtrl ctrl;
-        NvmeIdNs ns;
+        NvmeIdNsNvm ns;
     } *id;
     NvmeLBAF *lbaf;
     uint16_t oncs;
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index dff3e308e31b..29f5bcce67ea 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -30,11 +30,17 @@
 
 static void nvme_ns_init(NvmeNamespace *ns)
 {
-    NvmeIdNs *id_ns = &ns->id_ns;
-    int lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    NvmeIdNsNvm *id_ns;
+    int lba_index;
+
+    ns->id_ns[NVME_IOCS_NVM] = g_new0(NvmeIdNsNvm, 1);
+    id_ns = nvme_ns_id_nvm(ns);
+
+    ns->iocs = ns->params.iocs;
+    lba_index = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
 
     if (blk_get_flags(ns->blkconf.blk) & BDRV_O_UNMAP) {
-        ns->id_ns.dlfeat = 0x9;
+        id_ns->dlfeat = 0x9;
     }
 
     id_ns->lbaf[lba_index].ds = 31 - clz32(ns->blkconf.logical_block_size);
@@ -81,6 +87,14 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
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
 
@@ -130,6 +144,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_UINT8("iocs", NvmeNamespace, params.iocs, NVME_IOCS_NVM),
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index aaea0436fd05..c447dc75d5c0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -101,6 +101,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
     [NVME_WRITE_ATOMICITY]          = true,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = true,
     [NVME_TIMESTAMP]                = true,
+    [NVME_COMMAND_SET_PROFILE]      = true,
 };
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
@@ -110,6 +111,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
     [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
+    [NVME_COMMAND_SET_PROFILE]      = NVME_FEAT_CAP_CHANGE,
 };
 
 #define NVME_EFFECTS_ADMIN_INITIALIZER                 \
@@ -142,13 +144,15 @@ static const NvmeEffectsLog nvme_effects_admin_only = {
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
 
@@ -860,7 +864,7 @@ static void nvme_process_aers(void *opaque)
 
         req = n->aer_reqs[n->outstanding_aers];
 
-        result = (NvmeAerResult *) &req->cqe.result;
+        result = (NvmeAerResult *) &req->cqe.dw0;
         result->event_type = event->result.event_type;
         result->event_info = event->result.event_info;
         result->log_page = event->result.log_page;
@@ -920,7 +924,7 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
                                          uint64_t slba, uint32_t nlb)
 {
-    uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
+    uint64_t nsze = le64_to_cpu(nvme_ns_id_nvm(ns)->nsze);
 
     if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
         return NVME_LBA_RANGE | NVME_DNR;
@@ -1026,7 +1030,8 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb,
+                                             nvme_ns_id_nvm(ns)->nsze);
         return status;
     }
 
@@ -1062,7 +1067,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_pci_nvme_err_invalid_lba_range(slba, nlb,
+                                             nvme_ns_id_nvm(ns)->nsze);
         goto invalid;
     }
 
@@ -1108,9 +1114,10 @@ invalid:
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    uint8_t opc = req->cmd.opcode;
 
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
-                          req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
+                          opc, nvme_io_opc_str(req->cmd.opcode));
 
     if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1125,6 +1132,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (!(nvme_effects[req->ns->iocs].iocs[opc] & NVME_EFFECTS_CSUPP)) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, req);
@@ -1377,6 +1388,7 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
     const NvmeEffectsLog *effects;
 
     uint32_t trans_len;
+    uint8_t csi = le32_to_cpu(req->cmd.cdw14) >> 24;
 
     if (off >= sizeof(NvmeEffectsLog)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1388,7 +1400,17 @@ static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
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
@@ -1558,39 +1580,94 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1599,7 +1676,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     uint16_t ret;
     int j = 0;
 
-    trace_pci_nvme_identify_nslist(min_nsid);
+    trace_pci_nvme_identify_nslist(min_nsid, csi);
 
     /*
      * Both 0xffffffff (NVME_NSID_BROADCAST) and 0xfffffffe are invalid values
@@ -1611,11 +1688,21 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1639,6 +1726,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1660,25 +1752,45 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     memcpy(ns_descrs->uuid.v, ns->params.uuid.data, 16);
 
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
@@ -1687,7 +1799,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
-    req->cqe.result = 1;
+    req->cqe.dw0 = 1;
     if (nvme_check_sqid(n, sqid)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -1871,6 +1983,9 @@ defaults:
             result |= NVME_INTVC_NOCOALESCING;
         }
 
+        break;
+    case NVME_COMMAND_SET_PROFILE:
+        result = cpu_to_le32(n->features.iocsci & 0x1ff);
         break;
     default:
         result = nvme_feature_default[fid];
@@ -1878,7 +1993,8 @@ defaults:
     }
 
 out:
-    req->cqe.result = cpu_to_le32(result);
+    req->cqe.dw0 = cpu_to_le32(result);
+
     return NVME_SUCCESS;
 }
 
@@ -1901,6 +2017,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
+    NvmeIdNsNvm *id_ns;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -1977,7 +2094,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                     continue;
                 }
 
-                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                id_ns = nvme_ns_id_nvm(ns);
+                if (NVME_ID_NS_NSFEAT_DULBE(id_ns->nsfeat)) {
                     ns->features.err_rec = dw11;
                 }
             }
@@ -1993,6 +2111,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 
         for (int i = 1; i <= n->num_namespaces; i++) {
             ns = nvme_ns(n, i);
+
             if (!ns) {
                 continue;
             }
@@ -2023,14 +2142,34 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -2177,6 +2316,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
 
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
         return -1;
@@ -2220,28 +2361,28 @@ static int nvme_start_ctrl(NvmeCtrl *n)
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
@@ -2702,6 +2843,8 @@ static void nvme_init_state(NvmeCtrl *n)
     n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
     n->starttime_ms = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
+    n->iocscs[0] = 1 << NVME_IOCS_NVM;
+    n->features.iocsci = 0;
 }
 
 int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
@@ -2907,6 +3050,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
+    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_CSI);
     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_ADMIN_ONLY);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
@@ -2966,6 +3110,11 @@ static void nvme_exit(PCIDevice *pci_dev)
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
index cab9913b1f2d..c8181511e077 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -47,10 +47,12 @@ pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize,
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


