Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F3ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5645D208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F8jCX7JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5645D208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Jq-0007fn-Ht
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pi-0005Uk-Mn
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Ph-0003wL-6i
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Ph-0003w9-0y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id q21so5766672plr.13
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ZoHc+VHVu0Akb6H7aKW6gMetNPuN2wzERVN9x/1HJjc=;
 b=F8jCX7JZzM154uWfkxmBJq+SVY2/cU1YZZlyU0v6xzHxtDAFGY80ipmN0sFhOg3CH7
 XX2s23vG7ZOaf2KK9rgKPzOEt0us2yfbb3y+ZcRPkfSg+jSXNbIRbu0UM9DH5uGu3M80
 fM+wPmmdJ/sYzw9ZS3CAyTGfJqvAsrrJrZ3RRpK/E7K1KUyACQyCWmw8uKUkuLbGYZhh
 O7vWy5n2JYQ2+v27zdya2xOkVfW5nARDnxTKVdaNhK9Ak22TL1wTFU5HtmPuX8ZhowK/
 sNc9hdHy42d9PiHqQT7JxP/i47hmHGOlrz3OKgl5H8uykNF8BFWmt+rRSpU1/3a1pTnP
 ZSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ZoHc+VHVu0Akb6H7aKW6gMetNPuN2wzERVN9x/1HJjc=;
 b=gLWnMVLMhj6b9cBiMi/atXrt+1q2B5OuUEMEEp3TrszCkaJzz5a1KBX9tUe2+j50jF
 emr8Ftbq0xMyMVE7UL+XEQ7qjfTn3DoydPjk4JcOmODHAXi+52dTCWJ0O/q7MizKyPmZ
 3ACuot3Czg3LXedLiytSZ/+hDHrhvikVBOwVEehoLgKQVYdzgRWDcMnYJ4Vw+O4FxGWw
 0rVge6W61F/uTHf70drgw/FPOyI3ZHipL5tObBa6o9PWQy8mTilcv78xjyZ7vE6g2yat
 xrs26EIyYZLZekVXseJPYAljP8kGGxoRuUKSvtKj/XZwpRCP+8yhuV1iZba1aaL9Y+6m
 V5hQ==
X-Gm-Message-State: APjAAAUQuIFfD22/k0j5GmhNdU/nDyia+9jpKo/Taqbh0Mcdz3ef2pYs
 5rtPxvgM/GIkjFp0Y8lwXRtvGUQ/oiToIw==
X-Google-Smtp-Source: APXvYqznrUp1MPO418qNiEbQu5v1Jcgq8VpP6W5YjouGPFDtFaD3bfbyp+Mw6ajSE2RUNC6hAZMsXA==
X-Received: by 2002:a17:902:bd91:: with SMTP id
 q17mr19824143pls.43.1572278314453; 
 Mon, 28 Oct 2019 08:58:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id a6sm11595869pfn.99.2019.10.28.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:33 -0700 (PDT)
Subject: [PULL 10/18] riscv/sifive_u: Add the start-in-flash property
Date: Mon, 28 Oct 2019 08:48:54 -0700
Message-Id: <20191028154902.32491-11-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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

From: Alistair Francis <alistair.francis@wdc.com>

Add a property that when set to true QEMU will jump from the ROM code to
the start of flash memory instead of DRAM which is the default
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index eb4124f5b4..9552abf4dd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -315,6 +315,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
+    target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
     int i;
 
     /* Initialize SoC */
@@ -357,6 +358,10 @@ static void riscv_sifive_u_init(MachineState *machine)
         }
     }
 
+    if (s->start_in_flash) {
+        start_addr = memmap[SIFIVE_U_FLASH0].base;
+    }
+
     /* reset vector */
     uint32_t reset_vec[8] = {
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
@@ -369,7 +374,7 @@ static void riscv_sifive_u_init(MachineState *machine)
 #endif
         0x00028067,                    /*     jr     t0 */
         0x00000000,
-        memmap[SIFIVE_U_DRAM].base, /* start: .dword DRAM_BASE */
+        start_addr,                    /* start: .dword */
         0x00000000,
                                        /* dtb: */
     };
@@ -433,8 +438,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
+static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
 static void riscv_sifive_u_machine_instance_init(Object *obj)
 {
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
+                             sifive_u_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 794b958dcc..82667b5746 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -57,6 +57,8 @@ typedef struct SiFiveUState {
 
     void *fdt;
     int fdt_size;
+
+    bool start_in_flash;
 } SiFiveUState;
 
 enum {
-- 
2.21.0


