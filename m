Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546B02065E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBs8Aq6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546B02065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwv5-0001As-KP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsv-0005pM-TF; Thu, 16 Jul 2020 01:56:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsu-0000LY-4s; Thu, 16 Jul 2020 01:56:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2so9755672wmf.0;
 Wed, 15 Jul 2020 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TIOV1TSTMNVa25r8cgh5HeGElRw6XrfV2LxFYJnmpgY=;
 b=NBs8Aq6V7+cISc2n4BSZ9p5uhGzZ0mf+Ao7EyRJlW8lmm6yt8D6otS8nuT5qwv1wGs
 ld4ya4iWbwKXIjRQv2kDVvDSWVzH218XVM05XyF1+TEww2/3pF8imXdE3hdqk6b5qovQ
 2LBWzrI3vMLibCtwEmlsqt99bdPfQ9IjMjMMNBR6D0ZCWRpo57hCZ6Lzm/I/YwC8wLXy
 JpqGgD9l7ExjUb/EZi5NQ64RxGeo4g6voSdDnQPXoB1YY/lWAdoP8Ig6ceFiKf0x22vk
 2nuVBAjrnjoutEEgJW4eRCmMdouFzvdviESe3QmyafPRmljSKxsluxAnhwRxa5r0OkPV
 FK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TIOV1TSTMNVa25r8cgh5HeGElRw6XrfV2LxFYJnmpgY=;
 b=YMHrt8+rh18GAReaXB4Qbyj3Pci2bHekqCGRfeGlz1kPLnmg9qwT5qyuVrFmQ5owlr
 ZqBM5ixBXOdutM66wVT144qOeO/837qqkTxs1RwyRE7dXq+WzmfRbyruEibXjv5Bzcix
 CZVL7Ec/YnxhL3m34jJscUrYI6z9iuZbXD8aloTqwcuWstqOkdi5NlDcQVzRMVXqbvfv
 zOr24qy0/4QfNqSS90enLHD4E7BY47Ej8E1z366JESzgSZbCg9QxfQkAqnI86fAIYCFV
 EaoZKB3C2ZOG892uENaNMouIMECYH1WV87jebBCaDCIr8AEzzOSExY0IuBGsHAlzPqcT
 MBvQ==
X-Gm-Message-State: AOAM5329WnQWPwTpcXeKe4HCi4aYx6cd8yTh/6QyH86jmM/utiQomXis
 qr0Z3tOC/K/KDGUHONi8TRI=
X-Google-Smtp-Source: ABdhPJzfqxsbGAOFn0CoY8WLe0s9sstkWHNZzsaPPKrULo9hb7+jqDx/oxYiCyrX9SAv5V/XAR/z9w==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr2752124wmh.130.1594879002463; 
 Wed, 15 Jul 2020 22:56:42 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f12sm7193458wrw.53.2020.07.15.22.56.40
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 15 Jul 2020 22:56:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 4/7] hw/riscv: Use pre-built bios image of generic platform
 for virt & sifive_u
Date: Wed, 15 Jul 2020 22:56:08 -0700
Message-Id: <1594878971-26050-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x341.google.com
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

Update virt and sifive_u machines to use the opensbi fw_dynamic bios
image built for the generic FDT platform.

Remove the out-of-date no longer used bios images.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v5:
- Include the generic fw_dynamic.bin in the Makefile for `make install` bisection

Changes in v4:
- Remove old binaries in the Makefile for `make install` bisection

Changes in v3:
- Change to fw_dynamic.bin for virt & sifive_u

 Makefile                                       |   3 +--
 hw/riscv/sifive_u.c                            |   4 ++--
 hw/riscv/virt.c                                |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
 9 files changed, 5 insertions(+), 6 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/Makefile b/Makefile
index 32345c6..a6d6234 100644
--- a/Makefile
+++ b/Makefile
@@ -841,8 +841,7 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 19a976c..6487d5e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -60,9 +60,9 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 55a907b..6e91cf1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -43,9 +43,9 @@
 #include "hw/pci-host/gpex.h"
 
 #if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
 #else
-# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
+# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
 #endif
 
 static const struct MemmapEntry {
diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
new file mode 100644
index 0000000..23b4dfb
Binary files /dev/null and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
deleted file mode 100644
index 3e0da54..0000000
Binary files a/pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
deleted file mode 100644
index bc56ed6..0000000
Binary files a/pc-bios/opensbi-riscv32-virt-fw_jump.bin and /dev/null differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
new file mode 100644
index 0000000..16c0cf4
Binary files /dev/null and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
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


