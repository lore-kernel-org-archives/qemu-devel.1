Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77625C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D032072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtJuCvqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D032072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isGqB-0006Gg-8C
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 20:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isGpK-0005Xv-BB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isGpI-0004J8-T2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:53:33 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isGpI-0004BX-Kv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:53:32 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so10832098pgk.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 17:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/EsorkHRm7Bz/pt7Kle3XIoArmCPqgMmJgpsAFq7nlw=;
 b=LtJuCvqYKn2KBKgKAJCB286fzZdQ5RqhnmE8uuLn41dmZcmaaHx/jCeY+OCKPUx4Lx
 2Ahf+YiWCrbBOt+3Yuwj4Tq5AO/9aaNb7b4Gtq1nWn9Sc1huiWhKYq4IRn4CWj4TSH18
 pTakbgInozuXEyx1xZzPlNxzi/gTVD3E47Zgy/7ObAoh1v0zD1DoDgkXJ04VxgCsRuTG
 MPNXoUOMxFAm7UJnYVHZCtJPjKYvzc76JpDbMMp56wll1OTWaKk69zYOSrhmYq58Dx93
 4ds+O+0Dut+c0l4YwBZ5szQ2FsJlW/AtUGXrvB7g9yw40KEJ0adIiiqzx3Ql7hqymHrp
 nQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/EsorkHRm7Bz/pt7Kle3XIoArmCPqgMmJgpsAFq7nlw=;
 b=QMeI4eL23YuWkJOpSIB+wCkb7q72zuxQCFqKkuwtV1scbY0am1+bI4IjoEXPc6g1Vf
 kelv8jIXf6UfNCUY/Uny/CQZZiSuIna2bS1eRwzORNii6MdZ0nkoajdOUw0eHFHXqnx6
 dH0FuAs0lnSZHsH4B0CXQ/eBykfY4+f1eEVgvtdpCt885QyD+ZUwT5Mihs45YVQ+leuX
 9ErWU8AypLfUbEu48jqnqh4sHtVCl+aossehEttnxMD46pAo91eEcIjgR2i98R46vQ3i
 29pUuKtCfyJZejx7Hn89cQ0qSz7eMGirdwHz3QRao6UvwT5vbXS+0Hh7Y5PI0i8oGihy
 Jbbg==
X-Gm-Message-State: APjAAAVtRJLWEmCPBEDhYuXZVzBwkC5dVRxbQamATqqxOxREPKAzllfV
 8LKiIucgQSIJzX2etHGI6V5R9TLJyk8=
X-Google-Smtp-Source: APXvYqzbSZ6zgT4zo2OmqOQVZnsqZIds+2VtgeqTYnUNGl39mtVBfW6wWxrD4zC8IvRhoVwquKuk2Q==
X-Received: by 2002:a63:289:: with SMTP id 131mr43227717pgc.149.1579226007350; 
 Thu, 16 Jan 2020 17:53:27 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id b22sm26385424pft.110.2020.01.16.17.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 17:53:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
Date: Thu, 16 Jan 2020 15:53:22 -1000
Message-Id: <20200117015322.12953-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: deller@gmx.de, dave.anglin@bell.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
or the operation is undefined.  However, real hardware only generates
an unaligned access trap for unaligned mod 4.

Match real hardware, but diagnose with GUEST_ERROR a violation of the
specification.

Reported-by: Helge Deller <deller@gmx.de>
Suggested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Helge, can you please test this against your failing kernel?
You will of course want to add -D logfile -d guest_errors to
you qemu command-line.


r~

---
 target/hppa/helper.h    | 2 ++
 target/hppa/op_helper.c | 9 +++++++++
 target/hppa/translate.c | 6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 38d834ef6b..2d483aab58 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
+DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
+
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f0516e81f1..345cef2c08 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -153,6 +153,15 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_e(env, addr, val, true, GETPC());
 }
 
+void HELPER(ldc_check)(target_ulong addr)
+{
+    if (unlikely(addr & 0xf)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Undefined ldc to address unaligned mod 16: "
+                      TARGET_FMT_lx "\n", addr);
+    }
+}
+
 target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
                           uint32_t level, uint32_t want)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2f8d407a82..669381dc1d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2942,7 +2942,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    MemOp mop = MO_TEUL | MO_ALIGN_16 | a->size;
+    MemOp mop = MO_TE | MO_ALIGN | a->size;
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;
 
@@ -2958,8 +2958,12 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 
     form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
              a->disp, a->sp, a->m, ctx->mmu_idx == MMU_PHYS_IDX);
+
+    gen_helper_ldc_check(addr);
     zero = tcg_const_reg(0);
     tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
+    tcg_temp_free(zero);
+
     if (a->m) {
         save_gpr(ctx, a->b, ofs);
     }
-- 
2.20.1


