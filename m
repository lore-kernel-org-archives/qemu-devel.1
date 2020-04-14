Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39143C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4E32072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyIzmXDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4E32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJW2-0001uv-6f
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jOJVM-00019e-6M
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jOJVK-0001mm-79
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:13:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jOJVJ-0001l9-VG; Tue, 14 Apr 2020 07:13:22 -0400
Received: by mail-pl1-x641.google.com with SMTP id m16so4537400pls.4;
 Tue, 14 Apr 2020 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JN1UqE6+YpRxsawyrbRFyMn4vRzqFqThSa1A+kyrG+o=;
 b=IyIzmXDDnIi8UmpT6LSqcb6LiMSqzFsL/KxsBAsf0ptE9J9EFJKXnl49SjFGxriGVX
 tjLvXFkdCX0wnI7fe5Gq7UdrG1C19jQDTSqZ6OTlwdxzEkJNPn++LwZKx2Q1vdqdj6d/
 Zy10RKLKk1fKZav9BFvB04dn9AbEROTxP5B5tnNTKZiiIHNZeSFww80O2/Hgy2p4xmFP
 ipb6JDktNwZmlIvdmsW3HUC8gCb2NDSjyKlqB1EvEq9oTPyrwSgKd0g6HrbXC4v8wSD9
 DlUXJmBp8qrCL6ekQqtbG6x6StQTqfPh8shx1qjl4fFLyQp3hUu1uCOMSkmAEA+cneLz
 UbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JN1UqE6+YpRxsawyrbRFyMn4vRzqFqThSa1A+kyrG+o=;
 b=oybOfjfpUgOha39l5gltL3a79atqRgvl+Axhe6yg0HaKtZQ1DVbfYbjDp4mNtctFnx
 NAT5Vu2pcNris5F0Xks7T0Krp2y0ATRE09F0Vm3gQsrxTsHHEkWb0OPSt7bGyaOqTk31
 Ri+NzOAGrXCzqCq0lUkQbOrR/v3A15W5V044KntY4Kw9YZnC/hQssGEp6qA3PxTgSm/w
 SKNn5m/BNBNi9entH02zf9rSdFXghw6NjP7GQ8GCh2aLOLiwhGoRlUvdbpQcsO9sdPyV
 6DFhvJLwZmDcP9rNbc3faiOPwvD7EjQLPxLKq4xE2oug7N2uMyXnBimjluBgkRRRw6Y3
 sFVA==
X-Gm-Message-State: AGi0PuanuRiB4jSi1ccHqFComgFP7GdM7GGYm6UXgmK6NOawe9cKXwGD
 mMFvylxkbCX4YdpiuxGzWmEwazKQirk=
X-Google-Smtp-Source: APiQypJTyy97hXUH7vlb5EFbV8+CT0KEr49ENndCyCV/dlGiTpAT+FRcLAr9xHW/+45J/ZQYta41kg==
X-Received: by 2002:a17:90a:d596:: with SMTP id
 v22mr26475077pju.169.1586862800008; 
 Tue, 14 Apr 2020 04:13:20 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.18.28.220])
 by smtp.gmail.com with ESMTPSA id u44sm10311030pgn.81.2020.04.14.04.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 04:13:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts
Date: Tue, 14 Apr 2020 21:11:31 +1000
Message-Id: <20200414111131.465560-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
Thanks very much to Nathan for reporting and testing it, I added his
Tested-by tag despite a more polished patch, as the the basics are 
still the same (and still fixes his test case here).

This bug possibly goes back to early v2.04 / mtmsrd L=1 support around
2007, and the code has been changed several times since then so may
require some backporting.

32-bit / mtmsr untested at the moment, I don't have an environment
handy.

 target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b207fb5386..9959259dba 100644
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
2.23.0


