Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA97208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeigT26a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA97208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrCEb-0001Ep-6N
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 23:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDV-0007w8-5n; Thu, 02 Jul 2020 23:18:21 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDT-0005yN-Eb; Thu, 02 Jul 2020 23:18:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id c1so6109241pja.5;
 Thu, 02 Jul 2020 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RQAT9nNRIY+cpBD2vdhyBLwJvRwixaDE0fRY0E5e1cw=;
 b=EeigT26aBwR+I8jtwCZ56Ec6x+HUCKE7YjXE10y9z5j6YB+ODTgcEdYOqCbuSP5ej3
 w0lupJyIq93dpNGX3ISGJOGOKZm6Hb0YxHCxZe4eKo5NMmD7Fp86o6tnIkAguNGdI3uo
 Is9O8MFjZiDLZwXxamS/2at9gJoc6+Ow91541oFWyyDj3MabwV9FIfXJlIYz9nOrWi/Y
 xe8uh4lygKkNR+N1+aVwkhrj53+ohaQ/dIHKOp+pnLFIcRejxBh6bsDj9IQnBC8UUnkE
 Xz2SL9lkf1cN9zu2NOL/RG/SzedCUy43/H4jNPdng6trpeNe86WUR0SjVinLDuMGCvMM
 XvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RQAT9nNRIY+cpBD2vdhyBLwJvRwixaDE0fRY0E5e1cw=;
 b=RgGZRc8uTi576n6dcld26n//Q47zzK86Wj4/HIA9LuHAmzUIKVm2WligxBf81iOzWz
 Z4aymZYd0XeCunrjrMj8WPA4tX/kfcMsO4Oe1DCh8cJHaQVYctYUkIT8XFckCop+r1uN
 MbiWM6nALw+Y1JmjS6a44wwt4NYwNkCgxtdeJzMDH6ZJd0EJ7IwRnvv6KidoXUx5mGQ0
 54k9WFFhsaa0elGJZuMio0D6c+emt09eC0q8yLnHp+0mE11s3ZOXIc//IfqwkRVswhfa
 hbdOTKAlt+cpJNXOTHvSTPF54EFh5NKgBLisYfXULm8VgFnurIQ4O2GCLs9l5mPtrtrA
 MJTQ==
X-Gm-Message-State: AOAM531oMzk9JeBuMYTsZOgF+ZEu+SMcJ5zZYoqbys4d01rtarR9P3hG
 gE/R2cytXu0TMDvCZlm1hVGpP2ya
X-Google-Smtp-Source: ABdhPJwDcbzup4iwor0DhU706BgVN0RPYRHb7luCvsPyap0mGLaL6Yfxc/IdCBN1s5Sz/rPgPgdWaw==
X-Received: by 2002:a17:902:7592:: with SMTP id
 j18mr24500335pll.298.1593746297911; 
 Thu, 02 Jul 2020 20:18:17 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id c12sm10165745pfn.162.2020.07.02.20.18.16
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 02 Jul 2020 20:18:17 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 5/7] hw/riscv: spike: Change the default bios to use
 generic platform image
Date: Thu,  2 Jul 2020 20:18:05 -0700
Message-Id: <1593746287-19251-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
References: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

To keep sync with other RISC-V machines, change the default bios to
use generic platform fw_dynamic.elf image.

While we are here, add some comments to mention that using ELF files
for the Spike machine was intentional.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v3:
- Change to fw_dynamic.elf for Spike

 hw/riscv/spike.c                               |   9 +++++++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
 3 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b295a43..a187aa3 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -42,10 +42,15 @@
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 
+/*
+ * Not like other RISC-V machines that use plain binary bios images,
+ * keeping ELF files here was intentional because BIN files don't work
+ * for the Spike machine as HTIF emulation depends on ELF parsing.
+ */
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.elf"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.elf"
 #endif
 
 static const struct MemmapEntry {
diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.elf b/pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
new file mode 100644
index 0000000..eb9ebf5
Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.elf differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.elf b/pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
new file mode 100644
index 0000000..642a64e
Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.elf differ
-- 
2.7.4


