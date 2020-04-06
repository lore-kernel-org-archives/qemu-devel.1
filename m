Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34223C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65F920678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8RI1fJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65F920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW5d-0002c7-IF
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr8-00027q-Nw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr7-0002xn-J4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr7-0002wW-C5; Mon, 06 Apr 2020 13:48:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so548699wrd.0;
 Mon, 06 Apr 2020 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8TMNAxjLNSnTnU3+gPKyE2L5mZZ/LKhb2zY67/m5zA=;
 b=A8RI1fJa5N2As+JM88HbJVWQjXlnCdQhclkmh8vVRIHWkoWJ7GI3OiWzoc1mi/OUgU
 QtnZgFvZbMsRfIkKX2eehVT2rNieMhyK5essYIprpsGAJ/+x3Tbvt87Ek2zkQtNdmfEp
 UO+xzaZwG6eCsN1kheuGRXvr9Jo0FIutTO+mFsajIbx5V7W9GFoP0LKJUDkzQLR0DLH4
 WeK0yKWe13MOcreXM3aL3BtStTNvRwKoTyFFkCmn/LX06Nb4ztcTbetAQDA6/3Z8rwzL
 M0Ly2rpUzd+0VzoN4Vyc5pZMk4Ij/5hhkkHBU+l3vTpXBvRnOkh13afe4Q3KMHA1bXp9
 68MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y8TMNAxjLNSnTnU3+gPKyE2L5mZZ/LKhb2zY67/m5zA=;
 b=h6UTdIvrI/G+19O1hM7yU+jUEnKfI5B7lBISDVxmJCwqJkskkdCskrxgsTs4mFDvhO
 ggUs3R4dJrKlRHeIJ0Yhgarr8Yv0WUYDBJcwwfgOIwdSH7j36eQvn/1+SZn7Jq0vu+QF
 TN1MtHhTwmcXIZ7or81Dn74WoZJ3ElRiv+L8MSCsmuseBq6IOLP7LRwur5Rrno9f2az/
 Z3X90s0UpHoYSFZaMyvO7lHBg797gEWGclkqTGRXaTw/6v1KPrPtbQnGsEARNfnYmhai
 9BDO1ba1w8E6DTpgrYx2NoSbmkk6v/hmR332yOl+gnuE7jcS3FdCxlSXwykW/7hp8VOd
 qd7g==
X-Gm-Message-State: AGi0PuaCZR+JNDMy9NnZNQ54Mvibee8VPM7c2ZVrQ1ApPc605dsfXE+B
 r9VWAqrkfyUKKofaqROis4F48e4qOqM=
X-Google-Smtp-Source: APiQypJ1Kqv3bEdC1AwTIEXs6fBIhON/Uo5vx5juiPzowSuAp3eQWfGPP7CsHOU9sJdIYHgWNSCBKg==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr372161wrs.71.1586195296143;
 Mon, 06 Apr 2020 10:48:16 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 22/54] hw/riscv/sifive_u: Store MemoryRegion in
 SiFiveUSoCState
Date: Mon,  6 Apr 2020 19:47:11 +0200
Message-Id: <20200406174743.16956-23-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

While reviewing we notice storing the MemoryRegion in the device
state, we'll be able to later automatically simplify the error
propagation calls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/sifive_u.h |  2 ++
 hw/riscv/sifive_u.c         | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 82667b5746..254c6a64f8 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -42,6 +42,8 @@ typedef struct SiFiveUSoCState {
     SiFiveUPRCIState prci;
     SiFiveUOTPState otp;
     CadenceGEMState gem;
+    MemoryRegion mask_rom;
+    MemoryRegion l2lim_mem;
 } SiFiveUSoCState;
 
 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 754af19eef..96177c1977 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -478,8 +478,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
     MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
@@ -503,10 +501,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     /* boot rom */
-    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
+    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
-                                mask_rom);
+                                &s->mask_rom);
 
     /*
      * Add L2-LIM at reset size.
@@ -517,10 +515,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * leave it enabled all the time. This won't break anything, but will be
      * too generous to misbehaving guests.
      */
-    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+    memory_region_init_ram(&s->l2lim_mem, NULL, "riscv.sifive.u.l2lim",
                            memmap[SIFIVE_U_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base,
-                                l2lim_mem);
+                                &s->l2lim_mem);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
-- 
2.21.1


