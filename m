Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB288C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB4420EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB4420EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzMf-0005q5-77
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLp-0004HV-AG
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:57 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLm-0003G1-Sc
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:56 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLc-00087d-DZ; Sun, 20 Sep 2020 15:25:44 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/3] Add Hyper-V Dynamic Memory Protocol definitions
Date: Sun, 20 Sep 2020 15:25:21 +0200
Message-Id: <cb27fc9df2b5118a15bf132a2c7ebee5ad6b1ef4.1600556526.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600556526.git.maciej.szmigiero@oracle.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:25:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This commit adds Hyper-V Dynamic Memory Protocol definitions, taken
from hv_balloon Linux kernel driver, adapted to the QEMU coding style and
definitions.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/hw/hyperv/dynmem-proto.h | 425 +++++++++++++++++++++++++++++++
 1 file changed, 425 insertions(+)
 create mode 100644 include/hw/hyperv/dynmem-proto.h

diff --git a/include/hw/hyperv/dynmem-proto.h b/include/hw/hyperv/dynmem-proto.h
new file mode 100644
index 000000000000..407cc54b00a8
--- /dev/null
+++ b/include/hw/hyperv/dynmem-proto.h
@@ -0,0 +1,425 @@
+#ifndef HW_HYPERV_DYNMEM_PROTO_H
+#define HW_HYPERV_DYNMEM_PROTO_H
+
+/*
+ * Hyper-V Dynamic Memory Protocol definitions
+ *
+ * Copyright (C) 2020 Oracle and/or its affiliates.
+ *
+ * Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
+ *
+ * Based on drivers/hv/hv_balloon.c from Linux kernel:
+ * Copyright (c) 2012, Microsoft Corporation.
+ *
+ * Author: K. Y. Srinivasan <kys@microsoft.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Protocol versions. The low word is the minor version, the high word the major
+ * version.
+ *
+ * History:
+ * Initial version 1.0
+ * Changed to 0.1 on 2009/03/25
+ * Changes to 0.2 on 2009/05/14
+ * Changes to 0.3 on 2009/12/03
+ * Changed to 1.0 on 2011/04/05
+ * Changed to 2.0 on 2019/12/10
+ */
+
+#define DYNMEM_MAKE_VERSION(Major, Minor) ((uint32_t)(((Major) << 16) | (Minor)))
+#define DYNMEM_MAJOR_VERSION(Version) ((uint32_t)(Version) >> 16)
+#define DYNMEM_MINOR_VERSION(Version) ((uint32_t)(Version) & 0xff)
+
+enum {
+    DYNMEM_PROTOCOL_VERSION_1 = DYNMEM_MAKE_VERSION(0, 3),
+    DYNMEM_PROTOCOL_VERSION_2 = DYNMEM_MAKE_VERSION(1, 0),
+    DYNMEM_PROTOCOL_VERSION_3 = DYNMEM_MAKE_VERSION(2, 0),
+
+    DYNMEM_PROTOCOL_VERSION_WIN7 = DYNMEM_PROTOCOL_VERSION_1,
+    DYNMEM_PROTOCOL_VERSION_WIN8 = DYNMEM_PROTOCOL_VERSION_2,
+    DYNMEM_PROTOCOL_VERSION_WIN10 = DYNMEM_PROTOCOL_VERSION_3,
+
+    DYNMEM_PROTOCOL_VERSION_CURRENT = DYNMEM_PROTOCOL_VERSION_WIN10
+};
+
+
+
+/*
+ * Message Types
+ */
+
+enum dm_message_type {
+    /*
+     * Version 0.3
+     */
+    DM_ERROR = 0,
+    DM_VERSION_REQUEST = 1,
+    DM_VERSION_RESPONSE = 2,
+    DM_CAPABILITIES_REPORT = 3,
+    DM_CAPABILITIES_RESPONSE = 4,
+    DM_STATUS_REPORT = 5,
+    DM_BALLOON_REQUEST = 6,
+    DM_BALLOON_RESPONSE = 7,
+    DM_UNBALLOON_REQUEST = 8,
+    DM_UNBALLOON_RESPONSE = 9,
+    DM_MEM_HOT_ADD_REQUEST = 10,
+    DM_MEM_HOT_ADD_RESPONSE = 11,
+    DM_VERSION_03_MAX = 11,
+    /*
+     * Version 1.0.
+     */
+    DM_INFO_MESSAGE = 12,
+    DM_VERSION_1_MAX = 12,
+
+    /*
+     * Version 2.0
+     */
+    DM_MEM_HOT_REMOVE_REQUEST = 13,
+    DM_MEM_HOT_REMOVE_RESPONSE = 14
+};
+
+
+/*
+ * Structures defining the dynamic memory management
+ * protocol.
+ */
+
+union dm_version {
+    struct {
+        uint16_t minor_version;
+        uint16_t major_version;
+    };
+    uint32_t version;
+} QEMU_PACKED;
+
+
+union dm_caps {
+    struct {
+        uint64_t balloon:1;
+        uint64_t hot_add:1;
+        /*
+         * To support guests that may have alignment
+         * limitations on hot-add, the guest can specify
+         * its alignment requirements; a value of n
+         * represents an alignment of 2^n in mega bytes.
+         */
+        uint64_t hot_add_alignment:4;
+        uint64_t hot_remove:1;
+        uint64_t reservedz:57;
+    } cap_bits;
+    uint64_t caps;
+} QEMU_PACKED;
+
+union dm_mem_page_range {
+    struct  {
+        /*
+         * The PFN number of the first page in the range.
+         * 40 bits is the architectural limit of a PFN
+         * number for AMD64.
+         */
+        uint64_t start_page:40;
+        /*
+         * The number of pages in the range.
+         */
+        uint64_t page_cnt:24;
+    } finfo;
+    uint64_t  page_range;
+} QEMU_PACKED;
+
+
+
+/*
+ * The header for all dynamic memory messages:
+ *
+ * type: Type of the message.
+ * size: Size of the message in bytes; including the header.
+ * trans_id: The guest is responsible for manufacturing this ID.
+ */
+
+struct dm_header {
+    uint16_t type;
+    uint16_t size;
+    uint32_t trans_id;
+} QEMU_PACKED;
+
+/*
+ * A generic message format for dynamic memory.
+ * Specific message formats are defined later in the file.
+ */
+
+struct dm_message {
+    struct dm_header hdr;
+    uint8_t data[]; /* enclosed message */
+} QEMU_PACKED;
+
+
+/*
+ * Specific message types supporting the dynamic memory protocol.
+ */
+
+/*
+ * Version negotiation message. Sent from the guest to the host.
+ * The guest is free to try different versions until the host
+ * accepts the version.
+ *
+ * dm_version: The protocol version requested.
+ * is_last_attempt: If TRUE, this is the last version guest will request.
+ * reservedz: Reserved field, set to zero.
+ */
+
+struct dm_version_request {
+    struct dm_header hdr;
+    union dm_version version;
+    uint32_t is_last_attempt:1;
+    uint32_t reservedz:31;
+} QEMU_PACKED;
+
+/*
+ * Version response message; Host to Guest and indicates
+ * if the host has accepted the version sent by the guest.
+ *
+ * is_accepted: If TRUE, host has accepted the version and the guest
+ * should proceed to the next stage of the protocol. FALSE indicates that
+ * guest should re-try with a different version.
+ *
+ * reservedz: Reserved field, set to zero.
+ */
+
+struct dm_version_response {
+    struct dm_header hdr;
+    uint64_t is_accepted:1;
+    uint64_t reservedz:63;
+} QEMU_PACKED;
+
+/*
+ * Message reporting capabilities. This is sent from the guest to the
+ * host.
+ */
+
+struct dm_capabilities {
+    struct dm_header hdr;
+    union dm_caps caps;
+    uint64_t min_page_cnt;
+    uint64_t max_page_number;
+} QEMU_PACKED;
+
+/*
+ * Response to the capabilities message. This is sent from the host to the
+ * guest. This message notifies if the host has accepted the guest's
+ * capabilities. If the host has not accepted, the guest must shutdown
+ * the service.
+ *
+ * is_accepted: Indicates if the host has accepted guest's capabilities.
+ * reservedz: Must be 0.
+ */
+
+struct dm_capabilities_resp_msg {
+    struct dm_header hdr;
+    uint64_t is_accepted:1;
+    uint64_t hot_remove:1;
+    uint64_t suppress_pressure_reports:1;
+    uint64_t reservedz:61;
+} QEMU_PACKED;
+
+/*
+ * This message is used to report memory pressure from the guest.
+ * This message is not part of any transaction and there is no
+ * response to this message.
+ *
+ * num_avail: Available memory in pages.
+ * num_committed: Committed memory in pages.
+ * page_file_size: The accumulated size of all page files
+ *                 in the system in pages.
+ * zero_free: The nunber of zero and free pages.
+ * page_file_writes: The writes to the page file in pages.
+ * io_diff: An indicator of file cache efficiency or page file activity,
+ *          calculated as File Cache Page Fault Count - Page Read Count.
+ *          This value is in pages.
+ *
+ * Some of these metrics are Windows specific and fortunately
+ * the algorithm on the host side that computes the guest memory
+ * pressure only uses num_committed value.
+ */
+
+struct dm_status {
+    struct dm_header hdr;
+    uint64_t num_avail;
+    uint64_t num_committed;
+    uint64_t page_file_size;
+    uint64_t zero_free;
+    uint32_t page_file_writes;
+    uint32_t io_diff;
+} QEMU_PACKED;
+
+
+/*
+ * Message to ask the guest to allocate memory - balloon up message.
+ * This message is sent from the host to the guest. The guest may not be
+ * able to allocate as much memory as requested.
+ *
+ * num_pages: number of pages to allocate.
+ */
+
+struct dm_balloon {
+    struct dm_header hdr;
+    uint32_t num_pages;
+    uint32_t reservedz;
+} QEMU_PACKED;
+
+
+/*
+ * Balloon response message; this message is sent from the guest
+ * to the host in response to the balloon message.
+ *
+ * reservedz: Reserved; must be set to zero.
+ * more_pages: If FALSE, this is the last message of the transaction.
+ * if TRUE there will atleast one more message from the guest.
+ *
+ * range_count: The number of ranges in the range array.
+ *
+ * range_array: An array of page ranges returned to the host.
+ *
+ */
+
+struct dm_balloon_response {
+    struct dm_header hdr;
+    uint32_t reservedz;
+    uint32_t more_pages:1;
+    uint32_t range_count:31;
+    union dm_mem_page_range range_array[];
+} QEMU_PACKED;
+
+/*
+ * Un-balloon message; this message is sent from the host
+ * to the guest to give guest more memory.
+ *
+ * more_pages: If FALSE, this is the last message of the transaction.
+ * if TRUE there will atleast one more message from the guest.
+ *
+ * reservedz: Reserved; must be set to zero.
+ *
+ * range_count: The number of ranges in the range array.
+ *
+ * range_array: An array of page ranges returned to the host.
+ *
+ */
+
+struct dm_unballoon_request {
+    struct dm_header hdr;
+    uint32_t more_pages:1;
+    uint32_t reservedz:31;
+    uint32_t range_count;
+    union dm_mem_page_range range_array[];
+} QEMU_PACKED;
+
+/*
+ * Un-balloon response message; this message is sent from the guest
+ * to the host in response to an unballoon request.
+ *
+ */
+
+struct dm_unballoon_response {
+    struct dm_header hdr;
+} QEMU_PACKED;
+
+
+/*
+ * Hot add request message. Message sent from the host to the guest.
+ *
+ * mem_range: Memory range to hot add.
+ *
+ */
+
+struct dm_hot_add {
+    struct dm_header hdr;
+    union dm_mem_page_range range;
+} QEMU_PACKED;
+
+/*
+ * Hot add response message.
+ * This message is sent by the guest to report the status of a hot add request.
+ * If page_count is less than the requested page count, then the host should
+ * assume all further hot add requests will fail, since this indicates that
+ * the guest has hit an upper physical memory barrier.
+ *
+ * Hot adds may also fail due to low resources; in this case, the guest must
+ * not complete this message until the hot add can succeed, and the host must
+ * not send a new hot add request until the response is sent.
+ * If VSC fails to hot add memory DYNMEM_NUMBER_OF_UNSUCCESSFUL_HOTADD_ATTEMPTS
+ * times it fails the request.
+ *
+ *
+ * page_count: number of pages that were successfully hot added.
+ *
+ * result: result of the operation 1: success, 0: failure.
+ *
+ */
+
+struct dm_hot_add_response {
+    struct dm_header hdr;
+    uint32_t page_count;
+    uint32_t result;
+} QEMU_PACKED;
+
+struct dm_hot_remove {
+    struct dm_header hdr;
+    uint32_t virtual_node;
+    uint32_t page_count;
+    uint32_t qos_flags;
+    uint32_t reservedZ;
+} QEMU_PACKED;
+
+struct dm_hot_remove_response {
+    struct dm_header hdr;
+    uint32_t result;
+    uint32_t range_count;
+    uint64_t more_pages:1;
+    uint64_t reservedz:63;
+    union dm_mem_page_range range_array[];
+} QEMU_PACKED;
+
+#define DM_REMOVE_QOS_LARGE (1 << 0)
+#define DM_REMOVE_QOS_LOCAL (1 << 1)
+#define DM_REMOVE_QOS_MASK (0x3)
+
+/*
+ * Types of information sent from host to the guest.
+ */
+
+enum dm_info_type {
+    INFO_TYPE_MAX_PAGE_CNT = 0,
+    MAX_INFO_TYPE
+};
+
+
+/*
+ * Header for the information message.
+ */
+
+struct dm_info_header {
+    enum dm_info_type type;
+    uint32_t data_size;
+    uint8_t  data[];
+} QEMU_PACKED;
+
+/*
+ * This message is sent from the host to the guest to pass
+ * some relevant information (win8 addition).
+ *
+ * reserved: no used.
+ * info_size: size of the information blob.
+ * info: information blob.
+ */
+
+struct dm_info_msg {
+    struct dm_header hdr;
+    uint32_t reserved;
+    uint32_t info_size;
+    uint8_t  info[];
+};
+
+#endif

