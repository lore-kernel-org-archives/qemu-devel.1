Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC2120770
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyNzmMNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC2120770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxaA-0000UA-2d
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUO-00013G-9F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:36346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUK-0006ap-Ql
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id k13so291536plk.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qtxl/BXbvXweTMsYpGrM9mtyoo8FEzJG3RdxXTc8HzE=;
 b=tyNzmMNJG690Ppb4evlI1Zw2lCXeqLRnrgL03rQOHUuhJ7bAEzghrhQw9Wcpap+QyF
 ITh8yuCzNXvBTmtbZ/xQBGzDIgXBPAO2/cuNaZQTA4YEtp/yvTmx0+dCjN1HBqK83b3X
 /pS8Kkpp1POwZFT2MrwUG2lDDoTqRfG2LTpoFtdVA7raFtieMWbDzouv+1jhkRiz0uFJ
 XewC4btjTnkuasAcmdfhdrwtkbqaguV0bWEW5iBe2h5p1tORQkTWuMUIrTcKk0HvCl6y
 KPZ4l2wTq0AG642aIUlgBwq0rQrbsx/Wu0xE1D5UPIB7JHe2RbIU7eOIny3iN+dUkJg/
 056g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qtxl/BXbvXweTMsYpGrM9mtyoo8FEzJG3RdxXTc8HzE=;
 b=EJZ+D4bWGHxIDwbvAGG/VL/RbAPgr0rgXVPtGF9WfgltizR7AiexCYclIHLw/qGG2I
 bYqoAqJm0b/XLE0y/IQGGSXbaFyK4SnOji0kncbvze4DJo6OepUFTWogyontgsN/Ca95
 KN5jquJQ7JeK6z+2Yz799ZEk2JfstXmCZbXwwLfZ8UhhZzwJ+bnBfJlazy8uQ4MeqOC9
 IPulJMr1lojfT9SuGQ045KjSlqYm4BKFHTfqMfKpQ+JU8+xvCl0//S33+WdogfVCk74S
 32aWzuV7JLzAOy2rv7WrX3QzBe9QQOxGJt6G936oqvCg9lIDPkxQfhSN8QWJ9VKW2PgB
 MRhQ==
X-Gm-Message-State: AOAM53292Wfj2kefGpXcVv6PEYzsL6PgZMpUgvLRKEtrq/Bp/telgU8Z
 CLoe9x0j2qyTTxKPPCoXpboU2LoO6IDq+g==
X-Google-Smtp-Source: ABdhPJwm6kmFPgWfbGYB4JRfdE89pqncRZZfnEKy1IfvojlVwYUyLJkM2R4huVRmHMfZ8Pz4adht4w==
X-Received: by 2002:a17:90a:ee4f:: with SMTP id
 bu15mr1389940pjb.16.1600124539109; 
 Mon, 14 Sep 2020 16:02:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] disas: Use qemu/bswap.h for bfd endian loads
Date: Mon, 14 Sep 2020 16:02:05 -0700
Message-Id: <20200914230210.2185860-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914230210.2185860-1-richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the routines we have already instead of open-coding.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/dis-asm.h | 32 ++++++++++++++++++++----
 disas.c                 | 55 -----------------------------------------
 2 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index d2418c977e..8a216ac495 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -468,11 +468,33 @@ int print_insn_rx(bfd_vma, disassemble_info *);
 
 /* from libbfd */
 
-bfd_vma bfd_getl64 (const bfd_byte *addr);
-bfd_vma bfd_getl32 (const bfd_byte *addr);
-bfd_vma bfd_getb32 (const bfd_byte *addr);
-bfd_vma bfd_getl16 (const bfd_byte *addr);
-bfd_vma bfd_getb16 (const bfd_byte *addr);
+#include "qemu/bswap.h"
+
+static inline bfd_vma bfd_getl64(const bfd_byte *addr)
+{
+    return ldq_le_p(addr);
+}
+
+static inline bfd_vma bfd_getl32(const bfd_byte *addr)
+{
+    return (uint32_t)ldl_le_p(addr);
+}
+
+static inline bfd_vma bfd_getl16(const bfd_byte *addr)
+{
+    return lduw_le_p(addr);
+}
+
+static inline bfd_vma bfd_getb32(const bfd_byte *addr)
+{
+    return (uint32_t)ldl_be_p(addr);
+}
+
+static inline bfd_vma bfd_getb16(const bfd_byte *addr)
+{
+    return lduw_be_p(addr);
+}
+
 typedef bool bfd_boolean;
 
 #endif /* DISAS_DIS_ASM_H */
diff --git a/disas.c b/disas.c
index 7bc8e9a037..bf19b1b0bf 100644
--- a/disas.c
+++ b/disas.c
@@ -78,61 +78,6 @@ static int symbol_at_address(bfd_vma addr, struct disassemble_info *info)
     return 1;
 }
 
-bfd_vma bfd_getl64 (const bfd_byte *addr)
-{
-  unsigned long long v;
-
-  v = (unsigned long long) addr[0];
-  v |= (unsigned long long) addr[1] << 8;
-  v |= (unsigned long long) addr[2] << 16;
-  v |= (unsigned long long) addr[3] << 24;
-  v |= (unsigned long long) addr[4] << 32;
-  v |= (unsigned long long) addr[5] << 40;
-  v |= (unsigned long long) addr[6] << 48;
-  v |= (unsigned long long) addr[7] << 56;
-  return (bfd_vma) v;
-}
-
-bfd_vma bfd_getl32 (const bfd_byte *addr)
-{
-  unsigned long v;
-
-  v = (unsigned long) addr[0];
-  v |= (unsigned long) addr[1] << 8;
-  v |= (unsigned long) addr[2] << 16;
-  v |= (unsigned long) addr[3] << 24;
-  return (bfd_vma) v;
-}
-
-bfd_vma bfd_getb32 (const bfd_byte *addr)
-{
-  unsigned long v;
-
-  v = (unsigned long) addr[0] << 24;
-  v |= (unsigned long) addr[1] << 16;
-  v |= (unsigned long) addr[2] << 8;
-  v |= (unsigned long) addr[3];
-  return (bfd_vma) v;
-}
-
-bfd_vma bfd_getl16 (const bfd_byte *addr)
-{
-  unsigned long v;
-
-  v = (unsigned long) addr[0];
-  v |= (unsigned long) addr[1] << 8;
-  return (bfd_vma) v;
-}
-
-bfd_vma bfd_getb16 (const bfd_byte *addr)
-{
-  unsigned long v;
-
-  v = (unsigned long) addr[0] << 24;
-  v |= (unsigned long) addr[1] << 16;
-  return (bfd_vma) v;
-}
-
 static int print_insn_objdump(bfd_vma pc, disassemble_info *info,
                               const char *prefix)
 {
-- 
2.25.1


