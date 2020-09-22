Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A5CC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA0E22262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 18:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSzCqkmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA0E22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmhQ-0000L6-F9
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 14:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOg-0007zh-CU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:39747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOY-0004L5-C5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id n14so13132241pff.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xl0njD+k9BHK11779kcuePFVTL4w0dzNFEMm1XknPiM=;
 b=oSzCqkmdKmOyCI86Cn5o33TjoGcj6s+D7UShBli05lgWxHh2Xs1mt+p4cmf2zEY6Og
 vDHGXC6viKd+ES+NL8vc0KEnlGV4/U7tEy/kvbB49xuK7NeboiLT13Rbl3numJAOAf7R
 pZIX+zZA5q6SfRt5l7pX3qRrgbsfSXrjdVgq6cbbuPJoTOBKOeydM4lNOynpwT6eTzax
 I2Z1GVcVt5jvYrOUQIYeLfHPvGgeraEiNtA63sWqrSPL3+thCRxgkn3eDnpIdUxojZae
 oJ3Zkk71vxWHKiFnOd3DTJDc5Tcu001W9N24Qfz1n4+T5yNkzvo3wXrhltHOQbGt8UEG
 Ebyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xl0njD+k9BHK11779kcuePFVTL4w0dzNFEMm1XknPiM=;
 b=sZcZPBHkyHWPE+m4Nn0nmsjPnryw6aGNMd9uNd1ha40Ts9Mt3QzROAVJAGcojlQfVV
 Kjw+Uam8VNA/C+06gUjzFqYnVS6eHgwxdLAWDwcB9JypC+WiVkVSbwwozatmGRcoEj1V
 At6XQwsK5TWKTO7tbuopF0ElYP3OeH1poJHdpQAfAQ0/WbsBn1BalbNb+Hz5UquEh9E0
 mElxklCLhS9JGaCWZ2H4SYJ0M02vjuK+TQGKMq8f5TToMmZGfxhy+9/SyAvK8BEfUFp7
 KPuPHdG9Bp7oE45fpREj6ke+Z+S5J+a8qc5WQYxYYIgqohxi/t/8O6/u7bescuJOA6dA
 oWoQ==
X-Gm-Message-State: AOAM532pGpdsNjuUBEllXHJJZOsMYlAXI1bso6/uCi406mbYefz2teDI
 3EvlnjX+bmifTOx17qduJiSapghVufhGmw==
X-Google-Smtp-Source: ABdhPJz8ktM9wqQeSaAWHaDg5sKxOY4h7ka27EP4hLl0BlZBtN14+s7XXhKO6PKEaKW0mMZBgG9U2A==
X-Received: by 2002:a65:5aca:: with SMTP id d10mr4447952pgt.362.1600796873585; 
 Tue, 22 Sep 2020 10:47:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] disas: Use qemu/bswap.h for bfd endian loads
Date: Tue, 22 Sep 2020 10:47:36 -0700
Message-Id: <20200922174741.475876-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the routines we have already instead of open-coding.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index 1f35a4a33b..8d1403dedc 100644
--- a/disas.c
+++ b/disas.c
@@ -80,61 +80,6 @@ static int symbol_at_address(bfd_vma addr, struct disassemble_info *info)
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


