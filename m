Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542EAC47409
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2E020675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2E020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Azg-0003Wv-99
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax3-0006j5-1V
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-00053L-F1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2771 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awz-00050g-Rt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B0019EFBA72BCA44EF30;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:10 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 04/14] migration/rdma: Export the RDMAContext struct
Date: Thu, 13 Feb 2020 17:37:45 +0800
Message-ID: <20200213093755.370-5-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200213093755.370-1-fengzhimin1@huawei.com>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: jemmy858585@gmail.com, Zhimin Feng <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to use the RDMAContext in migration/multifd.c
so it has to be exported.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/rdma.c | 243 ----------------------------------------------
 migration/rdma.h | 247 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 243 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f086ab5a82..a76823986e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,9 +19,7 @@
 #include "qemu/cutils.h"
 #include "rdma.h"
 #include "migration.h"
-#include "qemu-file.h"
 #include "ram.h"
-#include "qemu-file-channel.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -47,34 +45,6 @@
         } \
     } while (0)
=20
-#define RDMA_RESOLVE_TIMEOUT_MS 10000
-
-/* Do not merge data if larger than this. */
-#define RDMA_MERGE_MAX (2 * 1024 * 1024)
-#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
-
-#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
-
-/*
- * This is only for non-live state being migrated.
- * Instead of RDMA_WRITE messages, we use RDMA_SEND
- * messages for that state, which requires a different
- * delivery design than main memory.
- */
-#define RDMA_SEND_INCREMENT 32768
-
-/*
- * Maximum size infiniband SEND message
- */
-#define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
-#define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
-
-#define RDMA_CONTROL_VERSION_CURRENT 1
-/*
- * Capabilities for negotiation.
- */
-#define RDMA_CAPABILITY_PIN_ALL 0x01
-
 /*
  * Add the other flags above to this list of known capabilities
  * as they are introduced.
@@ -117,18 +87,6 @@ static uint32_t known_capabilities =3D RDMA_CAPABILIT=
Y_PIN_ALL;
=20
 #define RDMA_WRID_CHUNK_MASK (~RDMA_WRID_BLOCK_MASK & ~RDMA_WRID_TYPE_MA=
SK)
=20
-/*
- * RDMA migration protocol:
- * 1. RDMA Writes (data messages, i.e. RAM)
- * 2. IB Send/Recv (control channel messages)
- */
-enum {
-    RDMA_WRID_NONE =3D 0,
-    RDMA_WRID_RDMA_WRITE =3D 1,
-    RDMA_WRID_SEND_CONTROL =3D 2000,
-    RDMA_WRID_RECV_CONTROL =3D 4000,
-};
-
 static const char *wrid_desc[] =3D {
     [RDMA_WRID_NONE] =3D "NONE",
     [RDMA_WRID_RDMA_WRITE] =3D "WRITE RDMA",
@@ -136,50 +94,6 @@ static const char *wrid_desc[] =3D {
     [RDMA_WRID_RECV_CONTROL] =3D "CONTROL RECV",
 };
=20
-/*
- * Work request IDs for IB SEND messages only (not RDMA writes).
- * This is used by the migration protocol to transmit
- * control messages (such as device state and registration commands)
- *
- * We could use more WRs, but we have enough for now.
- */
-enum {
-    RDMA_WRID_READY =3D 0,
-    RDMA_WRID_DATA,
-    RDMA_WRID_CONTROL,
-    RDMA_WRID_MAX,
-};
-
-/*
- * SEND/RECV IB Control Messages.
- */
-enum {
-    RDMA_CONTROL_NONE =3D 0,
-    RDMA_CONTROL_ERROR,
-    RDMA_CONTROL_READY,               /* ready to receive */
-    RDMA_CONTROL_QEMU_FILE,           /* QEMUFile-transmitted bytes */
-    RDMA_CONTROL_RAM_BLOCKS_REQUEST,  /* RAMBlock synchronization */
-    RDMA_CONTROL_RAM_BLOCKS_RESULT,   /* RAMBlock synchronization */
-    RDMA_CONTROL_COMPRESS,            /* page contains repeat values */
-    RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
-    RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration *=
/
-    RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
-    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
-    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
-};
-
-
-/*
- * Memory and MR structures used to represent an IB Send/Recv work reque=
st.
- * This is *not* used for RDMA writes, only IB Send/Recv.
- */
-typedef struct {
-    uint8_t  control[RDMA_CONTROL_MAX_BUFFER]; /* actual buffer to regis=
ter */
-    struct   ibv_mr *control_mr;               /* registration metadata =
*/
-    size_t   control_len;                      /* length of the message =
*/
-    uint8_t *control_curr;                     /* start of unconsumed by=
tes */
-} RDMAWorkRequestData;
-
 /*
  * Negotiate RDMA capabilities during connection-setup time.
  */
@@ -200,46 +114,6 @@ static void network_to_caps(RDMACapabilities *cap)
     cap->flags =3D ntohl(cap->flags);
 }
=20
-/*
- * Representation of a RAMBlock from an RDMA perspective.
- * This is not transmitted, only local.
- * This and subsequent structures cannot be linked lists
- * because we're using a single IB message to transmit
- * the information. It's small anyway, so a list is overkill.
- */
-typedef struct RDMALocalBlock {
-    char          *block_name;
-    uint8_t       *local_host_addr; /* local virtual address */
-    uint64_t       remote_host_addr; /* remote virtual address */
-    uint64_t       offset;
-    uint64_t       length;
-    struct         ibv_mr **pmr;    /* MRs for chunk-level registration =
*/
-    struct         ibv_mr *mr;      /* MR for non-chunk-level registrati=
on */
-    uint32_t      *remote_keys;     /* rkeys for chunk-level registratio=
n */
-    uint32_t       remote_rkey;     /* rkeys for non-chunk-level registr=
ation */
-    int            index;           /* which block are we */
-    unsigned int   src_index;       /* (Only used on dest) */
-    bool           is_ram_block;
-    int            nb_chunks;
-    unsigned long *transit_bitmap;
-    unsigned long *unregister_bitmap;
-} RDMALocalBlock;
-
-/*
- * Also represents a RAMblock, but only on the dest.
- * This gets transmitted by the dest during connection-time
- * to the source VM and then is used to populate the
- * corresponding RDMALocalBlock with
- * the information needed to perform the actual RDMA.
- */
-typedef struct QEMU_PACKED RDMADestBlock {
-    uint64_t remote_host_addr;
-    uint64_t offset;
-    uint64_t length;
-    uint32_t remote_rkey;
-    uint32_t padding;
-} RDMADestBlock;
-
 static const char *control_desc(unsigned int rdma_control)
 {
     static const char *strs[] =3D {
@@ -294,123 +168,6 @@ static void network_to_dest_block(RDMADestBlock *db=
)
     db->remote_rkey =3D ntohl(db->remote_rkey);
 }
=20
-/*
- * Virtual address of the above structures used for transmitting
- * the RAMBlock descriptions at connection-time.
- * This structure is *not* transmitted.
- */
-typedef struct RDMALocalBlocks {
-    int nb_blocks;
-    bool     init;             /* main memory init complete */
-    RDMALocalBlock *block;
-} RDMALocalBlocks;
-
-/*
- * Main data structure for RDMA state.
- * While there is only one copy of this structure being allocated right =
now,
- * this is the place where one would start if you wanted to consider
- * having more than one RDMA connection open at the same time.
- */
-typedef struct RDMAContext {
-    char *host;
-    int port;
-
-    RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
-
-    /*
-     * This is used by *_exchange_send() to figure out whether or not
-     * the initial "READY" message has already been received or not.
-     * This is because other functions may potentially poll() and detect
-     * the READY message before send() does, in which case we need to
-     * know if it completed.
-     */
-    int control_ready_expected;
-
-    /* number of outstanding writes */
-    int nb_sent;
-
-    /* store info about current buffer so that we can
-       merge it with future sends */
-    uint64_t current_addr;
-    uint64_t current_length;
-    /* index of ram block the current buffer belongs to */
-    int current_index;
-    /* index of the chunk in the current ram block */
-    int current_chunk;
-
-    bool pin_all;
-
-    /*
-     * infiniband-specific variables for opening the device
-     * and maintaining connection state and so forth.
-     *
-     * cm_id also has ibv_context, rdma_event_channel, and ibv_qp in
-     * cm_id->verbs, cm_id->channel, and cm_id->qp.
-     */
-    struct rdma_cm_id *cm_id;               /* connection manager ID */
-    struct rdma_cm_id *listen_id;
-    bool connected;
-
-    struct ibv_context          *verbs;
-    struct rdma_event_channel   *channel;
-    struct ibv_qp *qp;                      /* queue pair */
-    struct ibv_comp_channel *comp_channel;  /* completion channel */
-    struct ibv_pd *pd;                      /* protection domain */
-    struct ibv_cq *cq;                      /* completion queue */
-
-    /*
-     * If a previous write failed (perhaps because of a failed
-     * memory registration, then do not attempt any future work
-     * and remember the error state.
-     */
-    int error_state;
-    int error_reported;
-    int received_error;
-
-    /*
-     * Description of ram blocks used throughout the code.
-     */
-    RDMALocalBlocks local_ram_blocks;
-    RDMADestBlock  *dest_blocks;
-
-    /* Index of the next RAMBlock received during block registration */
-    unsigned int    next_src_index;
-
-    /*
-     * Migration on *destination* started.
-     * Then use coroutine yield function.
-     * Source runs in a thread, so we don't care.
-     */
-    int migration_started_on_destination;
-
-    int total_registrations;
-    int total_writes;
-
-    int unregister_current, unregister_next;
-    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
-
-    GHashTable *blockmap;
-
-    /* the RDMAContext for return path */
-    struct RDMAContext *return_path;
-    bool is_return_path;
-} RDMAContext;
-
-#define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
-#define QIO_CHANNEL_RDMA(obj)                                     \
-    OBJECT_CHECK(QIOChannelRDMA, (obj), TYPE_QIO_CHANNEL_RDMA)
-
-typedef struct QIOChannelRDMA QIOChannelRDMA;
-
-
-struct QIOChannelRDMA {
-    QIOChannel parent;
-    RDMAContext *rdmain;
-    RDMAContext *rdmaout;
-    QEMUFile *file;
-    bool blocking; /* XXX we don't actually honour this yet */
-};
-
 /*
  * Main structure for IB Send/Recv control messages.
  * This gets prepended at the beginning of every Send/Recv.
diff --git a/migration/rdma.h b/migration/rdma.h
index 3a00573083..cb206c7004 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -17,6 +17,253 @@
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
=20
+#include "qemu-file.h"
+#include "qemu-file-channel.h"
+
+#define RDMA_RESOLVE_TIMEOUT_MS 10000
+
+/* Do not merge data if larger than this. */
+#define RDMA_MERGE_MAX (2 * 1024 * 1024)
+#define RDMA_SIGNALED_SEND_MAX (RDMA_MERGE_MAX / 4096)
+
+#define RDMA_REG_CHUNK_SHIFT 20 /* 1 MB */
+
+/*
+ * This is only for non-live state being migrated.
+ * Instead of RDMA_WRITE messages, we use RDMA_SEND
+ * messages for that state, which requires a different
+ * delivery design than main memory.
+ */
+#define RDMA_SEND_INCREMENT 32768
+
+/*
+ * Maximum size infiniband SEND message
+ */
+#define RDMA_CONTROL_MAX_BUFFER (512 * 1024)
+#define RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE 4096
+
+#define RDMA_CONTROL_VERSION_CURRENT 1
+/*
+ * Capabilities for negotiation.
+ */
+#define RDMA_CAPABILITY_PIN_ALL 0x01
+
+/*
+ * RDMA migration protocol:
+ * 1. RDMA Writes (data messages, i.e. RAM)
+ * 2. IB Send/Recv (control channel messages)
+ */
+enum {
+    RDMA_WRID_NONE =3D 0,
+    RDMA_WRID_RDMA_WRITE =3D 1,
+    RDMA_WRID_SEND_CONTROL =3D 2000,
+    RDMA_WRID_RECV_CONTROL =3D 4000,
+};
+
+/*
+ * Work request IDs for IB SEND messages only (not RDMA writes).
+ * This is used by the migration protocol to transmit
+ * control messages (such as device state and registration commands)
+ *
+ * We could use more WRs, but we have enough for now.
+ */
+enum {
+    RDMA_WRID_READY =3D 0,
+    RDMA_WRID_DATA,
+    RDMA_WRID_CONTROL,
+    RDMA_WRID_MAX,
+};
+
+/*
+ * SEND/RECV IB Control Messages.
+ */
+enum {
+    RDMA_CONTROL_NONE =3D 0,
+    RDMA_CONTROL_ERROR,
+    RDMA_CONTROL_READY,               /* ready to receive */
+    RDMA_CONTROL_QEMU_FILE,           /* QEMUFile-transmitted bytes */
+    RDMA_CONTROL_RAM_BLOCKS_REQUEST,  /* RAMBlock synchronization */
+    RDMA_CONTROL_RAM_BLOCKS_RESULT,   /* RAMBlock synchronization */
+    RDMA_CONTROL_COMPRESS,            /* page contains repeat values */
+    RDMA_CONTROL_REGISTER_REQUEST,    /* dynamic page registration */
+    RDMA_CONTROL_REGISTER_RESULT,     /* key to use after registration *=
/
+    RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
+    RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
+    RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
+};
+
+
+/*
+ * Memory and MR structures used to represent an IB Send/Recv work reque=
st.
+ * This is *not* used for RDMA writes, only IB Send/Recv.
+ */
+typedef struct {
+    uint8_t  control[RDMA_CONTROL_MAX_BUFFER]; /* actual buffer to regis=
ter */
+    struct   ibv_mr *control_mr;               /* registration metadata =
*/
+    size_t   control_len;                      /* length of the message =
*/
+    uint8_t *control_curr;                     /* start of unconsumed by=
tes */
+} RDMAWorkRequestData;
+
+/*
+ * Representation of a RAMBlock from an RDMA perspective.
+ * This is not transmitted, only local.
+ * This and subsequent structures cannot be linked lists
+ * because we're using a single IB message to transmit
+ * the information. It's small anyway, so a list is overkill.
+ */
+typedef struct RDMALocalBlock {
+    char          *block_name;
+    uint8_t       *local_host_addr; /* local virtual address */
+    uint64_t       remote_host_addr; /* remote virtual address */
+    uint64_t       offset;
+    uint64_t       length;
+    struct         ibv_mr **pmr;    /* MRs for chunk-level registration =
*/
+    struct         ibv_mr *mr;      /* MR for non-chunk-level registrati=
on */
+    uint32_t      *remote_keys;     /* rkeys for chunk-level registratio=
n */
+    uint32_t       remote_rkey;     /* rkeys for non-chunk-level registr=
ation */
+    int            index;           /* which block are we */
+    unsigned int   src_index;       /* (Only used on dest) */
+    bool           is_ram_block;
+    int            nb_chunks;
+    unsigned long *transit_bitmap;
+    unsigned long *unregister_bitmap;
+} RDMALocalBlock;
+
+/*
+ * Also represents a RAMblock, but only on the dest.
+ * This gets transmitted by the dest during connection-time
+ * to the source VM and then is used to populate the
+ * corresponding RDMALocalBlock with
+ * the information needed to perform the actual RDMA.
+ */
+typedef struct QEMU_PACKED RDMADestBlock {
+    uint64_t remote_host_addr;
+    uint64_t offset;
+    uint64_t length;
+    uint32_t remote_rkey;
+    uint32_t padding;
+} RDMADestBlock;
+
+/*
+ * Virtual address of the above structures used for transmitting
+ * the RAMBlock descriptions at connection-time.
+ * This structure is *not* transmitted.
+ */
+typedef struct RDMALocalBlocks {
+    int nb_blocks;
+    bool     init;             /* main memory init complete */
+    RDMALocalBlock *block;
+} RDMALocalBlocks;
+
+/*
+ * Main data structure for RDMA state.
+ * While there is only one copy of this structure being allocated right =
now,
+ * this is the place where one would start if you wanted to consider
+ * having more than one RDMA connection open at the same time.
+ */
+typedef struct RDMAContext {
+    char *host;
+    int port;
+
+    RDMAWorkRequestData wr_data[RDMA_WRID_MAX];
+
+    /*
+     * This is used by *_exchange_send() to figure out whether or not
+     * the initial "READY" message has already been received or not.
+     * This is because other functions may potentially poll() and detect
+     * the READY message before send() does, in which case we need to
+     * know if it completed.
+     */
+    int control_ready_expected;
+
+    /* number of outstanding writes */
+    int nb_sent;
+
+    /*
+     * store info about current buffer so that we can
+     * merge it with future sends
+     */
+    uint64_t current_addr;
+    uint64_t current_length;
+    /* index of ram block the current buffer belongs to */
+    int current_index;
+    /* index of the chunk in the current ram block */
+    int current_chunk;
+
+    bool pin_all;
+
+    /*
+     * infiniband-specific variables for opening the device
+     * and maintaining connection state and so forth.
+     *
+     * cm_id also has ibv_context, rdma_event_channel, and ibv_qp in
+     * cm_id->verbs, cm_id->channel, and cm_id->qp.
+     */
+    struct rdma_cm_id *cm_id;               /* connection manager ID */
+    struct rdma_cm_id *listen_id;
+    bool connected;
+
+    struct ibv_context          *verbs;
+    struct rdma_event_channel   *channel;
+    struct ibv_qp *qp;                      /* queue pair */
+    struct ibv_comp_channel *comp_channel;  /* completion channel */
+    struct ibv_pd *pd;                      /* protection domain */
+    struct ibv_cq *cq;                      /* completion queue */
+
+    /*
+     * If a previous write failed (perhaps because of a failed
+     * memory registration, then do not attempt any future work
+     * and remember the error state.
+     */
+    int error_state;
+    int error_reported;
+    int received_error;
+
+    /*
+     * Description of ram blocks used throughout the code.
+     */
+    RDMALocalBlocks local_ram_blocks;
+    RDMADestBlock  *dest_blocks;
+
+    /* Index of the next RAMBlock received during block registration */
+    unsigned int    next_src_index;
+
+    /*
+     * Migration on *destination* started.
+     * Then use coroutine yield function.
+     * Source runs in a thread, so we don't care.
+     */
+    int migration_started_on_destination;
+
+    int total_registrations;
+    int total_writes;
+
+    int unregister_current, unregister_next;
+    uint64_t unregistrations[RDMA_SIGNALED_SEND_MAX];
+
+    GHashTable *blockmap;
+
+    /* the RDMAContext for return path */
+    struct RDMAContext *return_path;
+    bool is_return_path;
+} RDMAContext;
+
+#define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
+#define QIO_CHANNEL_RDMA(obj)                                     \
+    OBJECT_CHECK(QIOChannelRDMA, (obj), TYPE_QIO_CHANNEL_RDMA)
+
+typedef struct QIOChannelRDMA QIOChannelRDMA;
+
+
+struct QIOChannelRDMA {
+    QIOChannel parent;
+    RDMAContext *rdmain;
+    RDMAContext *rdmaout;
+    QEMUFile *file;
+    bool blocking; /* XXX we don't actually honour this yet */
+};
+
+
 void *multifd_rdma_recv_thread(void *opaque);
 void *multifd_rdma_send_thread(void *opaque);
=20
--=20
2.19.1



