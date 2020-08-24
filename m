Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D5C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74BD2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkGWnS8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74BD2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9F4-0008Kd-6m
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95n-0005We-5t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95l-0004pb-E7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id o21so7551440wmc.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=986a+dtrAGXDxkRArhjNYo7MkVjUW9PLQfZ9R0W5SLo=;
 b=jkGWnS8vCYIXlavTZRWs9aQi7tvOTdls7bgm+3BLuUbI18fxWzHeICnvajm1AH2sau
 PpMa3MkZVRJzBb+vY3m95Xv9v3mbU8MNj+TsTeXV/4zNDjG3ugdud09Wgei29PH+u8jM
 R+LLQ5a0Hi6dNzpUAJCw5UkYracmHyTlkLnG29U8J6o6nrPhUomF3vdnRlw31eO2fmQ8
 EYDoO9fdGqWX62W0FvbUwcP+MFzGLrIMlSz+Lc5G2I7R1HgkuSkCSJiWkB7bohgfrUUJ
 s0JYH+I5JeGedJV6xh+qw5kvVAlmpKCon6NShRz+U0w8ftX+oY8tVbekryA7Nj78Zove
 qf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=986a+dtrAGXDxkRArhjNYo7MkVjUW9PLQfZ9R0W5SLo=;
 b=a82gAAXNrtTlJ0Ck7n8yPgobtqkxmvlWCAGb/DVGRr1xf4dt3w7/kYGkBVXdIMlVxq
 JiMGj/yhknRvIqxjdbEIVSef/jH8yJniY0huuXXwKorwWt6gc8VO4cpLv2fR8fO/wwGQ
 17+HX1vKbMA0dkfZ/vV/NOoWA+/LmvjsBlneMX9t6/VOHZsCORfHrU37dGa5msJw7fAn
 sieqO+G4ByML9t1gE4FAOQaNYWpp4cggIhAqbVkhJQEpio/iXpoQGrTJg3+HHxsWiXR1
 IwRfA5rgD3LstQBqEZoV5yeFq7To2wo1OrpzYGLhaq6Q5W1pwJEoL1hqT93GTgp/d9Bl
 t6EQ==
X-Gm-Message-State: AOAM532WDNOQDrovSHoCY9Yk6RJwzR/Mv/fIcsQk4RgLf5TMSUlKv3Io
 +S5z1N6Ywa2B9zxDfSJwfqQ1DKx22kC/Wls8
X-Google-Smtp-Source: ABdhPJxfDZeQR37FDhKcKbvNbCN3cDX/SqgFpcJ5qxWO7kHci8v8cp4nsA6NxN1pv90M1590olOcLQ==
X-Received: by 2002:a1c:1b43:: with SMTP id b64mr5051161wmb.6.1598262519894;
 Mon, 24 Aug 2020 02:48:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/27] target/arm/translate.c: Delete/amend incorrect comments
Date: Mon, 24 Aug 2020 10:48:06 +0100
Message-Id: <20200824094811.15439-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In arm_tr_init_disas_context() we have a FIXME comment that suggests
"cpu_M0 can probably be the same as cpu_V0".  This isn't in fact
possible: cpu_V0 is used as a temporary inside gen_iwmmxt_shift(),
and that function is called in various places where cpu_M0 contains a
live value (i.e.  between gen_op_iwmmxt_movq_M0_wRn() and
gen_op_iwmmxt_movq_wRn_M0() calls).  Remove the comment.

We also have a comment on the declarations of cpu_V0/V1/M0 which
claims they're "for efficiency".  This isn't true with modern TCG, so
replace this comment with one which notes that they're only used with
the iwmmxt decode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803132815.3861-1-peter.maydell@linaro.org
---
 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ffd8b1fbe5..dd25adcf402 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -57,8 +57,9 @@
 #define IS_USER(s) (s->user)
 #endif
 
-/* We reuse the same 64-bit temporaries for efficiency.  */
+/* These are TCG temporaries used only by the legacy iwMMXt decoder */
 static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
+/* These are TCG globals which alias CPUARMState fields */
 static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
@@ -8566,7 +8567,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     cpu_V0 = tcg_temp_new_i64();
     cpu_V1 = tcg_temp_new_i64();
-    /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
 }
 
-- 
2.20.1


