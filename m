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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53FC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E0B2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 05:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqTz2w1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E0B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hza5Z-0005J7-5G
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 01:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxn-0004to-LO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hzZxm-0007FP-L7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 01:12:15 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hzZxm-0007CS-FB; Mon, 19 Aug 2019 01:12:14 -0400
Received: by mail-pg1-x543.google.com with SMTP id n9so480194pgc.1;
 Sun, 18 Aug 2019 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=YwKWwAEUWn+++T233GQLbFIriKPAZujasE7N9OhOk8s=;
 b=iqqTz2w1h/Urz9Dgi1nhMblolWROLjOtq5c2cvVp+iPvTRjD3uYRGNJPKEXovQ9Pf/
 jHdFVQUZjbmF7F4ggLivvJkejskR1fIOKCeDS9LjEnz0RnCffePcPNpbrosH/M4setQk
 IG/DCi6ytLOLR2X5LVqsZv6jes+OU58HszvZ3YY1RAuyNeX8SRcvq4Zfyuh8afmeRLdb
 fOOZECrp28OpdgBD/8GoHj+R+JVkYi/7Gneiasms8YL9MrXnSngyqrxyumKW5oVN2AB9
 y73xJM2wYrUnTq3wPMLD55/66qzROItT3EDnSaA1u3wN3LcYXrSkWRiKgabInccwNECX
 GVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=YwKWwAEUWn+++T233GQLbFIriKPAZujasE7N9OhOk8s=;
 b=IdUHxlwmgmA+sDmC7j7HPmHyw4qK4hVztxWO4r137ET/rsMstecvd/TT5qDMhRa5/t
 Xc7anfKOmQPhsUdtVLUWOrflTw70gKJMAfo+C2HMzSGQo7IlIGrHo15zHr7grdkfJy6s
 sKQxbVk6PCyLO0lo7LuXMdBo4hp5OsB2uqeAsgbC/IFw5ZW3xaDVK/JmJIeNFmuYgE9L
 yiFG+UAOx5Ov5JRhFXPzXxj1RE8NpiIlHw1I3Fl6kOJ6OJbjKRgtSSQpkTsKt0iu3l48
 vIcOVF/VqAS+8psWS66E3KxGOsfnq3VHWQiogaKjaaOEPoxEZL994bK7l9Ohw8altCGz
 wJKg==
X-Gm-Message-State: APjAAAUgUY6Zv+4LO8/uhs+PIoW8XYDNSnPcw2+N5kEp8gKJmLDiLQwp
 zbTeVcvhJtg4P7DCy4zN0xU=
X-Google-Smtp-Source: APXvYqyCj1uBbDWYq3/N3x138H841wzvCm8mPKkEDoB38uWgWFeJDb7kRyPWvtDXsauZIbehDoI/tA==
X-Received: by 2002:a17:90a:1d0:: with SMTP id
 16mr18502887pjd.98.1566191533724; 
 Sun, 18 Aug 2019 22:12:13 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id q13sm15464986pfl.124.2019.08.18.22.12.12
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 18 Aug 2019 22:12:13 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 18 Aug 2019 22:11:39 -0700
Message-Id: <1566191521-7820-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 06/28] riscv: sifive_u: Remove the
 unnecessary include of prci header
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

sifive_u machine does not use PRCI as of today. Remove the prci
header inclusion.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e22803b..3f58f61 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -39,7 +39,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.7.4


