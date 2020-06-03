Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4710E204EF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0pdcbSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4710E204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUoG-0005MM-Fx
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUii-0008Vq-Vm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jgUih-0008M2-Nd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591195818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lR2dKEWAeOpjQB8jU4uHsPdZUiJLgejeDRcLaul9r/w=;
 b=Y0pdcbSmgNhThMwMldO/508/xy053pojjupmYI2njjRsE8gPikd3G005NKTbs8L4jOcQ2O
 EKglCBOW+uxZojcP43fCvfq4gN2tTi4dWOExXTVmi6OsoaCoBtg1ur27gMLp5MXyBu1XUM
 NaA4XG9JUXpQ/kSMvqlCQkU4WcMrUnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-izDZsQcLPaOF43zZnn0CVA-1; Wed, 03 Jun 2020 10:50:17 -0400
X-MC-Unique: izDZsQcLPaOF43zZnn0CVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23C319067E0;
 Wed,  3 Jun 2020 14:50:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F411D5D9CD;
 Wed,  3 Jun 2020 14:50:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/20] linux-headers: update to contain virtio-mem
Date: Wed,  3 Jun 2020 16:49:03 +0200
Message-Id: <20200603144914.41645-10-david@redhat.com>
In-Reply-To: <20200603144914.41645-1-david@redhat.com>
References: <20200603144914.41645-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be merged hopefully soon. Then, we can replace this by a proper
header sync.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h |   1 +
 include/standard-headers/linux/virtio_mem.h | 211 ++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_mem.h

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index ecc27a1740..b052355ac7 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -44,6 +44,7 @@
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
 #define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_MEM          24 /* virtio mem */
 #define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
 #define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
diff --git a/include/standard-headers/linux/virtio_mem.h b/include/standard-headers/linux/virtio_mem.h
new file mode 100644
index 0000000000..c32164f43d
--- /dev/null
+++ b/include/standard-headers/linux/virtio_mem.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Virtio Mem Device
+ *
+ * Copyright Red Hat, Inc. 2020
+ *
+ * Authors:
+ *     David Hildenbrand <david@redhat.com>
+ *
+ * This header is BSD licensed so anyone can use the definitions
+ * to implement compatible drivers/servers:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef _LINUX_VIRTIO_MEM_H
+#define _LINUX_VIRTIO_MEM_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+
+/*
+ * Each virtio-mem device manages a dedicated region in physical address
+ * space. Each device can belong to a single NUMA node, multiple devices
+ * for a single NUMA node are possible. A virtio-mem device is like a
+ * "resizable DIMM" consisting of small memory blocks that can be plugged
+ * or unplugged. The device driver is responsible for (un)plugging memory
+ * blocks on demand.
+ *
+ * Virtio-mem devices can only operate on their assigned memory region in
+ * order to (un)plug memory. A device cannot (un)plug memory belonging to
+ * other devices.
+ *
+ * The "region_size" corresponds to the maximum amount of memory that can
+ * be provided by a device. The "size" corresponds to the amount of memory
+ * that is currently plugged. "requested_size" corresponds to a request
+ * from the device to the device driver to (un)plug blocks. The
+ * device driver should try to (un)plug blocks in order to reach the
+ * "requested_size". It is impossible to plug more memory than requested.
+ *
+ * The "usable_region_size" represents the memory region that can actually
+ * be used to (un)plug memory. It is always at least as big as the
+ * "requested_size" and will grow dynamically. It will only shrink when
+ * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
+ *
+ * There are no guarantees what will happen if unplugged memory is
+ * read/written. Such memory should, in general, not be touched. E.g.,
+ * even writing might succeed, but the values will simply be discarded at
+ * random points in time.
+ *
+ * It can happen that the device cannot process a request, because it is
+ * busy. The device driver has to retry later.
+ *
+ * Usually, during system resets all memory will get unplugged, so the
+ * device driver can start with a clean state. However, in specific
+ * scenarios (if the device is busy) it can happen that the device still
+ * has memory plugged. The device driver can request to unplug all memory
+ * (VIRTIO_MEM_REQ_UNPLUG) - which might take a while to succeed if the
+ * device is busy.
+ */
+
+/* --- virtio-mem: feature bits --- */
+
+/* node_id is an ACPI PXM and is valid */
+#define VIRTIO_MEM_F_ACPI_PXM		0
+
+
+/* --- virtio-mem: guest -> host requests --- */
+
+/* request to plug memory blocks */
+#define VIRTIO_MEM_REQ_PLUG			0
+/* request to unplug memory blocks */
+#define VIRTIO_MEM_REQ_UNPLUG			1
+/* request to unplug all blocks and shrink the usable size */
+#define VIRTIO_MEM_REQ_UNPLUG_ALL		2
+/* request information about the plugged state of memory blocks */
+#define VIRTIO_MEM_REQ_STATE			3
+
+struct virtio_mem_req_plug {
+	__virtio64 addr;
+	__virtio16 nb_blocks;
+	__virtio16 padding[3];
+};
+
+struct virtio_mem_req_unplug {
+	__virtio64 addr;
+	__virtio16 nb_blocks;
+	__virtio16 padding[3];
+};
+
+struct virtio_mem_req_state {
+	__virtio64 addr;
+	__virtio16 nb_blocks;
+	__virtio16 padding[3];
+};
+
+struct virtio_mem_req {
+	__virtio16 type;
+	__virtio16 padding[3];
+
+	union {
+		struct virtio_mem_req_plug plug;
+		struct virtio_mem_req_unplug unplug;
+		struct virtio_mem_req_state state;
+	} u;
+};
+
+
+/* --- virtio-mem: host -> guest response --- */
+
+/*
+ * Request processed successfully, applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_UNPLUG_ALL
+ * - VIRTIO_MEM_REQ_STATE
+ */
+#define VIRTIO_MEM_RESP_ACK			0
+/*
+ * Request denied - e.g. trying to plug more than requested, applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ */
+#define VIRTIO_MEM_RESP_NACK			1
+/*
+ * Request cannot be processed right now, try again later, applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_UNPLUG_ALL
+ */
+#define VIRTIO_MEM_RESP_BUSY			2
+/*
+ * Error in request (e.g. addresses/alignment), applicable for
+ * - VIRTIO_MEM_REQ_PLUG
+ * - VIRTIO_MEM_REQ_UNPLUG
+ * - VIRTIO_MEM_REQ_STATE
+ */
+#define VIRTIO_MEM_RESP_ERROR			3
+
+
+/* State of memory blocks is "plugged" */
+#define VIRTIO_MEM_STATE_PLUGGED		0
+/* State of memory blocks is "unplugged" */
+#define VIRTIO_MEM_STATE_UNPLUGGED		1
+/* State of memory blocks is "mixed" */
+#define VIRTIO_MEM_STATE_MIXED			2
+
+struct virtio_mem_resp_state {
+	__virtio16 state;
+};
+
+struct virtio_mem_resp {
+	__virtio16 type;
+	__virtio16 padding[3];
+
+	union {
+		struct virtio_mem_resp_state state;
+	} u;
+};
+
+/* --- virtio-mem: configuration --- */
+
+struct virtio_mem_config {
+	/* Block size and alignment. Cannot change. */
+	uint32_t block_size;
+	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
+	uint16_t node_id;
+	uint16_t padding;
+	/* Start address of the memory region. Cannot change. */
+	uint64_t addr;
+	/* Region size (maximum). Cannot change. */
+	uint64_t region_size;
+	/*
+	 * Currently usable region size. Can grow up to region_size. Can
+	 * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
+	 * update will be sent).
+	 */
+	uint64_t usable_region_size;
+	/*
+	 * Currently used size. Changes due to plug/unplug requests, but no
+	 * config updates will be sent.
+	 */
+	uint64_t plugged_size;
+	/* Requested size. New plug requests cannot exceed it. Can change. */
+	uint64_t requested_size;
+};
+
+#endif /* _LINUX_VIRTIO_MEM_H */
-- 
2.25.4


