Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53939CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285C3222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285C3222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSm9-0006cC-78
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSeO-000661-W5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSeN-0006iN-Ko
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSeN-0006hu-CV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8635951EF6;
 Fri, 18 Oct 2019 13:50:38 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AE1360BF1;
 Fri, 18 Oct 2019 13:50:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/20] hw/pci-host/piix: Move RCR_IOPORT register definition
Date: Fri, 18 Oct 2019 15:47:48 +0200
Message-Id: <20191018134754.16362-15-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-1-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 18 Oct 2019 13:50:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The RCR_IOPORT register belongs to the PIIX chipset.
Move the definition to "piix.h", and prepend the PIIX prefix.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: prepend PIIX prefix (Aleksandar)
---
 hw/i386/acpi-build.c          | 2 +-
 hw/pci-host/piix.c            | 7 ++++---
 include/hw/i386/pc.h          | 6 ------
 include/hw/southbridge/piix.h | 6 ++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 56c427f772..478ca29874 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -209,7 +209,7 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)
=20
     /* The above need not be conditional on machine type because the res=
et port
      * happens to be the same on PIIX (pc) and ICH9 (q35). */
-    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D RCR_IOPORT);
+    QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D PIIX_RCR_IOPORT);
=20
     /* Fill in optional s3/s4 related properties */
     o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 3292703de7..6548d9a4b5 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/southbridge/piix.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
@@ -87,7 +88,7 @@ typedef struct PIIX3State {
     /* Reset Control Register contents */
     uint8_t rcr;
=20
-    /* IO memory region for Reset Control Register (RCR_IOPORT) */
+    /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
     MemoryRegion rcr_mem;
 } PIIX3State;
=20
@@ -695,8 +696,8 @@ static void piix3_realize(PCIDevice *dev, Error **err=
p)
=20
     memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
                           "piix3-reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev), RCR_I=
OPORT,
-                                        &d->rcr_mem, 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(dev),
+                                        PIIX_RCR_IOPORT, &d->rcr_mem, 1)=
;
=20
     qemu_register_reset(piix3_reset, d);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 848078bacc..2628de8b72 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -260,12 +260,6 @@ typedef struct PCII440FXState PCII440FXState;
=20
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
=20
-/*
- * Reset Control Register: PCI-accessible ISA-Compatible Register at add=
ress
- * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:700=
0).
- */
-#define RCR_IOPORT 0xcf9
-
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state, int *piix_devfn,
                     ISABus **isa_bus, qemu_irq *pic,
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.=
h
index add352456b..e49d4a6bbe 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t=
 smb_io_base,
                       qemu_irq sci_irq, qemu_irq smi_irq,
                       int smm_enabled, DeviceState **piix4_pm);
=20
+/*
+ * Reset Control Register: PCI-accessible ISA-Compatible Register at add=
ress
+ * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:700=
0).
+ */
+#define PIIX_RCR_IOPORT 0xcf9
+
 extern PCIDevice *piix4_dev;
=20
 DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
--=20
2.21.0


