Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169B42133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169B42133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnWe-0001Yf-98
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:12:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnH4-0003dW-3q
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn4f-00010U-1Y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn4e-000108-TI; Thu, 23 May 2019 08:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 268E5308FBA9;
	Thu, 23 May 2019 12:43:56 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C21B5D9C3;
	Thu, 23 May 2019 12:43:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:08 +0200
Message-Id: <20190523124320.28726-4-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 23 May 2019 12:43:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/15] hw/i386: Extract fw_cfg definitions to
 local "fw_cfg.h"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the architecture-specific fw_cfg definitions to "fw_cfg.h".

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190422195020.1494-4-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/fw_cfg.h | 20 ++++++++++++++++++++
 hw/i386/pc.c     |  7 +------
 2 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 hw/i386/fw_cfg.h

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
new file mode 100644
index 0000000000..17a4bc32f2
--- /dev/null
+++ b/hw/i386/fw_cfg.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU fw_cfg helpers (X86 specific)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_I386_FW_CFG_H
+#define HW_I386_FW_CFG_H
+
+#include "hw/nvram/fw_cfg.h"
+
+#define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
+#define FW_CFG_SMBIOS_ENTRIES   (FW_CFG_ARCH_LOCAL + 1)
+#define FW_CFG_IRQ0_OVERRIDE    (FW_CFG_ARCH_LOCAL + 2)
+#define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
+#define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
+
+#endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..2632b73f80 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -30,6 +30,7 @@
 #include "hw/char/parallel.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
+#include "hw/i386/fw_cfg.h"
 #include "sysemu/cpus.h"
 #include "hw/block/fdc.h"
 #include "hw/ide.h"
@@ -88,12 +89,6 @@
 #define DPRINTF(fmt, ...)
 #endif
=20
-#define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
-#define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
-#define FW_CFG_IRQ0_OVERRIDE (FW_CFG_ARCH_LOCAL + 2)
-#define FW_CFG_E820_TABLE (FW_CFG_ARCH_LOCAL + 3)
-#define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)
-
 #define E820_NR_ENTRIES		16
=20
 struct e820_entry {
--=20
2.20.1


