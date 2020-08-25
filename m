Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D660EC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A238720665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9kjF86s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgF8-0000jP-U4
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3I-0007VH-F4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3G-0001hs-Fo
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:20 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q1so127248pjd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HaAnpocjYbBqDikM80fgZOEo5h0cDqsU8in/f2nqeSk=;
 b=k9kjF86s31Ab6Xxn5y1ioVUgfUNO5Z9DQhb3bZ6qS/8aB+TXe5RxE228zFX0joYqry
 jCpmGE/9BGjfUK8/lMe6cbl6DSHt7tW7Ba/y+7Whcnc8X9kQQJtIwwb9N+5whq94TFp1
 9okqSRW8nDo8nwAxwMfj/Y3n2RDxQ+E/6wkeA7hvsAAzcqf8uoXKFLCc6bSI06gX722u
 mO43Pe+X5aVDiGA8a9oc1212zKtcNTE7Ihfg0v9yAtJhn+Ajt+3FFa3Kos0xoE8gwtNU
 b7sDdPATD63oLz5ONAvHmqYvZa16II4x50z10FVjg0NxDIpAxe90jXM8twXtIqUu5J0f
 gXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HaAnpocjYbBqDikM80fgZOEo5h0cDqsU8in/f2nqeSk=;
 b=c+fvWZ2c8jAb+hbxtQpc7MgCoCXIB7FCO1LWZDYrTKLqM/uZCLOGRvicgA+N2n08cV
 6w2FUjjnJpLoGgL+Z30pNj55EkydPElfqm/NSxpr5liBA9LPIVY8InX1ZzntmAHtFc8o
 4Q2dlK+wIn2HJWDFj26hnwDZeVsG6yaeFzC8sZpuDOJwoLzecxuTk2ulUlZsGF6iTlRb
 V4s42l11XA5r1IMILo1H32Fb+0YKUIYgPzgYu+/lOFkSec0CUA/M3uqZhGO7sfkTq8bF
 EDReEnf5Ldl0P6Tc0gqnhrftwj71Z2T/hwzCsLLyFZ2hEhCM2yQWU8v4wdiCS/LA/C3M
 Izhg==
X-Gm-Message-State: AOAM5303uNH6CQZKEc9XKcvRAjASYSogvf3Ay3vA8m6dpNxPV6VIA0Tl
 kyhnfh5z8vJs8le0m62hTk8qD4y+2EeIEg==
X-Google-Smtp-Source: ABdhPJwXOwt3xJDrUSYFVwhpnGaIl117Xi+uhbnoeT/eJDn6/bomr/cF6n2Ylq9J5d2Qv9jy0spGfA==
X-Received: by 2002:a17:90b:1895:: with SMTP id
 mn21mr3146401pjb.173.1598389216498; 
 Tue, 25 Aug 2020 14:00:16 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/77] target/microblaze: Remove cpu_ear
Date: Tue, 25 Aug 2020 13:58:52 -0700
Message-Id: <20200825205950.730499-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since cpu_ear is only used during MSR and MTR instructions,
we can just as easily use an explicit load and store, so
eliminate the variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a862ac4055..f5ca25cead 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -57,7 +57,6 @@ static TCGv_i32 env_debug;
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
-static TCGv_i64 cpu_ear;
 static TCGv_i32 cpu_esr;
 static TCGv_i32 env_imm;
 static TCGv_i32 env_btaken;
@@ -533,7 +532,12 @@ static void dec_msr(DisasContext *dc)
                 msr_write(dc, cpu_R[dc->ra]);
                 break;
             case SR_EAR:
-                tcg_gen_extu_i32_i64(cpu_ear, cpu_R[dc->ra]);
+                {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+                    tcg_gen_extu_i32_i64(t64, cpu_R[dc->ra]);
+                    tcg_gen_st_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+                    tcg_temp_free_i64(t64);
+                }
                 break;
             case SR_ESR:
                 tcg_gen_mov_i32(cpu_esr, cpu_R[dc->ra]);
@@ -573,10 +577,15 @@ static void dec_msr(DisasContext *dc)
                 msr_read(dc, cpu_R[dc->rd]);
                 break;
             case SR_EAR:
-                if (extended) {
-                    tcg_gen_extrh_i64_i32(cpu_R[dc->rd], cpu_ear);
-                } else {
-                    tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_ear);
+                {
+                    TCGv_i64 t64 = tcg_temp_new_i64();
+                    tcg_gen_ld_i64(t64, cpu_env, offsetof(CPUMBState, ear));
+                    if (extended) {
+                        tcg_gen_extrh_i64_i32(cpu_R[dc->rd], t64);
+                    } else {
+                        tcg_gen_extrl_i64_i32(cpu_R[dc->rd], t64);
+                    }
+                    tcg_temp_free_i64(t64);
                 }
                 break;
             case SR_ESR:
@@ -1865,8 +1874,6 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, pc), "rpc");
     cpu_msr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, msr), "rmsr");
-    cpu_ear =
-        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, ear), "rear");
     cpu_esr =
         tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, esr), "resr");
 }
-- 
2.25.1


