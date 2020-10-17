Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D900C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAFD2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhX/T6Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAFD2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmrl-0006oR-FR
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmne-0001WJ-SA
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmna-0003hD-Qs
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id y12so6582122wrp.6
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w+RNDLWj4IFLfK+eBwoAQeU4+ogED2fJwsKp3kpT+Og=;
 b=lhX/T6Bru4d0moFLuUF2q4LSoamJYEL5oNBJuvK0IxgRDUtHSVPxN6AJ0Bv4l22Qks
 xzJEqr2pha9/XVqVVrVWi8Hs+67hZcHWQUw5mjmWWvTYyvJYI8Ntl9CQNsggRghkr3P1
 ubWi1C8ear09/xBwpw1L/uG2Snkt7LKZbT7g+T3X/3C0lrQTynM7yeGGrzj+BUggViO+
 4sEV7HyrGH74z67Au32UsqRXRlXXY7x6Lv8E/66MLcocGLWozxczlZ6x7xAoZOj3vUz6
 62h3ybpTChNmvIIEVnhDyEV5ELR9G4f7xirn0wQNgRSYRlWsxA3KwWODqENhfKUx79Ih
 ilJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w+RNDLWj4IFLfK+eBwoAQeU4+ogED2fJwsKp3kpT+Og=;
 b=BWlk4ViLd+rBuaoFe96QMZtll73g6YNBHCF/wxrG8zw74/hq05B+Fz5Hv3yjd67gZj
 nCZdXhlLSWk24tpihoz4hvwAN5+NZWFO31zh1ipl/5GzojER76NkfUDRAaJum4KXJ/A5
 fUmru4PIsEdFVtHU3I/+thf68sNof8l+g6y4fVi2SVRUu7bhmiohYs1CEQxHw0zUCifa
 6gbfnhOjCyMHiB0ym58q1lBnXl6OaY5MW53obhu9KsKX1qXRMjhlcLDRK0ZWXG+zPyXc
 XwPblI++Xhug+dABKN4vexiCSVjXp+m+H18iMt/TZ1LsWOAwDofahO4b/wtzQqpBYH79
 O/yA==
X-Gm-Message-State: AOAM530P/icpvpZ3Ohg4/weZo/0rJ2Y0nEseSWRulfpxFOAXVdf6H/AI
 8E15XA3NqXAQxW/lqnlHk6S856j/VFM=
X-Google-Smtp-Source: ABdhPJxG5+l9hlcXnZrOemPyWR8o2wyYmK06a0XaqlKt/EeufscTUvpOWH0ZY346xWY67cemSmFizg==
X-Received: by 2002:adf:e444:: with SMTP id t4mr10876914wrm.58.1602943384583; 
 Sat, 17 Oct 2020 07:03:04 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id f6sm8403768wru.50.2020.10.17.07.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/44] target/mips: Fix some comment spelling errors
Date: Sat, 17 Oct 2020 16:02:03 +0200
Message-Id: <20201017140243.1078718-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, zhaolichang <zhaolichang@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Edmondson <david.edmondson@oracle.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

There are many spelling errors in the comments in target/mips/.
Use spellcheck to check the spelling errors.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201009064449.2336-7-zhaolichang@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/internal.h           |  2 +-
 target/mips/translate.c          | 10 +++++-----
 target/mips/translate_init.c.inc |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9230c..b811f547f38 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -188,7 +188,7 @@ static inline bool cpu_mips_hw_interrupts_pending(CPUMIPSState *env)
         /*
          * A MIPS configured with a vectorizing external interrupt controller
          * will feed a vector into the Cause pending lines. The core treats
-         * the status lines as a vector level, not as indiviual masks.
+         * the status lines as a vector level, not as individual masks.
          */
         r = pending > status;
     } else {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf72898..b4d009078e0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3718,7 +3718,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
 
     t0 = tcg_temp_new();
     addr = tcg_temp_new();
-    /* compare the address against that of the preceeding LL */
+    /* compare the address against that of the preceding LL */
     gen_base_offset_addr(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
     tcg_temp_free(addr);
@@ -25597,7 +25597,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         }
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
-        /* finaly update the destination */
+        /* finally update the destination */
         tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
 
         tcg_temp_free(t1);
@@ -25633,7 +25633,7 @@ static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
         }
         /* return resulting half-words to its original position */
         tcg_gen_shri_i32(t0, t0, 16);
-        /* finaly update the destination */
+        /* finally update the destination */
         tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
 
         tcg_temp_free(t1);
@@ -25702,7 +25702,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             }
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
-            /* finaly update the destination */
+            /* finally update the destination */
             tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         }
 
@@ -25742,7 +25742,7 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
             }
             /* return resulting byte to its original position */
             tcg_gen_shri_i32(t0, t0, 8 * (3 - i));
-            /* finaly update the destination */
+            /* finally update the destination */
             tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
         }
 
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637caccd890..c735b2bf667 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -995,7 +995,7 @@ static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
 
     /* MVPConf1 implemented, TLB sharable, no gating storage support,
        programmable cache partitioning implemented, number of allocatable
-       and sharable TLB entries, MVP has allocatable TCs, 2 VPEs
+       and shareable TLB entries, MVP has allocatable TCs, 2 VPEs
        implemented, 5 TCs implemented. */
     env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
                              (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
-- 
2.26.2


