Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762ACC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9241120B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241120B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYYn-0004Q1-Ev
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7P-0004Sl-SJ; Thu, 24 Sep 2020 16:45:31 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7N-0007k4-3T; Thu, 24 Sep 2020 16:45:31 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 147A458050E;
 Thu, 24 Sep 2020 16:45:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=eMFL+KloNOKMc
 UMKk25g1WoQY0r3uhy8qMNoTTEz55k=; b=KJEmn/BVb4t2WjPhC+SPrSsrNT2ec
 D+bVJ9qPrxkqZ1wvIVBq/qKWnBhmNCk4330PnDPBuR5Hwx3/ymf31zslqnx+OPar
 m1/ivZg4830Bsf7QF/+BtW1hB+29qOOugL4GpSQOEs3UGb6nH36EHaXma/CYMCX6
 4YBSeBflQ5zgIkBtzHFhuz0+qQcNgZij0xtmlo2sENaOcVa/Fa7wlo2YCMAZRwxW
 m8EwZQbqZtVvvka4+PzyLXEDSejxOMfVy2if9ZX41yRPuCkimAJq/+6jJ/YlJgRr
 HcNACwmV4Z4dHNV5WiI6kXaI6Vqp+iN7aPmgZKfZBKKyTeLWAq3eKtjbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=eMFL+KloNOKMcUMKk25g1WoQY0r3uhy8qMNoTTEz55k=; b=nObfYEDF
 3sowoWCAOTgz+is0EUKOVhIs+UQsM6YQgHbPLcr3SqoWcGRL5DFcZhc2cG+8dz6+
 TIknZ4wzCQkhis0OwfNoNTC0aUPY1nuuBjCZTSaJgWjQ92taiCk1snIUjMeRDTEP
 q4S21p1QeLiiI9KvQ4QY2hT7XFx7n9+aFnkjKyor/UCx+PY0iN6Kygw28Pl7GSWR
 pFOa0AFlZnBCuJF/o0VrmRB8mM4/LOrhbADs0PbixtfPfB4s4ROW9EIM5ziLyp1D
 APr4cPlLhmT6ffLpfjme2UmQG1jThBU7+Zg6sDovNeN1F17LXdvvJFTsonl5o4e7
 FqfD9fT3ihmF8w==
X-ME-Sender: <xms:ZwVtX0kqELkC8MxX5PfblUQJYp5MJXK-HPcaTSdL-Iy4CY-6E98p9g>
 <xme:ZwVtXz2zIeOsure-AHfkZro085pWRk6O5DP35NjqL_NAIOcoALwFsThaMScT-yFIr
 ghTmlPrj40ENNVdYnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeekudehfeethfdvvdegieffheekueeghefhudfghffhhfevjeejffeuhedugedu
 udenucffohhmrghinhepuhhtihhlihiirghtihhonhdrmhgrphenucfkphepkedtrdduie
 ejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ZwVtXyp3_hWGiPZMzODK_qtgsXs3d8GsPBi2OII7rBZaPbkHvT6iIA>
 <xmx:ZwVtXwnlA4hftWzLHPtaVjc5O2iaelBj079RxYRwYzU_snogocyYMQ>
 <xmx:ZwVtXy1f_pdD1kN0cspQBucv8zSVd2tuFczpCtGjPzocP9xClPZihw>
 <xmx:ZwVtX--XZT54hkzolG7gLVQHKxymO4cW8n4gHRlgFuUhEFN91A6qSg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E53EB3064682;
 Thu, 24 Sep 2020 16:45:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] hw/block/nvme: add support for dulbe and block
 utilization tracking
Date: Thu, 24 Sep 2020 22:45:06 +0200
Message-Id: <20200924204516.1881843-7-its@irrelevant.dk>
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

This adds support for reporting the Deallocated or Unwritten Logical
Block error (DULBE). This requires tracking the allocated/deallocated
status of all logical blocks.

Introduce a bitmap that does this. The bitmap is persisted on the new
'pstate' blockdev that is associated with a namespace. If no such drive
is attached, the controller will not indicate support for DULBE.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/nvme.txt   |   7 +++
 hw/block/nvme-ns.h    |  13 +++++
 include/block/nvme.h  |   5 ++
 hw/block/nvme-ns.c    | 110 ++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.c       | 113 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/trace-events |   2 +
 6 files changed, 247 insertions(+), 3 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 438ca50d698c..9a5c67f10b5d 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -12,6 +12,13 @@ nvme-ns Options
      namespace. It is specified in terms of a power of two. Only values between
      9 and 12 (both inclusive) are supported.
 
+  `pstate`; This parameter specifies another blockdev to be used for storing
+     persistent state such as logical block allocation tracking. Adding this
+     parameter enables various optional features of the device.
+
+       -drive id=pstate,file=pstate.img,format=raw
+       -device nvme-ns,pstate=pstate,...
+
 
 Reference Specifications
 ------------------------
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 78b0d1a00672..51141796909f 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,7 +31,20 @@ typedef struct NvmeNamespace {
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
index 576c7486f45b..9a63004c000a 100644
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
@@ -45,6 +72,67 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->nuse = id_ns->ncap;
 }
 
+static int nvme_ns_setup_blk_pstate(NvmeNamespace *ns, Error **errp)
+{
+    BlockBackend *blk = ns->pstate.blk;
+    uint64_t perm, shared_perm;
+    ssize_t len;
+    size_t pstate_len;
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
+    pstate_len = ROUND_UP(DIV_ROUND_UP(nvme_ns_nlbas(ns), 8),
+                          BDRV_SECTOR_SIZE);
+
+    len = blk_getlength(blk);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "could not determine pstate size");
+        return len;
+    }
+
+    unsigned long *map = bitmap_new(nvme_ns_nlbas(ns));
+    ns->pstate.utilization.offset = 0;
+
+    if (!len) {
+        ret = nvme_blk_truncate(blk, pstate_len, errp);
+        if (ret < 0) {
+            return ret;
+        }
+
+        ns->pstate.utilization.map = map;
+    } else {
+        if (len != pstate_len) {
+            error_setg(errp, "pstate size mismatch "
+                "(expected %zd bytes; was %zu bytes)",
+                pstate_len, len);
+            return -1;
+        }
+
+        ret = blk_pread(blk, 0, map, pstate_len);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "could not read pstate");
+            return ret;
+        }
+#ifdef HOST_WORDS_BIGENDIAN
+        ns->pstate.utilization.map = bitmap_new(nvme_ns_nlbas(ns));
+        bitmap_from_le(ns->pstate.utilization.map, map, nvme_ns_nlbas(ns));
+#else
+        ns->pstate.utilization.map = map;
+#endif
+
+        return 0;
+    }
+
+    return 0;
+}
+
 static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 {
     if (!blkconf_blocksizes(&ns->blkconf, errp)) {
@@ -96,6 +184,19 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
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
@@ -106,11 +207,19 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
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
@@ -131,6 +240,7 @@ static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
+    DEFINE_PROP_DRIVE("pstate", NvmeNamespace, pstate.blk),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 795c7e7c529f..b16e089bda80 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -105,6 +105,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
     [NVME_TEMPERATURE_THRESHOLD]    = NVME_FEAT_CAP_CHANGE,
+    [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
     [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
     [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
     [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
@@ -888,6 +889,61 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
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
+    int nlongs, first;
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
+    nlongs = BITS_TO_LONGS(nlb) + 1;
+    first = slba / BITS_PER_LONG;
+    offset = ns->pstate.utilization.offset + first * sizeof(unsigned long);
+    src = ns->pstate.utilization.map;
+
+#ifdef HOST_WORDS_BIGENDIAN
+    map = g_new(nlongs, sizeof(unsigned long));
+    for (int i = first; i < first + nlongs; i++) {
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
+    ret = blk_pwrite(ns->pstate.blk, offset, &map[first],
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
@@ -1006,6 +1062,7 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     size_t len = nvme_l2b(ns, nlb);
 
+    bool is_write = nvme_req_is_write(req);
     uint16_t status;
 
     trace_pci_nvme_rwz(nvme_cid(req), nvme_io_opc_str(rw->opcode),
@@ -1017,6 +1074,16 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1030,12 +1097,18 @@ static uint16_t nvme_rwz(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1638,6 +1711,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
+
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1708,6 +1783,18 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1780,7 +1867,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
+    NvmeNamespace *ns = NULL;
 
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -1847,6 +1934,26 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
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


