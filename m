Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CBC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F758208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQN6xkF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F758208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4ks-0001Kd-BS
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:35:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aV-00006v-C6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aU-0006ry-By
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:37750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aU-0006p7-5b
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id z8so1890877pln.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Th3t/m0PioLpL2J3JR8QFGClCdlEYB4fbvw9qC7v3uc=;
	b=bQN6xkF/6mjgQD6aoiJqtsk8mR0nzfMl75mMliR0HvOyqTyOSLkC+nS54FGwy3wrAN
	ec4JcnGOH0gDVgLJhdz/ZjVxjozWSn/H/MfoGlIVzqMl55sYRIgDE8wguYCbmQ+34P0J
	FJqx6JEr5KIEiIgQdSkGC4gZiQIX+JDeJFcchFDaKhL1eQ3og9oXXJLHRd7HdWmbnapA
	r9hAgjUsAsEsD2G40ia2iQLXGy9LxaK37E+H0QYD+Ih1td3bgseSvME1NVtiKEw9pnNO
	J5S6vc1DDkzVcdRagOD600pOzJIzNIQiM2LeeqUzAES8W4I4a90IABdfgRoaXnjGtrsq
	f6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Th3t/m0PioLpL2J3JR8QFGClCdlEYB4fbvw9qC7v3uc=;
	b=f/5jwPrFTVxB7vsbGuWLHsuvRVToMKoRjth+k7pi92/NN0bGUZatOjaNeq2cMu8g4R
	uY7a1akP24zUytO5V7x7e4qsCMOtVUT34orsekmzg2zUu5hY3preTjdQdr4VIOqZdEO6
	PCMLOT9yxFflCtnx0X7W4er2iE7OebivV/stgtFYPqbwkz6r2Y1hpiRMYn9R85xYSpVC
	gvivTAHRxmcqUbcl22Bz7FubrgNFJcSZ4bcO0RpizN8ILvzvchOg7t4RBcn+9V7io4bv
	NwDpJkRPLy8EdAytvZ+RXIQ6zi6ICDxLPeUFhUCL6KiIHhQwCGc3QIvY2zfk75uXF77v
	xarQ==
X-Gm-Message-State: APjAAAXAlxJ6adhYAslxEZbj2mW/73tunmAwsweTJASMxsd/kAaWEoke
	ItU3y96e1B2izcFSmzprhab8Ece/Yek=
X-Google-Smtp-Source: APXvYqzjqp7aAl9jfKfz5A5GMuTEWKsj0+cNzAKHk/HO9jk9pYFfeyAiHI2RTXuW7/yOKWIokdSMGw==
X-Received: by 2002:a17:902:758b:: with SMTP id
	j11mr10005815pll.87.1556299476903; 
	Fri, 26 Apr 2019 10:24:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:17 -0700
Message-Id: <20190426172421.27133-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62f
Subject: [Qemu-devel] [PULL 11/15] tcg: Restart TB generation after constant
 pool overflow
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172417.P4aR4Oeg23XN5rbP-zJwFGNTaKvznyW4_UwyZFgvTQ4@z>

This is part b of relocation overflow handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-pool.inc.c | 12 +++++++-----
 tcg/tcg.c          |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
index 7af5513ff3..4eaa84b631 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc.c
@@ -121,14 +121,14 @@ static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
 /* To be provided by cpu/tcg-target.inc.c.  */
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
 
-static bool tcg_out_pool_finalize(TCGContext *s)
+static int tcg_out_pool_finalize(TCGContext *s)
 {
     TCGLabelPoolData *p = s->pool_labels;
     TCGLabelPoolData *l = NULL;
     void *a;
 
     if (p == NULL) {
-        return true;
+        return 0;
     }
 
     /* ??? Round up to qemu_icache_linesize, but then do not round
@@ -142,15 +142,17 @@ static bool tcg_out_pool_finalize(TCGContext *s)
         size_t size = sizeof(tcg_target_ulong) * p->nlong;
         if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
             if (unlikely(a > s->code_gen_highwater)) {
-                return false;
+                return -1;
             }
             memcpy(a, p->data, size);
             a += size;
             l = p;
         }
-        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
+        if (!patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend)) {
+            return -2;
+        }
     }
 
     s->code_ptr = a;
-    return true;
+    return 0;
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 752c45a0ec..0394e8ab34 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1019,8 +1019,8 @@ void tcg_prologue_init(TCGContext *s)
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
-        bool ok = tcg_out_pool_finalize(s);
-        tcg_debug_assert(ok);
+        int result = tcg_out_pool_finalize(s);
+        tcg_debug_assert(result == 0);
     }
 #endif
 
@@ -4005,8 +4005,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
-    if (!tcg_out_pool_finalize(s)) {
-        return -1;
+    i = tcg_out_pool_finalize(s);
+    if (i < 0) {
+        return i;
     }
 #endif
     if (!tcg_resolve_relocs(s)) {
-- 
2.17.1


