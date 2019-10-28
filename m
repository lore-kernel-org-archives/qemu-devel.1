Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF674CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDB920862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fntTbWrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDB920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Wk-0007eM-81
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iP80W-0002ua-Mp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iP80T-00087V-QA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iP80T-00087B-JP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2lfwmmQaDVAvDlyXppwXQpJKOOvmj7Yic9wf+wTvS4=;
 b=fntTbWrD9ygtmAnv1sX3KtFpS0w3OAFTLm2FYGmEj0en3NRsCV7MhZw3NAWAgxIMGmMs3z
 w5cQ+IvggWKnUobCWORvIK/oqDslbDvsvOYfwYdBA7McTwZyJAugDSqARsjG//RqpbLFQb
 Cj1kcyFwIEKsrBASKza0aZwZZs/Ergo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-Fh27MBZAP9aKt4APH8KuMw-1; Mon, 28 Oct 2019 12:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778A881A334;
 Mon, 28 Oct 2019 16:36:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-87.brq.redhat.com [10.40.204.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EC04261B0;
 Mon, 28 Oct 2019 16:36:28 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] hw/pci-host/piix: Move i440FX declarations to
 hw/pci-host/i440fx.h
Date: Mon, 28 Oct 2019 17:34:43 +0100
Message-Id: <20191028163447.18541-17-philmd@redhat.com>
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Fh27MBZAP9aKt4APH8KuMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The hw/pci-host/piix.c contains a mix of PIIX3 and i440FX chipsets
functions. To be able to split it, we need to export some
declarations first.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                  |  1 +
 hw/acpi/pcihp.c              |  2 +-
 hw/i386/pc_piix.c            |  1 +
 hw/pci-host/piix.c           |  1 +
 include/hw/i386/pc.h         | 22 ---------------------
 include/hw/pci-host/i440fx.h | 37 ++++++++++++++++++++++++++++++++++++
 stubs/pci-host-piix.c        |  3 ++-
 7 files changed, 43 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/pci-host/i440fx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90c5ece04b..a48daf0615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1228,6 +1228,7 @@ F: hw/i386/
 F: hw/pci-host/piix.c
 F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
+F: include/hw/pci-host/i440fx.h
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
 F: hw/isa/lpc_ich9.c
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 82d295b6e8..8413348a33 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/pcihp.h"
=20
-#include "hw/i386/pc.h"
+#include "hw/pci-host/i440fx.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a96ede19b2..ba35d5685e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -30,6 +30,7 @@
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
+#include "hw/pci-host/i440fx.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 390fb9ceba..95b04122fa 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci-host/i440fx.h"
 #include "hw/southbridge/piix.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d6ff95e047..e6fa8418ca 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -231,28 +231,6 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
 /* hpet.c */
 extern int no_hpet;
=20
-/* piix_pci.c */
-struct PCII440FXState;
-typedef struct PCII440FXState PCII440FXState;
-
-#define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
-#define TYPE_I440FX_PCI_DEVICE "i440FX"
-
-#define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
-
-PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-                    PCII440FXState **pi440fx_state, int *piix_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_memory,
-                    MemoryRegion *ram_memory);
-
-PCIBus *find_i440fx(void);
-
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memor=
y);
diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
new file mode 100644
index 0000000000..e327f9bf87
--- /dev/null
+++ b/include/hw/pci-host/i440fx.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU i440FX North Bridge Emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_PCI_I440FX_H
+#define HW_PCI_I440FX_H
+
+#include "hw/hw.h"
+#include "hw/pci/pci_bus.h"
+
+typedef struct PCII440FXState PCII440FXState;
+
+#define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
+#define TYPE_I440FX_PCI_DEVICE "i440FX"
+
+#define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
+
+PCIBus *i440fx_init(const char *host_type, const char *pci_type,
+                    PCII440FXState **pi440fx_state, int *piix_devfn,
+                    ISABus **isa_bus, qemu_irq *pic,
+                    MemoryRegion *address_space_mem,
+                    MemoryRegion *address_space_io,
+                    ram_addr_t ram_size,
+                    ram_addr_t below_4g_mem_size,
+                    ram_addr_t above_4g_mem_size,
+                    MemoryRegion *pci_memory,
+                    MemoryRegion *ram_memory);
+
+PCIBus *find_i440fx(void);
+
+#endif
diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
index 6ed81b1f21..93975adbfe 100644
--- a/stubs/pci-host-piix.c
+++ b/stubs/pci-host-piix.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
+#include "hw/pci-host/i440fx.h"
+
 PCIBus *find_i440fx(void)
 {
     return NULL;
--=20
2.21.0


