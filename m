Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68756C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9122074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH0xqORb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9122074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0FX-00072Z-Ea
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jw0EM-0006Cq-DP; Thu, 16 Jul 2020 05:31:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jw0EJ-0002E6-GL; Thu, 16 Jul 2020 05:31:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id l6so3607847plt.7;
 Thu, 16 Jul 2020 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=azQTDxp2AGf8ggOnGFH5tfIaZzBBmvEsmTO3HYeMlyw=;
 b=FH0xqORbIFeDxJquDOwAJ4cFlqN+xbPqN0xKj9MwpEUmuTsxPdnJEiDRZsTlG/4qXL
 Hx7DwqRn16WAwnKxAnfJ2iuou6Va2mHhBXKth/oozzJjcMRvzBVofcW3zVmS98WyRt9f
 UGkt5niea+o6WXCkLD5OvEXJxe/sYM3KqCw1J8RR3JACZ1CisVNvea8Phagh7cyEjs9U
 ci+woNoNGeWzwJ/80sdH9BOHmHASPZLMUPn01ppOE3hLpGZvrQkBZgNma4PwR3g9rxHh
 aUfywXB/UQzWYnj/i9tILwWGZg62S7YZ297gkvQicPcFhP5PMc+AIVdExkBEh1cKDixV
 tv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=azQTDxp2AGf8ggOnGFH5tfIaZzBBmvEsmTO3HYeMlyw=;
 b=W/hxp8zsgIAS1Uyq8POfh4zT7uFJGr25sp7i1UohZlTMf+73xAS1FDVsqLhmGm5w/U
 JPQXA5m1tcRTsd6oyaITzOk5fh8IZuYR0cWF+La9MUWdKI1b+PXpo3VoiJR4TM0JqzsM
 u2jUUSWvqe8+6SV+OkJ2j042B8vm+5TVe6bGFOvL+FQNRecdM5v/Uhl3llmeSSSPcJNt
 oCz3e/KS+jJ+b5rjdRfOcAlEPHibaeDYaRYpV2jy0+/24Q7Miw/uVI/B790FMOuVCg31
 GPeR7l5z0F5L67Ce7K26lKDqt80aOvbI8as/tyAY8t44geRXcd7pQFWpDqcr3Kmdxogf
 GCEw==
X-Gm-Message-State: AOAM531XzTIQ1wq0oE0vvxfXgVL1KQaVSlFjJ5oq1X8K02nxKxwO95Jk
 v7Kv9Yoaq5TfEOdhIgnDG4E=
X-Google-Smtp-Source: ABdhPJwN5Cp6Ync9czEfj+JUsdJ+BvtBwamhKivh8zR5OXKqmVYzuzmdytukyRbVyBWOFISHijVzQg==
X-Received: by 2002:a17:90b:30d0:: with SMTP id
 hi16mr4079961pjb.65.1594891861524; 
 Thu, 16 Jul 2020 02:31:01 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id o11sm4120459pfp.88.2020.07.16.02.31.00
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 16 Jul 2020 02:31:01 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] hw/riscv: sifive_e: Correct debug block size
Date: Thu, 16 Jul 2020 02:30:56 -0700
Message-Id: <1594891856-15474-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the debug region size is set to 0x100, but according to
FE310-G000 and FE310-G002 manuals:

  FE310-G000: 0x100 - 0xFFF
  FE310-G002: 0x0   - 0xFFF

Change the size to 0x1000 that applies to both.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7bb97b4..c8b0604 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -54,7 +54,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_e_memmap[] = {
-    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
+    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
     [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
     [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
     [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
-- 
2.7.4


