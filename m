Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D7BC4361C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285B42193E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxHMu+H4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285B42193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKPx9-0000J7-1i
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPoq-00089b-O9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPom-0000If-GP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:40 -0400
Received: by mail-pg1-x543.google.com with SMTP id k14so9661101pgi.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kjSlGDaz/gKdqZUsB3eBl8fd3FyvHs6q0rMsilYCIuA=;
 b=vxHMu+H40KDYMN3/MTzuVX8DAb9y9T87S5rN2r+jnp4MDeQcPY07lzvgveqVlPswTW
 A0y/Tk03gWaPGd/8wa9zZihSjQkLWtgFYHWESTFJ2wD8IBQ3mUqvQVX1f+de/FVpPuBI
 YNCXKEgYUYdTwEOa2siSUs+KpWFzJ28MueTSWFWNoKErCNWKlVrrYkCmAV7/sNl1kg/Y
 4xLOeNco6zLRKDuR6NABHJrlxbUSyHKvGBxFAM98Vai6KnN+/LaGlY8hmdPF4sHwzVu8
 zGrY3JatDbbGaCI/3eH27FxKi9UAY+SMtZiSj/p1fJT7PtjKnSBF62nVmwZqfCUQlxtD
 0wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjSlGDaz/gKdqZUsB3eBl8fd3FyvHs6q0rMsilYCIuA=;
 b=XM2h7bpSFHP6WpH93nYR+zss+vk2XEiSkQ2oX+GOtdEabBL9CdE9Ghnl1wZxLWVUwX
 CpaPLFx2coG4633tDL3xlDZKnTQC1/eS3jOdW21WKThXzgyk13sFYQtLx9xrLEPomsCm
 2wqcZKqDEFXuInXPPqCO3XhjrVRCaGhMDCVF9/DXqzKyGRY9KdwIs0P7l9J9rRE8JNB4
 qNVt4Ezlpx/aApN2zON9YCN5RdNiLITqLL7X6m+lOHYMJOuDxHfyTzGQxaabbh3DA+d1
 W2YbdtWXt+xm3naZRQFY24uB1EsIAUnecr0aqea8ogRfnvvFUDZO0Tg3AAMHXrRAXVq1
 QN5w==
X-Gm-Message-State: AOAM531y2HBuLH/+Ced3O6pWjNFSl6+TfmenjT0uFByPEZWCM1nTS4wI
 VExrYdQiG+X5+7TICHHF+kBQNk/lxN+n8g==
X-Google-Smtp-Source: ABdhPJwOR8qUzoCfgkxtONRpWoLgHkydQtTrffsHF02IAwgerVzpa6+0acU1om5u+51g6bhK5J4FGQ==
X-Received: by 2002:a62:1b4e:0:b029:13e:d13d:a135 with SMTP id
 b75-20020a621b4e0000b029013ed13da135mr829180pfb.29.1600710089601; 
 Mon, 21 Sep 2020 10:41:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/11] disas: Use qemu/bswap.h for bfd endian loads
Date: Mon, 21 Sep 2020 10:41:13 -0700
Message-Id: <20200921174118.39352-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: alex.bennee@linaro.org,
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


