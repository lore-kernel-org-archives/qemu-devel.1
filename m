Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E74C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B16F21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmZQ1LiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B16F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifo1g-0004Ho-SG
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifnft-0001Q3-L3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifnfs-00034R-B8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifnfs-00033X-5Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576254015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN6AckxlKUpsLzxakKRr0um+iuOesJrJu7GlUIEw6bQ=;
 b=MmZQ1LiHb7yd5M4X7q+qCp2C3t93mtfXDF/x8cB6eIBT8rCHDnU0/DVfK0fcYvpRW182ag
 v1quLewpJc9Ssm5HWeXXxkoa9wFe+ywXBZMj5MH2UbEHAPF7YXeWgeIlxsL4TXXTMbRa8P
 I7VEcUTf2nHYAYxMUePHNie0Ke0Gc1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-rlsJfBc9OvaPIStuNENCNA-1; Fri, 13 Dec 2019 11:20:14 -0500
X-MC-Unique: rlsJfBc9OvaPIStuNENCNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A050800EC0;
 Fri, 13 Dec 2019 16:20:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B180319C4F;
 Fri, 13 Dec 2019 16:20:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] hw/i386/pc: Rename allocate_cpu_irq from 'pc' to
 'x86_machine'
Date: Fri, 13 Dec 2019 17:17:51 +0100
Message-Id: <20191213161753.8051-11-philmd@redhat.com>
In-Reply-To: <20191213161753.8051-1-philmd@redhat.com>
References: <20191213161753.8051-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the X86 machines use an interrupt controller.
Rename the function to something more generic.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h | 2 +-
 hw/i386/microvm.c    | 2 +-
 hw/i386/pc.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 743141e107..244dbf2ec0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -198,7 +198,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
 uint64_t pc_pci_hole64_start(void);
-qemu_irq pc_allocate_cpu_irq(void);
+qemu_irq x86_machine_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index def37e60f7..7ac008460a 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -132,7 +132,7 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
     if (mms->pic =3D=3D ON_OFF_AUTO_ON || mms->pic =3D=3D ON_OFF_AUTO_AU=
TO) {
         qemu_irq *i8259;
=20
-        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 =3D i8259_init(isa_bus, x86_machine_allocate_cpu_irq());
         for (i =3D 0; i < ISA_NUM_IRQS; i++) {
             gsi_state->i8259_irq[i] =3D i8259[i];
         }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5f8e39c025..4defee274f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1282,7 +1282,7 @@ uint64_t pc_pci_hole64_start(void)
     return ROUND_UP(hole64_start, 1 * GiB);
 }
=20
-qemu_irq pc_allocate_cpu_irq(void)
+qemu_irq x86_machine_allocate_cpu_irq(void)
 {
     return qemu_allocate_irq(pic_irq_request, NULL, 0);
 }
@@ -1463,7 +1463,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i82=
59_irqs)
     } else if (xen_enabled()) {
         i8259 =3D xen_interrupt_controller_init();
     } else {
-        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 =3D i8259_init(isa_bus, x86_machine_allocate_cpu_irq());
     }
=20
     for (size_t i =3D 0; i < ISA_NUM_IRQS; i++) {
--=20
2.21.0


