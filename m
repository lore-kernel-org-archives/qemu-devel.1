Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EBCC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F166420773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F166420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNP3O-0006e2-Md
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuD-0000af-Sm; Tue, 29 Sep 2020 19:19:33 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOuA-00008m-Vn; Tue, 29 Sep 2020 19:19:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 1D437EB1;
 Tue, 29 Sep 2020 19:19:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=WVNRKZuD6uQ6i
 UCjGJsXw+ffVEycdwrhsJ8OcakOO1M=; b=eVZfvIY4rrir49khWJv6QNgiYByxT
 hS6t1tVv9Mbjj1NscqK1xgOLNiLBLU8y7Oy/YPgUhza8Rlu68zYIOZAh+wL+QAGh
 gAOUn60qaMPJEeHWb01kTOyFrmcsGoVI564arGe5AAGJfhaYuNxlzJXcBiBN4eDv
 AbahD0jQTg39mOjG/lPobzWxiDm0XHVOAsmDMJkHrEMSQBONAzFJb/GjdJ0CwWek
 XZFnVxZ99hrEOD4Dd6nhFBMu2jhuoH8hNbz8jmUI3uAwWDZOKiqYau7ylTnAFWtg
 FGrIlmyKGmPe62kmfCKQC5N9OOzHIHsFDeMHagDngDchP5HbYZFweOSRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=WVNRKZuD6uQ6iUCjGJsXw+ffVEycdwrhsJ8OcakOO1M=; b=odTsv3n6
 BFmv9Hngps2ceIxjtFFoevE88WVPspDq8CSsf25bY5rf4eYYvbBYP01RZb5Uj1lo
 zesF8bi74ldyQxHIoYy6MEjJMk87FM+5C9xFddomIA+DvaBiOsx2KrH/M18t2Q2p
 Ml037pqxebbAGwiTdRMhNe4Ef5VVagkxbym3DygePSAvgC1l62ORcR4ChJWuhg4R
 ddBaE2ObTzSjl7vFFr7h8jULxNHq9LRLJZZlKGZG5HIGdBYELVeY7td/7nVsoLDx
 TY/RA43REjGvBNdh/u1M55bswn0/VzcPkPysKfsdi5VaP/A648VpndJt9ix8zyDe
 gfL76qVRUnPZWg==
X-ME-Sender: <xms:AMFzX2ovZjpXpjCWFTOenBtB8yZgMcJXQMQuc6s-_HuKmJzzlwqJtw>
 <xme:AMFzX0qIyZUpaOagpDxV2djWXEnCut6NZ9SG_AiJne5a4TX3LJSegwOf2gP1EJP8q
 0ifM7OH9uUXd9jwDaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepkeduheeftefhvddvgeeiffehkeeugeehhfdugffhhffhveejjeffueehudeguddu
 necuffhomhgrihhnpehuthhilhhiiigrthhiohhnrdhmrghpnecukfhppeektddrudeije
 drleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:AMFzX7Pb2Z6tAeTHCgR-quBe51fcqFdgY685TS2TxMtLUqRo3E_E0g>
 <xmx:AMFzX17JDGadk9FQmXnrJdz0nho0dcJ_qlmw5XzrXypJ1Zw0j93Txw>
 <xmx:AMFzX171R1Oxre-vSYeeBBCDEkAtJVN2dev2NBasUW5uKwM_skX5Bg>
 <xmx:AMFzXzRcNoJHgaJb-Kb05Eft2A2ribapwjTRhaPp3el31s71B8zbe6J1Eqc>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F269D328005D;
 Tue, 29 Sep 2020 19:19:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/14] hw/block/nvme: add support for dulbe and block
 utilization tracking
Date: Wed, 30 Sep 2020 01:19:09 +0200
Message-Id: <20200929231917.433586-7-its@irrelevant.dk>
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

This adds support for reporting the Deallocated or Unwritten Logical
Block error (DULBE). This requires tracking the allocated/deallocated
status of all logical blocks.

Introduce a bitmap that does this. The bitmap is persisted on the new
'pstate' blockdev that is associated with a namespace. If no such drive
is attached, the controller will not indicate support for DULBE.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |  19 +++++
 hw/block/nvme-ns.h    |  32 ++++++++
 include/block/nvme.h  |   5 ++
 hw/block/nvme-ns.c    | 186 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.c       | 130 ++++++++++++++++++++++++++++-
 hw/block/trace-events |   2 +
 6 files changed, 371 insertions(+), 3 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 438ca50d698c..6d00ac064998 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -12,6 +12,25 @@ nvme-ns Options
      namespace. It is specified in terms of a power of two. Only values between
      9 and 12 (both inclusive) are supported.
 
+  `pstate`; This parameter specifies another blockdev to be used for storing
+     persistent state such as logical block allocation tracking. Adding this
+     parameter enables various optional features of the device.
+
+       -drive id=pstate,file=pstate.img,format=raw
+       -device nvme-ns,pstate=pstate,...
+
+     To reset (or initialize) state, the blockdev image should be of zero size:
+
+       qemu-img create -f raw pstate.img 0
+
+     The image will be intialized with a file format header and truncated to
+     the required size.
+
+     If the pstate given is of non-zero size, it will be assumed to contain
+     previous saved state and will be checked for consistency. If any stored
+     values (such as lbads) differs from those specified for the nvme-ns
+     device an error is produced.
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 78b0d1a00672..0ad83910dde9 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -19,6 +19,20 @@
 #define NVME_NS(obj) \
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
 
+#define NVME_PSTATE_MAGIC ((0x00 << 24) | ('S' << 16) | ('P' << 8) | 'N')
+#define NVME_PSTATE_V1 1
+
+typedef struct NvmePstateHeader {
+    uint32_t magic;
+    uint32_t version;
+
+    int64_t  blk_len;
+
+    uint8_t  lbads;
+
+    uint8_t  rsvd17[4079];
+} QEMU_PACKED NvmePstateHeader;
+
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     uint8_t  lbads;
@@ -31,7 +45,20 @@ typedef struct NvmeNamespace {
     int64_t      size;
     NvmeIdNs     id_ns;
 
+    struct {
+        BlockBackend *blk;
+
+        struct {
+            unsigned long *map;
+            int64_t       offset;
+        } utilization;
+    } pstate;
+
     NvmeNamespaceParams params;
+
+    struct {
+        uint32_t err_rec;
+    } features;
 } NvmeNamespace;
 
 static inline uint32_t nvme_nsid(NvmeNamespace *ns)
@@ -72,4 +99,9 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
 
+static inline void _nvme_ns_check_size(void)
+{
+    QEMU_BUILD_BUG_ON(sizeof(NvmePstateHeader) != 4096);
+}
+
 #endif /* NVME_NS_H */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 999b4f8ae0d4..abd49d371e63 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -683,6 +683,7 @@ enum NvmeStatusCodes {
     NVME_E2E_REF_ERROR          = 0x0284,
     NVME_CMP_FAILURE            = 0x0285,
     NVME_ACCESS_DENIED          = 0x0286,
+    NVME_DULB                   = 0x0287,
     NVME_MORE                   = 0x2000,
     NVME_DNR                    = 0x4000,
     NVME_NO_COMPLETE            = 0xffff,
@@ -898,6 +899,9 @@ enum NvmeIdCtrlLpa {
 #define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
 #define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
 
+#define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
+#define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                = 0x1,
     NVME_POWER_MANAGEMENT           = 0x2,
@@ -1018,6 +1022,7 @@ enum NvmeNsIdentifierType {
 
 
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
+#define NVME_ID_NS_NSFEAT_DULBE(nsfeat)     ((nsfeat >> 2) & 0x1)
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
 #define NVME_ID_NS_MC_SEPARATE(mc)          ((mc >> 1) & 0x1)
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 576c7486f45b..5e24b1a5dacd 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -25,9 +25,36 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 
+#include "trace.h"
+
 #include "nvme.h"
 #include "nvme-ns.h"
 
+static int nvme_blk_truncate(BlockBackend *blk, size_t len, Error **errp)
+{
+    int ret;
+    uint64_t perm, shared_perm;
+
+    blk_get_perm(blk, &perm, &shared_perm);
+
+    ret = blk_set_perm(blk, perm | BLK_PERM_RESIZE, shared_perm, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = blk_truncate(blk, len, false, PREALLOC_MODE_OFF, 0, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = blk_set_perm(blk, perm, shared_perm, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static void nvme_ns_init(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
@@ -45,6 +72,143 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->nuse = id_ns->ncap;
 }
 
+static int nvme_ns_pstate_init(NvmeNamespace *ns, Error **errp)
+{
+    BlockBackend *blk = ns->pstate.blk;
+    NvmePstateHeader header;
+    uint64_t nlbas = nvme_ns_nlbas(ns);
+    size_t bitmap_len, pstate_len;
+    int ret;
+
+    ret = nvme_blk_truncate(blk, sizeof(NvmePstateHeader), errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    header = (NvmePstateHeader) {
+        .magic   = cpu_to_le32(NVME_PSTATE_MAGIC),
+        .version = cpu_to_le32(NVME_PSTATE_V1),
+        .blk_len = cpu_to_le64(ns->size),
+        .lbads   = ns->params.lbads,
+    };
+
+    ret = blk_pwrite(blk, 0, &header, sizeof(header), 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not write pstate header");
+        return ret;
+    }
+
+    bitmap_len = DIV_ROUND_UP(nlbas, sizeof(unsigned long));
+    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len,
+                          BDRV_SECTOR_SIZE);
+
+    ret = nvme_blk_truncate(blk, pstate_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ns->pstate.utilization.map = bitmap_new(nlbas);
+
+    return 0;
+}
+
+static int nvme_ns_pstate_load(NvmeNamespace *ns, size_t len, Error **errp)
+{
+    BlockBackend *blk = ns->pstate.blk;
+    NvmePstateHeader header;
+    uint64_t nlbas = nvme_ns_nlbas(ns);
+    size_t bitmap_len, pstate_len;
+    unsigned long *map;
+    int ret;
+
+    ret = blk_pread(blk, 0, &header, sizeof(header));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "could not read pstate header");
+        return ret;
+    }
+
+    if (le32_to_cpu(header.magic) != NVME_PSTATE_MAGIC) {
+        error_setg(errp, "invalid pstate header");
+        return -1;
+    } else if (le32_to_cpu(header.version) > NVME_PSTATE_V1) {
+        error_setg(errp, "unsupported pstate version");
+        return -1;
+    }
+
+    if (le64_to_cpu(header.blk_len) != ns->size) {
+        error_setg(errp, "invalid drive size");
+        return -1;
+    }
+
+    if (header.lbads != ns->params.lbads) {
+        error_setg(errp, "lbads parameter inconsistent with pstate "
+                   "(pstate %u; parameter %u)",
+                   header.lbads, ns->params.lbads);
+        return -1;
+    }
+
+    bitmap_len = DIV_ROUND_UP(nlbas, sizeof(unsigned long));
+    pstate_len = ROUND_UP(sizeof(NvmePstateHeader) + bitmap_len,
+                          BDRV_SECTOR_SIZE);
+
+    if (len != pstate_len) {
+        error_setg(errp, "pstate size mismatch "
+                   "(expected %zd bytes; was %zu bytes)",
+                   pstate_len, len);
+        return -1;
+    }
+
+    map = bitmap_new(nlbas);
+    ret = blk_pread(blk, ns->pstate.utilization.offset, map, bitmap_len);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "could not read pstate allocation bitmap");
+        g_free(map);
+        return ret;
+    }
+
+#ifdef HOST_WORDS_BIGENDIAN
+    ns->pstate.utilization.map = bitmap_new(nlbas);
+    bitmap_from_le(ns->pstate.utilization.map, map, nlbas);
+    g_free(map);
+#else
+    ns->pstate.utilization.map = map;
+#endif
+
+    return 0;
+
+}
+
+static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
+{
+    BlockBackend *blk = ns->pstate.blk;
+    uint64_t perm, shared_perm;
+    ssize_t len;
+    int ret;
+
+    perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
+    shared_perm = BLK_PERM_ALL;
+
+    ret = blk_set_perm(blk, perm, shared_perm, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ns->pstate.utilization.offset = sizeof(NvmePstateHeader);
+
+    len = blk_getlength(blk);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "could not determine pstate size");
+        return len;
+    }
+
+    if (!len) {
+        return nvme_ns_pstate_init(ns, errp);
+    }
+
+    return nvme_ns_pstate_load(ns, len, errp);
+}
+
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
     if (!blkconf_blocksizes(&ns->blkconf, errp)) {
@@ -96,6 +260,19 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     nvme_ns_init(ns);
+
+    if (ns->pstate.blk) {
+        if (nvme_ns_setup_blk_pstate(ns, errp)) {
+            return -1;
+        }
+
+        /*
+         * With a pstate file in place we can enable the Deallocated or
+         * Unwritten Logical Block Error feature.
+         */
+        ns->id_ns.nsfeat |= 0x4;
+    }
+
     if (nvme_register_namespace(n, ns, errp)) {
         return -1;
     }
@@ -106,11 +283,19 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 void nvme_ns_drain(NvmeNamespace *ns)
 {
     blk_drain(ns->blkconf.blk);
+
+    if (ns->pstate.blk) {
+        blk_drain(ns->pstate.blk);
+    }
 }
 
 void nvme_ns_flush(NvmeNamespace *ns)
 {
     blk_flush(ns->blkconf.blk);
+
+    if (ns->pstate.blk) {
+        blk_flush(ns->pstate.blk);
+    }
 }
 
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
@@ -131,6 +316,7 @@ static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
+    DEFINE_PROP_DRIVE("pstate", NvmeNamespace, pstate.blk),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 795c7e7c529f..be5a0a7dfa09 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -105,6 +105,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
+    [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
@@ -888,6 +889,78 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+static inline uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
+                                        uint32_t nlb)
+{
+    uint64_t elba = slba + nlb;
+
+    if (find_next_zero_bit(ns->pstate.utilization.map, elba, slba) < elba) {
+        return NVME_DULB;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static int nvme_allocate(NvmeNamespace *ns, uint64_t slba, uint32_t nlb)
+{
+    int nlongs, idx;
+    int64_t offset;
+    unsigned long *map, *src;
+    int ret;
+
+    if (!(ns->pstate.blk && nvme_check_dulbe(ns, slba, nlb))) {
+        return 0;
+    }
+
+    trace_pci_nvme_allocate(nvme_nsid(ns), slba, nlb);
+
+    bitmap_set(ns->pstate.utilization.map, slba, nlb);
+
+    /*
+     * The bitmap is an array of unsigned longs, so calculate the index given
+     * the size of a long.
+     */
+#if HOST_LONG_BITS == 64
+    idx = slba >> 6;
+#else /* == 32 */
+    idx = slba >> 5;
+#endif
+
+    nlongs = BITS_TO_LONGS(nlb);
+
+    /* Unaligned modification (not staring at a long boundary) may modify the
+     * following long, so account for that.
+     */
+    if (((slba % BITS_PER_LONG) + nlb) > BITS_PER_LONG) {
+        nlongs += 1;
+    }
+
+    offset = ns->pstate.utilization.offset + idx * sizeof(unsigned long);
+    src = ns->pstate.utilization.map;
+
+#ifdef HOST_WORDS_BIGENDIAN
+    map = g_new(nlongs, sizeof(unsigned long));
+    for (int i = idx; i < idx + nlongs; i++) {
+# if HOST_LONG_BITS == 64
+        map[i] = bswap64(src[i]);
+# else
+        map[i] = bswap32(src[i]);
+# endif
+    }
+#else
+    map = src;
+#endif
+
+    ret = blk_pwrite(ns->pstate.blk, offset, &map[idx],
+                     nlongs * sizeof(unsigned long), 0);
+
+#ifdef HOST_WORDS_BIGENDIAN
+    g_free(map);
+#endif
+    return ret;
+}
+
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -1006,6 +1079,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     size_t len = nvme_l2b(ns, nlb);
 
+    bool is_write = nvme_req_is_write(req);
     uint16_t status;
 
     trace_pci_nvme_rwz(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1017,6 +1091,16 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
+    if (!is_write) {
+        if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
+            status = nvme_check_dulbe(ns, slba, nlb);
+            if (status) {
+                trace_pci_nvme_err_dulbe(nvme_cid(req), slba, nlb);
+                goto invalid;
+            }
+        }
+    }
+
     if (req->cmd.opcode & NVME_CMD_OPCODE_DATA_TRANSFER_MASK) {
         status = nvme_check_mdts(n, len);
         if (status) {
@@ -1030,12 +1114,18 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
         }
     }
 
+    if (is_write) {
+        if (nvme_allocate(ns, slba, nlb) < 0) {
+            status = NVME_INTERNAL_DEV_ERROR;
+            goto invalid;
+        }
+    }
+
     return nvme_do_aio(ns->blkconf.blk, nvme_l2b(ns, slba), len, req);
 
 invalid:
     block_acct_invalid(blk_get_stats(ns->blkconf.blk),
-                       nvme_req_is_write(req) ? BLOCK_ACCT_WRITE :
-                       BLOCK_ACCT_READ);
+                       is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
 
     return status;
 }
@@ -1638,6 +1728,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
+
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1708,6 +1800,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         }
 
         return NVME_INVALID_FIELD | NVME_DNR;
+    case NVME_ERROR_RECOVERY:
+        if (!nvme_nsid_valid(n, nsid)) {
+            return NVME_INVALID_NSID | NVME_DNR;
+        }
+
+        ns = nvme_ns(n, nsid);
+        if (unlikely(!ns)) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        result = ns->features.err_rec;
+        goto out;
     case NVME_VOLATILE_WRITE_CACHE:
         result = n->features.vwc;
         trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -1780,7 +1884,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
+    NvmeNamespace *ns = NULL;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -1847,6 +1951,26 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
                                NVME_LOG_SMART_INFO);
         }
 
+        break;
+    case NVME_ERROR_RECOVERY:
+        if (nsid == NVME_NSID_BROADCAST) {
+            for (int i = 1; i <= n->num_namespaces; i++) {
+                ns = nvme_ns(n, i);
+
+                if (!ns) {
+                    continue;
+                }
+
+                if (NVME_ID_NS_NSFEAT_DULBE(ns->id_ns.nsfeat)) {
+                    ns->features.err_rec = dw11;
+                }
+            }
+
+            break;
+        }
+
+        assert(ns);
+        ns->features.err_rec = dw11;
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         n->features.vwc = dw11 & 0x1;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b18056c49836..774513469274 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -42,6 +42,7 @@ pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, cons
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname '%s'"
 pci_nvme_rwz(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t len, uint64_t lba) "cid %"PRIu16" opname '%s' nsid %"PRIu32" nlb %"PRIu32" len %"PRIu64" lba 0x%"PRIx64""
 pci_nvme_rw_cb(uint16_t cid, const char *blkname) "cid %"PRIu16" blk '%s'"
+pci_nvme_allocate(uint32_t ns, uint64_t slba, uint32_t nlb) "nsid %"PRIu32" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_do_aio(uint16_t cid, uint8_t opc, const char *opname, const char *blkname, int64_t offset, size_t len) "cid %"PRIu16" opc 0x%"PRIx8" opname '%s' blk '%s' offset %"PRId64" len %zu"
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
@@ -89,6 +90,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_req_status(uint16_t cid, uint32_t nsid, uint16_t status, uint8_t opc) "cid %"PRIu16" nsid %"PRIu32" status 0x%"PRIx16" opc 0x%"PRIx8""
+pci_nvme_err_dulbe(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba 0x%"PRIx64" nlb %"PRIu32""
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_cfs(void) "controller fatal status"
-- 
2.28.0


