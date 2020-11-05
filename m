Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E30C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A6B2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fzl8eF9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A6B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVW6-00083u-By
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPW-0007je-Uj; Wed, 04 Nov 2020 21:54:03 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPU-0002ZQ-I5; Wed, 04 Nov 2020 21:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544840; x=1636080840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ioG8CtacGXPm8N0F0AXEBY1dx1hdRzuXtXfPGQ3KeOw=;
 b=Fzl8eF9vQKZg4otukvW6B+v+2CysLOb4RH4ClDItiNM/K1DxYK/aaXf9
 LN31+isv4zeoQIOdNzHEqQLa25z2sU9oindx8vp+udKfmut9156caeC9c
 y9kH4qNAca1HeKPwS7O6YYgJTETcJBt1rGlBRZ5xqI0Sgkl3PcZitbtK3
 YoLBe6WKYKzVROt9+50ecrZ80rkUQy2dAvbyoor/yNjQcdbIiD1pnCO7J
 fHUaHHobRY8WXTDc3HGWzRltpdIhlj3QbJShM8TTwgeeRIQXCIklUwXym
 BDC9bHQYdj3OPW7OzTnph+CDdbrNN7Wh2x171ZldZnImQss6LavMspPpD w==;
IronPort-SDR: bWwhf8qg8KJS6PIwpNgaDu+yV9UJRigfMv4LnbKYOniyjCHFoNPkG9cQs8VHtGR/BHgiX9r45T
 mc05vVq2WmIlOjW9MKBW/CRbyHhqZ5cqzsGRlYaW8d5yU02lOngxSot4x4IiDwB08wTv78vKX5
 ggiQwrNbEFRHkDsKnp/DUyPbjErCECsTnwYnZQlEiicRaWSo7dn/E+j3Ig+pa6KlD7f1Ciacfs
 oylVX/CvxQIGDhOfvp6tZ9vGJ7otymhmXlvpCFBI0OeG8b1ymBwxYuYvvqc1e601RcYKmM/Oum
 KYY=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335140"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:53:59 +0800
IronPort-SDR: GlFtjutU2YW+MV7J1jUpoEakXc6D4U6Qt95rQu4WMuTs2DlbLFo8oI3wWCd2GDTEqLQHqaSXoc
 A6XsyoW5UAL1IHWSK64oNSOIdsmHPjcPMgMUv0hiZvKHfrpVIwtVK0fngPFTNpn3ax1jH+akBp
 LMTnnIz+82V9keac+sSw/6ncDZxWiWiuHXlBYjQr+voneHTx0Fps9ijCq04b5c/caumxF+KTwe
 9q3+AVzN0psc5UknXsCq0hO2owa3GIAgigXtYMFn8dm1ruDn/a3Kv8Pcqk52s9PSmn0YiEqrAV
 pwe4aIyFYrEpHrURPNbiZFQ1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:40:06 -0800
IronPort-SDR: dFf0AT9CtFO/pXpTqzvEVvDot0BPNRSMQpTKJeUo0fmzeHw5aMXLG31/7VZSUcSU6SPFBI497w
 2ddlWfa7/Ai//9adDC7YXk0/EBWc++HZFZDcZUYNO6UYe3gkq/fEjjgfb0nbaRd5oZcqkDx+Rr
 7c37FI8bYVJQEgdds4bIXqV+/+2x0hWk93QqOlZKasubqN0YK4SFaV0UU3Wx0nzq3Rubar3zWX
 RQpIOjlK1vEROklJ7Xeej6U9S6bEI/sfghggeHvzLHoSmovVlM19liC75yDFh6PvKLdH4GXESf
 FKI=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:53:57 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 06/12] hw/block/nvme: Support allocated CNS command variants
Date: Thu,  5 Nov 2020 11:53:36 +0900
Message-Id: <20201105025342.9037-7-dmitry.fomichev@wdc.com>
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
 hw/block/nvme-ns.h   |  1 +
 include/block/nvme.h | 20 +++++++++++--------
 hw/block/nvme-ns.c   |  1 +
 hw/block/nvme.c      | 46 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 49 insertions(+), 19 deletions(-)

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
diff --git a/include/block/nvme.h b/include/block/nvme.h
index af23514713..394db19022 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -806,14 +806,18 @@ typedef struct QEMU_PACKED NvmePSD {
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
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bb82dd9975..7495cdb5ef 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1236,6 +1236,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint32_t trans_len;
     NvmeNamespace *ns;
     time_t current_ms;
+    int i;
 
     if (off >= sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1246,10 +1247,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         if (!ns) {
             return NVME_INVALID_NSID | NVME_DNR;
         }
-        nvme_set_blk_stats(ns, &stats);
     } else {
-        int i;
-
         for (i = 1; i <= n->num_namespaces; i++) {
             ns = nvme_ns(n, i);
             if (!ns) {
@@ -1552,7 +1550,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1569,11 +1568,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
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
@@ -1590,6 +1594,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
     }
@@ -1597,7 +1605,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1627,6 +1636,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid <= min_nsid) {
             continue;
         }
+        if (only_active && !ns->attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1636,7 +1648,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1667,6 +1680,9 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid <= min_nsid) {
             continue;
         }
+        if (only_active && !ns->attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1740,17 +1756,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+         /* fall through */
+    case NVME_ID_CNS_NS_PRESENT:
+        return nvme_identify_ns(n, req, true);
     case NVME_ID_CNS_CS_NS:
-        return nvme_identify_ns_csi(n, req);
+         /* fall through */
+    case NVME_ID_CNS_CS_NS_PRESENT:
+        return nvme_identify_ns_csi(n, req, true);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_CS_CTRL:
         return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+         /* fall through */
+    case NVME_ID_CNS_NS_PRESENT_LIST:
+        return nvme_identify_nslist(n, req, true);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist_csi(n, req);
+         /* fall through */
+    case NVME_ID_CNS_CS_NS_PRESENT_LIST:
+        return nvme_identify_nslist_csi(n, req, true);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
     case NVME_ID_CNS_IO_COMMAND_SET:
-- 
2.21.0


