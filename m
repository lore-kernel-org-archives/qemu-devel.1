Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8031BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9042076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHH2oOCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9042076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlF6-0006YH-FM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlE0-0004h2-JQ; Fri, 10 Jul 2020 01:05:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtlDy-0006Iq-SZ; Fri, 10 Jul 2020 01:05:28 -0400
Received: by mail-pg1-x543.google.com with SMTP id z5so1989145pgb.6;
 Thu, 09 Jul 2020 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M0wM1ATVTCyAhKblgVkTw/n2u4Z2M1VeonuoZ3M/FH4=;
 b=pHH2oOCWTUiLfcpCg+2n+ozlCH9eNLdPQBkuJlcwnkxtD/pjE0IswLwOLxBawXfwak
 RkXqk+RHuU/iSkiThqKAKH6WlqXWV53OUmeoHInJZDGdQyG1RyP8SVHxhhHbU4o2KkHl
 aVm1FH9OHdjNP72V+MjkNeOO5PSdvzhn/rYjotSqnArNfx/UaKmDvWU7fjoA9+yy08p8
 1sWU9B+btYQX+RZKVUacal3lVp4RfCYa4ig+oJ1hrd2OoqOORFBehM4bSWs/xKJPCAzs
 3Z5JnnyCJsG3ruGC3vs0+p9G4ux51cIiU2ruDsY6oj9Lf0EoG9ggLnwxI5A/5C5fcyvV
 c7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M0wM1ATVTCyAhKblgVkTw/n2u4Z2M1VeonuoZ3M/FH4=;
 b=ayjEXHFg2B83mSOZsNRW4waKCMF5Fygd9SAwnA0vOtCCvRvkT1sCeJ91NdVu8wJod6
 pKiBYtQ8xCyH6XaVAk2q9SDiwasplOnRGaYf2+MLd04+flHUAWm3vmtXR3ufjlKMPiPb
 cK0g8wnBsqlpCM/RKmEJ2oYAwUIcR+ft2Q/t2LI5MsGmQCs+R8d2dNoFJxCmAHAN4FCt
 SsT8uDv041lXjoHD2OJJ+gaAMN57aVBUClogmRDJQBv5ghcVe/dWiyLZSMMGyEmHQFzP
 dI4mHn/SC2ibtBlAe3xefyDGD2W0nEsqdOrp1GJXFVLSaGotncvc52bOzMuGaBtdDJ2A
 CEUA==
X-Gm-Message-State: AOAM533PEgzh2p3C0vH1HjrECgS464cHVR11J4qPBIoCf4zymA6QbV8e
 OuKRO4et8sXVx+9440ulX+g=
X-Google-Smtp-Source: ABdhPJxptjaIPa/0K0dhKenWIkpv133f8nE/dsK6sXHBVix9F+WYOLl2ZN30SGASislc8Y/L/CDKww==
X-Received: by 2002:aa7:8e0c:: with SMTP id c12mr19780775pfr.38.1594357525346; 
 Thu, 09 Jul 2020 22:05:25 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id g30sm4659175pfq.189.2020.07.09.22.05.24
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 09 Jul 2020 22:05:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 5/7] hw/riscv: spike: Change the default bios to use
 generic platform image
Date: Thu,  9 Jul 2020 22:04:57 -0700
Message-Id: <1594357499-29068-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x543.google.com
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


