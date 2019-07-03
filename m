Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273A4C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F039C20645
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F039C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibRl-0005lP-5D
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq9-0006ST-BE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq6-0008FV-7h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq5-000832-Lt
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so1136732lfm.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=fcm0+r8fxMNfE/F4H9Cg6/O9Ghx9bryN1yVdrSBGRYk=;
 b=gW1jk82WZB8sXwiRHoGyvegO5RRJU0HdSKV4cZMl94bnCnsCwGEVBaEHuw0D/QeJ9o
 g0EQITsP5ddX3q2XPKCjXSEQu2qOVHwqqeU5ee1HXlsGzOEh/UiO15l29d5lodIhasWL
 lj/qtxuXfsi86lRtUR2FN8/RRS8KTB8GT/LpfLM3Grsh/ELoNKUVeGqbogD0EjbPsqyl
 KjKSM1vo/RbcAe/NhiO2ubXUdh8BivVzbRChJVCTFs9cpsEvAeB1Whqvoo7WvFJwkfDh
 YfZiHUKdT74HNKYiJA6Q8M8eB58yB4ACSqCADMZkPh4tivtxJRfQjOZi64m4gcI2kEFD
 V3pQ==
X-Gm-Message-State: APjAAAWXiqCx1cOJJpDjFVcVUY1Zro5rOFvuE/DEmuVy+/cKVZ600dXj
 kzEQklGYJaHWOBiDPA181s3Vrhiu6Mn0lg==
X-Google-Smtp-Source: APXvYqykY4Uqid8OF1QFBuN0VY1kVUF2+SmKyo/Fzt9IeDNnvrNr2fvexi5s6o6JCiohGxWzQq4hFw==
X-Received: by 2002:a19:5e4e:: with SMTP id z14mr14667529lfi.11.1562143321205; 
 Wed, 03 Jul 2019 01:42:01 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id w28sm343979ljd.12.2019.07.03.01.42.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:42:00 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:45 -0700
Message-Id: <20190703084048.6980-30-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.68
Subject: [Qemu-devel] [PULL 29/32] riscv: sifive_u: Update the plic hart
 config to support multicore
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

At present the PLIC is instantiated to support only one hart, while
the machine allows at most 4 harts to be created. When more than 1
hart is configured, PLIC needs to instantiated to support multicore,
otherwise an SMP OS does not work.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e2120ac7a5d3..a416d5d08b4d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -344,6 +344,8 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
+    char *plic_hart_config;
+    size_t plic_hart_config_len;
     int i;
     Error *err = NULL;
     NICInfo *nd = &nd_table[0];
@@ -357,9 +359,21 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
 
+    /* create PLIC hart topology configuration string */
+    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
+    plic_hart_config = g_malloc0(plic_hart_config_len);
+    for (i = 0; i < smp_cpus; i++) {
+        if (i != 0) {
+            strncat(plic_hart_config, ",", plic_hart_config_len);
+        }
+        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
+                plic_hart_config_len);
+        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
+    }
+
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        (char *)SIFIVE_U_PLIC_HART_CONFIG,
+        plic_hart_config,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
-- 
2.21.0


