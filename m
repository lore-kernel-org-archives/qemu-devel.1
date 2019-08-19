Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D7DC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211172087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuf6Eprm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211172087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza8Z-0001GK-6Z
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy9-0005Jp-BM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZy8-0008W1-6d
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZy7-0008RE-6C; Mon, 19 Aug 2019 01:12:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id n4so480346pgv.2;
 Sun, 18 Aug 2019 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=RKGX/lJOr5kNn7PApN/gkY4WZxgsdiEPvpBUK+hOqPw=;
 b=Vuf6Eprm+/MQ61s4FuKX7mKiUouW5aJNrvvl+xLhKdIpmMSI6/sC4iVRDteXXIG0jn
 XpmvHdLyTbwy74AylVes+j4nlUB/sVfiH9/bAOqX4AmorDW32G+oewXbCUXo+deaYxbs
 Za6CZDl2Ru9LXlXE4DLyIcPioYBIkN9sDrnR9wOES8wdhXnBQm2bPEvMViDwAhRNu9FW
 bKDC+1JUIKBCQt4W3xEgIYqKv4iokCdCfnQurlDlHoFFODw3paom7yh+gZP1osl7Is62
 kEHRmH3mWxd/zDQIcxVRLwG0NGROyGp8yGLo+c3QrPjEOW+BgWC/XKoeufDsI71cDo0m
 2TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=RKGX/lJOr5kNn7PApN/gkY4WZxgsdiEPvpBUK+hOqPw=;
 b=dWvBedYrOZJKjX1U/U/oauXy0hZSI1AkXbeYY5Qty65Z0fwVbcVSjmEWUmhwk25K4s
 /ENm/KMW6uCrmmdTRea3SrCS8SA1e7QnDlErbxexDXC8hHSMDxo7IVmvBGJSAgXeWibY
 8Ahe4honSOHOeMFbHQvvvqscPEcO4zJrFLsY2XgMIB8AMHflKxMrjEFWHKkzk/8+NzP1
 EuRv4YYoZMokfDc3XAV6nqjcKImNl4QExeaRRpxGbwdpMLU0AMFS0vOXebgRbBFvW65L
 oceD/1C6LT59MBq+cSrt84PpYz2Gd8rKhrBq0q9oD8KvIzpL0kpVN/ZylWwKwxbk3VsU
 fibw==
X-Gm-Message-State: APjAAAUckhTHJWBgAKqOMAdMqau8K/HwNBP6R+5wUucF7pBqfgj8GJiR
 0hS8lO/j+sjN7GOaRMn+J7M=
X-Google-Smtp-Source: APXvYqwuuS4qevsP0E+17jypSGtgfNN4fYv+FX6bJaJsOnOAv9VjhH/8B/9loWqxD5b8fsyovuKHIg==
X-Received: by 2002:a65:5183:: with SMTP id h3mr18463996pgq.250.1566191554358; 
 Sun, 18 Aug 2019 22:12:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:58 -0700
Message-Id: <1566191521-7820-26-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 25/28] riscv: sifive_u: Instantiate OTP
 memory with a serial number
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds an OTP memory with a given serial number to the sifive_u
machine. With such support, the upstream U-Boot for sifive_fu540
boots out of the box on the sifive_u machine.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 5 +++++
 include/hw/riscv/sifive_u.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8f16028..d66a7e8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -10,6 +10,7 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
+ * 4) OTP (One-Time Programmable) memory with stored serial number
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -44,6 +45,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
+#include "hw/riscv/sifive_u_otp.h"
 #include "hw/riscv/sifive_u_prci.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
@@ -66,10 +68,12 @@ static const struct MemmapEntry {
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
 };
 
+#define SIFIVE_OTP_SERIAL   1
 #define GEM_REVISION        0x10070109
 
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
@@ -503,6 +507,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
     sifive_u_prci_create(memmap[SIFIVE_U_PRCI].base);
+    sifive_u_otp_create(memmap[SIFIVE_U_OTP].base, SIFIVE_OTP_SERIAL);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 9acb69e..0362121 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -57,6 +57,7 @@ enum {
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
+    SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM
 };
-- 
2.7.4


