Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27AFC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6FA22BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Buc8ocpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6FA22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Yw-0002YY-22
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nw-0007Uk-85
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ns-0001KU-6G
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nr-0001DD-UO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:00 -0400
Received: by mail-pl1-x644.google.com with SMTP id az7so25002530plb.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ggteB4WINk5mb6nMpXwNHzA9GUmr46ovcnkhvcdKD8k=;
 b=Buc8ocppTVZ8/0vu8O9BFAEvpnSUEBT08+KVgqmbrllPtLH1/hU4ckz56I+Esxjxzg
 ZrY1cZ1dtZy+SNx4EIMeD9lCtj7pi6eEXSm9O+X2OdhOjDeuUhzON26nzdm9Rc6fc95t
 DzB2/sDs4SW116bRspRHF8ezfsdjhAckAJC222a692ZTS6IFWNGQPra2PNGMlA3oFfrE
 5RNSApyaWBqw0+1W4FdTGMB3cFgqvYt4K+E2C/l0Uyc3H8cSgo7tJ0eViMPMpnn02Ads
 E8jR2HBPTkhA9hF2NJKgf5tUeaIBNEWROJBIjaeVtcaEQblh7lnmyCmiIBbgrcwpUYLY
 /sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ggteB4WINk5mb6nMpXwNHzA9GUmr46ovcnkhvcdKD8k=;
 b=EP6PvzJTwbygR8uGcGtOI01It01iQFPKiNQcprJguYStCtIiI+uAXEKr/Mq4BuBzYr
 r2vrKExc3lf1sQ/rP7gsV7tUmaxfD0PLiTyLnzJsu8jBUd6ON9Qh30rzc51mvLY0euxC
 rOSge61jlqTjz/jlB0fapB0+z0bt6dbVv6Rh/wmmp+wbyhUkHqf1gVKeHjMWvjTSihau
 PxcuWwh9ZBKc8ekKv5npUPnD+pUaSj8SWIgDlKUWMoIWVs7pA3GcwHF3/Nec6gnUH11y
 d/Q4i/awra12Ry5MZxZ9HMMif/+NSuKK2h7rBEcgwuHag8qmehD9R3t6QqUm6Lntv3dh
 cMkA==
X-Gm-Message-State: APjAAAVrKIwxEn5+5biYy0d8/I7DMtrgX/BUJ3KpChhWpYJOueN2bFrw
 3qfoL1q4tEhIoObUVqLcFOySR+L5m2g=
X-Google-Smtp-Source: APXvYqxuycKcD2FE60LO3agy4DSjcMsPKKJxoGOhSLIoE3Vn4TsB83lS1Pq1v6ttohtpFsLKbFcXeg==
X-Received: by 2002:a17:902:bd94:: with SMTP id
 q20mr87126516pls.307.1564163513826; 
 Fri, 26 Jul 2019 10:51:53 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:32 -0700
Message-Id: <20190726175032.6769-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 67/67] target/arm: Merge gen_bx_im into
 trans_BLX_i
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the only remaining use of gen_bx_im.  Simplify, since we know
the destination mode is changing.  Use gen_jmp for the actual branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9ae9b23823..dc51e1e622 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -813,21 +813,6 @@ static inline void gen_set_pc_im(DisasContext *s, target_ulong val)
     tcg_gen_movi_i32(cpu_R[15], val);
 }
 
-/* Set PC and Thumb state from an immediate address.  */
-static inline void gen_bx_im(DisasContext *s, uint32_t addr)
-{
-    TCGv_i32 tmp;
-
-    s->base.is_jmp = DISAS_JUMP;
-    if (s->thumb != (addr & 1)) {
-        tmp = tcg_temp_new_i32();
-        tcg_gen_movi_i32(tmp, addr & 1);
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUARMState, thumb));
-        tcg_temp_free_i32(tmp);
-    }
-    tcg_gen_movi_i32(cpu_R[15], addr & ~1);
-}
-
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
@@ -10042,12 +10027,18 @@ static bool trans_BL(DisasContext *s, arg_i *a)
 
 static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
+    TCGv_i32 tmp;
+
     /* For A32, ARCH(5) is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
     }
     tcg_gen_movi_i32(cpu_R[14], s->pc | s->thumb);
-    gen_bx_im(s, (s->pc_read & ~3) + a->imm + !s->thumb);
+    tmp = tcg_temp_new_i32();
+    tcg_gen_movi_i32(tmp, !s->thumb);
+    tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUARMState, thumb));
+    tcg_temp_free_i32(tmp);
+    gen_jmp(s, (s->pc_read & ~3) + a->imm);
     return true;
 }
 
-- 
2.17.1


