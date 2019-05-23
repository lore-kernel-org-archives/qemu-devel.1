Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE1520851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnYm-0003Uh-PC
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:15:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnH5-0003dW-85
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn4U-0000uc-JM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:43:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn4U-0000uC-CR; Thu, 23 May 2019 08:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE5CB81121;
	Thu, 23 May 2019 12:43:44 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B59A5D9D2;
	Thu, 23 May 2019 12:43:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:07 +0200
Message-Id: <20190523124320.28726-3-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 23 May 2019 12:43:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/15] hw/nvram/fw_cfg: Add
 fw_cfg_arch_key_name()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add fw_cfg_arch_key_name() which returns the name of
an architecture-specific key.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190422195020.1494-3-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS               |  1 +
 hw/nvram/fw_cfg.c         |  2 +-
 include/hw/nvram/fw_cfg.h | 14 ++++++++++++++
 stubs/Makefile.objs       |  1 +
 stubs/fw_cfg.c            | 21 +++++++++++++++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 stubs/fw_cfg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 73a0105082..3cacd751bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1696,6 +1696,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: docs/specs/fw_cfg.txt
 F: hw/nvram/fw_cfg.c
+F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
 F: tests/libqos/fw_cfg.c
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index d374a970fe..b2dc0a80cb 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -100,7 +100,7 @@ static const char *key_name(uint16_t key)
     };
=20
     if (key & FW_CFG_ARCH_LOCAL) {
-        return NULL;
+        return fw_cfg_arch_key_name(key);
     }
     if (key < FW_CFG_FILE_FIRST) {
         return fw_cfg_wellknown_keys[key];
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f5a6895a74..80e435d303 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -226,4 +226,18 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
=20
+/**
+ * fw_cfg_arch_key_name:
+ *
+ * @key: The uint16 selector key.
+ *
+ * The key is architecture-specific (the FW_CFG_ARCH_LOCAL mask is expec=
ted
+ * to be set in the key).
+ *
+ * Returns: The stringified architecture-specific name if the selector
+ *          refers to a well-known numerically defined item, or NULL on
+ *          key lookup failure.
+ */
+const char *fw_cfg_arch_key_name(uint16_t key);
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa5832..73452ad265 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-y +=3D xen-hvm.o
 stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
 stub-obj-y +=3D ramfb.o
+stub-obj-y +=3D fw_cfg.o
diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
new file mode 100644
index 0000000000..bb1e3c8aa9
--- /dev/null
+++ b/stubs/fw_cfg.c
@@ -0,0 +1,21 @@
+/*
+ * fw_cfg stubs
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nvram/fw_cfg.h"
+
+const char *fw_cfg_arch_key_name(uint16_t key)
+{
+    return NULL;
+}
--=20
2.20.1


