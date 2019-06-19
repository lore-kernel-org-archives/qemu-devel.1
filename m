Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19CC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C20320B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C20320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXT4-0003WH-HZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hdXF8-000747-L1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hdXF6-0001vm-15
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hdXF3-0001mc-UC
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EDE2308622C;
 Wed, 19 Jun 2019 09:50:50 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-148.sin2.redhat.com
 [10.67.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 228A710190AD;
 Wed, 19 Jun 2019 09:50:10 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:19:03 +0530
Message-Id: <20190619094907.10131-4-pagupta@redhat.com>
In-Reply-To: <20190619094907.10131-1-pagupta@redhat.com>
References: <20190619094907.10131-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 19 Jun 2019 09:50:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/7] virtio-pmem: sync linux headers
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
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
 xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
 riel@surriel.com, david@redhat.com, armbru@redhat.com, ehabkost@redhat.com,
 lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, dan.j.williams@intel.com, nilal@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sync linux headers for virtio pmem.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h  |  1 +
 include/standard-headers/linux/virtio_pmem.h | 35 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/standard-headers/linux/virtio_pmem.h

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6d5c3b2d4f..32b2f94d1f 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,5 +43,6 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_PMEM         27 /* virtio pmem */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_pmem.h b/include/standard-headers/linux/virtio_pmem.h
new file mode 100644
index 0000000000..7a3e2fe524
--- /dev/null
+++ b/include/standard-headers/linux/virtio_pmem.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Definitions for virtio-pmem devices.
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Author(s): Pankaj Gupta <pagupta@redhat.com>
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
+#define _UAPI_LINUX_VIRTIO_PMEM_H
+
+#include <linux/types.h>
+#include <linux/virtio_types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+
+struct virtio_pmem_config {
+	__le64 start;
+	__le64 size;
+};
+
+#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
+
+struct virtio_pmem_resp {
+	/* Host return status corresponding to flush request */
+	__virtio32 ret;
+};
+
+struct virtio_pmem_req {
+	/* command type */
+	__virtio32 type;
+};
+
+#endif
-- 
2.14.5


