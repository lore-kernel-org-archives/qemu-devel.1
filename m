Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E7C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD9A21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD9A21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oakgatetech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiO10-0004P5-7H
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hiMlj-0006Z0-2C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hiMle-0004hL-KT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:40:38 -0400
Received: from p3plmtsmtp01.prod.phx3.secureserver.net ([184.168.131.12]:37338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hiMle-0004SQ-7f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:40:34 -0400
Received: from n06.mail01.mtsvc.net ([216.70.64.26]) by :MT-SMTP: with ESMTP
 id iMknhLHnJywc7iMknh6z0s; Tue, 02 Jul 2019 10:39:41 -0700
X-SID: iMknhLHnJywc7
Received: from 76-14-151-140.rk.wavecable.com ([76.14.151.140]:59125
 helo=[10.10.0.62])
 by n06.mail01.mtsvc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <matt.fitzpatrick@oakgatetech.com>)
 id 1hiMkj-000CHD-9x; Tue, 02 Jul 2019 13:39:41 -0400
From: Matt Fitzpatrick <matt.fitzpatrick@oakgatetech.com>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <8115eb18-38c0-2bd9-b7d7-2d0c96a106e7@oakgatetech.com>
Date: Tue, 2 Jul 2019 10:39:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-User: 1274755 matt.fitzpatrick@oakgatetech.com
X-MT-ID: 4030CEC58F673A93EB94C0FECA0E49165788AD9E
X-CMAE-Envelope: MS4wfLNmkmzEVozXPSlTFbm3zpHx4BXjMVW1u7Ncu31BS4njNRAqk0vrVF3XtDTtewnAq7xYzsRwKCnZs3LxF1Ajuv1k4MOyGGy8dMi6m0Eyl+qZdT2KxV8l
 9SE7Ov1pjWc4w+zcj2EskGd0bjfhh9GBczQ0EUPj7ouubjJ7JLduv6HJZ3zoqwiAe5b8wbGIY0cZozi2YFgdSHSg+dLgifFxhrLn2FSSbVQ0AfkONqAk1OD7
 9mE+xKrcy9b92sBR11c2obPkTBaE+7jMBVPMIp9KBGXAIZhnLYpDNt3egvBiN7q8zTy/DgKwi68G4YJ/ript1w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 184.168.131.12
X-Mailman-Approved-At: Tue, 02 Jul 2019 14:11:03 -0400
Subject: [Qemu-devel] [RFC,v1] Namespace Management Support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding namespace management support to the nvme device. Namespace 
creation requires contiguous block space for a simple method of allocation.

I wrote this a few years ago based on Keith's fork and nvmeqemu fork and 
have recently re-synced with the latest trunk.  Some data structures in 
nvme.h are a bit more filled out that strictly necessary as this is also 
the base for sr-iov and IOD patched to be submitted later.

Signed-off-by: fitzpat <matt.fitzpatrick@oakgatetech.com>
---
  hw/block/nvme.c      | 506 +++++++++++++++++++++++++++++++++++++------
  hw/block/nvme.h      |  57 ++++-
  include/block/nvme.h | 128 ++++++++++-
  3 files changed, 610 insertions(+), 81 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 107a719b95..11d7da26f3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -42,6 +44,9 @@
  #include "trace.h"
  #include "nvme.h"

+#define NVME_CTRL_LIST_MAX_ENTRIES  2047
+#define NVME_MAX_NUM_NAMESPACES     256
+
  #define NVME_GUEST_ERR(trace, fmt, ...) \
      do { \
          (trace_##trace)(__VA_ARGS__); \
@@ -50,6 +55,8 @@
      } while (0)

  static void nvme_process_sq(void *opaque);
+static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
+    unsigned size);

  static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
  {
@@ -377,7 +384,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace 
*ns, NvmeCmd *cmd,
      uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
      uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
      uint64_t data_size = (uint64_t)nlb << data_shift;
-    uint64_t data_offset = slba << data_shift;
+    uint64_t data_offset = (slba << data_shift) + ns->start_byte_index;
      int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
      enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : 
BLOCK_ACCT_READ;

@@ -425,6 +432,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd 
*cmd, NvmeRequest *req)
      }

      ns = &n->namespaces[nsid - 1];
+
+    if (unlikely(!ns->ctrl)) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
      switch (cmd->opcode) {
      case NVME_CMD_FLUSH:
          return nvme_flush(n, ns, cmd, req);
@@ -676,6 +688,49 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, 
NvmeIdentify *c)
          prp1, prp2);
  }

+/**
+ * Identify Allocated Namespace List
+ * @param n
+ * @param c
+ * @return
+ */
+static uint16_t nvme_identify_ns_allocated(NvmeCtrl *n, NvmeIdentify *c)
+{
+    static const int data_len = 4 * KiB;
+    uint32_t min_nsid = le32_to_cpu(c->nsid);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+    uint32_t *list;
+    uint16_t ret;
+    int i, j = 0;
+
+    trace_nvme_identify_nslist(min_nsid);
+
+    list = g_malloc0(data_len);
+    for (i = 0; i < NVME_MAX_NUM_NAMESPACES; i++) {
+        if (i < min_nsid) {
+            continue;
+        }
+        if (n->namespaces[i].created) {
+            list[j++] = cpu_to_le32(i + 1);
+            if (j == data_len / sizeof(uint32_t)) {
+                break;
+            }
+        }
+    }
+    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    g_free(list);
+    return ret;
+}
+
+/**
+ * Identify Active Namespace List
+ * Active is defined as created and attached.
+ *
+ * @param n
+ * @param c
+ * @return
+ */
  static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
  {
      static const int data_len = 4 * KiB;
@@ -689,13 +744,15 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, 
NvmeIdentify *c)
      trace_nvme_identify_nslist(min_nsid);

      list = g_malloc0(data_len);
-    for (i = 0; i < n->num_namespaces; i++) {
+    for (i = 0; i < NVME_MAX_NUM_NAMESPACES; i++) {
          if (i < min_nsid) {
              continue;
          }
-        list[j++] = cpu_to_le32(i + 1);
-        if (j == data_len / sizeof(uint32_t)) {
-            break;
+        if (n->namespaces[i].created && n->namespaces[i].ctrl) {
+            list[j++] = cpu_to_le32(i + 1);
+            if (j == data_len / sizeof(uint32_t)) {
+                break;
+            }
          }
      }
      ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
@@ -708,18 +765,271 @@ static uint16_t nvme_identify(NvmeCtrl *n, 
NvmeCmd *cmd)
      NvmeIdentify *c = (NvmeIdentify *)cmd;

      switch (le32_to_cpu(c->cns)) {
-    case 0x00:
+    case NVME_ADM_CNS_ID_NS:
          return nvme_identify_ns(n, c);
-    case 0x01:
+    case NVME_ADM_CNS_ID_CTRL:
          return nvme_identify_ctrl(n, c);
-    case 0x02:
+    case NVME_ADM_CNS_ID_NS_LIST:
          return nvme_identify_nslist(n, c);
+    case NVME_ADM_CNS_ID_NS_LIST_ALLOC:
+        return nvme_identify_ns_allocated(n, c);
+    case NVME_ADM_CNS_ID_NS_ALLOC:
+        return nvme_identify_ns(n, c);
      default:
trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
          return NVME_INVALID_FIELD | NVME_DNR;
      }
  }

+static uint16_t nvme_namespace_controller_attach(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    int i;
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+    NvmeNamespace *ns = &n->namespaces[cmd->nsid - 1];
+
+    uint16_t ctrl_list[2048];
+    uint16_t ctrl_list_size;
+
+    if (nvme_dma_write_prp(n, (uint8_t *)ctrl_list, sizeof(ctrl_list), 
prp1, prp2)) {
+        return NVME_INVALID_FIELD;
+    }
+
+    ctrl_list_size = ctrl_list[0];
+
+    if (!ctrl_list_size || ctrl_list_size > NVME_CTRL_LIST_MAX_ENTRIES) {
+        return NVME_CTRL_LIST_INVALID;
+    }
+
+    if (ns->ctrl == n) {
+        return NVME_NS_ALREADY_ATTACHED;
+    }
+    if (!ns->created) {
+        return NVME_INVALID_NSID;
+    }
+
+    /*  TODO: Update NvmeNamespace to link multiple controllers */
+    for ( i = 1; i <= ctrl_list_size; i++) {
+        if (n->id_ctrl.cntlid == ctrl_list[i]) {
+            ns->ctrl = n;
+            return NVME_SUCCESS;
+        }
+    }
+    return NVME_CTRL_LIST_INVALID;
+}
+
+static uint16_t nvme_namespace_controller_detach(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    int i;
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+    NvmeNamespace *ns = &n->namespaces[cmd->nsid - 1];
+
+    uint16_t ctrl_list[2048];
+    uint16_t ctrl_list_size;
+
+    if (nvme_dma_write_prp(n, (uint8_t *)ctrl_list, sizeof(ctrl_list), 
prp1, prp2)) {
+        return NVME_INVALID_FIELD;
+    }
+
+    ctrl_list_size = ctrl_list[0];
+
+    if (!ctrl_list_size || ctrl_list_size > NVME_CTRL_LIST_MAX_ENTRIES) {
+        return NVME_CTRL_LIST_INVALID;
+    }
+    /* TODO: semaphore to lock NS on detach for scenario with detach 
during IO */
+    if (!ns->ctrl || (ns->ctrl != n) ) {
+        return NVME_NS_NOT_ATTACHED;
+    }
+    if (!ns->created) {
+        return NVME_INVALID_NSID;
+    }
+
+    /*  TODO: Update NvmeNamespace to link multiple controllers */
+    for ( i = 1; i <= ctrl_list_size; i++) {
+        if (n->id_ctrl.cntlid == ctrl_list[i]) {
+            ns->ctrl = NULL;
+            return NVME_SUCCESS;
+        }
+    }
+    return NVME_CTRL_LIST_INVALID;
+}
+
+static uint16_t nvme_namespace_attachment(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+
+    if ( (!cmd->nsid || cmd->nsid > NVME_MAX_NUM_NAMESPACES)
+            && (cmd->nsid != 0xFFFFFFFF)) {
+        return NVME_INVALID_FIELD;
+    }
+
+    switch (dw10) {
+    case NVME_NS_CONTROLLER_ATTACH:
+        return nvme_namespace_controller_attach(n, cmd);
+    case NVME_NS_CONTROLLER_DETACH:
+        return nvme_namespace_controller_detach(n, cmd);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
+static int nvme_set_start_index(NvmeCtrl *n, uint64_t *ns_start_index, 
uint64_t requested_ns_size)
+{
+    int i;
+    int lba_index;
+    uint64_t start_index = 0;
+    uint64_t end_index, ns_bytes;
+    bool adjusted;
+
+    if (requested_ns_size > n->nvm_capacity) {
+        return -1;
+    }
+    do {
+        adjusted = false;
+        end_index = start_index + requested_ns_size;
+        if (end_index > n->nvm_capacity) {
+            return -1;
+        }
+
+        for (i = 0; i < NVME_MAX_NUM_NAMESPACES; i++) {
+            NvmeNamespace *ns = &n->namespaces[i];
+            NvmeIdNs *id_ns = &ns->id_ns;
+            if (ns->created) {
+
+                lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+                ns_bytes = id_ns->nsze * ((1 << 
id_ns->lbaf[lba_index].ds));
+
+                if ((start_index >= ns->start_byte_index &&
+                       start_index < (ns->start_byte_index + ns_bytes)) ||
+                       (end_index >= ns->start_byte_index &&
+                        end_index < (ns->start_byte_index + ns_bytes))) {
+                   start_index = ns->start_byte_index + ns_bytes;
+                   adjusted = true;
+                }
+            }
+        }
+    } while (adjusted);
+
+    *ns_start_index = start_index;
+    return 0;
+}
+
+/**
+ * Attempts to create a namespace in a free contiguous space within the 
block layer
+ *
+ * @param n
+ * @param cmd
+ * @param req
+ * @return NVME_SUCCESS is successfuly created
+ */
+static uint16_t nvme_namespace_create(NvmeCtrl *n, NvmeCmd *cmd, 
NvmeRequest *req)
+{
+    int i;
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+    NvmeIdNs id_ns_host;
+
+
+    if (nvme_dma_write_prp(n, (uint8_t*)&id_ns_host, 
sizeof(id_ns_host), prp1, prp2)) {
+            return NVME_INVALID_FIELD;
+    }
+
+    for (i = 0; i < NVME_MAX_NUM_NAMESPACES; i++) {
+        uint64_t ns_size;
+        int lba_index;
+        NvmeNamespace *ns = &n->namespaces[i];
+        NvmeIdNs *id_ns = &ns->id_ns;
+
+        if (id_ns_host.flbas || id_ns_host.mc || id_ns_host.dps) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        if (!ns->created) { /* take the first available NS */
+
+            id_ns->flbas = id_ns_host.flbas;
+            id_ns->mc = id_ns_host.mc;
+            id_ns->dps = id_ns_host.dps;
+
+            id_ns->nuse = id_ns_host.nsze;
+            id_ns->ncap = id_ns_host.ncap;
+            id_ns->nsze = id_ns_host.nsze;
+
+            lba_index = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
+            id_ns->lbaf[lba_index].ds = BDRV_SECTOR_BITS;
+            ns_size = id_ns->nsze * (1 << id_ns->lbaf[lba_index].ds);
+            id_ns->nvmcap = ns_size;
+
+            ns->id = i + 1;
+            id_ns->nguid = ns->id;
+
+            if (nvme_set_start_index(n, &ns->start_byte_index, ns_size)) {
+                return NVME_NS_INSUFF_CAP;
+            }
+            ns->created = true;
+            n->id_ctrl.unvmcap -= id_ns->nvmcap;
+
+            ns->ctrl = NULL; /* not attached */
+
+            n->num_namespaces++;
+            n->id_ctrl.nn++;
+
+            req->cqe.result = ns->id;
+            return NVME_SUCCESS;
+        }
+    }
+
+    return NVME_NS_INSUFF_CAP;
+}
+
+static uint16_t nvme_namespace_delete(NvmeCtrl *n, NvmeCmd *cmd, 
NvmeRequest *req)
+{
+    NvmeNamespace *ns = &n->namespaces[cmd->nsid - 1];
+    if (ns->created) {
+        ns->created = false;
+        ns->ctrl = NULL;
+        n->num_namespaces--;
+        n->id_ctrl.nn--;
+        n->id_ctrl.unvmcap += ns->id_ns.nvmcap;
+        return NVME_SUCCESS;
+    }
+    return NVME_INVALID_NSID;
+}
+
+static uint16_t nvme_namespace_management(NvmeCtrl *n, NvmeCmd *cmd, 
NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+
+    if ( (cmd->nsid > NVME_MAX_NUM_NAMESPACES)
+            && (cmd->nsid != 0xFFFFFFFF)) {
+        return NVME_INVALID_FIELD;
+    }
+
+    switch (dw10) {
+        case NVME_NS_CREATE:
+            return nvme_namespace_create(n, cmd, req);
+        case NVME_NS_DELETE:
+            if ( cmd->nsid == 0xFFFFFFFF ) {
+                uint32_t i;
+                uint16_t ret = NVME_SUCCESS;
+
+                for (i = 1; i < NVME_MAX_NUM_NAMESPACES; i++) {
+                    cmd->nsid = i;
+                    if ( &n->namespaces[cmd->nsid - 1].created) {
+                        ret = nvme_namespace_delete(n, cmd, req);
+                    }
+                    if (ret != NVME_SUCCESS) {
+                        return ret;
+                    }
+                }
+                return ret;
+            }
+            return nvme_namespace_delete(n, cmd, req);
+        default:
+            return NVME_INVALID_FIELD;
+    }
+}
+
  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
  {
      trace_nvme_setfeat_timestamp(ts);
@@ -860,6 +1170,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, 
NvmeCmd *cmd, NvmeRequest *req)
          return nvme_set_feature(n, cmd, req);
      case NVME_ADM_CMD_GET_FEATURES:
          return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_NS_MANAGEMENT:
+        return nvme_namespace_management(n, cmd, req);
+    case NVME_ADM_CMD_NS_ATTACH:
+        return nvme_namespace_attachment(n, cmd);
      default:
          trace_nvme_err_invalid_admin_opc(cmd->opcode);
          return NVME_INVALID_OPCODE | NVME_DNR;
@@ -915,6 +1229,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
      }

      blk_flush(n->conf.blk);
+
      n->bar.cc = 0;
  }

@@ -1302,61 +1617,10 @@ static const MemoryRegionOps nvme_cmb_ops = {
      },
  };

-static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+static void nvme_init_ctrl(NvmeCtrl *n)
  {
-    NvmeCtrl *n = NVME(pci_dev);
      NvmeIdCtrl *id = &n->id_ctrl;
-
-    int i;
-    int64_t bs_size;
-    uint8_t *pci_conf;
-
-    if (!n->num_queues) {
-        error_setg(errp, "num_queues can't be zero");
-        return;
-    }
-
-    if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
-    }
-
-    bs_size = blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
-    }
-
-    if (!n->serial) {
-        error_setg(errp, "serial property not set");
-        return;
-    }
-    blkconf_blocksizes(&n->conf);
-    if (!blkconf_apply_backend_options(&n->conf, 
blk_is_read_only(n->conf.blk),
-                                       false, errp)) {
-        return;
-    }
-
-    pci_conf = pci_dev->config;
-    pci_conf[PCI_INTERRUPT_PIN] = 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(pci_dev, 0x80);
-
-    n->num_namespaces = 1;
-    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
-    n->ns_size = bs_size / (uint64_t)n->num_namespaces;
-
-    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq = g_new0(NvmeSQueue *, n->num_queues);
-    n->cq = g_new0(NvmeCQueue *, n->num_queues);
-
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
-    pci_register_bar(pci_dev, 0,
-        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
-        &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
+    uint8_t *pci_conf = n->parent_obj.config;

      id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
      id->ssvid = cpu_to_le16(pci_get_word(pci_conf + 
PCI_SUBSYSTEM_VENDOR_ID));
@@ -1367,16 +1631,25 @@ static void nvme_realize(PCIDevice *pci_dev, 
Error **errp)
      id->ieee[0] = 0x00;
      id->ieee[1] = 0x02;
      id->ieee[2] = 0xb3;
-    id->oacs = cpu_to_le16(0);
+    id->oacs = cpu_to_le16(0x8); // Namespace Management Supported
+
      id->frmw = 7 << 1;
      id->lpa = 1 << 0;
      id->sqes = (0x6 << 4) | 0x6;
      id->cqes = (0x4 << 4) | 0x4;
-    id->nn = cpu_to_le32(n->num_namespaces);
+    id->mnan = 0;
+    id->nn = NVME_MAX_NUM_NAMESPACES;
      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
      id->psd[0].mp = cpu_to_le16(0x9c4);
      id->psd[0].enlat = cpu_to_le32(0x10);
      id->psd[0].exlat = cpu_to_le32(0x4);
+    id->tnvmcap = n->nvm_capacity;
+    id->unvmcap = 0;
+    id->hmpre = n->hmpre;
+    id->hmmin = n->hmmin;
+
+    snprintf ((char*)id->subnqn, sizeof(id->subnqn), "QEMU NVMe 
Subsystem 1.2 Compatible");
+
      if (blk_enable_write_cache(n->conf.blk)) {
          id->vwc = 1;
      }
@@ -1387,10 +1660,34 @@ static void nvme_realize(PCIDevice *pci_dev, 
Error **errp)
      NVME_CAP_SET_AMS(n->bar.cap, 1);
      NVME_CAP_SET_TO(n->bar.cap, 0xf);
      NVME_CAP_SET_CSS(n->bar.cap, 1);
+    NVME_CAP_SET_MPSMIN(n->bar.cap, 0);
      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);

      n->bar.vs = 0x00010200;
      n->bar.intmc = n->bar.intms = 0;
+}
+
+static void nvme_init_pci(NvmeCtrl *n) {
+    uint8_t *pci_conf = n->parent_obj.config;
+
+    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_config_set_prog_interface(pci_conf, 0x2);
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
+
+
+    pci_config_set_device_id(pci_conf, 0x5845);
+    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
+                          n->reg_size);
+
+
+    pci_register_bar(&n->parent_obj, 0,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY | 
PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &n->iomem);
+
+
+    msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4, NULL);

      if (n->cmb_size_mb) {

@@ -1406,20 +1703,31 @@ static void nvme_realize(PCIDevice *pci_dev, 
Error **errp)
          NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);

          n->cmbloc = n->bar.cmbloc;
-        n->cmbsz = n->bar.cmbsz;
+        n->cmbsz  = n->bar.cmbsz;

          n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
          memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                                "nvme-cmb", 
NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
-
+        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
+                         PCI_BASE_ADDRESS_SPACE_MEMORY | 
PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                         PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
      }
+}
+
+/**
+ * Divides up the total block space between all requested namespaces.
+ * @param n
+ */
+static void nvme_init_namespaces(NvmeCtrl *n)
+{
+    uint8_t i;

      for (i = 0; i < n->num_namespaces; i++) {
+        uint64_t blks;
+        int lba_index;
          NvmeNamespace *ns = &n->namespaces[i];
          NvmeIdNs *id_ns = &ns->id_ns;
+
          id_ns->nsfeat = 0;
          id_ns->nlbaf = 0;
          id_ns->flbas = 0;
@@ -1427,12 +1735,65 @@ static void nvme_realize(PCIDevice *pci_dev, 
Error **errp)
          id_ns->dpc = 0;
          id_ns->dps = 0;
          id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
-        id_ns->ncap  = id_ns->nuse = id_ns->nsze =
-            cpu_to_le64(n->ns_size >>
- id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
+        id_ns->nsze = n->nvm_capacity / (uint64_t)n->num_namespaces;
+
+        lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+        blks = id_ns->nsze / (1 << id_ns->lbaf[lba_index].ds);
+        id_ns->nuse = id_ns->ncap = id_ns->nsze = cpu_to_le64(blks);
+        id_ns->nvmcap = id_ns->nsze * (1 << id_ns->lbaf[lba_index].ds);
+
+        ns->id = i + 1;
+        ns->start_byte_index = (i * id_ns->nsze) >> BDRV_SECTOR_BITS;
+        ns->created = true;
+        ns->ctrl = n; /* attached */
+
      }
  }

+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n = NVME(pci_dev);
+
+    int64_t bs_size;
+    Error *local_err = NULL;
+
+    if (!n->conf.blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+
+    bs_size = blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg(errp, "could not get backing file size");
+        return;
+    }
+
+    if (!n->serial) {
+        error_setg(errp, "serial property not set");
+        return;
+    }
+    blkconf_blocksizes(&n->conf);
+    blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
+                                  false, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
+    n->nvm_capacity = bs_size;
+    n->sq = g_new0(NvmeSQueue *, n->num_queues);
+    n->cq = g_new0(NvmeCQueue *, n->num_queues);
+    n->namespaces = g_new0(NvmeNamespace, NVME_MAX_NUM_NAMESPACES);
+
+    nvme_init_pci(n);
+    nvme_init_ctrl(n);
+    nvme_init_namespaces(n);
+
+}
+
  static void nvme_exit(PCIDevice *pci_dev)
  {
      NvmeCtrl *n = NVME(pci_dev);
@@ -1451,6 +1812,7 @@ static void nvme_exit(PCIDevice *pci_dev)
  static Property nvme_props[] = {
      DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
      DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
+    DEFINE_PROP_UINT32("namespaces", NvmeCtrl, num_namespaces, 1),
      DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
      DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
      DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 557194ee19..c182dcb10a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -9,6 +9,7 @@ typedef struct NvmeAsyncEvent {

  typedef struct NvmeRequest {
      struct NvmeSQueue       *sq;
+    struct NvmeNamespace    *ns;
      BlockAIOCB              *aiocb;
      uint16_t                status;
      bool                    has_sg;
@@ -50,7 +51,16 @@ typedef struct NvmeCQueue {
  } NvmeCQueue;

  typedef struct NvmeNamespace {
+    struct NvmeCtrl *ctrl;
+    bool            created;
      NvmeIdNs        id_ns;
+    NvmeRangeType   lba_range[64];
+    unsigned long   *util;
+    unsigned long   *uncorrectable;
+    uint32_t        id;
+    uint64_t        start_byte_index;
+    uint64_t        meta_start_offset;
+    BlockConf       conf;
  } NvmeNamespace;

  #define TYPE_NVME "nvme"
@@ -64,23 +74,66 @@ typedef struct NvmeCtrl {
      NvmeBar      bar;
      BlockConf    conf;

-    uint32_t    page_size;
+    time_t      start_time;
+    uint16_t    temperature;
+    uint16_t    page_size;
      uint16_t    page_bits;
      uint16_t    max_prp_ents;
      uint16_t    cqe_size;
      uint16_t    sqe_size;
+    uint16_t    oacs;
+    uint16_t    oncs;
      uint32_t    reg_size;
      uint32_t    num_namespaces;
      uint32_t    num_queues;
      uint32_t    max_q_ents;
-    uint64_t    ns_size;
+    uint64_t    nvm_capacity;
+    uint8_t     db_stride;
+    uint8_t     aerl;
+    uint8_t     acl;
+    uint8_t     elpe;
+    uint8_t     elp_index;
+    uint8_t     error_count;
+    uint8_t     mdts;
+    uint8_t     cqr;
+    uint8_t     max_sqes;
+    uint8_t     max_cqes;
+    uint8_t     meta;
+    uint8_t     vwc;
+    uint8_t     mc;
+    uint8_t     dpc;
+    uint8_t     dps;
+    uint8_t     nlbaf;
+    uint8_t     extended;
+    uint8_t     lba_index;
+    uint8_t     mpsmin;
+    uint8_t     mpsmax;
+    uint8_t     intc;
+    uint8_t     intc_thresh;
+    uint8_t     intc_time;
+    uint8_t     outstanding_aers;
+    uint8_t     temp_warn_issued;
+    uint8_t     num_errors;
+    uint8_t     cqes_pending;
+    uint16_t    vid;
+    uint16_t    did;
      uint32_t    cmb_size_mb;
      uint32_t    cmbsz;
      uint32_t    cmbloc;
+    uint32_t    sriov_total_vfs;
      uint8_t     *cmbuf;
      uint64_t    irq_status;
      uint64_t    host_timestamp;                 /* Timestamp sent by 
the host */
      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    uint8_t     ehm;
+    uint8_t     hsize;
+    uint32_t    hmdlal;
+    uint32_t    hmdlua;
+    uint32_t    hmdlec;
+    uint8_t     *hmbuf;
+    uint32_t    hmmin;
+    uint32_t    hmpre;
+

      char            *serial;
      NvmeNamespace   *namespaces;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3ec8efcc43..8c1e8c6cdc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -17,6 +17,16 @@ typedef struct NvmeBar {
      uint32_t    cmbsz;
  } NvmeBar;

+enum NvmeNsSelect {
+    NVME_NS_CONTROLLER_ATTACH = 0,
+    NVME_NS_CONTROLLER_DETACH = 1,
+};
+
+enum NvmeNsManagement {
+    NVME_NS_CREATE = 0,
+    NVME_NS_DELETE = 1,
+};
+
  enum NvmeCapShift {
      CAP_MQES_SHIFT     = 0,
      CAP_CQR_SHIFT      = 16,
@@ -233,13 +243,31 @@ enum NvmeAdminCommands {
      NVME_ADM_CMD_SET_FEATURES   = 0x09,
      NVME_ADM_CMD_GET_FEATURES   = 0x0a,
      NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
+    NVME_ADM_CMD_NS_MANAGEMENT  = 0x0d,
      NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
      NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
+    NVME_ADM_CMD_NS_ATTACH      = 0x15,
+    NVME_ADM_VIRT_MANAGEMENT    = 0x1C,
      NVME_ADM_CMD_FORMAT_NVM     = 0x80,
      NVME_ADM_CMD_SECURITY_SEND  = 0x81,
      NVME_ADM_CMD_SECURITY_RECV  = 0x82,
  };

+
+enum NvmeAdminCns {
+    NVME_ADM_CNS_ID_NS            = 0x00,
+    NVME_ADM_CNS_ID_CTRL          = 0x01,
+    NVME_ADM_CNS_ID_NS_LIST       = 0x02,
+    NVME_ADM_CNS_NS_DESC_LIST     = 0x03,
+    NVME_ADM_CNS_NVM_SET_LIST     = 0x04,
+    NVME_ADM_CNS_ID_NS_LIST_ALLOC = 0x10,
+    NVME_ADM_CNS_ID_NS_ALLOC      = 0x11,
+    NVME_ADM_CNS_CTRL_LIST_NS_ATT = 0x12,
+    NVME_ADM_CNS_CTRL_LIST        = 0x13,
+    NVME_ADM_CNS_PRIM_CTRL_CAP    = 0x14,
+    NVME_ADM_CNS_SEC_CTRL_LIST    = 0x15,
+};
+
  enum NvmeIoCommands {
      NVME_CMD_FLUSH              = 0x00,
      NVME_CMD_WRITE              = 0x01,
@@ -427,6 +455,17 @@ enum NvmeStatusCodes {
      NVME_CMD_ABORT_MISSING_FUSE = 0x000a,
      NVME_INVALID_NSID           = 0x000b,
      NVME_CMD_SEQ_ERROR          = 0x000c,
+    NVME_NS_INSUFF_CAP          = 0x0015,
+    NVME_NS_ID_UNAVAILABLE      = 0x0016,
+    NVME_NS_ALREADY_ATTACHED    = 0x0018,
+    NVME_NS_PRIVATE             = 0x0019,
+    NVME_NS_NOT_ATTACHED        = 0x001A,
+    NVME_THIN_PROV_NOT_SUP      = 0x001B,
+    NVME_CTRL_LIST_INVALID      = 0x001C,
+    NVME_INVALID_CTRL_ID        = 0x001F,
+    NVME_INVALID_SEC_CTRL_ST    = 0x0020,
+    NVME_INVALID_NUM_CTRL_RES   = 0x0021,
+    NVME_INVALID_RES_ID         = 0x0022,
      NVME_LBA_RANGE              = 0x0080,
      NVME_CAP_EXCEEDED           = 0x0081,
      NVME_NS_NOT_READY           = 0x0082,
@@ -543,7 +582,20 @@ typedef struct NvmeIdCtrl {
      uint8_t     ieee[3];
      uint8_t     cmic;
      uint8_t     mdts;
-    uint8_t     rsvd255[178];
+    uint16_t    cntlid;
+    uint32_t    ver;
+    uint8_t     rsvd_95[8];
+    uint32_t    oaes;
+    uint32_t    ctratt;
+    uint16_t    rrls;
+    uint8_t     rsvd110[9];
+    uint8_t     cntrltype;
+    uint64_t    fguid;
+    uint64_t    fguid_u;
+    uint16_t    crdt1;
+    uint16_t    crdt2;
+    uint16_t    crdt3;
+    uint8_t     rsvd255[122];
      uint16_t    oacs;
      uint8_t     acl;
      uint8_t     aerl;
@@ -551,10 +603,39 @@ typedef struct NvmeIdCtrl {
      uint8_t     lpa;
      uint8_t     elpe;
      uint8_t     npss;
-    uint8_t     rsvd511[248];
+    uint8_t     avscc;
+    uint8_t     apsta;
+    uint16_t    wctemp;
+    uint16_t    cctemp;
+    uint16_t    mtfa;
+    uint32_t    hmpre;
+    uint32_t    hmmin;
+    uint64_t    tnvmcap;
+    uint64_t    tnvmcap_u;
+    uint64_t    unvmcap;
+    uint64_t    unvmcap_u;
+    uint32_t    rpmbs;
+    uint16_t    edstt;
+    uint8_t     dsto;
+    uint8_t     fwug;
+    uint16_t    kas;
+    uint16_t    hctma;
+    uint16_t    mntmt;
+    uint16_t    mxtmt;
+    uint32_t    sanicap;
+    uint32_t    hmminds;
+    uint16_t    hmmaxd;
+    uint16_t    nsetidmax;
+    uint16_t    endgidmax;
+    uint8_t     anatt;
+    uint8_t     anacap;
+    uint32_t    anagrpmax;
+    uint32_t    nanagrpid;
+    uint32_t    pels;
+    uint8_t     rsvd511[156];
      uint8_t     sqes;
      uint8_t     cqes;
-    uint16_t    rsvd515;
+    uint16_t    maxcmd;
      uint32_t    nn;
      uint16_t    oncs;
      uint16_t    fuses;
@@ -562,8 +643,15 @@ typedef struct NvmeIdCtrl {
      uint8_t     vwc;
      uint16_t    awun;
      uint16_t    awupf;
-    uint8_t     rsvd703[174];
-    uint8_t     rsvd2047[1344];
+    uint8_t     nvscc;
+    uint8_t     nwpc;
+    uint16_t    acwu;
+    uint8_t     rsvd535[2];
+    uint32_t    sgls;
+    uint32_t    mnan;
+    uint8_t     rsvd767[224];
+    uint8_t     subnqn[256];
+    uint8_t     rsvd2047[1024];
      NvmePSD     psd[32];
      uint8_t     vs[1024];
  } NvmeIdCtrl;
@@ -653,9 +741,35 @@ typedef struct NvmeIdNs {
      uint8_t     mc;
      uint8_t     dpc;
      uint8_t     dps;
-    uint8_t     res30[98];
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint8_t     dlfeat;
+    uint16_t    nawun;
+    uint16_t    nawupf;
+    uint16_t    nacwu;
+    uint16_t    nabsn;
+    uint16_t    nabo;
+    uint16_t    nabspf;
+    uint16_t    noiob;
+    uint64_t    nvmcap;
+    uint64_t    nvmcap_u;
+    uint16_t    npwg;
+    uint16_t    npwa;
+    uint16_t    npdg;
+    uint16_t    npda;
+    uint16_t    nows;
+    uint8_t     rsvd91[18];
+    uint32_t    anagrpid;
+    uint8_t     rsvd98[3];
+    uint8_t     nsattr;
+    uint16_t    nvmsetid;
+    uint16_t    endgid;
+    uint64_t    nguid;
+    uint64_t    nguid_u;
+    uint64_t    eui64;
      NvmeLBAF    lbaf[16];
-    uint8_t     res192[192];
+    uint8_t     rsvd383[192];
      uint8_t     vs[3712];
  } NvmeIdNs;

-- 
2.17.1


