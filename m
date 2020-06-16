Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BDBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7340B2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haNTW4L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7340B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzs6-0003jb-OB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 20:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoY-00079Z-G5; Mon, 15 Jun 2020 20:51:01 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoW-0006Kv-OM; Mon, 15 Jun 2020 20:50:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so4349473plk.3;
 Mon, 15 Jun 2020 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jmW2hH35m1L4rvDInytOtIMsYkAXmXBZIMWlBl+zHXI=;
 b=haNTW4L2X1E8SWY3I1kYbF3H541u7v5o6ETogFbpJhRMZ+EUQAuqylpSXoMlTlbGHv
 suM8Gn/xbSx8kIY6SMh+Thsn5m86ZGoXOyQ4J/frnQsf/ytT47iDHzJYeYZP/VUVDlP2
 0d7juuPlMM/WEEfPKEBcU6KzI0fs7EfNpLFNpVoBbYI7wFTxVPvfCX7xVm5xN+HRWwDM
 NJZCsz/qjR+iT4/Cgm9ocCu04GImlbstLkgiN+/6AZtHEjayehwuQa0CEQO2g9Zdo9PQ
 d8ZReCBy0wGeB7ZDfyeXlkJAF3P7hukOQJ06w4zHnfRMxz4OOLsnCdVs59moHuVWeQxI
 2iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jmW2hH35m1L4rvDInytOtIMsYkAXmXBZIMWlBl+zHXI=;
 b=l9Rc1fmRi14W4WURKAPCRf29vNiSmcPujMxmRJx/LxkXVND5WMelar2q77UIG1bddf
 8zWdV7jUYwFSmCiuAUxs+witP8G7v4GReyoKQ5Iit3LREYCylVZL+VqaVOdltR3eVOLh
 VEwCj3uKyrKtjn+OTDQixqp0zwMVyU3uaLcSCd1dHK/UxDYhc76egZ4GQFjUbJQK2hRl
 FiS5nZsA41LJsfirXpZHKUEqAlKVIdLZNN5N8ieZJ5K1lXeCwS99dTfUrWcRE7JEOV3R
 fsXrUdRTViawopUFbhYif0mMs7aLdztDubXq6E8XCXd8elV1Cjojocis0ttqNBoalUhd
 f2kg==
X-Gm-Message-State: AOAM530CnABuaVNUdc/DnbS8/8j+EMVPTNcCBTjykUsKz1vWvrBw9Ver
 OT+vXivMDJTAqLkIaH8Ydjc=
X-Google-Smtp-Source: ABdhPJzzcBiiEKVH6QGSlOKZAS56dFRq7h3QFsDP0qJSYa0p4TEJV258FMt325fRWgg/b+uoxnfhJA==
X-Received: by 2002:a17:902:c3cb:: with SMTP id
 j11mr473566plj.171.1592268655058; 
 Mon, 15 Jun 2020 17:50:55 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i20sm15210539pfd.81.2020.06.15.17.50.54
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 15 Jun 2020 17:50:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 5/5] hw/riscv: sifive_u: Add a dummy DDR memory controller
 device
Date: Mon, 15 Jun 2020 17:50:41 -0700
Message-Id: <1592268641-7478-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
References: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v1)

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


