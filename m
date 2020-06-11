Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691902073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm/bG0YX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691902073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTLg-00033m-KB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8a-0007aC-IN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38724
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8W-0000tw-MX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtxO6BHV6g2zCUKIB0YNiqh82uRelwV67KidagQ0NP8=;
 b=Cm/bG0YXSLUBy6oRtdJFjqaP9p/rRHbwCGyaW5IyMNsZWvaMZAQmXlaM3YZ6zRvZb27EVo
 PQNbOVdP4UKQvVYSF1Cw56q/OQ2Jz/l/uFSePaz9TbtqhTQY/25PfzBTEHKLu/EWiirMxt
 FeZZbn7uWrpbrTLaLx8teq4uYcUtMvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-IZnGZ1zRMMyN76i9MgRwdQ-1; Thu, 11 Jun 2020 15:45:10 -0400
X-MC-Unique: IZnGZ1zRMMyN76i9MgRwdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8938F1800D41;
 Thu, 11 Jun 2020 19:45:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D85C860CD3;
 Thu, 11 Jun 2020 19:45:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 018/115] vmbus: add vmbus protocol definitions
Date: Thu, 11 Jun 2020 15:43:12 -0400
Message-Id: <20200611194449.31468-19-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Add a header with data structures and constants used in Hyper-V VMBus
hypervisor <-> guest interactions.

Based on the respective stuff from Linux kernel.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
Message-Id: <20200424123444.3481728-3-arilou@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/vmbus-proto.h | 222 ++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 include/hw/hyperv/vmbus-proto.h

diff --git a/include/hw/hyperv/vmbus-proto.h b/include/hw/hyperv/vmbus-proto.h
new file mode 100644
index 0000000000..4628d3b323
--- /dev/null
+++ b/include/hw/hyperv/vmbus-proto.h
@@ -0,0 +1,222 @@
+/*
+ * QEMU Hyper-V VMBus support
+ *
+ * Copyright (c) 2017-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_VMBUS_PROTO_H
+#define HW_HYPERV_VMBUS_PROTO_H
+
+#define VMBUS_VERSION_WS2008                    ((0 << 16) | (13))
+#define VMBUS_VERSION_WIN7                      ((1 << 16) | (1))
+#define VMBUS_VERSION_WIN8                      ((2 << 16) | (4))
+#define VMBUS_VERSION_WIN8_1                    ((3 << 16) | (0))
+#define VMBUS_VERSION_WIN10                     ((4 << 16) | (0))
+#define VMBUS_VERSION_INVAL                     -1
+#define VMBUS_VERSION_CURRENT                   VMBUS_VERSION_WIN10
+
+#define VMBUS_MESSAGE_CONNECTION_ID             1
+#define VMBUS_EVENT_CONNECTION_ID               2
+#define VMBUS_MONITOR_CONNECTION_ID             3
+#define VMBUS_SINT                              2
+
+#define VMBUS_MSG_INVALID               0
+#define VMBUS_MSG_OFFERCHANNEL          1
+#define VMBUS_MSG_RESCIND_CHANNELOFFER  2
+#define VMBUS_MSG_REQUESTOFFERS         3
+#define VMBUS_MSG_ALLOFFERS_DELIVERED   4
+#define VMBUS_MSG_OPENCHANNEL           5
+#define VMBUS_MSG_OPENCHANNEL_RESULT    6
+#define VMBUS_MSG_CLOSECHANNEL          7
+#define VMBUS_MSG_GPADL_HEADER          8
+#define VMBUS_MSG_GPADL_BODY            9
+#define VMBUS_MSG_GPADL_CREATED         10
+#define VMBUS_MSG_GPADL_TEARDOWN        11
+#define VMBUS_MSG_GPADL_TORNDOWN        12
+#define VMBUS_MSG_RELID_RELEASED        13
+#define VMBUS_MSG_INITIATE_CONTACT      14
+#define VMBUS_MSG_VERSION_RESPONSE      15
+#define VMBUS_MSG_UNLOAD                16
+#define VMBUS_MSG_UNLOAD_RESPONSE       17
+#define VMBUS_MSG_COUNT                 18
+
+#define VMBUS_MESSAGE_SIZE_ALIGN        sizeof(uint64_t)
+
+#define VMBUS_PACKET_INVALID                    0x0
+#define VMBUS_PACKET_SYNCH                      0x1
+#define VMBUS_PACKET_ADD_XFER_PAGESET           0x2
+#define VMBUS_PACKET_RM_XFER_PAGESET            0x3
+#define VMBUS_PACKET_ESTABLISH_GPADL            0x4
+#define VMBUS_PACKET_TEARDOWN_GPADL             0x5
+#define VMBUS_PACKET_DATA_INBAND                0x6
+#define VMBUS_PACKET_DATA_USING_XFER_PAGES      0x7
+#define VMBUS_PACKET_DATA_USING_GPADL           0x8
+#define VMBUS_PACKET_DATA_USING_GPA_DIRECT      0x9
+#define VMBUS_PACKET_CANCEL_REQUEST             0xa
+#define VMBUS_PACKET_COMP                       0xb
+#define VMBUS_PACKET_DATA_USING_ADDITIONAL_PKT  0xc
+#define VMBUS_PACKET_ADDITIONAL_DATA            0xd
+
+#define VMBUS_CHANNEL_USER_DATA_SIZE            120
+
+#define VMBUS_OFFER_MONITOR_ALLOCATED           0x1
+#define VMBUS_OFFER_INTERRUPT_DEDICATED         0x1
+
+#define VMBUS_RING_BUFFER_FEAT_PENDING_SZ       (1ul << 0)
+
+#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE      0x1
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES  0x2
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS          0x4
+#define VMBUS_CHANNEL_NAMED_PIPE_MODE                 0x10
+#define VMBUS_CHANNEL_LOOPBACK_OFFER                  0x100
+#define VMBUS_CHANNEL_PARENT_OFFER                    0x200
+#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION  0x400
+#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER            0x2000
+
+#define VMBUS_PACKET_FLAG_REQUEST_COMPLETION    1
+
+typedef struct vmbus_message_header {
+    uint32_t message_type;
+    uint32_t _padding;
+} vmbus_message_header;
+
+typedef struct vmbus_message_initiate_contact {
+    vmbus_message_header header;
+    uint32_t version_requested;
+    uint32_t target_vcpu;
+    uint64_t interrupt_page;
+    uint64_t monitor_page1;
+    uint64_t monitor_page2;
+} vmbus_message_initiate_contact;
+
+typedef struct vmbus_message_version_response {
+    vmbus_message_header header;
+    uint8_t version_supported;
+    uint8_t status;
+} vmbus_message_version_response;
+
+typedef struct vmbus_message_offer_channel {
+    vmbus_message_header header;
+    uint8_t  type_uuid[16];
+    uint8_t  instance_uuid[16];
+    uint64_t _reserved1;
+    uint64_t _reserved2;
+    uint16_t channel_flags;
+    uint16_t mmio_size_mb;
+    uint8_t  user_data[VMBUS_CHANNEL_USER_DATA_SIZE];
+    uint16_t sub_channel_index;
+    uint16_t _reserved3;
+    uint32_t child_relid;
+    uint8_t  monitor_id;
+    uint8_t  monitor_flags;
+    uint16_t interrupt_flags;
+    uint32_t connection_id;
+} vmbus_message_offer_channel;
+
+typedef struct vmbus_message_rescind_channel_offer {
+    vmbus_message_header header;
+    uint32_t child_relid;
+} vmbus_message_rescind_channel_offer;
+
+typedef struct vmbus_gpa_range {
+    uint32_t byte_count;
+    uint32_t byte_offset;
+    uint64_t pfn_array[];
+} vmbus_gpa_range;
+
+typedef struct vmbus_message_gpadl_header {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+    uint16_t range_buflen;
+    uint16_t rangecount;
+    vmbus_gpa_range range[];
+} QEMU_PACKED vmbus_message_gpadl_header;
+
+typedef struct vmbus_message_gpadl_body {
+    vmbus_message_header header;
+    uint32_t message_number;
+    uint32_t gpadl_id;
+    uint64_t pfn_array[];
+} vmbus_message_gpadl_body;
+
+typedef struct vmbus_message_gpadl_created {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+    uint32_t status;
+} vmbus_message_gpadl_created;
+
+typedef struct vmbus_message_gpadl_teardown {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t gpadl_id;
+} vmbus_message_gpadl_teardown;
+
+typedef struct vmbus_message_gpadl_torndown {
+    vmbus_message_header header;
+    uint32_t gpadl_id;
+} vmbus_message_gpadl_torndown;
+
+typedef struct vmbus_message_open_channel {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t open_id;
+    uint32_t ring_buffer_gpadl_id;
+    uint32_t target_vp;
+    uint32_t ring_buffer_offset;
+    uint8_t  user_data[VMBUS_CHANNEL_USER_DATA_SIZE];
+} vmbus_message_open_channel;
+
+typedef struct vmbus_message_open_result {
+    vmbus_message_header header;
+    uint32_t child_relid;
+    uint32_t open_id;
+    uint32_t status;
+} vmbus_message_open_result;
+
+typedef struct vmbus_message_close_channel {
+    vmbus_message_header header;
+    uint32_t child_relid;
+} vmbus_message_close_channel;
+
+typedef struct vmbus_ring_buffer {
+    uint32_t write_index;
+    uint32_t read_index;
+    uint32_t interrupt_mask;
+    uint32_t pending_send_sz;
+    uint32_t _reserved1[12];
+    uint32_t feature_bits;
+} vmbus_ring_buffer;
+
+typedef struct vmbus_packet_hdr {
+    uint16_t type;
+    uint16_t offset_qwords;
+    uint16_t len_qwords;
+    uint16_t flags;
+    uint64_t transaction_id;
+} vmbus_packet_hdr;
+
+typedef struct vmbus_pkt_gpa_direct {
+    uint32_t _reserved;
+    uint32_t rangecount;
+    vmbus_gpa_range range[];
+} vmbus_pkt_gpa_direct;
+
+typedef struct vmbus_xferpg_range {
+    uint32_t byte_count;
+    uint32_t byte_offset;
+} vmbus_xferpg_range;
+
+typedef struct vmbus_pkt_xferpg {
+    uint16_t buffer_id;
+    uint8_t sender_owns_set;
+    uint8_t _reserved;
+    uint32_t rangecount;
+    vmbus_xferpg_range range[];
+} vmbus_pkt_xferpg;
+
+#endif
-- 
2.26.2



