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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C91C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A64206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvrtecTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A64206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5WR-0004NA-Q3
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DX-0006Bd-Bn
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DV-0008Vm-9C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DV-0008U1-57
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:17 -0400
Received: by mail-yw1-xc43.google.com with SMTP id u141so299548ywe.4
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tLijPMcyDKCXtSPHRwSPvNlWAMP/Ey57t/uYlG4MOwo=;
 b=dvrtecTta0z8RAk/Zg8eJJ8ifb2gIy8mYuCupOf2gyGCIaoJ0awt5m+IfRJvXNWkgF
 8kiSHid+ZOJp8yZJQh3iLivoFllWx4c4EyTGqmSru6Ek7ie8ZOav8EOh0WuMsirSm96P
 oW7L6JFi8shDoMceVNmG+PXVa1rhuBducKzmpzfWCrY05dyzaSHWzJ+y3gman1PHb9w6
 5YnM8UbdLCGGhoAZa51VWNfwDIiyv/0QsZF8bbmrkaAANfhC4EfZa7aWNuhLrGlki7O3
 TEz94M7Qg1BtUkQSNNuR+wYHPJRHRwkN4ltfxfxkRye2GHpe+QttMng0xILWZOh9doL8
 2slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLijPMcyDKCXtSPHRwSPvNlWAMP/Ey57t/uYlG4MOwo=;
 b=EUE76LDyOuKJtRWtqDntoCi8vijo4MV6afQQdUx+Lwly5dKFo0ESGGepaGt6mehRsV
 aLUVbxyQjz7OP9TaMprzVOs7VBDnWpgPetBAJuh7VpblwRBKL7JjAoMI3fC+LFSu6S/K
 E7n83kI3NMNeVIM3ihpyDa1q4tlFa9D4eDtijqQspovGXzhq75MAUhQZpo4eItJDVJXr
 Ju1iwS8My31KD9URypnm0Uj3LHGhb0aO09biSe0kQErt7ikbuzwvrMV9be0ixCQzM9qq
 tSzdlqUZ0EC3FBqAlgYKgDMBz4ZhzYGwgrWoTkqmGK+9BAYdQ/svR/PJXJxdxbvBrnr+
 vakA==
X-Gm-Message-State: APjAAAVYUoK9eeboNDmJycof2BQkHH6tmuxwVRDc60i1y2wN8kf3E245
 W8jfA255IJRA0cKnSrmzBy9CSsbJ
X-Google-Smtp-Source: APXvYqw5hCsJn0Ixs9REUtc9WkQKfsZDzq9kAN7507w90OC/wS6NLzkJn19++gHjlNPOcqSU/R7kLw==
X-Received: by 2002:a81:2948:: with SMTP id p69mr1731436ywp.264.1565835015997; 
 Wed, 14 Aug 2019 19:10:15 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:15 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:05 -0400
Message-Id: <20190815020928.9679-24-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 23/46] target/i386: introduce operand
 for direct-only r/m field
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

Many operands can only decode successfully if the ModR/M byte has the
direct form (i.e. MOD=3). Capture this common aspect by introducing a
special direct-only r/m field operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index e4515e81df..c918065b96 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4822,6 +4822,43 @@ INSNOP_FINALIZE(modrm_rm)
 {
 }
 
+/*
+ * modrm_rm_direct
+ *
+ * Equivalent of modrm_rm, but only decodes successfully if
+ * the ModR/M byte has the direct form (i.e. MOD=3).
+ */
+typedef insnop_arg_t(modrm_rm) insnop_arg_t(modrm_rm_direct);
+typedef struct {
+    insnop_ctxt_t(modrm_rm) rm;
+} insnop_ctxt_t(modrm_rm_direct);
+
+INSNOP_INIT(modrm_rm_direct)
+{
+    int ret;
+    insnop_ctxt_t(modrm_mod) modctxt;
+
+    ret = insnop_init(modrm_mod)(&modctxt, env, s, modrm, 0);
+    if (!ret) {
+        const int mod = insnop_prepare(modrm_mod)(&modctxt, env, s, modrm, 0);
+        if (mod == 3) {
+            ret = insnop_init(modrm_rm)(&ctxt->rm, env, s, modrm, is_write);
+        } else {
+            ret = 1;
+        }
+        insnop_finalize(modrm_mod)(&modctxt, env, s, modrm, 0, mod);
+    }
+    return ret;
+}
+INSNOP_PREPARE(modrm_rm_direct)
+{
+    return insnop_prepare(modrm_rm)(&ctxt->rm, env, s, modrm, is_write);
+}
+INSNOP_FINALIZE(modrm_rm_direct)
+{
+    insnop_finalize(modrm_rm)(&ctxt->rm, env, s, modrm, is_write, arg);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


