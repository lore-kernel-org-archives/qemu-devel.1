Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649E22072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey+wyIia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649E22072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIeE-0004kH-Gp
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbW-00014q-Up; Mon, 08 Jun 2020 10:18:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbW-0004UA-0j; Mon, 08 Jun 2020 10:18:22 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ne5so3346170pjb.5;
 Mon, 08 Jun 2020 07:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=onR3wuZ/5Rbdh4abrNb1QZq5Ukg7fYZTqsNz+JjL+Pc=;
 b=Ey+wyIiaB4HT2NqG9wHxfu0jdEdIill8phrAIJfWJ6iFAQRn+vrsMhnriuu7KU49Uh
 HkpB+Up3FhtR/H6u7Si56SW2S0DCyJWADj6dweKralrTuAbrpfimXyz0leCR9Kmufi5w
 etnWyIgDaRto4zApxj7z9mPIoHmmpiMnlAtMTtr14MerpxX+obH6F4NyRtTtcbbdlf7v
 Q9YsHjh+qPN8tju+XW02swkzGixclOE0LFFpKDl2+SLg2aeodk1p3N2vxbhHF4v23XEi
 XEXoZ4dvfHptVTkDCEBWxFiXmYGEgVvPSUp2CzvpOH/Yu08AsinJjumKcS5axtb/zSk5
 bzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=onR3wuZ/5Rbdh4abrNb1QZq5Ukg7fYZTqsNz+JjL+Pc=;
 b=iIMSuL2eqWPWA2CGrDeMWERDItkcKpO3bUiQ1/dgIiAc+e2KWY403kdyuo063IE4L+
 33SjTrVg0yNgrNGlhoZm7XQrLTgYpXWDR5hU1kXXs4B/awmfSxb5vb1yA6Ab930TOqi+
 LL3yEimcAHSDyrEMqAVOnzNJLyvoWrEjI6yjccG/GIKbBoBn1j96KUSC5YBcibHsuaqr
 RSHuj5MHocE2MI3E+h7nDYk9vX6iH9e2Uly/FLXKoYlIMwNJM8niqHFE24EjJ2D4enOt
 7El3i3R4ZHpnEbZWXQEsvUDTeTFNNKi7QscwHfZXzOdO9e3Pwf2FLoUKSv9g9TwTXJ4r
 15Ig==
X-Gm-Message-State: AOAM53168m428qCFwbMt6/00LuWltp23ajzdqzdPS64UyoC7LmD1i05l
 nZWQFwsB6G3tnXbeN9qHj7w=
X-Google-Smtp-Source: ABdhPJy48bSeTTBkpVTZO7mvbv2SyP6+tthrn2AL6cfFUpKoq2awMN/v9bLJF0aQ4IquxVH57pHByw==
X-Received: by 2002:a17:90a:ff0e:: with SMTP id
 ce14mr17861893pjb.65.1591625899688; 
 Mon, 08 Jun 2020 07:18:19 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.18
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 03/15] hw/riscv: sifive_u: Simplify the GEM IRQ connect code a
 little bit
Date: Mon,  8 Jun 2020 07:17:32 -0700
Message-Id: <1591625864-31494-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

There is no need to retrieve all PLIC IRQ information in order to
just connect the GEM IRQ. Use qdev_get_gpio_in() directly like
what is done for other peripherals.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f9fef2b..cf7f833 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -528,7 +528,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
-    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -612,10 +611,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
-    for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
-        plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
-    }
-
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
@@ -629,7 +624,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
-                       plic_gpios[SIFIVE_U_GEM_IRQ]);
+                       qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
-- 
2.7.4


