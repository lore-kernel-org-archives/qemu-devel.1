Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C28C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45A1206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBzMqUp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45A1206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3TS-0005jb-Uv
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc3KY-0008HV-Fr; Mon, 09 Nov 2020 04:19:18 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kc3KW-00025j-QZ; Mon, 09 Nov 2020 04:19:18 -0500
Received: by mail-wr1-x443.google.com with SMTP id 23so7850900wrc.8;
 Mon, 09 Nov 2020 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iTiADtzI1Ftk0B1v8MF4qtQoR0XvSWJKuD44qK/1Dzc=;
 b=PBzMqUp3IALB0NU725s5lLyCt14IZH9NLDREt49rp/wascodk3g914aNFf3EQLgtT3
 1WBQ2UKNrjfkqivC43xgy9jSokEmmqs6PriGx2ZvcEeNTeeSmKueySKIFho2Nd4ESVBP
 exf812UaslLCEnjwXBWIL8FAjb9SQ4CuBNeLZpzvsCn9Yk+c7KUpd8Pd61cFye2Qqaz5
 Oi2ZdP8xLRGaJGwGZR+AdHfB+18bKRvYfZivM4Qyg6EHAI84N8yNw96s5eDyGThqVE3X
 wAlG9Usc8ZgIDkFaG3V07/u3+lRkWu0DPUwLf7uYggRwbKDpa1ixPTDe55KO/dZOZ/2F
 7WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iTiADtzI1Ftk0B1v8MF4qtQoR0XvSWJKuD44qK/1Dzc=;
 b=UOWVOXRGlJvt9YxMxevFjDUDx2sYel2GbjjDEF4BXVYJCCmXaRIXU96dsjnKtnyttN
 cd0AcV4Kf65iBCBlWtWPmiI1IXyafXBUp8bhocVAst8e2d1wsISQsnvmTRsNoQKBocRd
 KOHYTMdX8Xs2z+O+oGYhLOdiDq0uKDceS4hMHOwtfioUqayEgbCFaPkTPPTZujbPSIth
 YHbVj8lR9F7mACINW68LZeuG8NXIRINjhEAE21olK6PAtNXlZLpBVCJXPkzryL6pPi/W
 LdpUraqbmTBj5ZPEtula+q2qi4iE8VYHV0ZmDwi0wR1om+0/DprxEQ21eC5gjTs/Qpln
 Ri+A==
X-Gm-Message-State: AOAM533Lz5OjA2KJwA0xY0V547i7hXwY6EtmsTtAA5UhGEKU3esVMIDL
 PlL197BmCLWZKVG0Cm4Mdo6thogSBK0Jkw==
X-Google-Smtp-Source: ABdhPJypbaxr2dveZamltWm5u6ainBcBOwSvRkpQdr0zAVda8BqN+1lq1jRNQBUX3t6PzV0OEHkFzA==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr17301854wrl.101.1604913554899; 
 Mon, 09 Nov 2020 01:19:14 -0800 (PST)
Received: from localhost.localdomain ([151.33.227.77])
 by smtp.gmail.com with ESMTPSA id o17sm12281612wmd.34.2020.11.09.01.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:19:14 -0800 (PST)
From: LemonBoy <thatlemon@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] ppc/translate: Rewrite gen_lxvdsx to use gvec primitives
Date: Mon,  9 Nov 2020 10:17:11 +0100
Message-Id: <a463dea379da4cb3a22de49c678932f74fb15dd7.1604912739.git.thatlemon@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
References: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=thatlemon@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the implementation match the lxvwsx one.
The code is now shorter smaller and potentially faster as the
translation will use the host SIMD capabilities if available.

No functional change.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
---
 target/ppc/translate/vsx-impl.c.inc | 46 ++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 075f063e98..b817d31260 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -75,29 +75,6 @@ static void gen_lxvd2x(DisasContext *ctx)
     tcg_temp_free_i64(t0);
 }
 
-static void gen_lxvdsx(DisasContext *ctx)
-{
-    TCGv EA;
-    TCGv_i64 t0;
-    TCGv_i64 t1;
-    if (unlikely(!ctx->vsx_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VSXU);
-        return;
-    }
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    gen_set_access_type(ctx, ACCESS_INT);
-    EA = tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-    gen_qemu_ld64_i64(ctx, t0, EA);
-    set_cpu_vsrh(xT(ctx->opcode), t0);
-    tcg_gen_mov_i64(t1, t0);
-    set_cpu_vsrl(xT(ctx->opcode), t1);
-    tcg_temp_free(EA);
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
-}
-
 static void gen_lxvw4x(DisasContext *ctx)
 {
     TCGv EA;
@@ -169,6 +146,29 @@ static void gen_lxvwsx(DisasContext *ctx)
     tcg_temp_free_i32(data);
 }
 
+static void gen_lxvdsx(DisasContext *ctx)
+{
+    TCGv EA;
+    TCGv_i64 data;
+
+    if (unlikely(!ctx->vsx_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_VSXU);
+        return;
+    }
+
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = tcg_temp_new();
+
+    gen_addr_reg_index(ctx, EA);
+
+    data = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(data, EA, ctx->mem_idx, MO_TEQ);
+    tcg_gen_gvec_dup_i64(MO_Q, vsr_full_offset(xT(ctx->opcode)), 16, 16, data);
+
+    tcg_temp_free(EA);
+    tcg_temp_free_i64(data);
+}
+
 static void gen_bswap16x8(TCGv_i64 outh, TCGv_i64 outl,
                           TCGv_i64 inh, TCGv_i64 inl)
 {
-- 
2.27.0


