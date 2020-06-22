Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A514AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7036123331
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvv83vqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036123331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnG3d-0000Zd-Lv
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1c-0006Ts-4E; Mon, 22 Jun 2020 02:33:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1a-0007uw-9Y; Mon, 22 Jun 2020 02:33:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so15365948wrs.11;
 Sun, 21 Jun 2020 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aGHyCuLl/Ys7FbleNBZAF/IMrzuPBOPAwUm4n3cBWrQ=;
 b=Yvv83vqiTPUWqTUk++xOuXRVFk+QPaxQFfg11xVfNJf+2x3zXAdP+FUowjXyeyPmJx
 vgtxAciO2+d/q4j9zDLbPc5bcRXPWa6oJzEyZ8Wk0ctN3ViM28YXftOxCnmo13SSCX/r
 FEtz/Q34a60kCQ0e/0ziUwYobM51AuoTIl+byx0LlkfQ2Nujj9diPM5SiaILkWwJvqb3
 fT1lsIbwE2kVIiL3/+OlM1XSAiwwEH1yvSxEzyWfr8dZi0FDilfXlY6MerJXreg/c3V5
 ZxDA5MJeLH1wOGHiCWUobNOoz3pCRGzH1m/1yCK/jNLAl5xnqaK20OzSmFi9szXTbr60
 P5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aGHyCuLl/Ys7FbleNBZAF/IMrzuPBOPAwUm4n3cBWrQ=;
 b=tVGwWDMPO5vjagKKK2mRg7pOKyKnEVAQgyYUR4y/gYh164ck14BvHiRUJ/6B+y9NkQ
 DpSjeZngPNfT6hyho7Cc9g6050ePbj6Yi6Vflwtk3ICEdvj0eKmGvIf/MoJuXH1DFC5V
 dPLP0JATsZSsNyqbQRm/37t9Da8ciuvlK9rAd7ovGY7rvjy/ir9q0l4amO0JYCx5y9ek
 v3OOQbavPBorKmdd5vfTCFa5w0ZaF1rASAa3gx82Jw7knP1Yvj2tk8CJx+3O92HeADwq
 qHndHFjPtx6Y99qw+U5l1Pct0tkHiKdCvvxhz+bf0ArRPk8ERU9O8Y1plnFWpSP1jagA
 z5bA==
X-Gm-Message-State: AOAM530BDWtreZCDX0GJZ9oWa8x+CUDwo980g54I1ywFPFJ09rYPBpiF
 v5QB7BgyWpgmf4all9/xVnc=
X-Google-Smtp-Source: ABdhPJyvvuel2ptwTCFei2Ak1NGKs95SQcYZvEZT7cCW+8lARe6xv1VphlYV6k3wfKgzMIuM8JvE5w==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr18735402wrs.229.1592807623091; 
 Sun, 21 Jun 2020 23:33:43 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id a10sm16684240wrm.21.2020.06.21.23.33.40
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 21 Jun 2020 23:33:42 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 4/7] hw/riscv: Use pre-built bios image of generic platform
 for virt & sifive_u
Date: Sun, 21 Jun 2020 23:33:21 -0700
Message-Id: <1592807604-20805-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x442.google.com
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

Update virt and sifive_u machines to use the opensbi bios image
built for the generic FDT platform.

Remove the out-of-date no longer used bios images.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/sifive_u.c                          |   4 ++--
 hw/riscv/virt.c                              |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_jump.bin  | Bin 0 -> 58048 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_jump.bin  | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 57920 -> 0 bytes
 8 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ea197ab..2edd81a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -58,9 +58,9 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 616db6f..b7f8598 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -46,9 +46,9 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_jump.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_jump.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/pc-bios/opensbi-riscv32-generic-fw_jump.bin b/pc-bios/opensbi-riscv32-generic-fw_jump.bin
new file mode 100644
index 0000000..ec40860
Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_jump.bin differ
diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
deleted file mode 100644
index 3e0da54..0000000
Binary files a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
deleted file mode 100644
index bc56ed6..0000000
Binary files a/pc-bios/opensbi-riscv32-virt-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_jump.bin b/pc-bios/opensbi-riscv64-generic-fw_jump.bin
new file mode 100644
index 0000000..7b08352
Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_jump.bin differ
diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
deleted file mode 100644
index 1acee86..0000000
Binary files a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
deleted file mode 100644
index c62f2b4..0000000
Binary files a/pc-bios/opensbi-riscv64-virt-fw_jump.bin and /dev/null differ
-- 
2.7.4


