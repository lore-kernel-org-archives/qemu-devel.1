Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339422053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQbdz0HH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339422053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIlz-0000hF-GW
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbj-0001RZ-9w; Mon, 08 Jun 2020 10:18:35 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbi-0004Wg-9Z; Mon, 08 Jun 2020 10:18:34 -0400
Received: by mail-pl1-x641.google.com with SMTP id g12so6712109pll.10;
 Mon, 08 Jun 2020 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Nj6OhjWGxxBEnKG0HNnd5fIFBJbiq3a3JcYD2CxwjVc=;
 b=PQbdz0HHT8FYKBTGcaOht14eZo76lwv4fFuX4U+chb2+GnVw1hWuMC6cpI2D6KUo8+
 WJtI1Y0QzGlgL45gh5YNxdVChV+44zMJaD9G7tEYPln7QOSyIM2Qu0sVotvoam7xek22
 Bhp1LFXiMfymIwUx4rMH5qdbkVdCFFedaUEiGFpgeqsyMmGJS4S7yNqfm3l4BF4ONRQ8
 oxju2F8Oyrel4A7Yw1MlRoioPegeHOXJrMdUCtGcGZDJjyofcnUj6vr80RUg4SEbvGKp
 2SJ5sptJS/gag66JttuL9DX5f82B5r5pU9acDAhUqy67ZB9ERYeEya29v/iwSi4iiesh
 z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Nj6OhjWGxxBEnKG0HNnd5fIFBJbiq3a3JcYD2CxwjVc=;
 b=LLzHmW3PWYBAxk4KqXSZ11Kfgjye6R5P/EvlvaeVGO+SK79rWmie6p5xRBESBub25U
 bmSBfQFVE+aiN6+TfsHwZ5XKdjfXpZWbZUAM/oAlK4ggXGv7AC7Bpjns8IHobrY3WSl7
 Pr8sgY4KIzYdKW05fxvnLpNzq79XBkM09ZL7sotnrMcxC4fkmMa2serQCTw3rJLssZFD
 xY1WlPBO7cpTDf+Mil6hFNP5GrWeDyScYqDb+2/sNk5DkLpNH1eccckukyBRTU+aEtY3
 iT/0Z2co5A31mjdaaBgB2rb2bRdhloBCX8ghqcEPZWOwmY6xcpsSFjZAOKrhIOEZ7ZyS
 iY7g==
X-Gm-Message-State: AOAM531pQnC6zDd0E+7G4tRaH9/4Xo7bBNUG5OKWDQsps9Sr7KdRf6uq
 Fh9dZ7/wLzfaQn5QvYdYqp4=
X-Google-Smtp-Source: ABdhPJxjz0WWUUl2PfQue0VmBShfFa00YnGv+eXV97uxxDJi16+H8X3/XwPkojhkuKTr0bBr3MTE9A==
X-Received: by 2002:a17:90a:bf92:: with SMTP id
 d18mr17262350pjs.120.1591625912779; 
 Mon, 08 Jun 2020 07:18:32 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.32
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:32 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 15/15] hw/riscv: sifive_u: Add a dummy DDR memory controller
 device
Date: Mon,  8 Jun 2020 07:17:44 -0700
Message-Id: <1591625864-31494-16-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

It is enough to simply map the SiFive FU540 DDR memory controller
into the MMIO space using create_unimplemented_device(), to make
the upstream U-Boot v2020.07 DDR memory initialization codes happy.

Note we do not generate device tree fragment for the DDR memory
controller. Since the controller data in device tree consumes a
very large space (see fu540-hifive-unleashed-a00-ddr.dtsi in the
U-Boot source), and it is only needed by U-Boot SPL but not any
operating system, we choose not to generate the fragment here.
This also means when testing with U-Boot SPL, the device tree has
to come from U-Boot SPL itself, but not the one generated by QEMU
on the fly. The memory has to be set to 8GiB to match the real
HiFive Unleashed board when invoking QEMU (-m 8G).

With this commit, QEMU can boot U-Boot SPL built for SiFive FU540
all the way up to loading U-Boot proper from MMC:

$ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin

U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
Trying to boot from MMC1
Unhandled exception: Load access fault
EPC: 0000000008009be6 TVAL: 0000000010050014

The above exception is expected because QSPI is unsupported yet.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

 hw/riscv/sifive_u.c         | 4 ++++
 include/hw/riscv/sifive_u.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c94ff6f..7923df4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -82,6 +82,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_DMC] =      { 0x100b0000,    0x10000 },
     [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
@@ -733,6 +734,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
+
+    create_unimplemented_device("riscv.sifive.u.dmc",
+        memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
 }
 
 static Property sifive_u_soc_props[] = {
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 5d80f91..3e33646 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -78,6 +78,7 @@ enum {
     SIFIVE_U_UART1,
     SIFIVE_U_GPIO,
     SIFIVE_U_OTP,
+    SIFIVE_U_DMC,
     SIFIVE_U_FLASH0,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM,
-- 
2.7.4


