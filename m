Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCEC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC803206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ/PILdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC803206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37471 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Qn-0005bh-JC
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DU-00069f-T5
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-0008R4-Rc
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:16 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:44675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-0008PW-NQ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:14 -0400
Received: by mail-yb1-xb44.google.com with SMTP id y21so391113ybi.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hfIo3JgpILVtL9GqBEDfiaysShRSn0Njr8MBfKy2z7w=;
 b=gQ/PILdy4WOD/YPAieUzLawGhkZR1vtSlT4smA3HFjM+mqLOoUO3ocICp2ToyI0Hk9
 19hphV4eoxKtIPyW1Sgj8qDnlCGdOCkmUATumtMKgkYF/MwhWc/9uKeeFiJKjS+AS6hf
 aRShwduWLiRRsk0f5S9PsYJwO6gO9awYSzZSyB3iYxzfeVGy8EkYwBRlFdYf6P8TCi4V
 sIgjM/kmwulzurJV4G1Hy4ANsZIa30ffhEB/bipH556gJA4lu9/VCYYxTggl88Hjti4X
 Hs6d+G5kzYMSQzn+8+065+QgouHKUNL2m1XOo4NMJQDhgvUlqp+rSOUtLv9h72k+1PPv
 9brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hfIo3JgpILVtL9GqBEDfiaysShRSn0Njr8MBfKy2z7w=;
 b=IUY3qpzgYGxLEyqVAFhVzgnYubVi2IsDsGZmilaewb+Xou5sebS0ceoeFkUQkiv17+
 8rEErlCHCTNVM+eYcWiPZ8CPDd1d8S0iRNJwPQAMWJ27ZOj/G3ULFltCQXTgBMyowXd7
 u6qExEhUwds+5FLWiwip24QtB1B46ymNVCBys9E1w84C+VVrnCFgbLQGxs7cRjkNUkeI
 hUvC0e/f7JSbrvAp4CDQB0KuOFhALVIJVtdJka+h2Rs6NDkDjcur+7wKWPwabZ0DSUWo
 BbAQkxQ9f2qjd9eDYkQ78g/HMqf7jo4spZL4UYd7eg3o3DCpnX9YQDkqyQsxWkaPydAr
 7U8Q==
X-Gm-Message-State: APjAAAXzXUgmzUF48u1bCEPM7v/fZqZn68cRkzeElFAkAjE7Ea56mz/Q
 lql/eoMAw8JgM+VRyJjtW+gt97Wx
X-Google-Smtp-Source: APXvYqx03VZyp5nFdegY7i3oV+8OGVu/Pb7M8dRb7xTm3BgB0nzeG/LBo4yqoG2lETntduMm8DSMKQ==
X-Received: by 2002:a25:5e55:: with SMTP id s82mr1914416ybb.343.1565835013106; 
 Wed, 14 Aug 2019 19:10:13 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:12 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:02 -0400
Message-Id: <20190815020928.9679-21-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v3 20/46] target/i386: introduce tcg_temp
 operands
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG temporary operands allocate a 32-bit or 64-bit TCG temporary, and
later automatically free it.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 99f46be34e..7fc5149d29 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4696,6 +4696,50 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
         insnop_finalize(opTarg)(&ctxt->arg, env, s, modrm, is_write, arg); \
     }
 
+/*
+ * tcg_temp_i32
+ *
+ * Operand which allocates a 32-bit TCG temporary and frees it
+ * automatically after use.
+ */
+typedef TCGv_i32 insnop_arg_t(tcg_temp_i32);
+typedef struct {} insnop_ctxt_t(tcg_temp_i32);
+
+INSNOP_INIT(tcg_temp_i32)
+{
+    return 0;
+}
+INSNOP_PREPARE(tcg_temp_i32)
+{
+    return tcg_temp_new_i32();
+}
+INSNOP_FINALIZE(tcg_temp_i32)
+{
+    tcg_temp_free_i32(arg);
+}
+
+/*
+ * tcg_temp_i64
+ *
+ * Operand which allocates a 64-bit TCG temporary and frees it
+ * automatically after use.
+ */
+typedef TCGv_i64 insnop_arg_t(tcg_temp_i64);
+typedef struct {} insnop_ctxt_t(tcg_temp_i64);
+
+INSNOP_INIT(tcg_temp_i64)
+{
+    return 0;
+}
+INSNOP_PREPARE(tcg_temp_i64)
+{
+    return tcg_temp_new_i64();
+}
+INSNOP_FINALIZE(tcg_temp_i64)
+{
+    tcg_temp_free_i64(arg);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


