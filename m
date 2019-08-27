Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38676C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DDC2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DK0AdDDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DDC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58587 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P3P-0001Dd-Kx
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1d-0007xR-LG
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1c-00073A-Fe
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1c-00072m-9i
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id v12so12862056pfn.10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vLDY87+4dPSAxr3X1xIFyg3m7CkymniXhiEOvq4Rpg0=;
 b=DK0AdDDqNIzB8O9xmKTgrzRTP2K2CqPoA0BhOzOvIA1wc4I71hpPETrf6DlzIYaclG
 +Zarkovx8Ci9ey347KJyEZ2bmf6uJjtQXLh43YMv8r4sspqAbaHMj8bkPmdRlRHZ59zc
 kTk12McuTpBVMVQ/T5Do0eBL9KhiwJX/sQmuUTimUMC+76ULjJtO21tlXxBBjQahEK+f
 wV0Gdcx/NxW325399jq7t6VAFJbU6Q6JVYQj8goCdKZEkyjvVvaaHKSsLAaMVFnn7NU4
 H/LjHnLvMs40qKHi17SZJLneciHfCrbNj2svkpeCzRoYZByI5LitzYYzo6bEuKwEH0p1
 561w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vLDY87+4dPSAxr3X1xIFyg3m7CkymniXhiEOvq4Rpg0=;
 b=A0rqG5gXOFU5XALNNlOxSM3b00G1cQCf90lb7H7awB4o7tgmF6lPoYupDb/xloSelM
 aPiFFgYCc2Xk1nhaz3kQbWzRopAn3q6EGj0+8q/wj5TIgReoIXXr83n79LfJV87UN7PH
 27QNxuQ7XnxUWQtWVDPbU1YiHDA0DCX1yF6Vcw0x6dykrNUFbdoRHQmsIOtatn8zsITI
 ShXPwMzvxzA0xiJfSZbKgiujWObNnAR1EpYbKQSgV5uZgA0oDrcPiDNpoY1EQjIFvaFa
 8ghvgri20Zleftrab+yyFxJW52tut7ZjfR3QWNx5CmpZdI2PFBJni8mbCXmy08ucDn0T
 NEwQ==
X-Gm-Message-State: APjAAAVQS+2kaePEqBdhJZWntJIdFx4hvaDkaash65q9bc7uaYqLI9JC
 VK79/vjXJqclMLy4rtFeWMovNfAUyA8=
X-Google-Smtp-Source: APXvYqxU9XTlpTanEuF6/L5Cb9keTFeTm6tMYF44lwBxSnSRNkelXh5cub+5mGlRvz1HSfNTcmMhAw==
X-Received: by 2002:a17:90a:21eb:: with SMTP id
 q98mr22021613pjc.23.1566864471072; 
 Mon, 26 Aug 2019 17:07:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:35 -0700
Message-Id: <20190827000745.19645-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 03/13] target/openrisc: Cache R0 in DisasContext
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finish the race condition fix from the previous patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 3812dc4427..37e8098023 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -48,6 +48,9 @@ typedef struct DisasContext {
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
     target_ulong jmp_pc_imm;
+
+    /* The temporary corresponding to register 0 for this compilation.  */
+    TCGv R0;
 } DisasContext;
 
 static inline bool is_user(DisasContext *dc)
@@ -64,7 +67,6 @@ static inline bool is_user(DisasContext *dc)
 
 static TCGv cpu_sr;
 static TCGv cpu_regs[32];
-static TCGv cpu_R0;
 static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_ppc;
@@ -122,7 +124,6 @@ void openrisc_translate_init(void)
                                                   shadow_gpr[0][i]),
                                          regnames[i]);
     }
-    cpu_R0 = cpu_regs[0];
 }
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
@@ -165,7 +166,11 @@ static void check_ov64s(DisasContext *dc)
 
 static TCGv cpu_R(DisasContext *dc, int reg)
 {
-    return cpu_regs[reg];
+    if (reg == 0) {
+        return dc->R0;
+    } else {
+        return cpu_regs[reg];
+    }
 }
 
 /*
@@ -175,7 +180,7 @@ static TCGv cpu_R(DisasContext *dc, int reg)
 static void check_r0_write(DisasContext *dc, int reg)
 {
     if (unlikely(reg == 0)) {
-        cpu_regs[0] = cpu_R0;
+        dc->R0 = cpu_regs[0];
     }
 }
 
@@ -747,7 +752,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
        to cpu_regs[0].  Since l.swa is quite often immediately followed by a
        branch, don't bother reallocating; finish the TB using the "real" R0.
        This also takes care of RB input across the branch.  */
-    cpu_regs[0] = cpu_R0;
+    dc->R0 = cpu_regs[0];
 
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
@@ -1292,9 +1297,9 @@ static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
     if (dc->tb_flags & TB_FLAGS_R0_0) {
-        cpu_regs[0] = tcg_const_tl(0);
+        dc->R0 = tcg_const_tl(0);
     } else {
-        cpu_regs[0] = cpu_R0;
+        dc->R0 = cpu_regs[0];
     }
 }
 
-- 
2.17.1


