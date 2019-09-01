Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB6E21874
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoHbxu4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB6E21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GCy-0003cM-5C
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzb-0007ZM-7x
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fza-0006Gl-40
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:27 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4FzZ-0006Fa-U7; Sat, 31 Aug 2019 22:53:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id w26so6902881pfq.12;
 Sat, 31 Aug 2019 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=Hn68U2K6KP93bDFVlK3cFjeBSh27MtQi2nLu5yWHiWY=;
 b=EoHbxu4WEyJNw3V3fG+2EFKBL85klcbwKleG4oq566MFb6pW3I9bB3YKLuZo/mnBHQ
 aHMkkJEcuiJyPgfDw4d2MAVAqPJNSTiTCukJ6j/JwI+VW+9FK+Ab0RZ1qQYP5v7M4gCN
 pUYgXxF+gBDUMlZWy9veBsCoQFdDwjkgMyLI7UWRAU4C2zxAlXyNgepCCPNlIRF9Ge1j
 AToGTHFnKvmwvySUKwD+LBV1JT/3USCBbx3PW90FdYDkNOdn5bnNZMTLG30Se/iLed9j
 7Ghc93s6C12n/TTyIHUNM8GVSQXFDPVWAIj9vZgWF/+TYCIyMk4RVsNBKvA4qV9Y8S1M
 3xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=Hn68U2K6KP93bDFVlK3cFjeBSh27MtQi2nLu5yWHiWY=;
 b=WEy8BWz7MMeXISJGkzsOYw2tKVWj5GGamB5VX/qjkyv3+dDRPHt2bMhNa7UcTWoGBF
 0B3Igg/zaTFTxIflfADxfO/G8DszXMDMwPf8n9V8iM7Hkfew9qEm9yu7e2ZP6lnoRyfX
 vXdAWhWUhcXtOcfq9ZxrIlnJ31ZVP89iQn7tiUAfayQh2PvRw5Ypk18uUfd5JhCOSkza
 15L5inN6h+ru4Y+5mCQN8AxQFSn5+ewZnLDiBVC8RFSgE3QhQGWx60gV4DrzP2mRWNGk
 4wCZQl4190JexGxUPc50OAzextm2C/oCnuPFojDaeflfIvkrvri2nGe9WX962fGw1z4g
 2ioA==
X-Gm-Message-State: APjAAAV1UrY7QQg8D1QNaEWpmz5DFnKDDfejoHj2Cb2xcPMEncwP5GdY
 jnay47Va7uwTgkvFOqLGMfM=
X-Google-Smtp-Source: APXvYqwFOrjLE4OFFCdyCPZ5Ytlm8FNBrQvlkUCzsUTFh3p09UJDmI9LPRjdr5FTfTyPJl62CwzgsQ==
X-Received: by 2002:a62:3644:: with SMTP id d65mr27499830pfa.128.1567306405196; 
 Sat, 31 Aug 2019 19:53:25 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.24
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:47 -0700
Message-Id: <1567306391-2682-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 06/30] riscv: hw: Remove the unnecessary
 include of target/riscv/cpu.h
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

The inclusion of "target/riscv/cpu.h" is unnecessary in various
sifive model drivers.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5:
- new patch to remove the unnecessary include of target/riscv/cpu.h

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_prci.c | 1 -
 hw/riscv/sifive_test.c | 1 -
 hw/riscv/sifive_uart.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 1ab98d4..1957dcd 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_prci.h"
 
 static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 655a3d7..31cad9f 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
-#include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_test.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index cd74043..1601bd9 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_uart.h"
 
 /*
-- 
2.7.4


