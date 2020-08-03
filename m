Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9023C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764912070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXPXy3eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764912070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Uyt-0006Kk-DF
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvz-0001br-J9; Mon, 03 Aug 2020 03:31:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvw-000675-LC; Mon, 03 Aug 2020 03:30:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id a14so33211915wra.5;
 Mon, 03 Aug 2020 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M7TrC+MxPqLAfShenNJlui1NTwtnKhW8UXdzkGWvhA4=;
 b=aXPXy3eQIfDwEzAeNi9G7LG71wiVp/LNRbpzWPnVg/8nKm8giCv71Af8VdrlBXMnZA
 aSVZWsDzX4YJuPM19FewavFha/xQx+DgNG9vzBOedeaJVTx5k2/eapblux6LVcG+3qn0
 D67nZ+ZAlM60QkxfMy/+sw8oBlV2CpqmdXn174pg78uX3myjyrrmqgwNL0T5+6mejkvS
 xx4R7NckJhitC7KDTzIqS109+8++d/88ON+J3X++OoJRUBRb66iFaE+MV+BRT4e+5rkA
 ipC5gZntI3a4qwMaUdgPDSWN4QIstbCe0aFcbuBUbDbDp5B8VZ4EO8Za/bLpaXTqkyqQ
 KAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M7TrC+MxPqLAfShenNJlui1NTwtnKhW8UXdzkGWvhA4=;
 b=Pwy0bZqw8cvYHgIdPBrMBPfeRiAG0KWpiUhu3MT5gf/leV28omBfJZk4OyNwS0oNZv
 CBsxYHULP+al2MQjL4Wmp6//XxstHab+Ojd0MRx3FJXrRNj8lgZA0cYiLdFpSKVyBm+H
 jH1dp5de8+VLqKuBEqO/vTknqLu9CGGNhLYDobubVryNzNLbQv6tGUvtpDa2Gw6aa386
 sonoF7ptlT0bWeXovOwnFEKn7N2lQ4uVKykRQK3Yn61+RqPsQkfO6y+B+QDGUSZESCMb
 AtG4rEB9tWCvRlePhYONMQWEzf8iFySW5/egvLtrqwkRGEzIA+c62dKToITf+4uC2M6k
 bkZA==
X-Gm-Message-State: AOAM533xYGPd5yeaKhnwSiwq8N2xaQkQmZGw/cwKFhe8iLHBERGdqocn
 G6eLBykgZOU6GyNPoYL7Jhl6G+Kh
X-Google-Smtp-Source: ABdhPJzipqUSYUB57huamJCQ+/WWh6IWkNyYce3NNQYzZZCzJonRnMP8WRR5O2DzjXL8jq8DX67azg==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr13562987wrq.417.1596439851694; 
 Mon, 03 Aug 2020 00:30:51 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 130sm23969438wme.26.2020.08.03.00.30.49
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 03 Aug 2020 00:30:51 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 5/6] hw/riscv: spike: Change the default bios to use
 generic platform image
Date: Mon,  3 Aug 2020 00:30:31 -0700
Message-Id: <1596439832-29238-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
References: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
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
Cc: Bin Meng <bin.meng@windriver.com>
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

Changes in v6:
- Squash the Makefile ELF changes into this commit

Changes in v3:
- Change to fw_dynamic.elf for Spike

 Makefile                                       |   3 ++-
 hw/riscv/spike.c                               |   9 +++++++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
 4 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf

diff --git a/Makefile b/Makefile
index 9d87135..58db99f 100644
--- a/Makefile
+++ b/Makefile
@@ -842,7 +842,8 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin
+opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.bin \
+opensbi-riscv32-generic-fw_dynamic.elf opensbi-riscv64-generic-fw_dynamic.elf
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
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


