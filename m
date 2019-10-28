Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD24208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BMZQ6xAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD24208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8HH-0005xA-Hf
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pn-0005cT-1h
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pl-0003zm-S0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pl-0003zQ-Cg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id 15so7157954pgt.7
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=2NCHxf2RTfuXrJhdamckaC8gMLlH4bUoRGro3j12kyY=;
 b=BMZQ6xAhMV1Bhz7Pv6uytvQALaiS65Ikwji5Hp/zCFEdCdgcMhQKlZ8Sdy69JgoAAZ
 gOO1W9PZrbDA4bYZKZVVQ2dUct86F/zifZLjaMQ7XJ2okR0PBHHf/LvcqpU3EsxgRVpV
 JYTuHHRDnqBZhwVv0giirFrjeQ0e+GXwqu2dramRGmSOq1f0aVVe5N8gJSXTzSzmlro4
 MZdrULS4CFUjhVtDSbMWwzSDx7CU7nCvjCYOR/njAlQcb7uQzK6kAXnhFSWvlZopZgkc
 SSEHlUi0PBu6DkUdkqSDXOERdnQOuBmK1zZsEHUkkOjpAqBXidJW48dbByQ81a/DZbp3
 KGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=2NCHxf2RTfuXrJhdamckaC8gMLlH4bUoRGro3j12kyY=;
 b=ODttzK9r5OWGhhIyH78JlVcaHTxUh8acCaH2YlRlbehN+/Zpgti+YXo65IDj/+ALVH
 aT0R6x1UhpqS5uHE3NQdwHMFGbkYOHPtRwgezbiXRtck645zVVdY62jWyOnnMMCiQnDh
 Y4j8jr47+crtywH5daNC5t5j/FdAcqk/LEvD9RAHhjO/QBe/9uoXb3tesJiHmb0lXV4c
 AbCRLrnFj19RlZKegKt3YDEq6o75dY+NQdSjI8uEjOVSQnWs+LaxYLtKEbs+N4emTlx8
 dSKqxeiE85NgDkLvIPmFOgX3cCyXELWz5upafGgxqv+ldYpeT0GIG6t8KIkbO5k8FxJI
 j3pw==
X-Gm-Message-State: APjAAAWXO90PXJuGcm8dRMQ2sEwV2PLp+p9X1RLK9Chaiqe+2kzt4Qp2
 YXRJm8KiNop/Czx9FNoKbOjJbLRtuQm6CQ==
X-Google-Smtp-Source: APXvYqxXDhAJLe9HLi31OoScyRGZ545RYqLXzk9aXZjSY1aDYbP7hHX7ddZZg2Bkr/5RClm7ijM+YA==
X-Received: by 2002:a63:e255:: with SMTP id y21mr21309744pgj.353.1572278320076; 
 Mon, 28 Oct 2019 08:58:40 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id c6sm9841073pfj.59.2019.10.28.08.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:39 -0700 (PDT)
Subject: [PULL 13/18] riscv/virt: Jump to pflash if specified
Date: Mon, 28 Oct 2019 08:48:57 -0700
Message-Id: <20191028154902.32491-14-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

If the user supplied pflash to QEMU then change the reset code to jump
to the pflash base address instead of the DRAM base address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b2156abd6c..cc8f311e6b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -443,6 +443,7 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
+    target_ulong start_addr = memmap[VIRT_DRAM].base;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -489,6 +490,14 @@ static void riscv_virt_board_init(MachineState *machine)
         }
     }
 
+    if (drive_get(IF_PFLASH, 0, 0)) {
+        /*
+         * Pflash was supplied, let's overwrite the address we jump to after
+         * reset to the base of the flash.
+         */
+        start_addr = virt_memmap[VIRT_FLASH].base;
+    }
+
     /* reset vector */
     uint32_t reset_vec[8] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
@@ -501,7 +510,7 @@ static void riscv_virt_board_init(MachineState *machine)
 #endif
         0x00028067,                  /*     jr     t0 */
         0x00000000,
-        memmap[VIRT_DRAM].base,      /* start: .dword memmap[VIRT_DRAM].base */
+        start_addr,                  /* start: .dword */
         0x00000000,
                                      /* dtb: */
     };
-- 
2.21.0


