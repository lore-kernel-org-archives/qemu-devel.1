Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A2CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DF820867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjvbuaCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DF820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQgN-0007Mt-Op
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQRX-0004Rf-Vv
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQRW-00007n-Pf
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQRW-00007O-5j
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQsFUyLAwDljpdipMYVdl0GqrBsJ3XrvhlsEYkdcey4=;
 b=gjvbuaCvY68k0tG73B0o8YxEku85CRaX2rxLRRszoqJFdMA/p64FAhoML6qsVHXDOGJTy4
 n0W+IbwOyY3BHc8Keh/4+zZImBbDnCkjrOHJK5w6sUqHO9xuh67meCOsGCH3cIVcfGyFfF
 s+Q39GGO9MzBHyKREKN3jx5OOol4GFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-DrSHE9VQP-SzjnH1n34PiQ-1; Sat, 26 Oct 2019 14:05:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C37B71800E00;
 Sat, 26 Oct 2019 18:05:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A27A60C83;
 Sat, 26 Oct 2019 18:05:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] hw/pci-host/i440fx: Remove the last PIIX3 traces
Date: Sat, 26 Oct 2019 20:01:43 +0200
Message-Id: <20191026180143.7369-21-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DrSHE9VQP-SzjnH1n34PiQ-1
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc_piix.c            | 8 +++++++-
 hw/pci-host/i440fx.c         | 8 --------
 include/hw/pci-host/i440fx.h | 3 +--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ba35d5685e..2aefa3b8df 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -192,14 +192,20 @@ static void pc_init1(MachineState *machine,
     gsi_state =3D pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
=20
     if (pcmc->pci_enabled) {
+        PIIX3State *piix3;
+
         pci_bus =3D i440fx_init(host_type,
                               pci_type,
-                              &i440fx_state, &piix3_devfn, &isa_bus, x86ms=
->gsi,
+                              &i440fx_state,
                               system_memory, system_io, machine->ram_size,
                               x86ms->below_4g_mem_size,
                               x86ms->above_4g_mem_size,
                               pci_memory, ram_memory);
         pcms->bus =3D pci_bus;
+
+        piix3 =3D piix3_create(pci_bus, &isa_bus);
+        piix3->pic =3D x86ms->gsi;
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
@@ -272,8 +271,6 @@ static void i440fx_realize(PCIDevice *dev, Error **errp=
)
=20
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     PCII440FXState **pi440fx_state,
-                    int *piix3_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
                     MemoryRegion *address_space_mem,
                     MemoryRegion *address_space_io,
                     ram_addr_t ram_size,
@@ -286,7 +283,6 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,
     PCIBus *b;
     PCIDevice *d;
     PCIHostState *s;
-    PIIX3State *piix3;
     PCII440FXState *f;
     unsigned i;
     I440FXState *i440fx;
@@ -339,10 +335,6 @@ PCIBus *i440fx_init(const char *host_type, const char =
*pci_type,
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


