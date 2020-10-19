Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCCC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D450021D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 02:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eQKZ1IUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKmK-0001rd-Vx
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 22:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKk9-0008BO-6r; Sun, 18 Oct 2020 22:17:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5541069a6=dmitry.fomichev@wdc.com>)
 id 1kUKk4-0004HF-3f; Sun, 18 Oct 2020 22:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603073864; x=1634609864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZDQA7e6KniA9T/iOCXCMWEhuU3w4q61BBDAMvjGMtQ=;
 b=eQKZ1IUQmh2GqqpCqGSoXrGMwfscR2gTUhT5/zM+ZptteH08zrX0WRKx
 e0B5B8UHPAXTJefm5Rs4FjcOp9yW+DxyUfq72h0R0H9oE/RHZrzDbBy/C
 S204syweVWpwtVL1jtb7Xm6yNKRiN7sDTKJu7q7v39pK4ITLXpXtYsN8D
 EyibIW7nA1svfmOW+7cajRcw/hUm7tXUFZzxxfwxr9hLHUIot6nXOi6jm
 j7/3Pw3Z4KvaN69iVdFc8OFcJR82QXs+xniIbOENycQjb1ljN+n4wytAJ
 yvHjSkp5wB4Rrh0sWlj5h2NjVETuqTN3ncCo0UHWp3C9ptrvRp6OpnE5J Q==;
IronPort-SDR: f30/2/lDyFiMSXhZIdea3pDz2fZzhtw6mVTOh87CGWSPYJTxJr9pGr2o4f59iJbPuHjGe5JsRF
 vVHaSV9uqe3qSSpZYdBNgzsEpNAwunLiTMFtdWvSIaSGa3r1BSGecUksq8xtYivvKcMjR266/9
 LHxkaJupxC1mmKoUTrjirL72TvH5XexM6J7hf1SN8Uv58ZjQOAyI9tZJ1rFm+agdqrt6Nc8hK4
 o2vfkaHMzseA4UlIk4W2W5GWfSLUfrjo7WjNO2SlXi6eHTgf3DrLdUHhEybznKwqAcULvBtScn
 TH8=
X-IronPort-AV: E=Sophos;i="5.77,393,1596470400"; d="scan'208";a="150207959"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 10:17:41 +0800
IronPort-SDR: rvXkC2jFw5s42vE9Af79MrFvH5ZDQ6uAFN9nDEtwycQs09pdE7WXI8oEb9URBhznYdM4Tr9q/E
 4t3YVGY9YNrgMzmPFDyi373pNgp4lLjnoEj72xHy7JVkDk2QeRxjZTiO8kF0UCruRDJ22V2Nb0
 b+U9cQFMcpTTKMPf3fxAh6jzE0JQXLP5Wj5NTlQcsWhKPNlGBU5HMG85WR1RMjokyby6Hj+btZ
 d9IYenVdBVNiw5YOdpWaUZ9rkwTnLx+Vw4icqT3c4xQ/INgXPcXR2PLrsu7qzESVX5AZ4XAYyE
 ypCe3FJZSawb8tWXHsnZ+cag
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 19:03:17 -0700
IronPort-SDR: OBPIZGCIGXFRU/9++ZqNodIEPvQ6Du16CDiW9XP3NfwV/AhqDVNFgZ+2lxugjxfnUFjeFO7KYC
 jAZxbOb24QvzCsBvrgqmGe09s04lmit5P3Uh6xd8/wsAHhlqPTDBi8vUwBw4QEAldR3wWVH1dX
 oaMDPcUiXibaJ1h2EHYdG0ELH+vL6eS261siOKBdNQMNsbHodSsUCvklGOUYtuk1nfp2lbSQuc
 vLun6Fu0BqgJrCRPVqiu0on0ESSZ+Nw4I/ruG1B+mFackb1OIAFQ0DLMSGoL1Az63zT7nefbVS
 oig=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Oct 2020 19:17:39 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v7 04/11] hw/block/nvme: Support allocated CNS command variants
Date: Mon, 19 Oct 2020 11:17:19 +0900
Message-Id: <20201019021726.12048-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=5541069a6=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 22:17:33
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

CAP.CSS (together with the I/O Command Set data structure) defines
what command sets are supported by the controller.

CC.CSS (together with Set Profile) can be set to enable a subset of
the available command sets.

Even if a user configures CC.CSS to e.g. Admin only, NVM namespaces
will still be attached (and thus marked as active).
Similarly, if a user configures CC.CSS to e.g. NVM, ZNS namespaces
will still be attached (and thus marked as active).

However, any operation from a disabled command set will result in a
Invalid Command Opcode.

Add a new Boolean namespace property, "attached", to provide the most
basic namespace attachment support. The default value for this new
property is true. Also, implement the logic in the new CNS values to
include/exclude namespaces based on this new property. The only thing
missing is hooking up the actual Namespace Attachment command opcode,
which will allow a user to toggle the "attached" flag per namespace.

The reason for not hooking up this command completely is because the
NVMe specification requires the namespace management command to be
supported if the namespace attachment command is supported.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.c   |  1 +
 hw/block/nvme-ns.h   |  1 +
 hw/block/nvme.c      | 68 ++++++++++++++++++++++++++++++++++++--------
 include/block/nvme.h | 20 +++++++------
 4 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index c0362426cc..974aea33f7 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -132,6 +132,7 @@ static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
     DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
+    DEFINE_PROP_BOOL("attached", NvmeNamespace, params.attached, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index d795e44bab..d6b2808b97 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    bool     attached;
     QemuUUID uuid;
 } NvmeNamespaceParams;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ca0d0abf5c..93728e51b3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1062,6 +1062,9 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     if (unlikely(!req->ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    if (!req->ns->params.attached) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
 
     if (!(req->ns->iocs[req->cmd.opcode] & NVME_CMD_EFF_CSUPP)) {
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
@@ -1222,6 +1225,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint32_t trans_len;
     NvmeNamespace *ns;
     time_t current_ms;
+    int i;
 
     if (off >= sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1232,15 +1236,18 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         if (!ns) {
             return NVME_INVALID_NSID | NVME_DNR;
         }
-        nvme_set_blk_stats(ns, &stats);
+        if (ns->params.attached) {
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
+            if (!ns->params.attached) {
+                continue;
+            }
             nvme_set_blk_stats(ns, &stats);
         }
     }
@@ -1531,7 +1538,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1548,11 +1556,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->params.attached) {
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
@@ -1569,6 +1582,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->params.attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
     }
@@ -1576,7 +1593,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1606,6 +1624,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid < min_nsid) {
             continue;
         }
+        if (only_active && !ns->params.attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1615,7 +1636,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1639,6 +1661,9 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid < min_nsid) {
             continue;
         }
+        if (only_active && !ns->params.attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1712,17 +1737,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
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
@@ -1795,6 +1828,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
@@ -1826,7 +1860,11 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
             return NVME_INVALID_NSID | NVME_DNR;
         }
 
-        if (!nvme_ns(n, nsid)) {
+        ns = nvme_ns(n, nsid);
+        if (!ns) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        if (!ns->params.attached) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
     }
@@ -1968,6 +2006,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
             if (unlikely(!ns)) {
                 return NVME_INVALID_FIELD | NVME_DNR;
             }
+            if (!ns->params.attached) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
         }
     } else if (nsid && nsid != NVME_NSID_BROADCAST) {
         if (!nvme_nsid_valid(n, nsid)) {
@@ -2015,6 +2056,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
             if (!ns) {
                 continue;
             }
+            if (!ns->params.attached) {
+                continue;
+            }
 
             if (!(dw11 & 0x1) && blk_enable_write_cache(ns->blkconf.blk)) {
                 blk_flush(ns->blkconf.blk);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f5ac9143c4..27125c9d28 100644
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


