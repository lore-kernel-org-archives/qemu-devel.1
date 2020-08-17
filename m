Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB6C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBED2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LY2ujubw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBED2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bJh-0007xZ-5D
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atD-0002z9-VO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:39883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atA-0005MC-6R
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id g15so3268535plj.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xGiyjyhu0nBd1anJrEX8GtzAAQHyOT3gqdtC5FRFmdA=;
 b=LY2ujubwTGqv6Si57rnbgogt6r6s8XHUY4/70Iw1ypKPpXm+nwH1pmslME5u9MkogN
 RZ1Lp35mvt8kawSFdVLSlncHVDrPkgtbVXkAsUXJYZ2xmj2KDg6lXikVcV7DVLK4wTfA
 23/F//CjoHdg+5P943OslCcOPk4ofsT5kUfufpLIbnOdLN22N2O6HkClN131lo8HuZ0H
 arxAlPVf2BHT642BR/PHL9qT6j8eTU86DWiy7GGOO5sWZBfiEMT7NQDLPwHrb14de/l6
 5zBS+BsmeUjxpjLd/6u7313v9yJR2+4mpA2zwTLuPn39o8UmNA1cH588pu21QOHdXM3J
 RqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xGiyjyhu0nBd1anJrEX8GtzAAQHyOT3gqdtC5FRFmdA=;
 b=AmuHD5a3cAy1KQvChFvS89FZviGBmyBvKQNV+4gm7OYSJSdcIsZ2zVoD5sFDdNheFK
 JqKn37cmaBlZ48L1XUuiBQtw5YVDQnv+9GJMuXJ4CJxoKJgXmhyOgjx+SOWzglgL7vRA
 JjtGli/N3YiHaf3OUXM+WYp4UWNVlxa2Z3dYicCb8ZC5pfKV00hjoB+/NIuP4/Vov1E6
 zoh4rZ+huSlPCbfPAyL00kUwLX6lrbGHykK18irG4lwSAJp9LfBlrSQE1g4ymX4l7fh8
 3/ndJ6VeM6IpGwslgc6b6OhJSuN03nnplyBzwRfNONNXXgVJssfnb2TjdJmeQitqRuvl
 bL9A==
X-Gm-Message-State: AOAM530NP7KAl19MRdaUSDOnsBVlBkYmrJ/K0MFfmqDWGPPDBXWHVubg
 5S9qBrqRb+IFne7V4mTHmRN1fC5FdZZbEQ==
X-Google-Smtp-Source: ABdhPJyiEb1X0FEA7FrcIcZERzjPZYngOOZR47Y/RysMhvXDT4a9SV3ZfmqnKR3DhKoeWjSN7hdiPg==
X-Received: by 2002:a17:902:a714:: with SMTP id
 w20mr10300345plq.8.1597654386785; 
 Mon, 17 Aug 2020 01:53:06 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:53:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 65/70] target/riscv: add "set round to odd" rounding mode
 helper function
Date: Mon, 17 Aug 2020 16:49:50 +0800
Message-Id: <20200817084955.28793-66-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

helper_set_rounding_mode() is responsible for SIGILL, and "round to odd"
should be an interface private to translation, so add a new independent
helper_set_rod_rounding_mode().

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/fpu_helper.c | 5 +++++
 target/riscv/helper.h     | 1 +
 target/riscv/internals.h  | 1 +
 target/riscv/translate.c  | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 92e076c6ed8..a01b8eab0b3 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -81,6 +81,11 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
+void helper_set_rod_rounding_mode(CPURISCVState *env)
+{
+    set_float_rounding_mode(float_round_to_odd, &env->fp_status);
+}
+
 static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
                            uint64_t rs3, int flags)
 {
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7539b4a5004..b128610978d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -3,6 +3,7 @@ DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
 /* Floating Point - rounding mode */
 DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_1(set_rod_rounding_mode, TCG_CALL_NO_WG, void, env)
 
 /* Floating Point - fused */
 DEF_HELPER_FLAGS_4(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index d9ea6a32188..20fb6f2cb7e 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -44,6 +44,7 @@ enum {
     FRM_RUP = 3,    /* Round Up */
     FRM_RMM = 4,    /* Round to Nearest, ties to Max Magnitude */
     FRM_DYN = 7,    /* Dynamic rounding mode */
+    FRM_ROD = 8,    /* Round to Odd */
 };
 
 static inline uint64_t nanbox_s(float32 f)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5817e9344e9..9ae331cbc1a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -30,6 +30,7 @@
 #include "exec/log.h"
 
 #include "instmap.h"
+#include "internals.h"
 
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
@@ -584,6 +585,10 @@ static void gen_set_rm(DisasContext *ctx, int rm)
         return;
     }
     ctx->frm = rm;
+    if (rm == FRM_ROD) {
+        gen_helper_set_rod_rounding_mode(cpu_env);
+        return;
+    }
     t0 = tcg_const_i32(rm);
     gen_helper_set_rounding_mode(cpu_env, t0);
     tcg_temp_free_i32(t0);
-- 
2.17.1


