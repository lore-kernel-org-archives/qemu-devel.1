Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647B52541D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7C3q21X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B52541D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnG5i-0003k4-MG
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1i-0006WA-9A; Mon, 22 Jun 2020 02:33:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1b-0007v9-Jv; Mon, 22 Jun 2020 02:33:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so13420922wrm.4;
 Sun, 21 Jun 2020 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xz3x58qCy/6rZFSI16VgMGU7FAdOPJY6KAWYPjgSODE=;
 b=U7C3q21XyfMc755wUOL50i/2a1gFlnECu0lLh+XcvccNvMCqNCX2aRK4cjK2J8H3h+
 WNw64j3lb4SDstIHkZJr5fZHyGXTZdfpdjtptFW9AUqYx2DaVXhWof+M1jvGbDrToIht
 bAwg63QjenuXquThZp8DZ8vPpUALinSiVzovc/oUJpZqbLaXEwDKNgJEelwT6T7pCtM1
 JBB3EuBk36dyYZUCvqHQ8DSRCSkccg6QnEHkDCCH5z0oXhvyuzrAfz3q9tbAvUz6uTwK
 b4jhMwPWLg4KTBb9w5E+iK2UX9RmoHFsyceMxDXLpGRqXZlIg5W6rznDuECWe55T3frz
 HkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xz3x58qCy/6rZFSI16VgMGU7FAdOPJY6KAWYPjgSODE=;
 b=otYVwtR7pw7z0PSHRwSE1bT5DsOlZt/nsPILHAdjhwEoNRK/gSwBGgqKtYPQAOkQ09
 k2LljPJzvCchzhZlA+Az19tCiagy/dx1BC3FGEN6BRKC5BeF0SGD6l23YXoWi09SKxiT
 PxvjbHwYFzF81ZI9ajXCNniUdg/1Reb18caxhZ6H8WpJB/5/5kfmet3+LwJCo989DcRH
 4/eElKrebXhHiym8TKOnLxAiGpgeSGMowRy6IfXYj6V3T5euW2uHV+a9QdKmchvhOvKW
 8EBLupcv4GQpaoABZSkHH1LXuAPCu4lCJOEtlfWfkfoqcmT53U2JmT8MjWWb3Vs7tkQO
 9zbQ==
X-Gm-Message-State: AOAM533wolrWQv4TU7LjBKQDIavUx8jdg9x3E/LFX0FW/Eulo0Fq3guQ
 nP0rfH/fWuVXgMjCJl2Bwjk=
X-Google-Smtp-Source: ABdhPJw4XJMvzuVDtqPZSUYnUax1VSxhdpAThyrWnPJkAbQ4uXJ6Hv1eVw84MdE99HzJX3vzYBDefg==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr17831639wrs.374.1592807625465; 
 Sun, 21 Jun 2020 23:33:45 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id a10sm16684240wrm.21.2020.06.21.23.33.43
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 21 Jun 2020 23:33:45 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 5/7] hw/riscv: spike: Change the default bios to use
 generic platform image
Date: Sun, 21 Jun 2020 23:33:22 -0700
Message-Id: <1592807604-20805-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x441.google.com
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
use generic platform image.

While we are here, add some comments to mention that using ELF files
for the Spike machine was intentional.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/spike.c                            |   9 +++++++--
 pc-bios/opensbi-riscv32-generic-fw_jump.elf | Bin 0 -> 554156 bytes
 pc-bios/opensbi-riscv64-generic-fw_jump.elf | Bin 0 -> 619960 bytes
 3 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_jump.elf
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.elf

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3c87e04..2fb7f98 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -45,10 +45,15 @@
 
 #include <libfdt.h>
 
+/*
+ * Not like other RISC-V machines that use plain binary bios images,
+ * keeping ELF files here was intentional because BIN files don't work
+ * for the Spike machine as HTIF emulation depends on ELF parsing.
+ */
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.elf"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.elf"
 #endif
 
 static const struct MemmapEntry {
diff --git a/pc-bios/opensbi-riscv32-generic-fw_jump.elf b/pc-bios/opensbi-riscv32-generic-fw_jump.elf
new file mode 100644
index 0000000..5fd3fb7
Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_jump.elf differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_jump.elf b/pc-bios/opensbi-riscv64-generic-fw_jump.elf
new file mode 100644
index 0000000..d29e4f8
Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_jump.elf differ
-- 
2.7.4


