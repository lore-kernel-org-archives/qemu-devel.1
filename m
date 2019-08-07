Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE76C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4538022BEB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+e9lu/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4538022BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGpX-0001mN-Iq
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGe2-0001VN-Vx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGe1-0008Hl-S7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:46:02 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGe1-0008HD-M6; Wed, 07 Aug 2019 03:46:01 -0400
Received: by mail-pl1-x643.google.com with SMTP id a93so39422019pla.7;
 Wed, 07 Aug 2019 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=WcpG0CVXsq6+o6LWOrY8Ur4Wyj26nMAadnvMIS79BgA=;
 b=Q+e9lu/5J5vgBg8dxjAdOx/LMflBrPklOVEBB/Qcz6UdsK9WTcU1YEVhNRhxCjmH8O
 YGSKdu95nlMKLw3t5rI6J+WVHg2+OZsK3t0Ek3xjBl25IK3/9Sq5YIdhyvZjjq7wYrx7
 O4EwZe0rU0Dyq7mGHlYyB9lykPc8e4noxBinijyJENoeCwTE7b0DaZgS6pO2vFYdseAU
 UqbPW7gwtywLXY0ikkrnEf1AXo8fMaWxVJtZZ416h+NoGZrtRYABHDvTyu6PIxR22jGo
 pp2xr0YM4ob7yTkTqOcsyhRazVIgD7th8DidTEz+HlT8MX58Adyey+UrzvZy4obV1hIY
 b2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=WcpG0CVXsq6+o6LWOrY8Ur4Wyj26nMAadnvMIS79BgA=;
 b=acrzTSFLQ83ZiRzoIrO/j6Cy5yK6V/cijdkHEEiBfbQzGl1tDDBG0X8YzZ0Z0gztIX
 N0Q3E5L+lzKk+FsHh6i0QFLFah+QvSCPNUZ/Bhg2DiztMNKCzgJylESMsIxAfoP3w+PM
 59dDOA2p9VQ5mu/s016U5YUly0w1qmDOflW6g+cvs0ChEMlrA7RepAzG1aLGTYkT0jms
 +qd1myOtXTvBC+ZlWyGLY9ST14qv9KEqhmqvzqf19yUUQJOGYihaqyxbd9T00cxSSvS9
 lehIkHTqDa8GPo5gJDP8SNscK0CmQYXw+n06/7Uy9sT3oTbwUXh9mtX5H40cK3Et+a/L
 cCCw==
X-Gm-Message-State: APjAAAW/RvT24hnQ0mTGM7JTO+mtCE8xY7I2GpavKsYbnQRhyySuvl85
 EQPKfyBPItZJmPnbcKDUPcQ=
X-Google-Smtp-Source: APXvYqwqd+fz30ASxK8yq6NZH1iewj2D4OTQ/b57MuWCXdXTkC006WwAPXE8ERDnz22sMqXCRQvNaA==
X-Received: by 2002:aa7:9713:: with SMTP id a19mr8008957pfg.64.1565163960946; 
 Wed, 07 Aug 2019 00:46:00 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.59
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:46:00 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:23 -0700
Message-Id: <1565163924-18621-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 27/28] riscv: virt: Change create_fdt() to
 return void
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

There is no need to return fdt at the end of create_fdt() because
it's already saved in s->fdt. Other machines (sifive_u, spike)
don't do it neither.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v2: None

 hw/riscv/virt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2f75195..6bfa721 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -112,7 +112,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename,
                            0x1800, 0, 0, 0x7);
 }
 
-static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
+static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -316,8 +316,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
-
-    return fdt;
 }
 
 
@@ -373,7 +371,6 @@ static void riscv_virt_board_init(MachineState *machine)
     size_t plic_hart_config_len;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
-    void *fdt;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
@@ -392,7 +389,7 @@ static void riscv_virt_board_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
@@ -411,9 +408,9 @@ static void riscv_virt_board_init(MachineState *machine)
             hwaddr end = riscv_load_initrd(machine->initrd_filename,
                                            machine->ram_size, kernel_entry,
                                            &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
                                   "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     }
-- 
2.7.4


