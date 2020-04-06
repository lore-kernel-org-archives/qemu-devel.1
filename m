Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DBDC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8F22064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOTaXd6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8F22064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW7k-0006t3-Cr
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrA-0002Bh-K8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr9-00033M-AU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr9-00030u-34; Mon, 06 Apr 2020 13:48:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id i19so335183wmb.0;
 Mon, 06 Apr 2020 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aQ0X+HWMU9WGFg41OMAjP3yVb6N0PLiNzSrYmZnrIlE=;
 b=WOTaXd6c0yFH3nRGwJqIsFagkG/NlFGCO7DTapLUpuB8LaGYgMpoSA/Ev1/6NUN+FX
 z1bw38/aezftn+wQhL8wIh0rqSJmSSiCLusI8siyYDGD0K4nSfnCLbqoA+MxAGVkuYwW
 qqzZJgo210pou7zm7hO8TyEnE4hGBAueHUAAYT86AJCuKqCPwH8ZU4NhXBzWG7+N1G6M
 ymFRtLb3Gr+32RfzR9+iPB/zg3kfBGPUP4/OJMEhdtmgTFYcbjOzbRvZhUGGd7aYRx+E
 hVg8rkzGC079C0yYFyeSIS8sREVqmzvCx3qDnmk5VSVeh5Crl366UWD5fiwyXCJJ83qQ
 6cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aQ0X+HWMU9WGFg41OMAjP3yVb6N0PLiNzSrYmZnrIlE=;
 b=QJGxVClMvG7K2lAzFZ7U1gURrZ7FMlNNYLLaN223PAwFSWpghyJBz5BpSatvQzgiH/
 JtDfS5hYTSRmzYWcQhtwj9++SuqdoKaTEYktTGPRvWhro8fcfjr11dVJR9TIKKW5sPPJ
 U8wbuFzuu/VX9uafgos0f9O+5qQMiCRfRKf0Gx6an5vjtb4EYe7UFgCp9LbIgmATt4ps
 Ra6q7elig7WVLbJEFlCzk4GgnmQZOyxnih52Oswwh9EOCoi1iLE07c9aQMZFMVt5TDzc
 yL08KrtWBiPi+B6c2EJfoidOf0Z3aohumP5r/vRdZKMtvR9lv4CWrYwW4aBN4JvWotPd
 E/DA==
X-Gm-Message-State: AGi0PuaztUFxva73RbMTLeDa39ddnX6ivA2D/QjEP553bWuHDyriU6An
 1FiH4nFM8U+WUpIYtkjVHLOiZmA1GR4=
X-Google-Smtp-Source: APiQypJVnY1Bhnwe9G/r2C1COEiB/B0AzO9H4ebeQzlrZvXb5tAJpTTQOHDEPyTUULcHFKsU31pcVw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr475442wmi.31.1586195297775;
 Mon, 06 Apr 2020 10:48:17 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 23/54] hw/riscv/sifive_u: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:47:12 +0200
Message-Id: <20200406174743.16956-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/riscv/sifive_u.c
  >>> possible moves from riscv_sifive_u_soc_init() to riscv_sifive_u_soc_realize() in ./hw/riscv/sifive_u.c:473

Move the calls using &error_abort which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/riscv/sifive_u.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 96177c1977..7bf1f30a35 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -406,6 +406,8 @@ static void riscv_sifive_u_init(MachineState *machine)
 static void riscv_sifive_u_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    const struct MemmapEntry *memmap = sifive_u_memmap;
+    MemoryRegion *system_memory = get_system_memory();
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster,
@@ -443,6 +445,26 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
+
+    /* boot rom */
+    memory_region_init_rom(&s->mask_rom, obj, "riscv.sifive.u.mrom",
+                           memmap[SIFIVE_U_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
+                                &s->mask_rom);
+
+    /*
+     * Add L2-LIM at reset size.
+     * This should be reduced in size as the L2 Cache Controller WayEnable
+     * register is incremented. Unfortunately I don't see a nice (or any) way
+     * to handle reducing or blocking out the L2 LIM while still allowing it
+     * be re returned to all enabled after a reset. For the time being, just
+     * leave it enabled all the time. This won't break anything, but will be
+     * too generous to misbehaving guests.
+     */
+    memory_region_init_ram(&s->l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
+                                &s->l2lim_mem);
 }
 
 static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
@@ -500,26 +522,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
                              &error_abort);
 
-    /* boot rom */
-    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
-                                &s->mask_rom);
-
-    /*
-     * Add L2-LIM at reset size.
-     * This should be reduced in size as the L2 Cache Controller WayEnable
-     * register is incremented. Unfortunately I don't see a nice (or any) way
-     * to handle reducing or blocking out the L2 LIM while still allowing it
-     * be re returned to all enabled after a reset. For the time being, just
-     * leave it enabled all the time. This won't break anything, but will be
-     * too generous to misbehaving guests.
-     */
-    memory_region_init_ram(&s->l2lim_mem, NULL, "riscv.sifive.u.l2lim",
-                           memmap[SIFIVE_U_L2LIM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
-                                &s->l2lim_mem);
-
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
                            ms->smp.cpus;
-- 
2.21.1


