Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7391320786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ5VvYBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7391320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD93-0003R8-Kz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR0-0004Fp-Ui; Tue, 16 Jun 2020 10:19:30 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:35789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQy-00071i-VS; Tue, 16 Jun 2020 10:19:30 -0400
Received: by mail-oi1-x230.google.com with SMTP id k4so19388166oik.2;
 Tue, 16 Jun 2020 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2sGZeIkn1XRAThlPtGTj22txvZ5HLiiO307uo0Zge1U=;
 b=iQ5VvYBO6W9LW3IlvybIixdsur1eSa37dAB5/CFKEtGn6HNJBveyx5vGOiOysYh7pE
 hLLEaZukUko1p9sUviyNOgSJnBkFBigZQWTKkhEON4NbEZC4j3GGrG3ASUxRHpMjYxxh
 FppU9j7Z9/4pN6OPaPbxDc+oJCtfWEEAil1/NtoPSO9itPJVmqZH76D5FqiMMh7JsE34
 8IEifd/wpv98meAB8S/khIgHBQiIly9TzModPryrfrw03b9qBIdgX8+UfMC5mQ5VwPxt
 qvV5iCI+9jFhTLyrlwMvi4rosiRk583tVgjbyw2BS0IcLrQE0kDxrCEKq3FImV+ViRDc
 d+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2sGZeIkn1XRAThlPtGTj22txvZ5HLiiO307uo0Zge1U=;
 b=jkLB1k2/8K9T2uNlM+YpAUvpHR6Tk8jGtTIxgdyMvtRmlIADbRVt3KhP0tX2Iatim2
 vsCTDSr6IxH+MPEK+yQ1BOwnQxO5a2gBGsz9Ej4NbTTyIRwW+MCqCD89QRleJni/v881
 jponj/hCXShTQsapJfn6xBba3DR7lMpCWEUqD5SNbMHBcJiOCg0IuBFV7kJx+3fHhCmz
 Xa99WqFLUBlAaMu8Sjkw/LBr9fQvTqK694FJLMI2DRn7t6WiuEgPPqTk9Xj9TlOoYYr2
 hWrk/dQA0vW9JnPY+KE6k4ipH/wLhNfTJFRczIzW6zJFxXXYgU/MfVpUT2B+G34el/De
 wQ+g==
X-Gm-Message-State: AOAM5304+3wlf8OKRME0gLZ7UuTsApHhM7kAOIgkwFnSW80O1LUNUoOj
 oRAQewJS3mP3b2eatgeZ+b7KJCJc6A0=
X-Google-Smtp-Source: ABdhPJxfYOLhH8ZOcJmjUQjjean/8BmwRsenergJa5ecfZ9UWPUwhTx8hLwlMuCYuQhop2Q2xB+Rww==
X-Received: by 2002:aca:2b1a:: with SMTP id i26mr3507705oik.45.1592317166761; 
 Tue, 16 Jun 2020 07:19:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c1sm4173638otn.81.2020.06.16.07.19.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:25 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 68/78] target/ppc: Fix mtmsr(d) L=1 variant that loses
 interrupts
Date: Tue, 16 Jun 2020 09:15:37 -0500
Message-Id: <20200616141547.24664-69-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nicholas Piggin <npiggin@gmail.com>

If mtmsr L=1 sets MSR[EE] while there is a maskable exception pending,
it does not cause an interrupt. This causes the test case to hang:

https://lists.gnu.org/archive/html/qemu-ppc/2019-10/msg00826.html

More recently, Linux reduced the occurance of operations (e.g., rfi)
which stop translation and allow pending interrupts to be processed.
This started causing hangs in Linux boot in long-running kernel tests,
running with '-d int' shows the decrementer stops firing despite DEC
wrapping and MSR[EE]=1.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208301.html

The cause is the broken mtmsr L=1 behaviour, which is contrary to the
architecture. From Power ISA v3.0B, p.977, Move To Machine State Register,
Programming Note states:

    If MSR[EE]=0 and an External, Decrementer, or Performance Monitor
    exception is pending, executing an mtmsrd instruction that sets
    MSR[EE] to 1 will cause the interrupt to occur before the next
    instruction is executed, if no higher priority exception exists

Fix this by handling L=1 exactly the same way as L=0, modulo the MSR
bits altered.

The confusion arises from L=0 being "context synchronizing" whereas L=1
is "execution synchronizing", which is a weaker semantic. However this
is not a relaxation of the requirement that these exceptions cause
interrupts when MSR[EE]=1 (e.g., when mtmsr executes to completion as
TCG is doing here), rather it specifies how a pipelined processor can
have multiple instructions in flight where one may influence how another
behaves.

Cc: qemu-stable@nongnu.org
Reported-by: Anton Blanchard <anton@ozlabs.org>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20200414111131.465560-1-npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 5ed195065cc6895f61b9d59bfa0a0536ed5ed51e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f87f6eeaf7..4f5008ed6f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4361,30 +4361,34 @@ static void gen_mtmsrd(DisasContext *ctx)
     CHK_SV;
 
 #if !defined(CONFIG_USER_ONLY)
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     if (ctx->opcode & 0x00010000) {
-        /* Special form that does not need any synchronisation */
+        /* L=1 form only updates EE and RI */
         TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
         tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
                         (1 << MSR_RI) | (1 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+        tcg_gen_andi_tl(t1, cpu_msr,
                         ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
-        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
+        tcg_gen_or_tl(t1, t1, t0);
+
+        gen_helper_store_msr(cpu_env, t1);
         tcg_temp_free(t0);
+        tcg_temp_free(t1);
+
     } else {
         /*
          * XXX: we need to update nip before the store if we enter
          *      power saving mode, we will exit the loop directly from
          *      ppc_store_msr
          */
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
         gen_update_nip(ctx, ctx->base.pc_next);
         gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
-        /* Must stop the translation as machine state (may have) changed */
-        /* Note that mtmsr is not always defined as context-synchronizing */
-        gen_stop_exception(ctx);
     }
+    /* Must stop the translation as machine state (may have) changed */
+    gen_stop_exception(ctx);
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
 #endif /* defined(TARGET_PPC64) */
@@ -4394,15 +4398,23 @@ static void gen_mtmsr(DisasContext *ctx)
     CHK_SV;
 
 #if !defined(CONFIG_USER_ONLY)
-   if (ctx->opcode & 0x00010000) {
-        /* Special form that does not need any synchronisation */
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    if (ctx->opcode & 0x00010000) {
+        /* L=1 form only updates EE and RI */
         TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
         tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
                         (1 << MSR_RI) | (1 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+        tcg_gen_andi_tl(t1, cpu_msr,
                         ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
-        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
+        tcg_gen_or_tl(t1, t1, t0);
+
+        gen_helper_store_msr(cpu_env, t1);
         tcg_temp_free(t0);
+        tcg_temp_free(t1);
+
     } else {
         TCGv msr = tcg_temp_new();
 
@@ -4411,9 +4423,6 @@ static void gen_mtmsr(DisasContext *ctx)
          *      power saving mode, we will exit the loop directly from
          *      ppc_store_msr
          */
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
         gen_update_nip(ctx, ctx->base.pc_next);
 #if defined(TARGET_PPC64)
         tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32);
@@ -4422,10 +4431,9 @@ static void gen_mtmsr(DisasContext *ctx)
 #endif
         gen_helper_store_msr(cpu_env, msr);
         tcg_temp_free(msr);
-        /* Must stop the translation as machine state (may have) changed */
-        /* Note that mtmsr is not always defined as context-synchronizing */
-        gen_stop_exception(ctx);
     }
+    /* Must stop the translation as machine state (may have) changed */
+    gen_stop_exception(ctx);
 #endif
 }
 
-- 
2.17.1


