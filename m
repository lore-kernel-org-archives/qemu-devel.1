Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D579CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25FF21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWwi/RvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25FF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeDf-0008JA-V7
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdim-0007DH-Mp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdih-0007do-0L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdig-0007cd-Pl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:06 -0400
Received: by mail-wr1-x42f.google.com with SMTP id l10so25813771wrb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yXqREab8+Dht8ov84n50u33TUba4e4JzVsBJv+Jjg+k=;
 b=KWwi/RvL2ZE8LcP1Ah3xM7VL8nv5WEwfRy+DSqaL/hTvEI/ivcQMXfyJxwMI6NUJXm
 47ExC9L4qgeNMv/x92inQBJmaSru24W8o9BzagFVIoKSOLwZVgmVOcd2ZGtHtAAv9/tU
 CzC2x3lbJQDM84l6pneKDZxIfZEyaJGrkaoj3CAMMvOc/iFR8TXDGbvSYKzMwQKNBR2z
 FnOh91ZmGebNsKY1POPQwSoOs/vwy2+TPZbg1TbHbH5D4fHtzxjRVv/FNVw0FRE2ySH8
 DjN7o01ulbm7tcQf4XbtgOnhV7TIi5SXPRJ6yeJq/C0FJkQ5eHZFTGWuK2XNTEeqtalY
 CIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yXqREab8+Dht8ov84n50u33TUba4e4JzVsBJv+Jjg+k=;
 b=lSCSgs0FShz+RUmcQxHgKzbXNWnbB1Iw8tDKzd8dYG++3eWFqUNW4i8c0HpXN3E9m5
 xzKkKrnyxoDAFIV0QvqjJ+vY0FrOjMixwUQq8paIG+eNHgBd84riNqFbi8I2TCv92YWk
 FcXXFJH+6J/lIazOZ5RJjcawMaeLuEKAoZAF38GCH8ZboxgzTKCErqaQsMfLlkKeXlEi
 PAt7DPM5lXgH6bx7AI0HpO6OYHbmnTwxug95BdJio638RBNoq3NxiFo13ZUHxm/Iz4S5
 Hv1IWisZ2oSgG8VE/2pL6XWHe7aOmPgkXgyhdBkWKN0v8zsYXl/tnVlYDl4zDp1jHZkU
 Z5BQ==
X-Gm-Message-State: APjAAAXSjq09jhkHPqmrjW2x+u5Y50evay9klM/GoNzdVybUKU8ZS36Y
 c2yoD2Ye3ykCk1nofDXQGy7Lg/E5
X-Google-Smtp-Source: APXvYqyyzR9H7eU4wyqYOmmLtldLClmpsM358SNHyBTDb7Q+R1LUAqcd9JYdYoJBYB6kRFTtPeYW6g==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4223154wrw.206.1571925845015; 
 Thu, 24 Oct 2019 07:04:05 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/39] hw/virtio: Factorize virtio-mmio headers
Date: Thu, 24 Oct 2019 16:03:23 +0200
Message-Id: <1571925835-31930-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Put QOM and main struct definition in a separate header file, so it
can be accessed from other components.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c         | 48 +--------------------------
 include/hw/virtio/virtio-mmio.h | 73 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 47 deletions(-)
 create mode 100644 include/hw/virtio/virtio-mmio.h

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 3d5ca0f..94d934c 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -29,57 +29,11 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
-#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-mmio.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
 
-/* QOM macros */
-/* virtio-mmio-bus */
-#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
-#define VIRTIO_MMIO_BUS(obj) \
-        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
-#define VIRTIO_MMIO_BUS_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
-
-/* virtio-mmio */
-#define TYPE_VIRTIO_MMIO "virtio-mmio"
-#define VIRTIO_MMIO(obj) \
-        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
-
-#define VIRT_MAGIC 0x74726976 /* 'virt' */
-#define VIRT_VERSION 2
-#define VIRT_VERSION_LEGACY 1
-#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
-
-typedef struct VirtIOMMIOQueue {
-    uint16_t num;
-    bool enabled;
-    uint32_t desc[2];
-    uint32_t avail[2];
-    uint32_t used[2];
-} VirtIOMMIOQueue;
-
-typedef struct {
-    /* Generic */
-    SysBusDevice parent_obj;
-    MemoryRegion iomem;
-    qemu_irq irq;
-    bool legacy;
-    /* Guest accessible state needing migration and reset */
-    uint32_t host_features_sel;
-    uint32_t guest_features_sel;
-    uint32_t guest_page_shift;
-    /* virtio-bus */
-    VirtioBusState bus;
-    bool format_transport_address;
-    /* Fields only used for non-legacy (v2) devices */
-    uint32_t guest_features[2];
-    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
-} VirtIOMMIOProxy;
-
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
 {
     return kvm_eventfds_enabled();
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
new file mode 100644
index 0000000..7dbfd03
--- /dev/null
+++ b/include/hw/virtio/virtio-mmio.h
@@ -0,0 +1,73 @@
+/*
+ * Virtio MMIO bindings
+ *
+ * Copyright (c) 2011 Linaro Limited
+ *
+ * Author:
+ *  Peter Maydell <peter.maydell@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_VIRTIO_MMIO_H
+#define HW_VIRTIO_MMIO_H
+
+#include "hw/virtio/virtio-bus.h"
+
+/* QOM macros */
+/* virtio-mmio-bus */
+#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
+#define VIRTIO_MMIO_BUS(obj) \
+        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
+#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
+#define VIRTIO_MMIO_BUS_CLASS(klass) \
+        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BUS)
+
+/* virtio-mmio */
+#define TYPE_VIRTIO_MMIO "virtio-mmio"
+#define VIRTIO_MMIO(obj) \
+        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
+
+#define VIRT_MAGIC 0x74726976 /* 'virt' */
+#define VIRT_VERSION 2
+#define VIRT_VERSION_LEGACY 1
+#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
+
+typedef struct VirtIOMMIOQueue {
+    uint16_t num;
+    bool enabled;
+    uint32_t desc[2];
+    uint32_t avail[2];
+    uint32_t used[2];
+} VirtIOMMIOQueue;
+
+typedef struct {
+    /* Generic */
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    qemu_irq irq;
+    bool legacy;
+    /* Guest accessible state needing migration and reset */
+    uint32_t host_features_sel;
+    uint32_t guest_features_sel;
+    uint32_t guest_page_shift;
+    /* virtio-bus */
+    VirtioBusState bus;
+    bool format_transport_address;
+    /* Fields only used for non-legacy (v2) devices */
+    uint32_t guest_features[2];
+    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
+} VirtIOMMIOProxy;
+
+#endif
-- 
1.8.3.1



