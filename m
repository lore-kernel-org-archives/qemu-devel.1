Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF5C2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942422146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUg+86Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942422146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYk9-0000Uz-3K
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY47-0007f2-Qr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY46-0004RU-Fc
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY46-0004OQ-8g
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id a5so1565711wmb.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CgppvqZAewfZJvWnPL9K16Q5E1v7zyG2NScejjiBbbI=;
 b=hUg+86FdBnwQl84WMFa++8Z/EYHBZtAOgUbDC1eMA07rjyL5PBiHtdljMtLjPfZfA/
 yxw01OISlrnmbMvqXrDgmyfDwL3xWwGU37qOL92YyMSjPBTgjffisA7VupMklA8C8ipM
 l9KL7ff2CtfrR2hUcGs0zq/g9lRNU7vITZxVd8SIut8cPmmc9NlsESQc1ufpD/VGTbHe
 7sU5idQmd3hurWbYf9hzsnP7oe4+gXI1rpaDMXv5t77GiXn8/7dhf1sCubTodpfzrADu
 bNxlT0ksMwbM+9X/OhxsZ0QZGlAVW5OgHu/sTMmWsH28YIH9XJsOyMfMsvGvvNkHX7Y6
 gNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CgppvqZAewfZJvWnPL9K16Q5E1v7zyG2NScejjiBbbI=;
 b=pWQJ8cNki/aB43mBElPkmiquzqL0mvzWV8us/xCD8sDD7fbpdhnR1OsBZFqhNgHX+U
 RgcL+FOyRO80vT77uGRkbPvKnD/u5GIz2yRuacR6Am5muYvoT47Onij9W/uyuDfOIxOX
 Gq1cWDdkeDVa5isrReVdmxOlMKKLixkdKxFHQM+GQXeJ/Z8F9V1ZdQTpHtSwgI2cccxW
 AUz6Q1KYAj2oDb/DwrwMY4lkKNfF7k+nBq9LwVxFEvrS/oRzHeXtjKrGNyIygP7l44xn
 HYF5Jb/lrrHxB/ffjAaEXbQ3ACfwLrnWO7+/sFY70GVMgIYHAJbFdul68mcWjofjecb9
 KBNw==
X-Gm-Message-State: APjAAAWxf7yz2Hlvu31Z/J5GPi2uM+9Rk0FgGYhy3682CISXMYCror7e
 l+em34S8Vvm85xT7nD/ivcoUraVS
X-Google-Smtp-Source: APXvYqwMW4UcPkuhfdEAwZgsvGWJxIhOhagY2ku5x+JIXcbt5OJdNCwLaD+ddVfrwPjrQAUbmqdsJg==
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr2946375wmm.21.1576670669034; 
 Wed, 18 Dec 2019 04:04:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 87/87] vga: cleanup mapping of VRAM for non-PCI VGA
Date: Wed, 18 Dec 2019 13:02:53 +0100
Message-Id: <1576670573-48048-88-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vga_init_vbe is now used only from ISA VGA cards.  Since the alias is
not needed anymore, remove it (effectively reverting commit 8294a64d7f,
"vga: fix vram double-mapping with -vga std and -M pc-0.12", 2012-05-29)
and the now unused vbe_mapped field of VGACommonState.  The function now
consists of a single memory_region_add_subregion call, so we can inline
it; this avoids incorrect usage from PCI cards.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Based-on: <05af415a-5058-98b4-4a12-9d093a30b1e3@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-isa-mm.c |  5 ++++-
 hw/display/vga-isa.c    |  4 +++-
 hw/display/vga.c        | 12 ------------
 hw/display/vga_int.h    |  3 ---
 4 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index e9c43e5..7321b7a 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -106,6 +106,9 @@ int isa_vga_mm_init(hwaddr vram_base,
 
     s->vga.con = graphic_console_init(NULL, 0, s->vga.hw_ops, s);
 
-    vga_init_vbe(&s->vga, NULL, address_space);
+    memory_region_add_subregion(address_space,
+                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
+                                &s->vga.vram);
+
     return 0;
 }
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 873e5e9..08a2730 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -76,7 +76,9 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
     memory_region_set_coalescing(vga_io_memory);
     s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
 
-    vga_init_vbe(s, OBJECT(dev), isa_address_space(isadev));
+    memory_region_add_subregion(isa_address_space(isadev),
+                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
+                                &s->vram);
     /* ROM BIOS */
     rom_add_vga(VGABIOS_FILENAME);
 }
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 636586a..061fd9a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2301,15 +2301,3 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
         portio_list_add(&s->vbe_port_list, address_space_io, 0x1ce);
     }
 }
-
-void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *system_memory)
-{
-    /* Use an alias to avoid double-mapping the same region */
-    memory_region_init_alias(&s->vram_vbe, obj, "vram.vbe",
-                             &s->vram, 0, memory_region_size(&s->vram));
-    /* XXX: use optimized standard vga accesses */
-    memory_region_add_subregion(system_memory,
-                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
-                                &s->vram_vbe);
-    s->vbe_mapped = 1;
-}
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 55c418e..847e784 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -60,7 +60,6 @@ typedef struct VGACommonState {
     MemoryRegion *legacy_address_space;
     uint8_t *vram_ptr;
     MemoryRegion vram;
-    MemoryRegion vram_vbe;
     uint32_t vram_size;
     uint32_t vram_size_mb; /* property */
     uint32_t vbe_size;
@@ -106,7 +105,6 @@ typedef struct VGACommonState {
     uint32_t vbe_start_addr;
     uint32_t vbe_line_offset;
     uint32_t vbe_bank_mask;
-    int vbe_mapped;
     /* display refresh support */
     QemuConsole *con;
     uint32_t font_offsets[2];
@@ -178,7 +176,6 @@ void vga_invalidate_scanlines(VGACommonState *s, int y1, int y2);
 
 int vga_ioport_invalid(VGACommonState *s, uint32_t addr);
 
-void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *address_space);
 uint32_t vbe_ioport_read_data(void *opaque, uint32_t addr);
 void vbe_ioport_write_index(void *opaque, uint32_t addr, uint32_t val);
 void vbe_ioport_write_data(void *opaque, uint32_t addr, uint32_t val);
-- 
1.8.3.1


