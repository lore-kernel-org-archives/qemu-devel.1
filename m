Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4095C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B722076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JfqwQDgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B722076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKMK-0000kf-Vh
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDx-00060p-LZ; Thu, 29 Oct 2020 22:33:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDv-0006dn-4y; Thu, 29 Oct 2020 22:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025182; x=1635561182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d314ib4hspwnmoqEeUQZZ7DJ78AQXSVepnrOba+JKFQ=;
 b=JfqwQDglxUdIj9rje7e6pmHpGYMuaYcdJFw32FBpL6BiMSfDKdvm3xB1
 sgVWOK0OCya75c6sBE1AOg5iOtCLlcxDGlCtV//6Vw1PrVVh95ltDJyOS
 HTQCUq5b6gfmQOg/1Rt93CsNYfDSWwnGrrTFB5WARzE+gfHuOusCRU96J
 NqizK9a0441a+ayUf6qeRlv9LEklNyJA75CeREMvfg9u40OL1ec5/FnBF
 LP/NQ5bp2WNNa8y01QZIm8LR9J+ETDrgSWltucQNdDg3L4sSRYhRswYZo
 Oh1qNgvLSmpa4RLW8A9hph0u1jfqLPjK0xgmMk6WMKbVQtS+EoZnotjaa A==;
IronPort-SDR: 84X6mZ9+HzDIrMGZ4D4jMEEJJ4UaeyIYaNu9YqnvCJ3qBVN5iHz1axb+nbkJFiciMTplz++HwA
 mWlZC+fejMAuDJMhZurWBjxhkR1JZXwdbGSqdMOcNEEScBYN6EDEMyEDFvDCzccbeZ+0SIYMWS
 Ab/GcS7XY36wtywJE1DUrRGDeUND5Lp18y+Rg7C5hJGs7SCgKN/DSFe6shNoJKR8ovSgDbwLE5
 KFKTOjsihiuko3REOVO+E+OjgXb9T9QMpMQ9yV2db/OY4qmB1GLsGEtTHT4BLMrP95cSfVe1wt
 /z8=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748081"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:33:01 +0800
IronPort-SDR: bhNGC/PS/xfaJc/5v45xp5p61uiUhsE3YnMEN46HpWSj+aFmvxrzoWje258tG22MvwghPmFT1g
 aSTqEixbZ0lKbrHamrrIsRshODz76zhv1xMyt5TTmHRBsjeT/PmyiQgfa1l/PEWfICUQXyhPtK
 sNulnw6QpAbv91j29sMXq65ccZe1sKjsNIj5HCYZR8MOlAipGH6ywGv7XKZBXdzCmAxx5IjcGX
 36Jl2fwikJ9L2oEegd0p1rbnd3tFyhGjYsYBSDXagC4F3d2Ox9PuTFHBW+t6Q1ROFuwxesPDdA
 83IpU1m9V8qKHaxFoTeg+fsJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:18:06 -0700
IronPort-SDR: M6c6EHgPNdyABrgbuB6eREJm2ZIJzijR0C4rvzOxffNVyiCs9T3SGiHDKMZGCGsRMDSe62Qak9
 Xm8ldDhljI/HUYxn9u0Ef4mic+WIJCKBkK+vAMNARnFdHiE2dqMvajasmf/86Crj830Av4Fw0I
 En8im+pFlEofGqzz1PRTzGVIJJgfUIl5FQnJSvx3wqq8vedr5nVBIoY3wgE2DBTov8lPmf1ckt
 o4GysTyPdly91TbWsKZFYJuje3FNB4RJNwClgt9uzBt02Rwp5cY5EwoPWk0oAWmF1ZnStzsOva
 siE=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:33:01 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 06/11] hw/block/nvme: Support allocated CNS command variants
Date: Fri, 30 Oct 2020 11:32:37 +0900
Message-Id: <20201030023242.5204-7-dmitry.fomichev@wdc.com>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Many CNS commands have "allocated" command variants. These include
a namespace as long as it is allocated, that is a namespace is
included regardless if it is active (attached) or not.

While these commands are optional (they are mandatory for controllers
supporting the namespace attachment command), our QEMU implementation
is more complete by actually providing support for these CNS values.

However, since our QEMU model currently does not support the namespace
attachment command, these new allocated CNS commands will return the
same result as the active CNS command variants.

In NVMe, a namespace is active if it exists and is attached to the
controller.

Add a new Boolean namespace flag, "attached", to provide the most
basic namespace attachment support. The default value for this new
flag is true. Also, implement the logic in the new CNS values to
include/exclude namespaces based on this new property. The only thing
missing is hooking up the actual Namespace Attachment command opcode,
which will allow a user to toggle the "attached" flag per namespace.

The reason for not hooking up this command completely is because the
NVMe specification requires the namespace management command to be
supported if the namespace attachment command is supported.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme-ns.c   |  1 +
 hw/block/nvme-ns.h   |  1 +
 hw/block/nvme.c      | 68 ++++++++++++++++++++++++++++++++++++--------
 include/block/nvme.h | 20 +++++++------
 4 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index c0362426cc..e191ef9be0 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -42,6 +42,7 @@ static void nvme_ns_init(NvmeNamespace *ns)
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
     ns->csi = NVME_CSI_NVM;
+    ns->attached = true;
 
     /* no thin provisioning */
     id_ns->ncap = id_ns->nsze;
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index d795e44bab..2d9cd29d07 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -31,6 +31,7 @@ typedef struct NvmeNamespace {
     int64_t      size;
     NvmeIdNs     id_ns;
     const uint32_t *iocs;
+    bool         attached;
     uint8_t      csi;
 
     NvmeNamespaceParams params;
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d9e9fd264c..7b3eafad03 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1084,6 +1084,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     if (unlikely(!req->ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    if (!req->ns->attached) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
 
     if (!(req->ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
@@ -1245,6 +1248,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint32_t trans_len;
     NvmeNamespace *ns;
     time_t current_ms;
+    int i;
 
     if (off >= sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1255,15 +1259,18 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         if (!ns) {
             return NVME_INVALID_NSID | NVME_DNR;
         }
-        nvme_set_blk_stats(ns, &stats);
+        if (ns->attached) {
+            nvme_set_blk_stats(ns, &stats);
+        }
     } else {
-        int i;
-
         for (i = 1; i <= n->num_namespaces; i++) {
             ns = nvme_ns(n, i);
             if (!ns) {
                 continue;
             }
+            if (!ns->attached) {
+                continue;
+            }
             nvme_set_blk_stats(ns, &stats);
         }
     }
@@ -1560,7 +1567,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1577,11 +1585,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1598,6 +1611,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
     }
@@ -1605,7 +1622,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1635,6 +1653,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid <= min_nsid) {
             continue;
         }
+        if (only_active && !ns->attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1644,7 +1665,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1675,6 +1697,9 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid <= min_nsid) {
             continue;
         }
+        if (only_active && !ns->attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1748,17 +1773,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+        return nvme_identify_ns(n, req, true);
     case NVME_ID_CNS_CS_NS:
-        return nvme_identify_ns_csi(n, req);
+        return nvme_identify_ns_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT:
+        return nvme_identify_ns(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT:
+        return nvme_identify_ns_csi(n, req, false);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_CS_CTRL:
         return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+        return nvme_identify_nslist(n, req, true);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist_csi(n, req);
+        return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT_LIST:
+        return nvme_identify_nslist(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT_LIST:
+        return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
     case NVME_ID_CNS_IO_COMMAND_SET:
@@ -1831,6 +1864,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1862,7 +1896,11 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
             return NVME_INVALID_NSID | NVME_DNR;
         }
 
-        if (!nvme_ns(n, nsid)) {
+        ns = nvme_ns(n, nsid);
+        if (!ns) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        if (!ns->attached) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
     }
@@ -2004,6 +2042,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
             if (unlikely(!ns)) {
                 return NVME_INVALID_FIELD | NVME_DNR;
             }
+            if (!ns->attached) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
         }
     } else if (nsid && nsid != NVME_NSID_BROADCAST) {
         if (!nvme_nsid_valid(n, nsid)) {
@@ -2051,6 +2092,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
             if (!ns) {
                 continue;
             }
+            if (!ns->attached) {
+                continue;
+            }
 
             if (!(dw11 & 0x1) && blk_enable_write_cache(ns->blkconf.blk)) {
                 blk_flush(ns->blkconf.blk);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bcf695c646..3653b4aefc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -805,14 +805,18 @@ typedef struct QEMU_PACKED NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum NvmeIdCns {
-    NVME_ID_CNS_NS                = 0x00,
-    NVME_ID_CNS_CTRL              = 0x01,
-    NVME_ID_CNS_NS_ACTIVE_LIST    = 0x02,
-    NVME_ID_CNS_NS_DESCR_LIST     = 0x03,
-    NVME_ID_CNS_CS_NS             = 0x05,
-    NVME_ID_CNS_CS_CTRL           = 0x06,
-    NVME_ID_CNS_CS_NS_ACTIVE_LIST = 0x07,
-    NVME_ID_CNS_IO_COMMAND_SET    = 0x1c,
+    NVME_ID_CNS_NS                    = 0x00,
+    NVME_ID_CNS_CTRL                  = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST        = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST         = 0x03,
+    NVME_ID_CNS_CS_NS                 = 0x05,
+    NVME_ID_CNS_CS_CTRL               = 0x06,
+    NVME_ID_CNS_CS_NS_ACTIVE_LIST     = 0x07,
+    NVME_ID_CNS_NS_PRESENT_LIST       = 0x10,
+    NVME_ID_CNS_NS_PRESENT            = 0x11,
+    NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
+    NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
+    NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
-- 
2.21.0


