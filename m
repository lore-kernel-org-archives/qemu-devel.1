Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A649C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFAF20679
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i4Ipab4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFAF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLri-0006yS-6w
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzn-00089e-QM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:51276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzk-0002V0-KX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id l18so48985pjz.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pvN8Om/RgBOsGrGBRFmFDJLUCxKzek2s7iLbr+SMo5Q=;
 b=i4Ipab4//u63l2OOiskP/9LaE4srJBFX7SM7OP+G7f872nADh6wrasqsWgzPOPjgwt
 o5ZWi4D8p7Kc/J48B8rjaJi/574gdUuqNtB0GWudPLUKunLUYJqXeTRBwN/e3GicU/U3
 lQDmkeDirak7USEHmqoJut/Wpwj9aRuXxHxh5kMaehQzNEgS7bUg+KdufrxB+bljamKV
 LgAaXFcvqyqPlMYz/cXbElZ+Ra6lSRexGB9TDk7dTlBznOhmMobMpy+ihwVwMMgIxTYS
 x2vk/cc5b9n8Yk+kSdEJNaHWPNxHd2f7Qj06cui87X6Zi+4/qNfr96c0HcqFBW7fE2Pi
 VCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pvN8Om/RgBOsGrGBRFmFDJLUCxKzek2s7iLbr+SMo5Q=;
 b=eWw3F4VcvHRj69VTgUHElo15dDRSr6zm8gfqJeoPlt4FeLLh8S+wxYfbOhfAkKzpAs
 fLgPWgARrORb1/qRGuqeaTGQ/gCmBgEO4eAKNazw3brtk2YFdiU7lMQBbul5s2uUXe10
 DW9tOOaC36rFhufoqdlgr5JTxINv6V7c5eeLeb7sCjj7y6Svxsqdj6FqN7gg14zZSH/C
 dQDHqq4XNkWn7+8bDiKebFeUYqckjnBmuyF/ZqfY/aOw2YEe0TYjWh/8WBJVwEP/eG5M
 +ev51r771Ec9TrrVT7pJ5Xjicg3n3fqlmNERAOeJkqsEu6gfjmI0hlAqs9sxqFKdfrm5
 /Y/A==
X-Gm-Message-State: AOAM533ZUlY3usmZ9YGfUL5Dn8ytpF1eKrOIFMfXa4lfr9ZUPPuITNEv
 PKZTG9xQxRi3jyydi4TqWzJs24aCNdCeRw==
X-Google-Smtp-Source: ABdhPJwwtZsoMhoLCFTRbjPDnhbOR+hd+3qNU+tpfsrb2oZlNVqEBZgGK5z1HdFIra4Gaq46V37R4g==
X-Received: by 2002:a17:90a:4b0e:: with SMTP id
 g14mr2317124pjh.140.1601406539237; 
 Tue, 29 Sep 2020 12:08:59 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:58 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 62/68] target/riscv: add "set round to odd" rounding mode
 helper function
Date: Wed, 30 Sep 2020 03:04:37 +0800
Message-Id: <20200929190448.31116-63-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 3850146fec..b37e1d08a2 100644
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
index 2a31c7bba1..32edc77858 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -3,6 +3,7 @@ DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
 /* Floating Point - rounding mode */
 DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_1(set_rod_rounding_mode, TCG_CALL_NO_WG, void, env)
 
 /* Floating Point - fused */
 DEF_HELPER_FLAGS_4(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 55bcd84e39..f0705a796b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -39,6 +39,7 @@ enum {
     RISCV_FRM_RUP = 3,  /* Round Up */
     RISCV_FRM_RMM = 4,  /* Round to Nearest, ties to Max Magnitude */
     RISCV_FRM_DYN = 7,  /* Dynamic rounding mode */
+    RISCV_FRM_ROD = 8,  /* Round to Odd */
 };
 
 static inline uint64_t nanbox_s(float32 f)
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2d12b8adc4..e6f4a662f5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -30,6 +30,7 @@
 #include "exec/log.h"
 
 #include "instmap.h"
+#include "internals.h"
 
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_pc, cpu_vl;
@@ -583,6 +584,10 @@ static void gen_set_rm(DisasContext *ctx, int rm)
         return;
     }
     ctx->frm = rm;
+    if (rm == RISCV_FRM_ROD) {
+        gen_helper_set_rod_rounding_mode(cpu_env);
+        return;
+    }
     t0 = tcg_const_i32(rm);
     gen_helper_set_rounding_mode(cpu_env, t0);
     tcg_temp_free_i32(t0);
-- 
2.17.1


