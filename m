Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9638C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9E6204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9E6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43517 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIf2C-0007g6-0S
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:55:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexw-0004eI-N2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexv-0008CC-Jt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hIexv-0008Bg-Ds; Mon, 22 Apr 2019 15:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0396C034DC4;
	Mon, 22 Apr 2019 19:50:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-61.brq.redhat.com [10.40.204.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A855D71E;
	Mon, 22 Apr 2019 19:50:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 21:50:16 +0200
Message-Id: <20190422195020.1494-4-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 22 Apr 2019 19:50:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/7] hw/i386: Extract fw_cfg definitions to
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Laszlo Ersek <lersek@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422195016.qoTRsff2KKsgAcN8lho8cx7qSCmPFTOuTY7su9VtjSI@z>

Extract the architecture-specific fw_cfg definitions to "fw_cfg.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/fw_cfg.h | 20 ++++++++++++++++++++
 hw/i386/pc.c     |  7 +------
 2 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 hw/i386/fw_cfg.h

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
new file mode 100644
index 00000000000..17a4bc32f22
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
index f2c15bf1f2c..acb8fd9667d 100644
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


