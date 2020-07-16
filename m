Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976AFC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C592065E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVZCbEj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C592065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwvF-0001PI-PE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsx-0005tu-RB; Thu, 16 Jul 2020 01:56:47 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsw-0000Lq-Ac; Thu, 16 Jul 2020 01:56:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so5718655wrw.1;
 Wed, 15 Jul 2020 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v4rIb2CeclCvwojfrkAqQ1sS0w4c9rJ4vZWLayY4XDc=;
 b=CVZCbEj8q8nNgCkAPO0JJkK4Tk4OrU03tI+1IW2lZLzcZWrM2Yx6R4NOTCUGptCUfJ
 7yLYTiXK3psqw/910aOi9KnKHSLKiYjby05ZGEsMC2xHKP/6YZ+XXGNjdghomHgtjWIP
 Xbf5K2WDhBJ/xzlUoBgemIdAZuFGdKBGUurCh+d40YlVFAlNyPE6illau8HJs57FIIV1
 /ju1q3fTiChS8RS275AKg4Li8GuNktAOuT4C2Q5nZ8+lLa8gkVjHvdJ5r28fmtH1wlnz
 AnP12OY1zyiK+hNY3nKHKgfqjJYWa0N/e4lRLRXkRtfqOrAYTQYeMcywytZqdZWkQpIz
 jhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v4rIb2CeclCvwojfrkAqQ1sS0w4c9rJ4vZWLayY4XDc=;
 b=YaCA8bJobOyLi/CJQmFZI4no579R1DMSUyqe6Usc44+ActOU56QHTKb1dtCfQC9SOW
 WmbjzyVoo9ECkGV2RS/H85GkewlmXceWqyubdQSAfr7bG2Ypy638JgKuuumjPaIjg6H8
 47c2p2TpFVLEB/mkevRuArVEkou3cUtltw9NTsXfrI1e4fWNjBDmAE1s6RkyRd6ZTsEU
 oz6wnWE0datsyqcEqrgM4JlkS4dyTTeAaGthK29OB4aUrPZPtY0m9SRZmsNECylQ45RH
 y/qKm9/G8ssTOeQlvYGXI10uuBXki3xJsxJ89SCHei/fkgtrZmfk5F4IO4t0A3mTIVqc
 e/iw==
X-Gm-Message-State: AOAM532X7V1F9d1jPT52GzVQNhH/Pv0xh1PhG5EwhpHJpioYFr8dOtqn
 uO5tjL/UMNPBD+vHSZh0o6E=
X-Google-Smtp-Source: ABdhPJyeRQ89v02DAROIHnm/6tk4X93uhC5ccEsi4dbjE+RUR5yKW+250CwJg7INMxLROKDFTz+OtQ==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr3296268wrr.196.1594879004844; 
 Wed, 15 Jul 2020 22:56:44 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f12sm7193458wrw.53.2020.07.15.22.56.42
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 15 Jul 2020 22:56:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 5/7] hw/riscv: spike: Change the default bios to use
 generic platform image
Date: Wed, 15 Jul 2020 22:56:09 -0700
Message-Id: <1594878971-26050-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(no changes since v3)

Changes in v3:
- Change to fw_dynamic.elf for Spike

 hw/riscv/spike.c                               |   9 +++++++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
 3 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 7b23a29..13958bd 100644
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


