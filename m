Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F57C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE472071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNBOKi3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE472071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCon8-0000tN-Ac
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojH-0001jV-4z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:31 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojF-0007DO-Gu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id g29so1120883pgl.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uj24xMFJGA/MCPfshVwohiNf2SvgonL4GmtJig6PZxw=;
 b=wNBOKi3TJIgRqCD+4a6EGXLsTau+Mgpbcu5zpXtvNhGCnFcgMj0oEOmih6S7c9aFmi
 3b3lodbvqTQ4Bm9fx24aCkHA6oHndrdnW/NPmKsR1xpNrAdAIyrt+U9/aa4W/7qoFN+A
 onn5HQdFGzg2NhqpjKA/nb8LQn5rkEjqhVVDdBQuapCVZt2FwjeEC/zETvH/MNdgkZNU
 H/tnMAWUfv/+hBDMpVuETg24b4QY87ZI6BblypQjI7DzNIsU+4XyGjZ5MZuYiS7/3YOB
 01MoYJWQDFQKfwzIdJ3/KO1FWjGxJyZu6CmI8ZCzKmGCrmM5TX8C80FEeSdI/Ojca/DM
 SAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uj24xMFJGA/MCPfshVwohiNf2SvgonL4GmtJig6PZxw=;
 b=kpHyuYf1jbu30lNCtnHQv5EIeXRseBh2dBKQPHCm6jXw2tJpAth0Ez6auIydKZSLOL
 aZ89cw9WZ4bfnryGZZuijYo6AujGq/AnurCvhDHCpI8eU2piPo8HWp/qqwRmL2oVg6Kl
 Ql1+DF3GCBngu/d/vA72nCcTTskvX1pRnmTofiQ2ZV0cJZ5vZwrAQkq4cPm1HVRQ5NTc
 +tRC933ZpC0Y76YPBfzQ5KB/W9XDiLkPOb+J4mRBcQHXIECSIvCU2w7F/kMAzRP/RN2z
 0e1hp9EoFewh39QdFIAGxRqWpqTiaTp2iw/Oibc12snqmUfWLKlf7/+30SP2uc88zOtk
 ahWw==
X-Gm-Message-State: AOAM532QqK4du3VYj3Kz066z6MkaYYeFTkL3V+uyN8KSHD2JsCqwUtTs
 u94wlxLqvIbsd5Q9v5Rnm2MxLBuKvufhIw==
X-Google-Smtp-Source: ABdhPJycrVBj6o/Ib4/oB/l5NnN3rH4YENAj48mIsQlYMHt9bXEhD7JTq0GyDveuLJi1/dYB/gtydA==
X-Received: by 2002:a63:29c6:: with SMTP id p189mr2190782pgp.148.1598899227945; 
 Mon, 31 Aug 2020 11:40:27 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y195sm5757580pfc.137.2020.08.31.11.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 11:40:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Mon, 31 Aug 2020 11:40:18 -0700
Message-Id: <20200831184018.839906-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831184018.839906-1-richard.henderson@linaro.org>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8d02b07b73..2c166eeb92 100644
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


