Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD05246A8
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBxoo4eP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD05246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7sBR-0006aN-6O
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6g-00076k-T2
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6e-00037g-TW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:58 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:50604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6e-00036X-O0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:56 -0500
Received: by mail-pj1-x1032.google.com with SMTP id r67so2036300pjb.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eSileXcCP7W6yOgW27jNaouMctoAYA46YTtTPUHqQM0=;
 b=hBxoo4eP/HgO4S21xvK31T0j3Nh2JMEg+IlxlwwVWGgifMfZzDDuZUEZNJxoxE4ENF
 xb3Ms9DJf8Off0hO1BfIn366jo4yIbGgyIAh/6CSBZNxzuGZuYGRtlzy9g3hrKEJsLwA
 Os2XH96G65lse6r1/JxG8a+yMOfYje7z1/HwnAYbdxZv0wUhYYffR/9N67YJS6Tt7x54
 RUdFi1QI6763LqCZphqdxzFgrVFL2Dv8N0sG24VLFngU9kE4lQpICPSvziZOc4qYnVWd
 2s2iFzY+B4/uZMZmijZ9WGgK8dVu4AHLEWD4zficMvfZc5kTFAZ2Ns+6QIGJPUQ6VMQt
 FoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eSileXcCP7W6yOgW27jNaouMctoAYA46YTtTPUHqQM0=;
 b=M6Vq2ERN0OC7zNBeH+jHlFhpmGJSDK+OvW1Mj+bkzTo0hHMPBRlcPQn3Aw3VT/ewzR
 1aK7hOKWZMZLEYqTembhzk/GHmvIS3YM5JyRuNB3Kt8sWZQfCEj4qs/YFwTz/LUsiz6z
 F6kr2xOTKI43drMp4cdbSq5cIEQ0EV96kB18bmUdhi7ZyEsd9jWBK/aXrDDyXW32mRHM
 kdYHWzWMhro+TKN1rN93Nn8ms/4VeMImmF1WLfo1/l2dqdJm2fy0uhtNaS5E/HxbY1CB
 q5atqyP6leX/h/j6w/NLA5GFhno7Bp96rJfh6wOSy4hZDD/F06YLhqR28QJchL16DCr3
 SACA==
X-Gm-Message-State: APjAAAVFVtKFbr/0kikpdvM2GrC7J5s/ZgltSxwFdHold2fKUbWpyFs2
 NAFX5azZvxyf76AUbRW4+ee6Ol5Bt94=
X-Google-Smtp-Source: APXvYqwIeJyLdXOjUSTTGFSzQJYuWXBzosVrsqLIQuN9t+jkWx0gHhiWN31dIKyJiuRg/3XkEnVsgw==
X-Received: by 2002:a17:902:41:: with SMTP id 59mr7130672pla.39.1582944235311; 
 Fri, 28 Feb 2020 18:43:55 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] tcg/arm: Expand epilogue inline
Date: Fri, 28 Feb 2020 18:43:43 -0800
Message-Id: <20200229024347.22826-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1032
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

It is, after all, just two instructions.

Profiling on a cortex-a15, using -d nochain to increase the number
of exit_tb that are executed, shows a minor improvement of 0.5%.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e1aa740ba4..6aa7757aac 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1745,7 +1745,6 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #endif
 }
 
-static tcg_insn_unit *tb_ret_addr;
 static void tcg_out_epilogue(TCGContext *s);
 
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
@@ -1756,14 +1755,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        /* Reuse the zeroing that exists for goto_ptr.  */
-        a0 = args[0];
-        if (a0 == 0) {
-            tcg_out_goto(s, COND_AL, s->code_gen_epilogue);
-        } else {
-            tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
-            tcg_out_goto(s, COND_AL, tb_ret_addr);
-        }
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, args[0]);
+        tcg_out_epilogue(s);
         break;
     case INDEX_op_goto_tb:
         {
@@ -2309,7 +2302,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      */
     s->code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
-    tb_ret_addr = s->code_ptr;
     tcg_out_epilogue(s);
 }
 
-- 
2.20.1


