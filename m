Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059C522DFA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arXxml7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059C522DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ez7-0003sZ-6e
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3eyR-0003S9-B5
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:26:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3eyP-0002yA-Kv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:26:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id r4so40835422wrx.9
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CE7vTZN+AndL4BTmKCQ7EENl2Y0h1Hx36qm6L0uk2NY=;
 b=arXxml7YMIgFlrz5KUg/o0GokHhH96Fpkqd4/QzOzg01dCtflo70k6wgfKkipMEUpq
 w55T/vpS4sJQJywMkdkZdG4G1nI0vnVrzAYROiQHkYiVRNcKD3Bg3QGMu8/60wEAEwDC
 TcGlTlfJ9I2SsyuCNwP4cRWkY7cTQmnJvBKqO/088U4L5GVO1MmZqZEXk3WKesJW67wv
 wf+V25+xH0N97PDCofXdvrCNWRvWVntQhZl8+KscfeKZQxPGWCuoq3EiEREgoV2IcBNR
 zGk1QnGGoKKC/S+z+ZenhtHMzUC79S00v29Vfw0drgAFIORY5FxKpoca5MkUupu81hl5
 d5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CE7vTZN+AndL4BTmKCQ7EENl2Y0h1Hx36qm6L0uk2NY=;
 b=npZxha2xxZV6BVCayBR3yQuIsWAyWWR0hB4PVWpFexHYvgl9Sh0Uxcfyntylde4kEM
 7AEKY7cuoEE3+i27fQB8G1iaPJ+O0/khyETrGeVi0s4tVbrHrYlpzfV4BCy4oMccULQA
 BYgLBlag6coAyYQWNLvSVzA7SVmgsLWt2KumohPrqlsSIOChYRN1mZ8dQZX7BV8oYgGe
 gUHyKJE5Qons4NmvYMFtO6EKWtUsUme2w2MHhyQ/NEzdnUKYrdRes2YCJGmIfJjJCuiE
 T9OIQ50aR3LnjAGr4P7mopkXqbfe6Ydb2rK4mLNVxQC5HNAetRyPclTHpuu8cCDYTZp0
 rA5w==
X-Gm-Message-State: AOAM533eAbL8EqCMvoyQq8YqVcDbvliglW2g+Bc8xavkfF+I2F3qcrIP
 2DEAo9Rodp8Pna4p1CtAtlilncjU
X-Google-Smtp-Source: ABdhPJxCfm65B9QymBuSYl0uWUhWv26VccEjbI0Zx7MFMpy9vC0qnImnJ8dukWA3Z5FXlCBzXTMDVQ==
X-Received: by 2002:adf:de91:: with SMTP id w17mr7186608wrl.108.1596716775331; 
 Thu, 06 Aug 2020 05:26:15 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m14sm6596426wrx.76.2020.08.06.05.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] target/mips: Report unimplemented cache() operations
Date: Thu,  6 Aug 2020 14:26:12 +0200
Message-Id: <20200806122612.17167-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only implement the Index[Store/Load]Tag from the 'cache' opcode.
Instead of ignoring the other cache operations, report them as
unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/op_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b280e0..7f87e57c8e 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1583,6 +1583,8 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
         /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
                                     MO_64, MEMTXATTRS_UNSPECIFIED);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "cache %u\n", op);
     }
 #endif
 }
-- 
2.21.3


