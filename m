Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C589C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1DD208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiBe+Onz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1DD208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwixJ-0000xG-7U
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwist-0005zl-0x
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwiss-0003yk-2M
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisr-0003x0-S7; Sun, 11 Aug 2019 04:07:21 -0400
Received: by mail-pg1-x542.google.com with SMTP id n190so7170243pgn.0;
 Sun, 11 Aug 2019 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=6dLjJ31T+Cxxsp5GGfF1L/TvONGnqWJPKtEBUGOOwxo=;
 b=NiBe+Onz0WidQKT8En8usTGePGyZggd0WMiitJzXhpicEqNJ477G0GdQWdqLRamC1H
 s4/dtlNu9+4Coseenwsbrv+HhEu/h781rFzf/feoM3LMzCYg49SH3UyYLr5qdyIZmAXD
 WQIZbFxj5xxogtRDyZ8B+9KK6yu+qUc2iu8zC244bE4GSAW2MI8WpbAAPKfJ6J1dAGim
 BH4I+VK42c/ScekcsDdY3QQT/MH91VnAXbb7TvtqBzaex2r/dYPOnZoXzaMkZlQT1bLq
 lRga/C1nozVl8ShK9LEcWwbSANBBuYNjoy6kB5yuRkVOWGBlt3aQexk0L2iFHoeV3fkd
 0log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=6dLjJ31T+Cxxsp5GGfF1L/TvONGnqWJPKtEBUGOOwxo=;
 b=jve+IZ4NNtGdrUjx1FzJLKvwNjx2luCjEJnTm3+mvkLEnQWWliCscl+U7/yFEjzVFa
 ZWB3XL9f7dg+WBgg5CvpRPeMoiyRzMrIek3ktl96JSPprWjqAEMrkcsgVfNzC21sW2OP
 D7m5eu3/+xBVN/ldYAapAF99DtuW/JV4r8v/LgOuA/Neu7etVHegBm/01JOK6OBH9ZL9
 pqucZ7Ew+FaLWD3aC4ABUJ38vx+MuNa7NDDboz9yFg4aqiB7wykI7DOU5Tu6mxpXEgTa
 RfVYhVEDk4dJh9hJo4BFHNA7aL7ZrHm8dB5unmPaG0r+l79mmhYwxw0YdtYvL2jBCphZ
 PhbA==
X-Gm-Message-State: APjAAAXVU867bqRoeVMEREUD4OJUW50ikOXJKJ9SID6584M3j8IEzp+4
 9SxnjP+OU5xRpBfzOnpGfhE=
X-Google-Smtp-Source: APXvYqzTuSRF43Zp5DicrIANSdbzWn9Ig2AVRXEAx5GWYL2rMHlToC+eerzGWIapfYfwQMwwgo0GcQ==
X-Received: by 2002:a63:2157:: with SMTP id s23mr22157702pgm.167.1565510841028; 
 Sun, 11 Aug 2019 01:07:21 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.20
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:20 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:46 -0700
Message-Id: <1565510821-3927-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 13/28] riscv: sifive_e: prci: Update the
 PRCI register block size
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

Currently the PRCI register block size is set to 0x8000, but in fact
0x1000 is enough, which is also what the manual says.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index c906f11..4cbce48 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -85,7 +85,7 @@ static void sifive_prci_init(Object *obj)
     SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
-                          TYPE_SIFIVE_E_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
index 7932fe7..81e506b 100644
--- a/include/hw/riscv/sifive_e_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -47,6 +47,8 @@ enum {
     SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
 };
 
+#define SIFIVE_E_PRCI_REG_SIZE  0x1000
+
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
 #define SIFIVE_E_PRCI(obj) \
-- 
2.7.4


