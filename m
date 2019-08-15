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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5CC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91893206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2fUmJwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91893206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5cR-0003J6-GC
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0006HR-2e
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DZ-0000Ap-Qp
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:24 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:44674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DX-00007R-GA
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y21so391166ybi.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aKh00eIYWVxWWAJICSDb8BanWXW1Kn9B7TLnmofwb5c=;
 b=q2fUmJwNjUpaliFpK8lcfZLH12AcNUbzif4r87i+zSir4+vjhDG/PLnxBDX3xcDOdm
 fkeAx9kiJQuemHTBP2OJ/9rHHoAovK8Np8y3Ll/Izoc4xRI8WEf3oBiyFmxkkaix3Aed
 fAzx0l9PlCk2CGUUk1gKTDnBmT6/oGuoz9XBqgkCQ9Bzf8biHivjwz0xrELqEoNT/EZH
 9xF+n3COX56CTU6yWTW4OMjY0zmTrAMCuIbn8odW8H+rD1HqR5Tzn3AM1pIt1e6RBqlq
 ogkq+zJoVIfGKxkamZtjZ9yQUx+1s53TTXaG+MieOJI9aQYuRbVh0lj03dVIhWW4MGst
 ea+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aKh00eIYWVxWWAJICSDb8BanWXW1Kn9B7TLnmofwb5c=;
 b=mi2mAzUtYFyS+BObtPu8GoEhF28fsQzYcIISbpfxtIAWNFR/Y1wtPul9vtEtjemIrl
 95yem7BW3EUTJp+1sT35R+WIwH9ujdfseul70VKT//XV8Pc2WESY1dtk6L4jbyLl7Kqw
 Erzu28l95EJlQMnmBT880fIniKfFGI4fry0jBRI4KRiXQaXaTE7MiMVGKQLH44aWVXc1
 7Jcu34Rx2MVJgcW++wDr6WMSetSPIH1qh5JMR3olIurshXK1CcXQ4s6xpenV59AbN2fN
 orWIiuApqK+Lx8jg0N3RUZiPnCA5HF11fbgByqMMdMP3Q4JN8C0sgpRAhUKMDCXgQ/N0
 EzJQ==
X-Gm-Message-State: APjAAAX2cQWk/x+gkVOgQ8KidN5buM1p+kFBFVz3e8BT1Y0SvlJpfXn9
 Lc8Str4szDtE49F2+Rj9VQvL+L8U
X-Google-Smtp-Source: APXvYqzwWq0lOwyan/eYFONhaCl7piG4dHNpyssB1gNr0BXEjBG/flhXi57d3M+mZYlMlChgi3vqbQ==
X-Received: by 2002:a25:340c:: with SMTP id b12mr2062929yba.190.1565835018739; 
 Wed, 14 Aug 2019 19:10:18 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:08 -0400
Message-Id: <20190815020928.9679-27-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 26/46] target/i386: introduce M*
 (memptr) operands
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

The memory-pointer operand decodes the indirect form of ModR/M byte,
loads the effective address into a register and passes that register
as the operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 78e8f7a212..2374876b38 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4897,6 +4897,42 @@ INSNOP_FINALIZE(Ib)
 {
 }
 
+/*
+ * Memory-pointer operand
+ */
+typedef TCGv insnop_arg_t(M);
+typedef struct {} insnop_ctxt_t(M);
+
+INSNOP_INIT(M)
+{
+    int ret;
+    insnop_ctxt_t(modrm_mod) modctxt;
+
+    ret = insnop_init(modrm_mod)(&modctxt, env, s, modrm, is_write);
+    if (!ret) {
+        const int mod =
+            insnop_prepare(modrm_mod)(&modctxt, env, s, modrm, is_write);
+        ret = !(mod != 3);
+        insnop_finalize(modrm_mod)(&modctxt, env, s, modrm, is_write, mod);
+    }
+    return ret;
+}
+INSNOP_PREPARE(M)
+{
+    gen_lea_modrm(env, s, modrm);
+    return s->A0;
+}
+INSNOP_FINALIZE(M)
+{
+}
+
+DEF_INSNOP_ALIAS(Mb, M)
+DEF_INSNOP_ALIAS(Mw, M)
+DEF_INSNOP_ALIAS(Md, M)
+DEF_INSNOP_ALIAS(Mq, M)
+DEF_INSNOP_ALIAS(Mdq, M)
+DEF_INSNOP_ALIAS(Mqq, M)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


