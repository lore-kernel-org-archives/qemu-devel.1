Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E0C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB87420684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MS3ejoo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVq4-00009Z-03
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk4-0000Ex-2r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk2-00057D-Gm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id o68so3142808pfg.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T5+4Hm8QKZkxl4HUg0KhrOXM6aaOJZgbxYaiAZNZh2c=;
 b=MS3ejoo2FhbzvTtYqQF5pCCKIozEPJzgzI77f4N8WC6N7+Dh37RIczP0m0G0FNHAkJ
 mpAKgwQxSCK2LchQFvoQ4C+a+ZldF/Rv3qD/gFyToLdmnMMR8UvlcAHlIn8SKMTUZ4LG
 BMLzAroYrz41jAfDkbuLxULHmDrRuu2kzDAr9Hs7aO1EchUbGk7VUuDODC1zyE23AuGV
 mQh3l1x1AJoB3lyuObJy0a0I8h8SKjcishTXJVd2FSgsI/FGxq8/bpPdBFn3mm8uSP9Q
 nbNnZ+xdgDvNNoqpOdMl7bBRL7NrXlgH9ZZI/sisx0c8JtVu9Bw/j/zPBIAxMUdUHzC8
 I25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T5+4Hm8QKZkxl4HUg0KhrOXM6aaOJZgbxYaiAZNZh2c=;
 b=uFcFN1I45hFwRiliH1ELQKi4+2vSvh9d7fHw75lV//nTeRUdJDOJgYofu++q/wdJR2
 1A2IpWQ5ziDo8Rgm3BRDzd8CLqrorJcbiujYCn0qaT33gHxtgqBdUSYUDjA1BFvAz6iq
 M0hF/1sXHKqWEDXRyO1OguBEfU6YtCDziFXE/LKfxP9qYbpACgFCsippIGIPKNmXgFWT
 Q/Hj25TDRe0CCUQ6hGlobygfWMOVP2WP6KK7ouRShKkdfNgKSR/rVxFp73kFTl98clka
 HWuoyssdgE5Z/zDXULxozMxpruNjbCDC/NUkG6vXapd4wdAdynw9L21tSz9DM3YIee/f
 SYOQ==
X-Gm-Message-State: AOAM533pFeBIzeiyLu3AQP9vzbrHhoiE7vU9TEyS6lCCOB3yLOvySL5E
 5mqmI/xvAVDevRJEdpHx2GRWBxJz0SgYOg==
X-Google-Smtp-Source: ABdhPJzkzXLiF4Zos9TLQyp/UgvsjCHO3M5Qr8FJoiFqxdPeGlmtHzKhaVsAgssQqCUgIk5AexzWbw==
X-Received: by 2002:a63:3742:: with SMTP id g2mr2460165pgn.71.1599064568788;
 Wed, 02 Sep 2020 09:36:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Wed,  2 Sep 2020 09:35:58 -0700
Message-Id: <20200902163559.1077728-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Normal indirect jumps, or page-crossing direct jumps, can use
tcg_gen_lookup_and_goto_ptr to avoid returning to the main loop
simply to find an existing TB for the next pc.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a94f3e340e..4416361d08 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -147,7 +147,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1803,7 +1803,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(NULL, 0);
+            tcg_gen_lookup_and_goto_ptr();
         }
         return;
 
-- 
2.25.1


