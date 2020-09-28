Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5D1C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A434C22207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+l660sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A434C22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj6w-0004V2-MD
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj18-0006nY-1g; Sun, 27 Sep 2020 22:35:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj15-0003Li-AD; Sun, 27 Sep 2020 22:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260551; x=1632796551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/8T3r48lypPmtnWJ26Xu7M8fiROgym4XT2MFunTfVIo=;
 b=e+l660sZyfXJgcLt9JuhUqcPaPqmf1RY5miHbt+LWlk7Bu2JoO1lfDCh
 O587vehSa3ZaYv5lQ+OdEWk6YSyUxMCkq8YSqY0Ty1P6nPCUjb0KWspwp
 f6smU3c4KodCdBIztrR819cQJs7LjBhcJSrzY/2QQ7UTXzmrRui7enKPP
 MDMMzF9/dBeRnF2anWm93Npu1R0aBWNQZONKy0Ybg8ut0GlCMLEVLiqOm
 CxcshqUjvTxdRPPFMIrIVQ1tJkQ9WWwF6BgWL8AudZKe0+sVstoAonnq6
 cYDQ2z2oSEG/0e+WOIXQV0Ms9/YDFcSyH5klrhBtuQ7JarLSCIfzZw2l1 A==;
IronPort-SDR: amDQjfNbs4gfbpZ7LvIPMTV58twOHyzEvbn0lCyU1JzQcEnhdhDchPC9mZqAmfyFnkdsY3xN/w
 HSyKjMrjQMjDLgM1Fj/b5Ii9xxFI4uZRbqjK700R7MKBfwBNYpqMk0PoWLRR5zXR2nGPBkqPQu
 oss9Kr2jQacpKXMUQF3jqD42xw696ChceAlgPy2H4/OxSkh3IL2ekhSLk3YZbinwDPZdPe1741
 2NZy24m5KAQTfwGeiu86lVSNlKVlVIkQz/CNJSdY4DLK3xwIQgPbctt0x/GoulxrWNjqBf+B4Q
 KSE=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:49 +0800
IronPort-SDR: 323ssRm8SFf5hmji7WKwQ2n5LVU/ZPs1l5PXgAjLuWif4I5typYz/vGaxCo/+3957bW6yqm9my
 TIUBAeQrS/XQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:46 -0700
IronPort-SDR: mqt7CpmG58+GxRrQvLer/dG+oHKSv7+9GSVus+rZZSZsuKPKWjdaJt0XA5WyrfVUxsd4lBbHPI
 pIGy2PwNs7FQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:48 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 07/14] hw/block/nvme: Make Zoned NS Command Set definitions
Date: Mon, 28 Sep 2020 11:35:21 +0900
Message-Id: <20200928023528.15260-8-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
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

Define values and structures that are needed to support Zoned
Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.

All new protocol definitions are located in include/block/nvme.h
and everything added that is specific to this implementation is kept
in hw/block/nvme.h.

In order to improve scalability, all open, closed and full zones
are organized in separate linked lists. Consequently, almost all
zone operations don't require scanning of the entire zone array
(which potentially can be quite large) - it is only necessary to
enumerate one or more zone lists. Zone lists are designed to be
position-independent as they can be persisted to the backing file
as a part of zone metadata. NvmeZoneList struct defined in this patch
serves as a head of every zone list.

NvmeZone structure encapsulates NvmeZoneDescriptor defined in Zoned
Command Set specification and adds a few more fields that are
internal to this implementation.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.h   | 114 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h      |  10 ++++
 include/block/nvme.h | 107 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index acdb76f058..04172f083e 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -19,11 +19,33 @@
 #define NVME_NS(obj) \
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
 
+typedef struct NvmeZone {
+    NvmeZoneDescr   d;
+    uint64_t        w_ptr;
+    uint32_t        next;
+    uint32_t        prev;
+    uint8_t         rsvd80[8];
+} NvmeZone;
+
+#define NVME_ZONE_LIST_NIL    UINT_MAX
+
+typedef struct NvmeZoneList {
+    uint32_t        head;
+    uint32_t        tail;
+    uint32_t        size;
+    uint8_t         rsvd12[4];
+} NvmeZoneList;
+
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     uint8_t  csi;
     bool     attached;
     QemuUUID uuid;
+
+    bool     zoned;
+    bool     cross_zone_read;
+    uint64_t zone_size_mb;
+    uint64_t zone_capacity_mb;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
@@ -33,6 +55,18 @@ typedef struct NvmeNamespace {
     int64_t      size;
     NvmeIdNs     id_ns;
 
+    NvmeIdNsZoned   *id_ns_zoned;
+    NvmeZone        *zone_array;
+    NvmeZoneList    *exp_open_zones;
+    NvmeZoneList    *imp_open_zones;
+    NvmeZoneList    *closed_zones;
+    NvmeZoneList    *full_zones;
+    uint32_t        num_zones;
+    uint64_t        zone_size;
+    uint64_t        zone_capacity;
+    uint64_t        zone_array_size;
+    uint32_t        zone_size_log2;
+
     NvmeNamespaceParams params;
 } NvmeNamespace;
 
@@ -74,4 +108,84 @@ int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_flush(NvmeNamespace *ns);
 
+static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
+{
+    return zone->d.zs >> 4;
+}
+
+static inline void nvme_set_zone_state(NvmeZone *zone, enum NvmeZoneState state)
+{
+    zone->d.zs = state << 4;
+}
+
+static inline uint64_t nvme_zone_rd_boundary(NvmeNamespace *ns, NvmeZone *zone)
+{
+    return zone->d.zslba + ns->zone_size;
+}
+
+static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
+{
+    return zone->d.zslba + zone->d.zcap;
+}
+
+static inline bool nvme_wp_is_valid(NvmeZone *zone)
+{
+    uint8_t st = nvme_get_zone_state(zone);
+
+    return st != NVME_ZONE_STATE_FULL &&
+           st != NVME_ZONE_STATE_READ_ONLY &&
+           st != NVME_ZONE_STATE_OFFLINE;
+}
+
+/*
+ * Initialize a zone list head.
+ */
+static inline void nvme_init_zone_list(NvmeZoneList *zl)
+{
+    zl->head = NVME_ZONE_LIST_NIL;
+    zl->tail = NVME_ZONE_LIST_NIL;
+    zl->size = 0;
+}
+
+/*
+ * Initialize the number of entries contained in a zone list.
+ */
+static inline uint32_t nvme_zone_list_size(NvmeZoneList *zl)
+{
+    return zl->size;
+}
+
+/*
+ * Check if the zone is not currently included into any zone list.
+ */
+static inline bool nvme_zone_not_in_list(NvmeZone *zone)
+{
+    return (bool)(zone->prev == 0 && zone->next == 0);
+}
+
+/*
+ * Return the zone at the head of zone list or NULL if the list is empty.
+ */
+static inline NvmeZone *nvme_peek_zone_head(NvmeNamespace *ns, NvmeZoneList *zl)
+{
+    if (zl->head == NVME_ZONE_LIST_NIL) {
+        return NULL;
+    }
+    return &ns->zone_array[zl->head];
+}
+
+/*
+ * Return the next zone in the list.
+ */
+static inline NvmeZone *nvme_next_zone_in_list(NvmeNamespace *ns, NvmeZone *z,
+                                               NvmeZoneList *zl)
+{
+    assert(!nvme_zone_not_in_list(z));
+
+    if (z->next == NVME_ZONE_LIST_NIL) {
+        return NULL;
+    }
+    return &ns->zone_array[z->next];
+}
+
 #endif /* NVME_NS_H */
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e080a2318a..f09e741d9a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,6 +6,9 @@
 
 #define NVME_MAX_NAMESPACES 256
 
+#define NVME_DEFAULT_ZONE_SIZE   128 /* MiB */
+#define NVME_DEFAULT_MAX_ZA_SIZE 128 /* KiB */
+
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues; /* deprecated since 5.1 */
@@ -16,6 +19,8 @@ typedef struct NvmeParams {
     uint32_t aer_max_queued;
     uint8_t  mdts;
     bool     use_intel_id;
+    uint8_t  fill_pattern;
+    uint32_t zasl_kb;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
@@ -28,6 +33,8 @@ typedef struct NvmeRequest {
     struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    int64_t                 fill_ofs;
+    uint32_t                fill_len;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
     BlockAcctCookie         acct;
@@ -147,6 +154,9 @@ typedef struct NvmeCtrl {
     QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
     int         aer_queued;
 
+    uint32_t    zasl_bs;
+    uint8_t     zasl;
+
     NvmeNamespace   namespace;
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
     NvmeSQueue      **sq;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index b182fe40b2..a7126e123f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -488,6 +488,9 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct QEMU_PACKED NvmeDeleteQ {
@@ -677,6 +680,7 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_CMD_SET_CMB_REJECTED   = 0x002b,
+    NVME_INVALID_CMD_SET        = 0x002c,
     NVME_LBA_RANGE              = 0x0080,
     NVME_CAP_EXCEEDED           = 0x0081,
     NVME_NS_NOT_READY           = 0x0082,
@@ -701,6 +705,14 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
+    NVME_ZONE_FULL              = 0x01b9,
+    NVME_ZONE_READ_ONLY         = 0x01ba,
+    NVME_ZONE_OFFLINE           = 0x01bb,
+    NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_ZONE_TOO_MANY_ACTIVE   = 0x01bd,
+    NVME_ZONE_TOO_MANY_OPEN     = 0x01be,
+    NVME_ZONE_INVAL_TRANSITION  = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -885,6 +897,11 @@ typedef struct QEMU_PACKED NvmeIdCtrl {
     uint8_t     vs[1024];
 } NvmeIdCtrl;
 
+typedef struct NvmeIdCtrlZoned {
+    uint8_t     zasl;
+    uint8_t     rsvd1[4095];
+} NvmeIdCtrlZoned;
+
 enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
@@ -1009,6 +1026,12 @@ typedef struct QEMU_PACKED NvmeLBAF {
     uint8_t     rp;
 } NvmeLBAF;
 
+typedef struct QEMU_PACKED NvmeLBAFE {
+    uint64_t    zsze;
+    uint8_t     zdes;
+    uint8_t     rsvd9[7];
+} NvmeLBAFE;
+
 #define NVME_NSID_BROADCAST 0xffffffff
 
 typedef struct QEMU_PACKED NvmeIdNs {
@@ -1063,10 +1086,24 @@ enum NvmeNsIdentifierType {
 
 enum NvmeCsi {
     NVME_CSI_NVM                = 0x00,
+    NVME_CSI_ZONED              = 0x02,
 };
 
 #define NVME_SET_CSI(vec, csi) (vec |= (uint8_t)(1 << (csi)))
 
+typedef struct QEMU_PACKED NvmeIdNsZoned {
+    uint16_t    zoc;
+    uint16_t    ozcs;
+    uint32_t    mar;
+    uint32_t    mor;
+    uint32_t    rrl;
+    uint32_t    frl;
+    uint8_t     rsvd20[2796];
+    NvmeLBAFE   lbafe[16];
+    uint8_t     rsvd3072[768];
+    uint8_t     vs[256];
+} NvmeIdNsZoned;
+
 /*Deallocate Logical Block Features*/
 #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
 #define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
@@ -1098,6 +1135,71 @@ enum NvmeIdNsDps {
     DPS_FIRST_EIGHT = 8,
 };
 
+enum NvmeZoneAttr {
+    NVME_ZA_FINISHED_BY_CTLR         = 1 << 0,
+    NVME_ZA_FINISH_RECOMMENDED       = 1 << 1,
+    NVME_ZA_RESET_RECOMMENDED        = 1 << 2,
+    NVME_ZA_ZD_EXT_VALID             = 1 << 7,
+};
+
+typedef struct QEMU_PACKED NvmeZoneReportHeader {
+    uint64_t    nr_zones;
+    uint8_t     rsvd[56];
+} NvmeZoneReportHeader;
+
+enum NvmeZoneReceiveAction {
+    NVME_ZONE_REPORT                 = 0,
+    NVME_ZONE_REPORT_EXTENDED        = 1,
+};
+
+enum NvmeZoneReportType {
+    NVME_ZONE_REPORT_ALL             = 0,
+    NVME_ZONE_REPORT_EMPTY           = 1,
+    NVME_ZONE_REPORT_IMPLICITLY_OPEN = 2,
+    NVME_ZONE_REPORT_EXPLICITLY_OPEN = 3,
+    NVME_ZONE_REPORT_CLOSED          = 4,
+    NVME_ZONE_REPORT_FULL            = 5,
+    NVME_ZONE_REPORT_READ_ONLY       = 6,
+    NVME_ZONE_REPORT_OFFLINE         = 7,
+};
+
+enum NvmeZoneType {
+    NVME_ZONE_TYPE_RESERVED          = 0x00,
+    NVME_ZONE_TYPE_SEQ_WRITE         = 0x02,
+};
+
+enum NvmeZoneSendAction {
+    NVME_ZONE_ACTION_RSD             = 0x00,
+    NVME_ZONE_ACTION_CLOSE           = 0x01,
+    NVME_ZONE_ACTION_FINISH          = 0x02,
+    NVME_ZONE_ACTION_OPEN            = 0x03,
+    NVME_ZONE_ACTION_RESET           = 0x04,
+    NVME_ZONE_ACTION_OFFLINE         = 0x05,
+    NVME_ZONE_ACTION_SET_ZD_EXT      = 0x10,
+};
+
+typedef struct QEMU_PACKED NvmeZoneDescr {
+    uint8_t     zt;
+    uint8_t     zs;
+    uint8_t     za;
+    uint8_t     rsvd3[5];
+    uint64_t    zcap;
+    uint64_t    zslba;
+    uint64_t    wp;
+    uint8_t     rsvd32[32];
+} NvmeZoneDescr;
+
+enum NvmeZoneState {
+    NVME_ZONE_STATE_RESERVED         = 0x00,
+    NVME_ZONE_STATE_EMPTY            = 0x01,
+    NVME_ZONE_STATE_IMPLICITLY_OPEN  = 0x02,
+    NVME_ZONE_STATE_EXPLICITLY_OPEN  = 0x03,
+    NVME_ZONE_STATE_CLOSED           = 0x04,
+    NVME_ZONE_STATE_READ_ONLY        = 0x0D,
+    NVME_ZONE_STATE_FULL             = 0x0E,
+    NVME_ZONE_STATE_OFFLINE          = 0x0F,
+};
+
 static inline void _nvme_check_size(void)
 {
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
@@ -1117,9 +1219,14 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsDescr) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescr) != 64);
 }
 #endif
-- 
2.21.0


