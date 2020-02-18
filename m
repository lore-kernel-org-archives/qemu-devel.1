Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE302C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2742067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgcShjjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2742067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49Dl-0004qi-Sq
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j49Cp-0004EL-Sp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j49Co-0001M8-JU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:10:55 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1j49Co-0001KB-Dv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:10:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id 2so11182864pfg.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 12:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=dcIb0UwBhtGfUdFFpp0WtqcE2tLChD5qZinEn1fAzhA=;
 b=BgcShjjCvRWF7b5LC/uwLgcUELt3UA/Mwu911ZEMi73rD3DSzsTggkmlRu23DHmVQg
 IIgesfEO7w+dK0mpW4QywWuSRNQn3U9wuzupZjr076CQnfZJl0DTnoMe4Xoi9wc+WPu9
 w5I1nWgV1sDp7TbbwmLNi4Vj6xbNF7BWlZ2i8+xQPZK3V1eR8i+Uh+J5D667UbyfmVeC
 ELd3IkPFDMawDgp/S/5X6pbsWB37FFmmarcQR8r9V8rAc3ASXE8ZVTafEw6dS8UibfOx
 n71SGOBdqWHwMalJMzD6I5t3t+YzCp/r2fz2ts6kX7ZsrXJKTaXDgdx+fr9JxASnME/+
 3daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=dcIb0UwBhtGfUdFFpp0WtqcE2tLChD5qZinEn1fAzhA=;
 b=CoMRhuwbJXu76uBaFsXPaPqV9G/3Gkb3KAmx3Iu+AWlnssmb4T+8IFkSavILsWYLjy
 m64d8Cz31HwQPIXpELE5nASLss+xlLnu/SPqztbOl71LLPtfp1Ei9w6aHwMdBXNJMzWV
 og+CsEulpRcb81lplnHcxaXZpUIxbmT1e3G1TDbd3Tbm2wY2J44umN6GIyEYvtDG0NHd
 i0EflbVE0RP14S3YobFwyDBvAuqie2FhxSnC26V2pcOwJXX6WxHH09ofjh0juO7YzYCR
 xBXXiY+l2WhLkEefiVik6U80YM4vC6h2xFiWO4Rfm/NMErP0C07tyE2KvKRC5AwT6xFA
 jNfw==
X-Gm-Message-State: APjAAAUlO5QqWBLg/zfuBAPjXLR0r9lZgEn/3s9bXwNBp/XF/j6VfAvf
 4KhkDyk8exejQOIXbdtisOU=
X-Google-Smtp-Source: APXvYqx4Eutqu5KJbnYP6bbWRhZEXX2AateHp1zmeVpdxboquKQsF2YOaF3bK61TLIb4LDm82elNbw==
X-Received: by 2002:a63:f501:: with SMTP id w1mr26009273pgh.61.1582056653047; 
 Tue, 18 Feb 2020 12:10:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u4sm4164937pgu.75.2020.02.18.12.10.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Feb 2020 12:10:52 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2] sh4: Fix PCI ISA IO memory subregion
Date: Tue, 18 Feb 2020 12:10:50 -0800
Message-Id: <20200218201050.15273-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Booting the r2d machine from flash fails because flash is not discovered.
Looking at the flattened memory tree, we see the following.

FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 AS "sh_pci_host", root: bus master container
 Root memory region: system
  0000000000000000-000000000000ffff (prio 0, i/o): io
  0000000000010000-0000000000ffffff (prio 0, i/o): r2d.flash @0000000000010000

The overlapping memory region is sh_pci.isa, ie the ISA I/O region bridge.
This region is initially assigned to address 0xfe240000, but overwritten
with a write into the PCIIOBR register. This write is expected to adjust
the PCI memory window, but not to change the region's base adddress.

Peter Maydell provided the following detailed explanation.

"Section 22.3.7 and in particular figure 22.3 (of "SSH7751R user's manual:
hardware") are clear about how this is supposed to work: there is a window
at 0xfe240000 in the system register space for PCI I/O space. When the CPU
makes an access into that area, the PCI controller calculates the PCI
address to use by combining bits 0..17 of the system address with the
bits 31..18 value that the guest has put into the PCIIOBR. That is, writing
to the PCIIOBR changes which section of the IO address space is visible in
the 0xfe240000 window. Instead what QEMU's implementation does is move the
window to whatever value the guest writes to the PCIIOBR register -- so if
the guest writes 0 we put the window at 0 in system address space."

Fix the problem by calling memory_region_set_alias_offset() instead of
removing and re-adding the PCI ISA subregion on writes into PCIIOBR.
At the same time, in sh_pci_device_realize(), don't set iobr since
it is overwritten later anyway. Instead, pass the base address to
memory_region_add_subregion() directly.

Many thanks to Peter Maydell for the detailed problem analysis, and for
providing suggestions on how to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Complete rework based on Peter's analysis. Don't remove the
    'sh_pci.isa' alias, which was perfectly fine.
    Instead, fix the underlying problem.
    Rename subject from "'sh4: Remove bad memory alias 'sh_pci.isa'"

 hw/sh4/sh_pci.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 71afd23b67..08f2fc1dde 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -67,12 +67,8 @@ static void sh_pci_reg_write (void *p, hwaddr addr, uint64_t val,
         pcic->mbr = val & 0xff000001;
         break;
     case 0x1c8:
-        if ((val & 0xfffc0000) != (pcic->iobr & 0xfffc0000)) {
-            memory_region_del_subregion(get_system_memory(), &pcic->isa);
-            pcic->iobr = val & 0xfffc0001;
-            memory_region_add_subregion(get_system_memory(),
-                                        pcic->iobr & 0xfffc0000, &pcic->isa);
-        }
+        pcic->iobr = val & 0xfffc0001;
+        memory_region_set_alias_offset(&pcic->isa, val & 0xfffc0000);
         break;
     case 0x220:
         pci_data_write(phb->bus, pcic->par, val, 4);
@@ -147,8 +143,7 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
                              get_system_io(), 0, 0x40000);
     sysbus_init_mmio(sbd, &s->memconfig_p4);
     sysbus_init_mmio(sbd, &s->memconfig_a7);
-    s->iobr = 0xfe240000;
-    memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
+    memory_region_add_subregion(get_system_memory(), 0xfe240000, &s->isa);
 
     s->dev = pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
 }
-- 
2.17.1


