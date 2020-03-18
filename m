Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C7C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8AA20768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4vuX6uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8AA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEQYj-0001ir-S1
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 00:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jEQXz-0000kt-JF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jEQXy-00054L-9Y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:43:15 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:53219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jEQXt-0004nK-UR; Wed, 18 Mar 2020 00:43:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id ng8so770178pjb.2;
 Tue, 17 Mar 2020 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lTa9s69zsSSP7eKn2sDXJ96v9u0GvLRbRyFh6bHh4rY=;
 b=t4vuX6uID88rpnei+OS2nSfNaEHv/xNVFa8WnTs06NZ++gE5uglxYS9EuCSF6zyFPk
 FL2Omubr6+6e8H6Sg7EzSmAuaf0nwGkBn8BCmojy3JS32zfzQ/p6Zwe/qIwweqZPk62s
 fr7XaytiTk/En4wTl4bDoKo2f5tCknLdeajA7R1sIEsTHm1NQIJBPmsYuyHKDn8E9Qva
 4jrHgc459wcGHJrLF3cWnAe0MWsI8viDSI9hYOLAasuYRRTEG5EpF3MEFqZ/MCn70IfZ
 LQRHmOSus1irlFZP9VjCwq3W109nFQ8kPd3UCgCr+rORrhFhpfvqlcVBpGLjLyXx3Hr1
 Us9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lTa9s69zsSSP7eKn2sDXJ96v9u0GvLRbRyFh6bHh4rY=;
 b=E/iJy3xL/CjsCvlAZW1qJu1BFGBEU8EqZ4Im8ot9WhGcceqfi2smnAX2GiCj9y4Ka3
 DvFPhu+mgeQrjtzk7c2jUR/gkeMpl53C71u8JwLIAp1n6Hsdkww54xyrReYf07E/PA0L
 zDuEn+/cwIH99lmbsFi3TpezM+lvTz4Ot0oMJuG4BwRYBqK2Munn/RuYC8iNipyzuAAG
 qjOyOOFDfpI5qmQOQ8TBnhYTS4b6aUHkiGXHgSgtVEOz0TR0A7m39zMT15yCn9JpQGyV
 CDJW6qLihTTh4XdpZi9btwIaBJJTxzN+LA9kXG/hBPpnlCjbcxZrim8VvUwuomQGZLa1
 SlFA==
X-Gm-Message-State: ANhLgQ1Qj/KyEM8y/0xjTcpznP0DFyk+ZHdw+rcIIQ7jW9O9/dLJhSl2
 pasWr049F22hKPHX/GLL2MzYszXO
X-Google-Smtp-Source: ADFU+vsyrsUibOc/WxGANPC84nJaNqfGE39BL7SPhHaWcAzmxtYfDTqT4WTwbKqf+rzAPqlmfjCcqw==
X-Received: by 2002:a17:902:b193:: with SMTP id
 s19mr2160836plr.130.1584506588616; 
 Tue, 17 Mar 2020 21:43:08 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id e28sm4192629pgn.21.2020.03.17.21.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 21:43:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH 2/2] target/ppc: Fix ISA v3.0 (POWER9) slbia implementation
Date: Wed, 18 Mar 2020 14:41:35 +1000
Message-Id: <20200318044135.851716-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200318044135.851716-1-npiggin@gmail.com>
References: <20200318044135.851716-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1036
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux using the hash MMU ("disable_radix" command line) on a POWER9
machine quickly hits translation bugs due to using v3.0 slbia
features that are not implemented in TCG. Add them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h     |  2 +-
 target/ppc/mmu-hash64.c | 57 ++++++++++++++++++++++++++++++++++++-----
 target/ppc/translate.c  |  5 +++-
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ee1498050d..2dfa1c6942 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -615,7 +615,7 @@ DEF_HELPER_FLAGS_3(store_slb, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_2(load_slb_esid, tl, env, tl)
 DEF_HELPER_2(load_slb_vsid, tl, env, tl)
 DEF_HELPER_2(find_slb_vsid, tl, env, tl)
-DEF_HELPER_FLAGS_1(slbia, TCG_CALL_NO_RWG, void, env)
+DEF_HELPER_FLAGS_2(slbia, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(slbie, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(slbieg, TCG_CALL_NO_RWG, void, env, tl)
 #endif
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 373d44de74..deb1c13a66 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -95,9 +95,10 @@ void dump_slb(PowerPCCPU *cpu)
     }
 }
 
-void helper_slbia(CPUPPCState *env)
+void helper_slbia(CPUPPCState *env, uint32_t ih)
 {
     PowerPCCPU *cpu = env_archcpu(env);
+    int starting_entry;
     int n;
 
     /*
@@ -111,18 +112,59 @@ void helper_slbia(CPUPPCState *env)
      * expected that slbmte is more common than slbia, and slbia is usually
      * going to evict valid SLB entries, so that tradeoff is unlikely to be a
      * good one.
+     *
+     * ISA v2.05 introduced IH field with values 0,1,2,6. These all invalidate
+     * the same SLB entries (everything but entry 0), but differ in what
+     * "lookaside information" is invalidated. TCG can ignore this and flush
+     * everything.
+     *
+     * ISA v3.0 introduced additional values 3,4,7, which change what SLBs are
+     * invalidated.
      */
 
-    /* XXX: Warning: slbia never invalidates the first segment */
-    for (n = 1; n < cpu->hash64_opts->slb_size; n++) {
-        ppc_slb_t *slb = &env->slb[n];
+    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+
+    starting_entry = 1; /* default for IH=0,1,2,6 */
+
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        switch (ih) {
+        case 0x7:
+            /* invalidate no SLBs, but all lookaside information */
+            return;
 
-        if (slb->esid & SLB_ESID_V) {
-            slb->esid &= ~SLB_ESID_V;
+        case 0x3:
+        case 0x4:
+            /* also considers SLB entry 0 */
+            starting_entry = 0;
+            break;
+
+        case 0x5:
+            /* treat undefined values as ih==0, and warn */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "slbia undefined IH field %u.\n", ih);
+            break;
+
+        default:
+            /* 0,1,2,6 */
+            break;
         }
     }
 
-    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
+    for (n = starting_entry; n < cpu->hash64_opts->slb_size; n++) {
+        ppc_slb_t *slb = &env->slb[n];
+
+        if (!(slb->esid & SLB_ESID_V)) {
+            continue;
+        }
+        if (env->mmu_model == POWERPC_MMU_3_00) {
+            if (ih == 0x3 && (slb->vsid & SLB_VSID_C) == 0) {
+                /* preserves entries with a class value of 0 */
+                continue;
+            }
+        }
+
+        slb->esid &= ~SLB_ESID_V;
+    }
 }
 
 static void __helper_slbie(CPUPPCState *env, target_ulong addr,
@@ -136,6 +178,7 @@ static void __helper_slbie(CPUPPCState *env, target_ulong addr,
         return;
     }
 
+    env->tlb_need_flush |= TLB_NEED_LOCAL_FLUSH;
     if (slb->esid & SLB_ESID_V) {
         slb->esid &= ~SLB_ESID_V;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index eb0ddba850..e514732a09 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5027,12 +5027,15 @@ static void gen_tlbsync(DisasContext *ctx)
 /* slbia */
 static void gen_slbia(DisasContext *ctx)
 {
+    uint32_t ih = (ctx->opcode >> 21) & 0x7;
+    TCGv_i32 t0 = tcg_const_i32(ih);
+
 #if defined(CONFIG_USER_ONLY)
     GEN_PRIV;
 #else
     CHK_SV;
 
-    gen_helper_slbia(cpu_env);
+    gen_helper_slbia(cpu_env, t0);
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-- 
2.23.0


