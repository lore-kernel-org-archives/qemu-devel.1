Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E57C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B8D20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWxvfLJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B8D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfcI-0007pm-Vp
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFD-0001bm-3r
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:43 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFA-0005IR-OL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id 10so524337plg.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R2cuEf3Qt/jcGcIZclz+3Hjy1ReL2CdcRjCqzKw0P3k=;
 b=vWxvfLJxBpRPSsuqGep2SiXPgGL6pOvxL7YlkQ0SZRuQ4m6u9+R1TQQOwbWCurhaVx
 8fetg63TUXNpY5LUR3Z6uo4UKuCv462o5Kbl7iSkhFNUDaRIxioscXPO5cV1d2qUNfRX
 MQmdSzhGa8gttSFQF06xXqGXqS49hcx7zjEyiYyIgIsa0oZmDOBkWIShyGGDp2RuJJKN
 Q07nD7VZtcW93bX/MHO4Rpapeu0WCDtPf1ejadxvjdw5vLpX+V3hL3+r1k/rL7ztT6Na
 hxs29deB5LkyH6NF5ETtqTVqPdTdlTk4z1IDBPGWIZ25VlwBvOx3vBFSNpofecoCGUeG
 pHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R2cuEf3Qt/jcGcIZclz+3Hjy1ReL2CdcRjCqzKw0P3k=;
 b=NjfvwEgAXtTw0tXLAufKX8s+B9o+pJ6DOgenRjO4HWGNmbJVzg2sJwsKv5HwqT/P4l
 8YF8EXkvjzFReO4Yvg2uU2juzYtkzL8y9d8J/mDqJBYJpK93F8NoCe/5U9/eACoGmAkT
 QKGd8dudfOAs1YH2Ag1zPmc4psDzb5aJGEiFzaQXrfabd0OcZYPrbZYmObhVFH0zSbjJ
 67Y7esgkcToSVtroImx32TD22uikXPHo2h3U9zm0Al1GsIoTJh9ZHVdc+b89z5Dcd75R
 FFMKmM+IvscOK96o/tmPPapTIb6BX13HPHy3UhMsnRJDIEMhCagaPqG9Zn2luxWeOjet
 zcRQ==
X-Gm-Message-State: AOAM532Sy0IRFJkD/vwkwbiOIOug/KYpgnog8hhkxL3VdgaV0zPTXRNo
 SPDP/LlUj5sILD1SRIIKWsNtaCjhVF9WHQ==
X-Google-Smtp-Source: ABdhPJyMx1j+0htr3/y3SeYDDotgr0E2Ub2rqIwRGfWNNSmF59ahCdY1kB/qNBEU1n5/d+hmK4dW3Q==
X-Received: by 2002:a17:90b:4c46:: with SMTP id
 np6mr1434791pjb.201.1598624437388; 
 Fri, 28 Aug 2020 07:20:37 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 52/76] target/microblaze: Fix cpu unwind for stackprot
Date: Fri, 28 Aug 2020 07:19:05 -0700
Message-Id: <20200828141929.77854-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restore the correct PC when an exception must be raised.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    | 2 +-
 target/microblaze/op_helper.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 64816c89e1..a473c1867b 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -26,7 +26,7 @@ DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_5(memalign, void, env, tl, i32, i32, i32)
-DEF_HELPER_2(stackprot, void, env, tl)
+DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_2(get, i32, i32, i32)
 DEF_HELPER_3(put, void, i32, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 2c59d4492d..a99c467364 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -389,12 +389,16 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
 void helper_stackprot(CPUMBState *env, target_ulong addr)
 {
     if (addr < env->slr || addr > env->shr) {
+        CPUState *cs = env_cpu(env);
+
         qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
                       TARGET_FMT_lx " %x %x\n",
                       addr, env->slr, env->shr);
+
         env->ear = addr;
         env->esr = ESR_EC_STACKPROT;
-        helper_raise_exception(env, EXCP_HW_EXCP);
+        cs->exception_index = EXCP_HW_EXCP;
+        cpu_loop_exit_restore(cs, GETPC());
     }
 }
 
-- 
2.25.1


