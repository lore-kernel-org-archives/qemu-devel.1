Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7640DC2D0E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2347C20719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7FYIj1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2347C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBi2-0006gS-8H
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYW-0000ky-Cy
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYU-0000C1-UW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:19:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYU-0000B9-N8; Wed, 25 Mar 2020 15:19:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so4741522wrl.1;
 Wed, 25 Mar 2020 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=34e/1tkh8UzMXO9BSDRz0SbUnMBtdxSyq4dkJt/HptY=;
 b=H7FYIj1kPOc3ehdYcW7MvD7RGjdbT9PCSra9IQq2r350xDWbE8FdP76m6Rp+A3OKZO
 qbMR/hUgLwd/jPE7FxPiGF7HHcaaWC1ddkhu0WONfBc45y/4setWflwXcLk2YH1sFK4x
 f1c1wFiEWpUhxMLFhFyq/jiIWhYcHsss5qzqKGWx3qIgojpGZ0Vi3+5MHPMKgllAI6/H
 cFAEuCpTJFYVDfAcUfZmkDeFB+g5jJUEYQ9KDp4od5szUahLJtBNhKxFKsnxgnxxqZxz
 2Y9srB8FB/EFQZ02DScqhCuJQcmchdxQ5xy5kvVosqGwFzDdF/WcBioQzNWo1PIxnt58
 aBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=34e/1tkh8UzMXO9BSDRz0SbUnMBtdxSyq4dkJt/HptY=;
 b=qaBK77WqHruu0wmOVFoVJGfef3yluDIWy8ybB0nqwlj8u/AQiRS6Bt0PaeWYI6dG79
 0I5Toju+P2pYvP2kJqnNhP5Tw2UUQf9Fv5cNJFh1gvFg+b2ji/V+XUDhUbhQ7v/8H6s5
 +1efCwO+P9PvHgc1mGgGx2b6GfwYOWtM/tXLZiukOXCYoQxVTPGrihw3FD1iwJyjPmTj
 SMnHicnSq9dcUbV7GE+lwyWbyDm3RDNR5wajTFb6u2di4llVZZT8XFYNMH32umm+eQHq
 z3v+NMCg4poAmKk7r6Kh88MfOFHoKTf9SIwxp+rZJu918osAE52b1O0c/667+a41KbRR
 csyQ==
X-Gm-Message-State: ANhLgQ1DvJ/p5W3mZ8IrJUDl3WDbR1QX7oubNSPo0gCQm0AMkxFd8D2Y
 0ZdDDlkieeA9Sv+9eeEHj3Y6z+igaXE=
X-Google-Smtp-Source: ADFU+vvYPZcXigBt8X/Lok18x2u5CNVTDYBc6nZFM0ULnlB1vR0IPo4W/wxE131g0b6ZuX6vTmhxCA==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr4944531wrn.261.1585163949299; 
 Wed, 25 Mar 2020 12:19:09 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:19:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 12/12] hw/riscv/sifive_u: Add missing
 error-propagation code
Date: Wed, 25 Mar 2020 20:18:30 +0100
Message-Id: <20200325191830.16553-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

  [[manual check required: error_propagate() might be missing in object_property_set_bool() hw/riscv/sifive_u.c:558:4]]
  [[manual check required: error_propagate() might be missing in object_property_set_bool() hw/riscv/sifive_u.c:561:4]]

Add the missing error_propagate() after manual review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_u.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 56351c4faa..01e44018cd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -473,113 +473,121 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
     Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
     object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
                              &error_abort);
     object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
                              &error_abort);
     /*
      * The cluster must be realized after the RISC-V hart array container,
      * as the container's CPU object is only created on realize, and the
      * CPU must exist and have been parented into the cluster before the
      * cluster is realized.
      */
     object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
                              &error_abort);
     object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
                              &error_abort);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
     /*
      * Add L2-LIM at reset size.
      * This should be reduced in size as the L2 Cache Controller WayEnable
      * register is incremented. Unfortunately I don't see a nice (or any) way
      * to handle reducing or blocking out the L2 LIM while still allowing it
      * be re returned to all enabled after a reset. For the time being, just
      * leave it enabled all the time. This won't break anything, but will be
      * too generous to misbehaving guests.
      */
     memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
                            memmap[SIFIVE_U_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
                                 l2lim_mem);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
                            ms->smp.cpus;
     plic_hart_config = g_malloc0(plic_hart_config_len);
     for (i = 0; i < ms->smp.cpus; i++) {
         if (i != 0) {
             strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
                     plic_hart_config_len);
         } else {
             strncat(plic_hart_config, "M", plic_hart_config_len);
         }
         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
     }
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
         plic_hart_config,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
         SIFIVE_U_PLIC_PENDING_BASE,
         SIFIVE_U_PLIC_ENABLE_BASE,
         SIFIVE_U_PLIC_ENABLE_STRIDE,
         SIFIVE_U_PLIC_CONTEXT_BASE,
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
     g_free(plic_hart_config);
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_IRQ));
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
     object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
     }
 
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
     }
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        plic_gpios[SIFIVE_U_GEM_IRQ]);
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
-- 
2.21.1


