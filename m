Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219D8207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtcdC/QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219D8207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HCq-0004Zq-LM
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyS-0004G4-M5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyR-0004EH-97
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyR-0004DB-1r; Fri, 06 Sep 2019 12:20:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id bd8so3377228plb.6;
 Fri, 06 Sep 2019 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=kUo9T1wmMWdWJ3ji77+EmKdfGWCSzhrxWRCVGGBX7Sk=;
 b=KtcdC/QVaYTILvP56z2zJeulC/xJHz6PO6AEDL4KXq9txi6Rdahlo95DbrzQr1E72v
 6pm/AeCv3U4KLyYVTaJkko2JEkqAstxPrxA6jaZ80g1zpMT8G6vQLCcSpPyjbAHKUcJr
 LLkNUXykbj0IBMqXg/xF+jVCx7e2HHOv1CSgxX9Sj/Hwd5MC2GyjIv5fHkW+0KYmmTtr
 g3WJ82caQJE5l/1iEDKz5t/8kiWAPEKCzopJmgGpsEfbMLN1YNj3a7/PvfTaUUP8yOp8
 YaK4lrM9lYfQv6fZ9zaS5JW4znEwSCCbfLYIGp+a77Xhp0cc2NtYxhCi/9NM98znLl78
 A28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=kUo9T1wmMWdWJ3ji77+EmKdfGWCSzhrxWRCVGGBX7Sk=;
 b=UX42ZbK9pgfNMANI8PoCwdAYq19yrmL/d1kIq72kAEjqeRdQ0oP50GAkGq8K1dxB4j
 BntjS7awTX6DjUugjj4m9CbmigbJzLAqTLDX+Pgl+OYhzxdL15Uus7RwqK+iEHhwjS6u
 FIgiTwVMveIW4DYVG+tTZzpT75rD1jpI5mk8eGd+nRLOlX6la3UlziL+fx7OCO15+pYj
 zTzf+pseUiTpsavnjzsuRR3EStMpB8PHoMbxfjs0SkzHdE0p+6qxWP3My4yw6DUCsUYl
 Oelnx326c1x2ji0970vtrUGx79INZ1DkitUsqJOrhMzL38Hh4Fs9OWNeHEQu/BvejFMh
 xf+Q==
X-Gm-Message-State: APjAAAXo3Hc1Rx1osU9dVS2CxP8milkHU7dMCM2aTLqExa/Nbcjpr0lO
 ty5QNgcfQylo8+z8V6hVskg=
X-Google-Smtp-Source: APXvYqwS9zTYmY9Y1oW0USGevZw4ysKM13ER4d3v7zE9lnoauYlX8xV8LFa3jlLmAhyG1VZwOuSizQ==
X-Received: by 2002:a17:902:e493:: with SMTP id
 cj19mr9990034plb.292.1567786834205; 
 Fri, 06 Sep 2019 09:20:34 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:55 -0700
Message-Id: <1567786819-22142-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v8 08/32] riscv: hw: Remove the unnecessary
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

Changes in v8: None
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
index 982fbb2..c413f0c 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_prci.h"
 
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index aa544e7..339195c 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
 
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 215990b..a403ae9 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -22,7 +22,6 @@
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "target/riscv/cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/riscv/sifive_uart.h"
-- 
2.7.4


