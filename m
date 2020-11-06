Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFDC55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DD9208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVOykowX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DD9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3fo-000554-Lk
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eX-0003RS-5x
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eV-0001IO-BU
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id b8so1751577wrn.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eM8x5tgPhhwtpKk11UYKbf2bCBwlq92NBJB9ED/iCiI=;
 b=qVOykowXcnFt3XDdXBfLj5qVwOxHqvzr0YpxBQuGii688VyRqxvozj8Q6xb1RTYOiK
 wRtwyhPxaZQf44+9zMf4BKZ8P2cX8Ueq7JrxPEu1xzQEVsMnLlMJLT39LomA3EbRGTGK
 o4XRLRqwAgC+UPRPQWXWg84+gxMnq9kl1qKwLR8Km9PUh/tx2Wko1B27zPhBKdOOODR/
 3rlfdDdj6c2jyJYBMWDel4LWzR7V+O55V+557Im3BkRuK9XYmjyGErfCFcYgugiRmEVk
 g4LGUIyM/stAr8Eun5vuOBY0Ex8Reu0Ys43GhneSSfCg5QJJa0VPH7Ezp7VCYD4B8Lq2
 Ondg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eM8x5tgPhhwtpKk11UYKbf2bCBwlq92NBJB9ED/iCiI=;
 b=ALDqRDUecb6S8RVUfN8qgABfcgrdR9wGvU0Lt7nO56kgjfityEhbCAjUcdIDjuy0rw
 elKdJOtFKTX1WN4AcuS4D+3KOS7LyiWRrqDGR8hrFI1gU20kErwnz6NAN1/Vnu/9ebEF
 4DLga/CoYlAl/hIMyHKr9Edc+j9A3qMybMA4O6B29j9TAXS97PhrhabzCBQ1Q4eR3A7w
 bOaxBtYxn/o/2UGVfIDPjpJ5T0WwgeS+iIzyvtL0h9PslsE3O3/gEfqlzOpYD2jOifPW
 qhJwLqiT6ueA6KQNWQRtIR3T6I51Xyn1Sor6JQSv85SG4Ln0XGlToDC6QObs3uaUpkMB
 PjwQ==
X-Gm-Message-State: AOAM532lvm1S0RX8oNoMHFP190o8GV1wxB31WHA4ZYkrA7OD8nPBDHYs
 Cp17tgjeQ1Txb0KEiZP2RqNxeMuuBNdELQ==
X-Google-Smtp-Source: ABdhPJzXNrJPR+9Yl/QBzKIu6WIk2BEY0s4Rhxwlvv4Sh5prpg0SOlQVjbr1Fp/plC4y+0gQAZ8Yyg==
X-Received: by 2002:adf:8bcc:: with SMTP id w12mr3555152wra.157.1604676465794; 
 Fri, 06 Nov 2020 07:27:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 109sm2723462wra.29.2020.11.06.07.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:27:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] linux-user/sparc: Handle tstate in
 sparc64_get/set_context()
Date: Fri,  6 Nov 2020 15:27:38 +0000
Message-Id: <20201106152738.26026-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106152738.26026-1-peter.maydell@linaro.org>
References: <20201106152738.26026-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correctly implement save/restore of the tstate field in
sparc64_get_context() and sparc64_set_context():
 * Don't use the CWP value from the guest in set_context
 * Construct and save a tstate value rather than leaving
   it as zero in get_context

To do this we factor out the "calculate TSTATE value from CPU state"
code from sparc_cpu_do_interrupt() into its own sparc64_tstate()
function; that in turn requires us to move some of the function
prototypes out from inside a CPU_NO_IO_DEFS ifdef guard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.h          | 24 ++++++++++++++++++++----
 linux-user/sparc/signal.c   |  7 +++----
 target/sparc/int64_helper.c |  5 +----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 277254732b9..4b2290650be 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -608,10 +608,6 @@ target_ulong cpu_get_psr(CPUSPARCState *env1);
 void cpu_put_psr(CPUSPARCState *env1, target_ulong val);
 void cpu_put_psr_raw(CPUSPARCState *env1, target_ulong val);
 #ifdef TARGET_SPARC64
-target_ulong cpu_get_ccr(CPUSPARCState *env1);
-void cpu_put_ccr(CPUSPARCState *env1, target_ulong val);
-target_ulong cpu_get_cwp64(CPUSPARCState *env1);
-void cpu_put_cwp64(CPUSPARCState *env1, int cwp);
 void cpu_change_pstate(CPUSPARCState *env1, uint32_t new_pstate);
 void cpu_gl_switch_gregs(CPUSPARCState *env, uint32_t new_gl);
 #endif
@@ -829,4 +825,24 @@ static inline bool tb_am_enabled(int tb_flags)
 #endif
 }
 
+#ifdef TARGET_SPARC64
+/* win_helper.c */
+target_ulong cpu_get_ccr(CPUSPARCState *env1);
+void cpu_put_ccr(CPUSPARCState *env1, target_ulong val);
+target_ulong cpu_get_cwp64(CPUSPARCState *env1);
+void cpu_put_cwp64(CPUSPARCState *env1, int cwp);
+
+static inline uint64_t sparc64_tstate(CPUSPARCState *env)
+{
+    uint64_t tstate = (cpu_get_ccr(env) << 32) |
+        ((env->asi & 0xff) << 24) | ((env->pstate & 0xf3f) << 8) |
+        cpu_get_cwp64(env);
+
+    if (env->def.features & CPU_FEATURE_GL) {
+        tstate |= (env->gl & 7ULL) << 40;
+    }
+    return tstate;
+}
+#endif
+
 #endif
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index ed32c7abd17..a6c7c7664a2 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -438,9 +438,9 @@ void sparc64_set_context(CPUSPARCState *env)
     env->npc = npc;
     __get_user(env->y, &((*grp)[SPARC_MC_Y]));
     __get_user(tstate, &((*grp)[SPARC_MC_TSTATE]));
+    /* Honour TSTATE_ASI, TSTATE_ICC and TSTATE_XCC only */
     env->asi = (tstate >> 24) & 0xff;
-    cpu_put_ccr(env, tstate >> 32);
-    cpu_put_cwp64(env, tstate & 0x1f);
+    cpu_put_ccr(env, (tstate >> 32) & 0xff);
     __get_user(env->gregs[1], (&(*grp)[SPARC_MC_G1]));
     __get_user(env->gregs[2], (&(*grp)[SPARC_MC_G2]));
     __get_user(env->gregs[3], (&(*grp)[SPARC_MC_G3]));
@@ -557,8 +557,7 @@ void sparc64_get_context(CPUSPARCState *env)
         }
     }
 
-    /* XXX: tstate must be saved properly */
-    //    __put_user(env->tstate, &((*grp)[SPARC_MC_TSTATE]));
+    __put_user(sparc64_tstate(env), &((*grp)[SPARC_MC_TSTATE]));
     __put_user(env->pc, &((*grp)[SPARC_MC_PC]));
     __put_user(env->npc, &((*grp)[SPARC_MC_NPC]));
     __put_user(env->y, &((*grp)[SPARC_MC_Y]));
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32de61..735668f5006 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -131,9 +131,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
     tsptr = cpu_tsptr(env);
 
-    tsptr->tstate = (cpu_get_ccr(env) << 32) |
-        ((env->asi & 0xff) << 24) | ((env->pstate & 0xf3f) << 8) |
-        cpu_get_cwp64(env);
+    tsptr->tstate = sparc64_tstate(env);
     tsptr->tpc = env->pc;
     tsptr->tnpc = env->npc;
     tsptr->tt = intno;
@@ -148,7 +146,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
 
     if (env->def.features & CPU_FEATURE_GL) {
-        tsptr->tstate |= (env->gl & 7ULL) << 40;
         cpu_gl_switch_gregs(env, env->gl + 1);
         env->gl++;
     }
-- 
2.20.1


