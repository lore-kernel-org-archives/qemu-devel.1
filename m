Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59838C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6F02098B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AqF3Wb04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6F02098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHaMa-0000c6-0Q
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 18:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaH9-0000JE-P5; Sun, 13 Sep 2020 18:15:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=518fa018e=dmitry.fomichev@wdc.com>)
 id 1kHaH5-00019x-58; Sun, 13 Sep 2020 18:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600035307; x=1631571307;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i2KGCSgBnXLmj6bypP55XarmJ95TjmhyK9TUQo2+JrM=;
 b=AqF3Wb04qDW+McdWaBgIPwgBUY1CR9D5VsB9a0CxnzdHy2xDoaXEIUtE
 klGQnGSXlG4n+DVdZYQN64b6ZPwdbgODQUOep0RavBNW5a14IOkATTwRo
 wAaun9Dsw3Ug0LpSyn5vb9hyXzT4BMFKghSOcm27cbtytwJoqfOpjbVNn
 ciVOGngH6Ry+A7oE3uow6z8d6XZ5ZoekB1DhgZB8nqKMV7y886oBlqqHF
 TJf5AXPZfoLZZiTnfCqD4OL6wZxlcjlrvSfX9AlKMikPAsYEjVIroV1+y
 88nyIU/yRpaZcXxPkWRkpcSo44DRtkelCCV0aVLXpmo98D72CWWxI1YDW A==;
IronPort-SDR: obo6dBhNjYxc0LII8tFxJ7WfrrpXmhmnY1/fCK1Ovr5anZbpbaXJig6dMKOKjRF24qepx0VsqT
 HxC7EATnfOoxUzJ5bp2KTo1/tHmzJBUcc7KX7wxd2fV9nc0l2bGe6lU6wC6HIjpO+wBWGqAthR
 sXI5RbECz4jC5CKMtWNFa8eiesDg+cPM+GXhbGVbG/CDSsvsQrSLm9ZpNSjgFV15WU7ghqN+Xg
 ovs939MdJPhxQvI237Twf/cAE85XM6CjGdz1D8Urq0VUnHMnE4mh+Cz2B20igap0XyfN/q0Ukd
 P20=
X-IronPort-AV: E=Sophos;i="5.76,423,1592841600"; d="scan'208";a="147179064"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 06:15:05 +0800
IronPort-SDR: hcxxAyI3McqQEURWJs7IABahuVR4E6mYwJsABDd9JEEc1mWLRVZz19RpYBeOa1mQbOuNGLj6ml
 pK6W5oSVa7+Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2020 15:02:18 -0700
IronPort-SDR: MwonoQF6oSOHQyrPmuMxSyj8o/a8TxyZGbrZXcSWJxYPc+vW18pxoxY4Pb4voubXtvn8YIN3W2
 iOSg/6WttpDw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2020 15:15:04 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 10/15] hw/block/nvme: Support Zoned Namespace Command Set
Date: Mon, 14 Sep 2020 07:14:31 +0900
Message-Id: <20200913221436.22844-11-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=518fa018e=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 18:14:44
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

The emulation code has been changed to advertise NVM Command Set when
"zoned" device property is not set (default) and Zoned Namespace
Command Set otherwise.

Handlers for three new NVMe commands introduced in Zoned Namespace
Command Set specification are added, namely for Zone Management
Receive, Zone Management Send and Zone Append.

Device initialization code has been extended to create a proper
configuration for zoned operation using device properties.

Read/Write command handler is modified to only allow writes at the
write pointer if the namespace is zoned. For Zone Append command,
writes implicitly happen at the write pointer and the starting write
pointer value is returned as the result of the command. Write Zeroes
handler is modified to add zoned checks that are identical to those
done as a part of Write flow.

The code to support for Zone Descriptor Extensions is not included in
this commit and ZDES 0 is always reported. A later commit in this
series will add ZDE support.

This commit doesn't yet include checks for active and open zone
limits. It is assumed that there are no limits on either active or
open zones.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c | 968 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 939 insertions(+), 29 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c740cbcf1f..0bf7471815 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -53,6 +53,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "crypto/random.h"
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -125,6 +126,98 @@ static uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+/*
+ * Add a zone to the tail of a zone list.
+ */
+static void nvme_add_zone_tail(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
+                               NvmeZone *zone)
+{
+    uint32_t idx = (uint32_t)(zone - ns->zone_array);
+
+    assert(nvme_zone_not_in_list(zone));
+
+    if (!zl->size) {
+        zl->head = zl->tail = idx;
+        zone->next = zone->prev = NVME_ZONE_LIST_NIL;
+    } else {
+        ns->zone_array[zl->tail].next = idx;
+        zone->prev = zl->tail;
+        zone->next = NVME_ZONE_LIST_NIL;
+        zl->tail = idx;
+    }
+    zl->size++;
+}
+
+/*
+ * Remove a zone from a zone list. The zone must be linked in the list.
+ */
+static void nvme_remove_zone(NvmeCtrl *n, NvmeNamespace *ns, NvmeZoneList *zl,
+                             NvmeZone *zone)
+{
+    uint32_t idx = (uint32_t)(zone - ns->zone_array);
+
+    assert(!nvme_zone_not_in_list(zone));
+
+    --zl->size;
+    if (zl->size == 0) {
+        zl->head = NVME_ZONE_LIST_NIL;
+        zl->tail = NVME_ZONE_LIST_NIL;
+    } else if (idx == zl->head) {
+        zl->head = zone->next;
+        ns->zone_array[zl->head].prev = NVME_ZONE_LIST_NIL;
+    } else if (idx == zl->tail) {
+        zl->tail = zone->prev;
+        ns->zone_array[zl->tail].next = NVME_ZONE_LIST_NIL;
+    } else {
+        ns->zone_array[zone->next].prev = zone->prev;
+        ns->zone_array[zone->prev].next = zone->next;
+    }
+
+    zone->prev = zone->next = 0;
+}
+
+static void nvme_assign_zone_state(NvmeCtrl *n, NvmeNamespace *ns,
+                                   NvmeZone *zone, uint8_t state)
+{
+    if (!nvme_zone_not_in_list(zone)) {
+        switch (nvme_get_zone_state(zone)) {
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+            nvme_remove_zone(n, ns, ns->exp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+            nvme_remove_zone(n, ns, ns->imp_open_zones, zone);
+            break;
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_remove_zone(n, ns, ns->closed_zones, zone);
+            break;
+        case NVME_ZONE_STATE_FULL:
+            nvme_remove_zone(n, ns, ns->full_zones, zone);
+        }
+   }
+
+    nvme_set_zone_state(zone, state);
+
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        nvme_add_zone_tail(n, ns, ns->exp_open_zones, zone);
+        break;
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_add_zone_tail(n, ns, ns->imp_open_zones, zone);
+        break;
+    case NVME_ZONE_STATE_CLOSED:
+        nvme_add_zone_tail(n, ns, ns->closed_zones, zone);
+        break;
+    case NVME_ZONE_STATE_FULL:
+        nvme_add_zone_tail(n, ns, ns->full_zones, zone);
+        break;
+    default:
+        zone->d.za = 0;
+        /* fall through */
+    case NVME_ZONE_STATE_READ_ONLY:
+        zone->tstamp = 0;
+    }
+}
+
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low = n->ctrl_mem.addr;
@@ -622,6 +715,138 @@ static void nvme_fill_data(QEMUSGList *qsg, QEMUIOVector *iov,
     }
 }
 
+static uint16_t nvme_check_zone_write(NvmeZone *zone, uint64_t slba,
+                                      uint32_t nlb)
+{
+    uint16_t status;
+
+    if (unlikely((slba + nlb) > nvme_zone_wr_boundary(zone))) {
+        return NVME_ZONE_BOUNDARY_ERROR;
+    }
+
+    switch (nvme_get_zone_state(zone)) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+        status = NVME_SUCCESS;
+        break;
+    case NVME_ZONE_STATE_FULL:
+        status = NVME_ZONE_FULL;
+        break;
+    case NVME_ZONE_STATE_OFFLINE:
+        status = NVME_ZONE_OFFLINE;
+        break;
+    case NVME_ZONE_STATE_READ_ONLY:
+        status = NVME_ZONE_READ_ONLY;
+        break;
+    default:
+        assert(false);
+    }
+    return status;
+}
+
+static uint16_t nvme_check_zone_read(NvmeCtrl *n, NvmeZone *zone, uint64_t slba,
+                                     uint32_t nlb, bool zone_x_ok)
+{
+    uint64_t lba = slba, count;
+    uint16_t status;
+    uint8_t zs;
+
+    do {
+        if (!zone_x_ok && (lba + nlb > nvme_zone_rd_boundary(n, zone))) {
+            return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
+        }
+
+        zs = nvme_get_zone_state(zone);
+        switch (zs) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        case NVME_ZONE_STATE_FULL:
+        case NVME_ZONE_STATE_CLOSED:
+        case NVME_ZONE_STATE_READ_ONLY:
+            status = NVME_SUCCESS;
+            break;
+        case NVME_ZONE_STATE_OFFLINE:
+            status = NVME_ZONE_OFFLINE | NVME_DNR;
+            break;
+        default:
+            assert(false);
+        }
+        if (status != NVME_SUCCESS) {
+            break;
+        }
+
+        if (lba + nlb > nvme_zone_rd_boundary(n, zone)) {
+            count = nvme_zone_rd_boundary(n, zone) - lba;
+        } else {
+            count = nlb;
+        }
+
+        lba += count;
+        nlb -= count;
+        zone++;
+    } while (nlb);
+
+    return status;
+}
+
+static inline uint32_t nvme_zone_idx(NvmeCtrl *n, uint64_t slba)
+{
+    return n->zone_size_log2 > 0 ? slba >> n->zone_size_log2 :
+                                   slba / n->zone_size;
+}
+
+static void nvme_finalize_zone_write(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
+    NvmeNamespace *ns;
+    NvmeZone *zone;
+    uint64_t slba;
+    uint32_t nlb, zone_idx;
+    uint8_t zs;
+
+    if (rw->opcode != NVME_CMD_WRITE &&
+        rw->opcode != NVME_CMD_ZONE_APND &&
+        rw->opcode != NVME_CMD_WRITE_ZEROES) {
+        return;
+    }
+
+    slba = le64_to_cpu(rw->slba);
+    nlb  = le16_to_cpu(rw->nlb) + 1;
+    zone_idx = nvme_zone_idx(n, slba);
+    assert(zone_idx < n->num_zones);
+    ns = req->ns;
+    zone = &ns->zone_array[zone_idx];
+
+    zone->d.wp += nlb;
+
+    zs = nvme_get_zone_state(zone);
+    if (zone->d.wp == nvme_zone_wr_boundary(zone)) {
+        switch (zs) {
+        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        case NVME_ZONE_STATE_CLOSED:
+        case NVME_ZONE_STATE_EMPTY:
+            break;
+        default:
+            assert(false);
+        }
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
+    } else {
+        switch (zs) {
+        case NVME_ZONE_STATE_EMPTY:
+        case NVME_ZONE_STATE_CLOSED:
+            nvme_assign_zone_state(n, ns, zone,
+                                   NVME_ZONE_STATE_IMPLICITLY_OPEN);
+        }
+    }
+
+    req->cqe.result64 = zone->d.wp;
+    return;
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -632,6 +857,13 @@ static void nvme_rw_cb(void *opaque, int ret)
     trace_pci_nvme_rw_cb(nvme_cid(req));
 
     if (!ret) {
+        if (n->params.zoned) {
+            if (req->fill_ofs >= 0) {
+                nvme_fill_data(&req->qsg, &req->iov, req->fill_ofs,
+                               n->params.fill_pattern);
+            }
+            nvme_finalize_zone_write(n, req);
+        }
         block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
         req->status = NVME_SUCCESS;
     } else {
@@ -655,12 +887,14 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    NvmeZone *zone = NULL;
     const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
     uint64_t offset = slba << data_shift;
     uint32_t count = nlb << data_shift;
+    uint32_t zone_idx;
     uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
@@ -671,25 +905,47 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
+    if (n->params.zoned) {
+        zone_idx = nvme_zone_idx(n, slba);
+        assert(zone_idx < n->num_zones);
+        zone = &ns->zone_array[zone_idx];
+
+        status = nvme_check_zone_write(zone, slba, nlb);
+        if (status != NVME_SUCCESS) {
+            trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+            return status | NVME_DNR;
+        }
+
+        assert(nvme_wp_is_valid(zone));
+        if (unlikely(slba != zone->d.wp)) {
+            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                               zone->d.wp);
+            return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+        }
+    }
+
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
                                         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
+
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req, bool append)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    NvmeZone *zone = NULL;
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
     uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t data_size = (uint64_t)nlb << data_shift;
-    uint64_t data_offset = slba << data_shift;
-    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
+    uint64_t data_offset;
+    uint32_t zone_idx = 0;
+    bool is_write = rw->opcode == NVME_CMD_WRITE || append;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
 
@@ -709,11 +965,77 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
+    if (n->params.zoned) {
+        zone_idx = nvme_zone_idx(n, slba);
+        assert(zone_idx < n->num_zones);
+        zone = &ns->zone_array[zone_idx];
+
+        if (is_write) {
+            status = nvme_check_zone_write(zone, slba, nlb);
+            if (status != NVME_SUCCESS) {
+                trace_pci_nvme_err_zone_write_not_ok(slba, nlb, status);
+                return status | NVME_DNR;
+            }
+
+            assert(nvme_wp_is_valid(zone));
+            if (append) {
+                if (unlikely(slba != zone->d.zslba)) {
+                    trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
+                    return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+                }
+                if (data_size > (n->page_size << n->zasl)) {
+                    trace_pci_nvme_err_append_too_large(slba, nlb, n->zasl);
+                    return NVME_INVALID_FIELD | NVME_DNR;
+                }
+                slba = zone->d.wp;
+            } else if (unlikely(slba != zone->d.wp)) {
+                trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
+                                                   zone->d.wp);
+                return NVME_ZONE_INVALID_WRITE | NVME_DNR;
+            }
+            req->fill_ofs = -1LL;
+        } else {
+            status = nvme_check_zone_read(n, zone, slba, nlb,
+                                          n->params.cross_zone_read);
+            if (status != NVME_SUCCESS) {
+                trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
+                return status | NVME_DNR;
+            }
+
+            if (slba + nlb > zone->d.wp) {
+                /*
+                 * All or some data is read above the WP. Need to
+                 * fill out the buffer area that has no backing data
+                 * with a predefined data pattern (zeros by default)
+                 */
+                if (slba >= zone->d.wp) {
+                    req->fill_ofs = 0;
+                } else {
+                    req->fill_ofs = ((zone->d.wp - slba) << data_shift);
+                }
+            } else {
+                req->fill_ofs = -1LL;
+            }
+        }
+    } else if (append) {
+        trace_pci_nvme_err_invalid_opc(rw->opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     if (nvme_map_dptr(n, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (unlikely(n->params.zoned && req->fill_ofs == 0)) {
+        /* No backend I/O necessary, only need to fill the buffer */
+        nvme_fill_data(&req->qsg, &req->iov, 0, n->params.fill_pattern);
+        req->status = NVME_SUCCESS;
+        return NVME_SUCCESS;
+    }
+
+    data_offset = slba << data_shift;
+
     if (req->qsg.nsg > 0) {
         block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
                          acct);
@@ -735,6 +1057,380 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeCtrl *n, NvmeNamespace *ns,
+                                            NvmeCmd *c, uint64_t *slba,
+                                            uint32_t *zone_idx)
+{
+    uint32_t dw10 = le32_to_cpu(c->cdw10);
+    uint32_t dw11 = le32_to_cpu(c->cdw11);
+
+    if (!n->params.zoned) {
+        trace_pci_nvme_err_invalid_opc(c->opcode);
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
+    *slba = ((uint64_t)dw11) << 32 | dw10;
+    if (unlikely(*slba >= ns->id_ns.nsze)) {
+        trace_pci_nvme_err_invalid_lba_range(*slba, 0, ns->id_ns.nsze);
+        *slba = 0;
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    *zone_idx = nvme_zone_idx(n, *slba);
+    assert(*zone_idx < n->num_zones);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_open_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                               NvmeZone *zone, uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EMPTY:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
+        /* fall through */
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_open_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_CLOSED;
+}
+
+static uint16_t nvme_close_zone(NvmeCtrl *n,  NvmeNamespace *ns,
+                                NvmeZone *zone, uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_CLOSED);
+        /* fall through */
+    case NVME_ZONE_STATE_CLOSED:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_close_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN;
+}
+
+static uint16_t nvme_finish_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                                 NvmeZone *zone, uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_EMPTY:
+        zone->d.wp = nvme_zone_wr_boundary(zone);
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_FULL);
+        /* fall through */
+    case NVME_ZONE_STATE_FULL:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_finish_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_CLOSED;
+}
+
+static uint16_t nvme_reset_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                                NvmeZone *zone, uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
+    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
+    case NVME_ZONE_STATE_CLOSED:
+    case NVME_ZONE_STATE_FULL:
+        zone->d.wp = zone->d.zslba;
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_EMPTY);
+        /* fall through */
+    case NVME_ZONE_STATE_EMPTY:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_reset_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_IMPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_EXPLICITLY_OPEN ||
+           state == NVME_ZONE_STATE_CLOSED ||
+           state == NVME_ZONE_STATE_FULL;
+}
+
+static uint16_t nvme_offline_zone(NvmeCtrl *n, NvmeNamespace *ns,
+                                  NvmeZone *zone, uint8_t state)
+{
+    switch (state) {
+    case NVME_ZONE_STATE_READ_ONLY:
+        nvme_assign_zone_state(n, ns, zone, NVME_ZONE_STATE_OFFLINE);
+        /* fall through */
+    case NVME_ZONE_STATE_OFFLINE:
+        return NVME_SUCCESS;
+    }
+
+    return NVME_ZONE_INVAL_TRANSITION;
+}
+
+static bool nvme_cond_offline_all(uint8_t state)
+{
+    return state == NVME_ZONE_STATE_READ_ONLY;
+}
+
+typedef uint16_t (*op_handler_t)(NvmeCtrl *, NvmeNamespace *, NvmeZone *,
+                                 uint8_t);
+typedef bool (*need_to_proc_zone_t)(uint8_t);
+
+static uint16_t name_do_zone_op(NvmeCtrl *n, NvmeNamespace *ns,
+                                NvmeZone *zone, uint8_t state, bool all,
+                                op_handler_t op_hndlr,
+                                need_to_proc_zone_t proc_zone)
+{
+    int i;
+    uint16_t status = 0;
+
+    if (!all) {
+        status = op_hndlr(n, ns, zone, state);
+    } else {
+        for (i = 0; i < n->num_zones; i++, zone++) {
+            state = nvme_get_zone_state(zone);
+            if (proc_zone(state)) {
+                status = op_hndlr(n, ns, zone, state);
+                if (status != NVME_SUCCESS) {
+                    break;
+                }
+            }
+        }
+    }
+
+    return status;
+}
+
+static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint64_t slba = 0;
+    uint32_t zone_idx = 0;
+    uint16_t status;
+    uint8_t action, state;
+    bool all;
+    NvmeZone *zone;
+
+    action = dw13 & 0xff;
+    all = dw13 & 0x100;
+
+    req->status = NVME_SUCCESS;
+
+    if (!all) {
+        status = nvme_get_mgmt_zone_slba_idx(n, ns, cmd, &slba, &zone_idx);
+        if (status) {
+            return status;
+        }
+    }
+
+    zone = &ns->zone_array[zone_idx];
+    if (slba != zone->d.zslba) {
+        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslba);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    state = nvme_get_zone_state(zone);
+
+    switch (action) {
+
+    case NVME_ZONE_ACTION_OPEN:
+        trace_pci_nvme_open_zone(slba, zone_idx, all);
+        status = name_do_zone_op(n, ns, zone, state, all,
+                                 nvme_open_zone, nvme_cond_open_all);
+        break;
+
+    case NVME_ZONE_ACTION_CLOSE:
+        trace_pci_nvme_close_zone(slba, zone_idx, all);
+        status = name_do_zone_op(n, ns, zone, state, all,
+                                 nvme_close_zone, nvme_cond_close_all);
+        break;
+
+    case NVME_ZONE_ACTION_FINISH:
+        trace_pci_nvme_finish_zone(slba, zone_idx, all);
+        status = name_do_zone_op(n, ns, zone, state, all,
+                                 nvme_finish_zone, nvme_cond_finish_all);
+        break;
+
+    case NVME_ZONE_ACTION_RESET:
+        trace_pci_nvme_reset_zone(slba, zone_idx, all);
+        status = name_do_zone_op(n, ns, zone, state, all,
+                                 nvme_reset_zone, nvme_cond_reset_all);
+        break;
+
+    case NVME_ZONE_ACTION_OFFLINE:
+        trace_pci_nvme_offline_zone(slba, zone_idx, all);
+        status = name_do_zone_op(n, ns, zone, state, all,
+                                 nvme_offline_zone, nvme_cond_offline_all);
+        break;
+
+    case NVME_ZONE_ACTION_SET_ZD_EXT:
+        trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
+        return NVME_INVALID_FIELD | NVME_DNR;
+        break;
+
+    default:
+        trace_pci_nvme_err_invalid_mgmt_action(action);
+        status = NVME_INVALID_FIELD;
+    }
+
+    if (status == NVME_ZONE_INVAL_TRANSITION) {
+        trace_pci_nvme_err_invalid_zone_state_transition(state, action, slba,
+                                                         zone->d.za);
+    }
+    if (status) {
+        status |= NVME_DNR;
+    }
+
+    return status;
+}
+
+static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
+{
+    int zs = nvme_get_zone_state(zl);
+
+    switch (zafs) {
+    case NVME_ZONE_REPORT_ALL:
+        return true;
+    case NVME_ZONE_REPORT_EMPTY:
+        return (zs == NVME_ZONE_STATE_EMPTY);
+    case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
+        return (zs == NVME_ZONE_STATE_IMPLICITLY_OPEN);
+    case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
+        return (zs == NVME_ZONE_STATE_EXPLICITLY_OPEN);
+    case NVME_ZONE_REPORT_CLOSED:
+        return (zs == NVME_ZONE_STATE_CLOSED);
+    case NVME_ZONE_REPORT_FULL:
+        return (zs == NVME_ZONE_STATE_FULL);
+    case NVME_ZONE_REPORT_READ_ONLY:
+        return (zs == NVME_ZONE_STATE_READ_ONLY);
+    case NVME_ZONE_REPORT_OFFLINE:
+        return (zs == NVME_ZONE_STATE_OFFLINE);
+    default:
+        return false;
+    }
+}
+
+static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeNamespace *ns = req->ns;
+    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
+    /* cdw12 is zero-based number of dwords to return. Convert to bytes */
+    uint32_t len = (le32_to_cpu(cmd->cdw12) + 1) << 2;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint32_t zone_idx, zra, zrasf, partial;
+    uint64_t max_zones, nr_zones = 0;
+    uint16_t ret;
+    uint64_t slba;
+    NvmeZoneDescr *z;
+    NvmeZone *zs;
+    NvmeZoneReportHeader *header;
+    void *buf, *buf_p;
+    size_t zone_entry_sz;
+
+    req->status = NVME_SUCCESS;
+
+    ret = nvme_get_mgmt_zone_slba_idx(n, ns, cmd, &slba, &zone_idx);
+    if (ret) {
+        return ret;
+    }
+
+    if (len < sizeof(NvmeZoneReportHeader)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zra = dw13 & 0xff;
+    if (!(zra == NVME_ZONE_REPORT || zra == NVME_ZONE_REPORT_EXTENDED)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (zra == NVME_ZONE_REPORT_EXTENDED) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    zrasf = (dw13 >> 8) & 0xff;
+    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    partial = (dw13 >> 16) & 0x01;
+
+    zone_entry_sz = sizeof(NvmeZoneDescr);
+
+    max_zones = (len - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
+    buf = g_malloc0(len);
+
+    header = (NvmeZoneReportHeader *)buf;
+    buf_p = buf + sizeof(NvmeZoneReportHeader);
+
+    while (zone_idx < n->num_zones && nr_zones < max_zones) {
+        zs = &ns->zone_array[zone_idx];
+
+        if (!nvme_zone_matches_filter(zrasf, zs)) {
+            zone_idx++;
+            continue;
+        }
+
+        z = (NvmeZoneDescr *)buf_p;
+        buf_p += sizeof(NvmeZoneDescr);
+        nr_zones++;
+
+        z->zt = zs->d.zt;
+        z->zs = zs->d.zs;
+        z->zcap = cpu_to_le64(zs->d.zcap);
+        z->zslba = cpu_to_le64(zs->d.zslba);
+        z->za = zs->d.za;
+
+        if (nvme_wp_is_valid(zs)) {
+            z->wp = cpu_to_le64(zs->d.wp);
+        } else {
+            z->wp = cpu_to_le64(~0ULL);
+        }
+
+        zone_idx++;
+    }
+
+    if (!partial) {
+        for (; zone_idx < n->num_zones; zone_idx++) {
+            zs = &ns->zone_array[zone_idx];
+            if (nvme_zone_matches_filter(zrasf, zs)) {
+                nr_zones++;
+            }
+        }
+    }
+    header->nr_zones = cpu_to_le64(nr_zones);
+
+    ret = nvme_dma_prp(n, (uint8_t *)buf, len, prp1, prp2,
+                       DMA_DIRECTION_FROM_DEVICE, req);
+    g_free(buf);
+
+    return ret;
+}
+
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
@@ -753,9 +1449,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
         return nvme_write_zeroes(n, req);
+    case NVME_CMD_ZONE_APND:
+        return nvme_rw(n, req, true);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, req);
+        return nvme_rw(n, req, false);
+    case NVME_CMD_ZONE_MGMT_SEND:
+        return nvme_zone_mgmt_send(n, req);
+    case NVME_CMD_ZONE_MGMT_RECV:
+        return nvme_zone_mgmt_recv(n, req);
     default:
         trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -984,7 +1686,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -1012,11 +1714,19 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
     acs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
     acs[NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_CMD_EFFECTS_CSUPP;
 
-    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_WRITE_ZEROES] = NVME_CMD_EFFECTS_CSUPP |
-                                  NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
-    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+    if (NVME_CC_CSS(n->bar.cc) != CSS_ADMIN_ONLY) {
+        iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_WRITE_ZEROES] = NVME_CMD_EFFECTS_CSUPP |
+                                      NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+    }
+    if (csi == NVME_CSI_ZONED && NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+        iocs[NVME_CMD_ZONE_APND] = NVME_CMD_EFFECTS_CSUPP |
+                                   NVME_CMD_EFFECTS_LBCC;
+        iocs[NVME_CMD_ZONE_MGMT_SEND] = NVME_CMD_EFFECTS_CSUPP;
+        iocs[NVME_CMD_ZONE_MGMT_RECV] = NVME_CMD_EFFECTS_CSUPP;
+    }
 
     trans_len = MIN(sizeof(cmd_eff_log) - off, buf_len);
 
@@ -1035,6 +1745,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     uint8_t  lid = dw10 & 0xff;
     uint8_t  lsp = (dw10 >> 8) & 0xf;
     uint8_t  rae = (dw10 >> 15) & 0x1;
+    uint8_t csi = le32_to_cpu(cmd->cdw14) >> 24;
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
@@ -1068,7 +1779,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
     case NVME_LOG_CMD_EFFECTS:
-        return nvme_cmd_effects(n, len, off, req);
+        return nvme_cmd_effects(n, csi, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1193,6 +1904,16 @@ static uint16_t nvme_rpt_empty_id_struct(NvmeCtrl *n, uint64_t prp1,
     return NVME_SUCCESS;
 }
 
+static inline bool nvme_csi_has_nvm_support(NvmeNamespace *ns)
+{
+    switch (ns->csi) {
+    case NVME_CSI_NVM:
+    case NVME_CSI_ZONED:
+        return true;
+    }
+    return false;
+}
+
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1208,13 +1929,22 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    NvmeIdCtrlZoned *id;
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint16_t ret;
 
     trace_pci_nvme_identify_ctrl_csi(c->csi);
 
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    } else if (c->csi == NVME_CSI_ZONED && n->params.zoned) {
+        id = g_malloc0(sizeof(*id));
+        id->zasl = n->zasl;
+        ret = nvme_dma_prp(n, (uint8_t *)id, sizeof(*id), prp1, prp2,
+                           DMA_DIRECTION_FROM_DEVICE, req);
+        g_free(id);
+        return ret;
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1243,8 +1973,12 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
     }
 
-    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
+        return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
+                            prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    }
+
+    return NVME_INVALID_CMD_SET | NVME_DNR;
 }
 
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
@@ -1270,8 +2004,12 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
     }
 
-    if (c->csi == NVME_CSI_NVM) {
+    if (c->csi == NVME_CSI_NVM && nvme_csi_has_nvm_support(ns)) {
         return nvme_rpt_empty_id_struct(n, prp1, prp2, req);
+    } else if (c->csi == NVME_CSI_ZONED && ns->csi == NVME_CSI_ZONED) {
+        return nvme_dma_prp(n, (uint8_t *)ns->id_ns_zoned,
+                            sizeof(*ns->id_ns_zoned), prp1, prp2,
+                            DMA_DIRECTION_FROM_DEVICE, req);
     }
 
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -1331,7 +2069,7 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
 
     trace_pci_nvme_identify_nslist_csi(min_nsid, c->csi);
 
-    if (c->csi != NVME_CSI_NVM) {
+    if (c->csi != NVME_CSI_NVM && c->csi != NVME_CSI_ZONED) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1395,7 +2133,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     desc->nidt = NVME_NIDT_CSI;
     desc->nidl = NVME_NIDL_CSI;
     buf_ptr += sizeof(*desc);
-    *(uint8_t *)buf_ptr = NVME_CSI_NVM;
+    *(uint8_t *)buf_ptr = ns->csi;
 
     status = nvme_dma_prp(n, buf, data_len, prp1, prp2,
                           DMA_DIRECTION_FROM_DEVICE, req);
@@ -1418,6 +2156,9 @@ static uint16_t nvme_identify_cmd_set(NvmeCtrl *n, NvmeRequest *req)
     list = g_malloc0(data_len);
     ptr = (uint8_t *)list;
     NVME_SET_CSI(*ptr, NVME_CSI_NVM);
+    if (n->params.zoned) {
+        NVME_SET_CSI(*ptr, NVME_CSI_ZONED);
+    }
     status = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
                           DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
@@ -1986,6 +2727,20 @@ static int nvme_start_ctrl(NvmeCtrl *n)
                 n->namespaces[i].attached = true;
             }
             break;
+        case NVME_CSI_ZONED:
+            if (NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+                n->namespaces[i].attached = true;
+            }
+            break;
+        }
+    }
+
+    if (n->params.zoned) {
+        if (!n->zasl_bs) {
+            assert(n->params.mdts);
+            n->zasl = n->params.mdts;
+        } else {
+            n->zasl = nvme_ilog2(n->zasl_bs / n->page_size);
         }
     }
 
@@ -2049,12 +2804,18 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
             } else {
                 switch (NVME_CC_CSS(data)) {
                 case CSS_NVM_ONLY:
-                    trace_pci_nvme_css_nvm_cset_selected_by_host(data &
-                                                                 0xffffffff);
+                    if (n->params.zoned) {
+                        NVME_GUEST_ERR(pci_nvme_err_only_zoned_cmd_set_avail,
+                               "only NVM+ZONED command set can be selected");
                     break;
+                }
+                trace_pci_nvme_css_nvm_cset_selected_by_host(data &
+                                                             0xffffffff);
+                break;
                 case CSS_CSI:
                     NVME_SET_CC_CSS(n->bar.cc, CSS_CSI);
-                    trace_pci_nvme_css_all_csets_sel_by_host(data & 0xffffffff);
+                    trace_pci_nvme_css_all_csets_sel_by_host(data &
+                                                             0xffffffff);
                     break;
                 case CSS_ADMIN_ONLY:
                     break;
@@ -2386,6 +3147,126 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+static int nvme_init_zone_meta(NvmeCtrl *n, NvmeNamespace *ns,
+                               uint64_t capacity)
+{
+    NvmeZone *zone;
+    uint64_t start = 0, zone_size = n->zone_size;
+    int i;
+
+    ns->zone_array = g_malloc0(n->zone_array_size);
+    ns->exp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->imp_open_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->closed_zones = g_malloc0(sizeof(NvmeZoneList));
+    ns->full_zones = g_malloc0(sizeof(NvmeZoneList));
+    zone = ns->zone_array;
+
+    nvme_init_zone_list(ns->exp_open_zones);
+    nvme_init_zone_list(ns->imp_open_zones);
+    nvme_init_zone_list(ns->closed_zones);
+    nvme_init_zone_list(ns->full_zones);
+
+    for (i = 0; i < n->num_zones; i++, zone++) {
+        if (start + zone_size > capacity) {
+            zone_size = capacity - start;
+        }
+        zone->d.zt = NVME_ZONE_TYPE_SEQ_WRITE;
+        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
+        zone->d.za = 0;
+        zone->d.zcap = n->zone_capacity;
+        zone->d.zslba = start;
+        zone->d.wp = start;
+        zone->prev = 0;
+        zone->next = 0;
+        start += zone_size;
+    }
+
+    return 0;
+}
+
+static void nvme_zoned_init_ctrl(NvmeCtrl *n, Error **errp)
+{
+    uint64_t zone_size, zone_cap;
+    uint32_t nz;
+
+    if (n->params.zone_size_mb) {
+        zone_size = n->params.zone_size_mb;
+    } else {
+        zone_size = NVME_DEFAULT_ZONE_SIZE;
+    }
+    if (n->params.zone_capacity_mb) {
+        zone_cap = n->params.zone_capacity_mb;
+    } else {
+        zone_cap = zone_size;
+    }
+    n->zone_size = zone_size * MiB / n->conf.logical_block_size;
+    n->zone_capacity = zone_cap * MiB / n->conf.logical_block_size;
+    if (n->zone_capacity > n->zone_size) {
+        error_setg(errp, "zone capacity exceeds zone size");
+        return;
+    }
+
+    nz = DIV_ROUND_UP(n->ns_size / n->conf.logical_block_size, n->zone_size);
+    n->num_zones = nz;
+    n->zone_array_size = sizeof(NvmeZone) * nz;
+    n->zone_size_log2 = is_power_of_2(n->zone_size) ? nvme_ilog2(n->zone_size) :
+                                                      0;
+
+    if (!n->params.zasl_kb) {
+        n->zasl_bs = n->params.mdts ? 0 : NVME_DEFAULT_MAX_ZA_SIZE * KiB;
+    } else {
+        n->zasl_bs = n->params.zasl_kb * KiB;
+    }
+
+    return;
+}
+
+static int nvme_zoned_init_ns(NvmeCtrl *n, NvmeNamespace *ns, int lba_index,
+                              Error **errp)
+{
+    int ret;
+
+    ret = nvme_init_zone_meta(n, ns, n->num_zones * n->zone_size);
+    if (ret) {
+        error_setg(errp, "could not init zone metadata");
+        return -1;
+    }
+
+    ns->id_ns_zoned = g_malloc0(sizeof(*ns->id_ns_zoned));
+
+    /* MAR/MOR are zeroes-based, 0xffffffff means no limit */
+    ns->id_ns_zoned->mar = 0xffffffff;
+    ns->id_ns_zoned->mor = 0xffffffff;
+    ns->id_ns_zoned->zoc = 0;
+    ns->id_ns_zoned->ozcs = n->params.cross_zone_read ? 0x01 : 0x00;
+
+    ns->id_ns_zoned->lbafe[lba_index].zsze = cpu_to_le64(n->zone_size);
+    ns->id_ns_zoned->lbafe[lba_index].zdes = 0;
+
+    if (n->params.fill_pattern == 0) {
+        ns->id_ns.dlfeat = 0x01;
+    } else if (n->params.fill_pattern == 0xff) {
+        ns->id_ns.dlfeat = 0x02;
+    }
+
+    return 0;
+}
+
+static void nvme_zoned_clear(NvmeCtrl *n)
+{
+    int i;
+
+    for (i = 0; i < n->num_namespaces; i++) {
+        NvmeNamespace *ns = &n->namespaces[i];
+        g_free(ns->id_ns_zoned);
+        g_free(ns->zone_array);
+        g_free(ns->exp_open_zones);
+        g_free(ns->imp_open_zones);
+        g_free(ns->closed_zones);
+        g_free(ns->full_zones);
+    }
+}
+
 static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
     NvmeParams *params = &n->params;
@@ -2454,18 +3335,13 @@ static void nvme_init_state(NvmeCtrl *n)
 
 static void nvme_init_blk(NvmeCtrl *n, Error **errp)
 {
+    int64_t bs_size;
+
     if (!blkconf_blocksizes(&n->conf, errp)) {
         return;
     }
     blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                   false, errp);
-}
-
-static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
-{
-    int64_t bs_size;
-    NvmeIdNs *id_ns = &ns->id_ns;
-    int lba_index;
 
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
@@ -2474,6 +3350,12 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     }
 
     n->ns_size = bs_size;
+}
+
+static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    int lba_index;
 
     ns->csi = NVME_CSI_NVM;
     qemu_uuid_generate(&ns->uuid); /* TODO make UUIDs persistent */
@@ -2481,8 +3363,18 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     id_ns->lbaf[lba_index].ds = nvme_ilog2(n->conf.logical_block_size);
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(n, ns));
 
+    if (n->params.zoned) {
+        ns->csi = NVME_CSI_ZONED;
+        id_ns->ncap = cpu_to_le64(n->zone_capacity * n->num_zones);
+        if (nvme_zoned_init_ns(n, ns, lba_index, errp) != 0) {
+            return;
+        }
+    } else {
+        ns->csi = NVME_CSI_NVM;
+        id_ns->ncap = id_ns->nsze;
+    }
+
     /* no thin provisioning */
-    id_ns->ncap = id_ns->nsze;
     id_ns->nuse = id_ns->ncap;
 }
 
@@ -2642,8 +3534,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     /*
-     * The device now always supports NS Types, but all commands
-     * that support CSI field will only handle NVM Command Set.
+     * The device now always supports NS Types, even when "zoned" property
+     * is set to zero. If this is the case, all commands that support CSI
+     * field only handle NVM Command Set.
      */
     NVME_CAP_SET_CSS(n->bar.cap, (CAP_CSS_NVM | CAP_CSS_CSI_SUPP));
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
@@ -2679,6 +3572,13 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
+    if (n->params.zoned) {
+        nvme_zoned_init_ctrl(n, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
     nvme_init_ctrl(n, pci_dev);
 
     ns = n->namespaces;
@@ -2697,6 +3597,9 @@ static void nvme_exit(PCIDevice *pci_dev)
     NvmeCtrl *n = NVME(pci_dev);
 
     nvme_clear_ctrl(n);
+    if (n->params.zoned) {
+        nvme_zoned_clear(n);
+    }
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
@@ -2724,6 +3627,13 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
+    DEFINE_PROP_BOOL("zoned", NvmeCtrl, params.zoned, false),
+    DEFINE_PROP_UINT64("zone_size", NvmeCtrl, params.zone_size_mb,
+                       NVME_DEFAULT_ZONE_SIZE),
+    DEFINE_PROP_UINT64("zone_capacity", NvmeCtrl, params.zone_capacity_mb, 0),
+    DEFINE_PROP_UINT32("zone_append_size_limit", NvmeCtrl, params.zasl_kb, 0),
+    DEFINE_PROP_BOOL("cross_zone_read", NvmeCtrl, params.cross_zone_read, true),
+    DEFINE_PROP_UINT8("fill_pattern", NvmeCtrl, params.fill_pattern, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.0


