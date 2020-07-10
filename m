Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A77C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A655E2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUCeSAjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A655E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlGx-0002bb-So
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlDz-0004ek-P2; Fri, 10 Jul 2020 01:05:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlDy-0006Ii-1E; Fri, 10 Jul 2020 01:05:27 -0400
Received: by mail-pf1-x442.google.com with SMTP id u18so2002063pfk.10;
 Thu, 09 Jul 2020 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mlUaGZWQPKSRpzuD0YNNdJYl3EAixOrmpeDJCpiLcI0=;
 b=pUCeSAjN68vXbf58Ul49OEpnReR9sjn/gPzXMRlccrJb6yYEgJ5DK8oSL7Lm9JiHAw
 XnppnGIdFfpO9Q0LK2h+WBGklndtBZjviazUovz25LoyGsXr+Yv2suTcOuqM+7m4Vp9s
 2Yjkrd5/cYIjL2IwbaSZ78GkAp55pCnBNjaMXTdGQtoMR2+TX43U+OK3ASV0kc664bC0
 +FKjhCMZ8TYpvL6GA0VBhbXkBP3Kv3pGvFb7AiHYKbRX2f8UbQwQTbm2QzVVqIsE5gp5
 Dya91kkoyzewpdbIDjXYNVjtcQ+H9tcJzyVpRNTRxQJWVKMAPrz+3n+Ew9qx6k6qfp7d
 /MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mlUaGZWQPKSRpzuD0YNNdJYl3EAixOrmpeDJCpiLcI0=;
 b=mv4AY9caAFggDa3YNatUFmGQ8i/y2SK6+Xhw7pRqTtpt4jDZ9Yo5kY9/BGvS920WPO
 qnOypvkBDo0m4r1nMJamVUoZA2YuDP6qJe2iM7TSSYk4VDajgNFG+vUj1h1BTEb102x3
 uV0CMVRvnIQvv07uRuCDQud0rYvCQf5m+CjqG2bYv8AaIYNiY7ntiiKMvKPymi0Agg+C
 z4MbOZ56lVSPpAam9fJ+idSLPWrRSavNC0KbNOk4nu6ooRKk97X318QVhUDPukDi7YWY
 yaO27jvWKLLlMyBK/+WM4VDy6h5SerIvko/RzUqWWGZKhxXMOMC/YRE6m5RwZ+36ac9D
 8UYw==
X-Gm-Message-State: AOAM530ceSBhDso4VR/w0m/UYKeyUY5mPlweunKgUKtVOHlzegRRkKpu
 ryJWchv0IDcwQgq9aRttbY0=
X-Google-Smtp-Source: ABdhPJzj/Gw7r3Z3riASxq9Z6aA5cw8PvHkqzN8VraY8gEvPRBKCYb3l5jMBTELrU56ZkJOyu8F1sQ==
X-Received: by 2002:aa7:8801:: with SMTP id c1mr60194571pfo.105.1594357524332; 
 Thu, 09 Jul 2020 22:05:24 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id g30sm4659175pfq.189.2020.07.09.22.05.23
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 09 Jul 2020 22:05:23 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic platform
 for virt & sifive_u
Date: Thu,  9 Jul 2020 22:04:56 -0700
Message-Id: <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x442.google.com
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

Changes in v4:
- Remove old binaries in the Makefile for `make install` bisection

Changes in v3:
- Change to fw_dynamic.bin for virt & sifive_u

 Makefile                                       |   4 +---
 hw/riscv/sifive_u.c                            |   4 ++--
 hw/riscv/virt.c                                |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
 9 files changed, 5 insertions(+), 7 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/Makefile b/Makefile
index b1b8a5a..f06b3ae 100644
--- a/Makefile
+++ b/Makefile
@@ -840,9 +840,7 @@ palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
-hppa-firmware.img \
-opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+hppa-firmware.img
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b434fd3..dc46f64 100644
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
index 85e17fe..5ca49c5 100644
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


