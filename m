Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B796CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADED20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naYk8Qqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs0J-0005uz-Qh
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvz-0002XE-0c
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvv-0004T2-3B
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvq-0004Rp-6i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so3630338wrx.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n37cEJrol8AD/IZetkBdnc9gLn6k6fFQUH++UO9sxLc=;
 b=naYk8Qqzyhv5aXDAnqXsfstj/X2uRHawlXM83yyVYtLx7UIUUQcckiOPfvD9Ba+EMU
 kmHlQOWeFiGza7bNZFCxB/E/LLkd3oKsJ0gTipsfdnuxEpDRXAiblrRTLMoZbmhkMhit
 CouxbTC8KGqsZ3m0NXPkBJkdMuv93nmYNvDoLBbWxEQZYN6kHDJz3eLsSxuLJ9tTV7wZ
 mhgn8qd0FkpXGzLkPiDyVixV5E/o7VxI3oELr3FMhk+33iCfph3ld2nhuzM0idLzbgOw
 6wTEzpqohg7eGQhX+NYX26ZprWVFCxX4dJnTVSTgd46Lscn2zK5AfFmCjXLHVAHcXP6C
 WFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n37cEJrol8AD/IZetkBdnc9gLn6k6fFQUH++UO9sxLc=;
 b=YZABA/HK+J6y/TovaELqu2x+Xr9hcZn3SJkx0mt/E7EF77cIxKLauyod1n9nDH42EX
 /QFwBOvLHCkLAGRQBU6/5XsTe/PPtMWJCXlSFkx27fhyAA25aNn3LdI3FCt2f/6hHj2d
 fDoiIQE0W/AkTBVbnDkWvqbxabQjkyq6y+8EHPpegkBHgbA7UUsHE4nnt/jz8k1/m6hF
 eoZZEksads2XKXirrPzXzR+I87s2sfc2tz5dtql8ZH2mQrYbLz7sJBaidhgo+DND+5Sw
 5S5/XxXxbQ9WZlNyMfV29bpG4llSdYIsVJdiYkxTsqSyIX6rZA2RfPm9vl+iutCFBwuN
 6qQg==
X-Gm-Message-State: APjAAAUV1dI6GYKiW2YVEEdJx8V5KTWLCrqD8wZVZKH4h/gtO0aEw12G
 DmtvC0j6H/wdYACKKPZRGOvPLA==
X-Google-Smtp-Source: APXvYqzndSo7WD6Am/1Q1EfTJXEPzK0Fl/tkyGEJKvmZ+44HQJjfBBf70NgGaGynQMxgcMffn2Vlkg==
X-Received: by 2002:adf:f949:: with SMTP id q9mr4958097wrr.382.1569358868190; 
 Tue, 24 Sep 2019 14:01:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm955358wmc.1.2019.09.24.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF19F1FF8C;
 Tue, 24 Sep 2019 22:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 01/33] target/alpha: Use array for FPCR_DYN conversion
Date: Tue, 24 Sep 2019 22:00:34 +0100
Message-Id: <20190924210106.27117-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This is a bit more straight-forward than using a switch statement.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-2-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 19cda0a2db5..6c1703682e0 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -36,6 +36,13 @@ uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
 
 void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
 {
+    static const uint8_t rm_map[] = {
+        [FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT] = float_round_nearest_even,
+        [FPCR_DYN_CHOPPED >> FPCR_DYN_SHIFT] = float_round_to_zero,
+        [FPCR_DYN_MINUS >> FPCR_DYN_SHIFT] = float_round_down,
+        [FPCR_DYN_PLUS >> FPCR_DYN_SHIFT] = float_round_up,
+    };
+
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
 
@@ -48,22 +55,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr = fpcr;
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
-    switch (fpcr & FPCR_DYN_MASK) {
-    case FPCR_DYN_NORMAL:
-    default:
-        t = float_round_nearest_even;
-        break;
-    case FPCR_DYN_CHOPPED:
-        t = float_round_to_zero;
-        break;
-    case FPCR_DYN_MINUS:
-        t = float_round_down;
-        break;
-    case FPCR_DYN_PLUS:
-        t = float_round_up;
-        break;
-    }
-    env->fpcr_dyn_round = t;
+    env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
 
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
-- 
2.20.1


