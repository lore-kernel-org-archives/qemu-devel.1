Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C641C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031832084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031832084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQBG-0008HO-S3
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPlQ-0005uY-6w
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPlO-0007ha-Rq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPlO-0007gv-Jb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:33:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E87A882FB;
 Tue, 15 Oct 2019 16:33:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D044319C5B;
 Tue, 15 Oct 2019 16:33:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/32] hw/pci-host/i440fx: Remove the last PIIX3 traces
Date: Tue, 15 Oct 2019 18:27:05 +0200
Message-Id: <20191015162705.28087-33-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 15 Oct 2019 16:33:33 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PIIX3 is not tied to the i440FX and can even be used without it.
Move its creation to the machine code (pc_piix.c).
We have now removed the last trace of southbridge code in the i440FX
northbridge.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc_piix.c            | 8 +++++++-
 hw/pci-host/i440fx.c         | 8 --------
 include/hw/pci-host/i440fx.h | 3 +--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ac4bf12ca..cb4f4fc94c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -190,14 +190,20 @@ static void pc_init1(MachineState *machine,
     gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
=20
     if (pcmc->pci_enabled) {
+        PIIX3State *piix3;
+
         pci_bus =3D i440fx_init(host_type,
                               pci_type,
-                              &i440fx_state, &piix3_devfn, &isa_bus, pcm=
s->gsi,
+                              &i440fx_state,
                               system_memory, system_io, machine->ram_siz=
e,
                               pcms->below_4g_mem_size,
                               pcms->above_4g_mem_size,
                               pci_memory, ram_memory);
         pcms->bus =3D pci_bus;
+
+        piix3 =3D piix3_create(pci_bus, &isa_bus);
+        piix3->pic =3D pcms->gsi;
+        piix3_devfn =3D piix3->dev.devfn;
     } else {
         pci_bus =3D NULL;
         i440fx_state =3D NULL;
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 79ecd58a2b..f27131102d 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -27,7 +27,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/southbridge/piix.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
@@ -272,8 +271,6 @@ static void i440fx_realize(PCIDevice *dev, Error **er=
rp)
=20
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state,
-                    int *piix3_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
                     ram_addr_t ram_size,
@@ -286,7 +283,6 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
     PCIBus *b;
     PCIDevice *d;
     PCIHostState *s;
-    PIIX3State *piix3;
     PCII440FXState *f;
     unsigned i;
     I440FXState *i440fx;
@@ -339,10 +335,6 @@ PCIBus *i440fx_init(const char *host_type, const cha=
r *pci_type,
                  PAM_EXPAN_SIZE);
     }
=20
-    piix3 =3D piix3_create(b, isa_bus);
-    piix3->pic =3D pic;
-    *piix3_devfn =3D piix3->dev.devfn;
-
     ram_size =3D ram_size / 8 / 1024 / 1024;
     if (ram_size > 255) {
         ram_size =3D 255;
diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index e327f9bf87..f54e6466e4 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -22,8 +22,7 @@ typedef struct PCII440FXState PCII440FXState;
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
=20
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-                    PCII440FXState **pi440fx_state, int *piix_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
+                    PCII440FXState **pi440fx_state,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
                     ram_addr_t ram_size,
--=20
2.21.0


