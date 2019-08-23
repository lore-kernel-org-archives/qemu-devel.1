Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8564EC3A5A3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EAC22CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWZcOUTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EAC22CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i123B-0007zb-4O
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rB-0003wA-4s
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rA-0002U1-1x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:25 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11r9-0002TQ-Ri; Fri, 23 Aug 2019 01:11:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3so5072635pgb.10;
 Thu, 22 Aug 2019 22:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=opzuml6fqRIWQBbdwqjXZPFwmr327XnVlwROZQz1Lm4=;
 b=AWZcOUTHtJ2cTxAeRhKKURE8J8lBx/WrBOsx54KuRZljj8I4cJidljOncRQV/DCMa1
 zvNc1ez7v7qWnmr/ojK6L0iEMHjsN/lyYH0GL4QzdFOAi/xmxRuKb/MtVomCIoQ/R3ev
 ActCjmVTvcpXbzjQ722sBF5gn5Tdxqik8TbiDjK+gD/A1dgCh9Fza/GEqsLeoyiIps1X
 Tl5dr4RuIDT6TE2eolSHw24KPpH+V8zklZELNOCMidV7T/qHJ6Lt/58otBEk5TLgyEV4
 FNjdrf8ofjdVsVbEEi3gPh8VXtFIAUsAMZHvi2FMgvS++3ImHE7u3J+RfOCj6Xa/yipq
 006w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=opzuml6fqRIWQBbdwqjXZPFwmr327XnVlwROZQz1Lm4=;
 b=Rdle18r8eB194Ty4bdFPHrs4SAzxuIcy0xaC69EEd2EAiWHceABCDaf39ZuTOWvud4
 4ZbuuxMidbdujMcP4NoyDxgnKVJWjFhsjrFXnVYnGCQ0QZr5S9LmVzuQBJeGHqD/+bsc
 WDY+AbSmqJoRE9q9Z9UHOYL8GNSrsMa/BMqPWatGrQzXo2DhhliQ4uQrymfCg8ql63b6
 MLU04o1oKKVPN8UZ8v1xp2TiritzNXCOvT7NitjSX9dg1hsBfU5FJRqsQXTHgd+9Tc75
 ejebm/4m2qthGxksV5MjuJ4VFneZbKV3xzzEt12r3xXZS3yKi+U994sLI1Mw3GBki2YI
 WY6Q==
X-Gm-Message-State: APjAAAVjux23CAHFnHzHn4hMQP6UooLj+swM5RrhAwS+CHKGLuz8BEzg
 lDCbA7sXTVxd06kZNsgBDYQ=
X-Google-Smtp-Source: APXvYqx3WH6SrbM+zOtPPaNWEVG8pLrVZ2HnCuAo9knL5yL+3Kv3d9zh6u7qmmBvrsUnqIf60GKQvQ==
X-Received: by 2002:aa7:8d98:: with SMTP id i24mr3097113pfr.199.1566537083061; 
 Thu, 22 Aug 2019 22:11:23 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.21
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:22 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:45 -0700
Message-Id: <1566537069-22741-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 06/30] riscv: hw: Remove the unnecessary
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

---

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


