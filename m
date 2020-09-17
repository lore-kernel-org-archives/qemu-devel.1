Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83032C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1956320789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uG+j9eba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3qU-0000Qs-5q
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mN-0003li-OW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mL-0006eV-VC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id n14so2252868pff.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kjSlGDaz/gKdqZUsB3eBl8fd3FyvHs6q0rMsilYCIuA=;
 b=uG+j9ebaGVqMlWfPMwT/68dawIqiIiGUB+ERUgi86sesnpmmGo8xnWTzWVJe4dBboG
 J1G7pbaCg+c8Opm9x0WkUkMYBjucs4ktez7L/XtQg4VCZnzyaGTLkWXGGhLm/D+PtQEa
 oFIXPblM+dednCrgGLMF9ZatPdaupiLCQjSgDrmGyIXeWO9hNXwI6KbZK58/zg46ZPRf
 uV26wBzrRDnm7ODSU3Ed0TeI3N9ijm1VvZkzRzWD8qcoRTy+eaRHfhCyd6/6AAhk6yD4
 0zpkxXlJvGfsOgmRLBRhAjX37DVIosM43azM3d+JqY1gBgTNYTNP9GLLbvOfkY2isNIQ
 ws7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjSlGDaz/gKdqZUsB3eBl8fd3FyvHs6q0rMsilYCIuA=;
 b=GrVgWBTJYyDerijxXGR6fIahSNRK/iRRR04YSuWu9C82lyTsf7US9OdPwzoM871j0K
 zNg8qsEcUiQKOcoIlwC9zx9Y0HAa8Y1fsn1KOEWZlfule2TrZkhOzd9mCbVQ1lHWoH6f
 stve5eAqfmhzakLKu9dTT33tc9o/lCUQWOid6z0iC0KU5FjmHDXeF2fCZiXl8XjkMyQu
 g/AsDCZHSSSlDAVDDk4uy18e3AGVZMwLOqiBaZo9spRWjsYCEYUGEw1lafoaJW8sTnZS
 jkNARn+VMmJ5j/C3OSiT0eOp1JAlGXn1+d+UfKyads1/wjN/O+39gJqTTP12A1gYnzM1
 Nz0A==
X-Gm-Message-State: AOAM531muz51qzKi3StxL3JqMAmdu4+W7awWwJiImtlZ/6BP0yvj/xT/
 SuH8bMTQPLR7J6eggJxUKmAAucgMwEu/CQ==
X-Google-Smtp-Source: ABdhPJwVuMJVl0M0z68cph5gwoBFTtm01irYEYWcznLzZ8zG+hMkAGEenSwJ1qicZUcGkuH9cebiyw==
X-Received: by 2002:a63:6fc6:: with SMTP id
 k189mr23895970pgc.165.1600387048333; 
 Thu, 17 Sep 2020 16:57:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/10] disas: Use qemu/bswap.h for bfd endian loads
Date: Thu, 17 Sep 2020 16:57:15 -0700
Message-Id: <20200917235720.2685978-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
index dda247eaf2..6b45aa9898 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -466,11 +466,33 @@ int print_insn_rx(bfd_vma, disassemble_info *);
 
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


