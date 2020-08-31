Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6453CC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F4D2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhiGN9rI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F4D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmek-0006n2-8p
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKx-0005kQ-3o
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:15 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:37620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKt-00065N-KL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id mw10so28221pjb.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ySARoLfSzmE74D4LscfR58zxrdoE7jaYed6YBL0jQs8=;
 b=qhiGN9rIhhZTCZ+y5TeaYdycrJFmD5xCNU/1efZN8ESQDvCW8XtnJAm3In3XIyb42L
 O1Ub/fjZW+HexF3AJxOHJLFcu2IiN81+JNPYvOaI6Cx+sq+t7VQ9Dx/lcw/IxieLHhvX
 o0z6kOf9UgUD3lhGlbazNyAx52AbDNXu6180Y76UCDUiOuO4OjP65nrq2nGuaQuIAABQ
 sg6aMgKt0jiUCma3FKQD9aAWLGY3FiQpC9qnt++RYXXvPPY9Ob+v/2q+jKI4GHIa/NAv
 EVxpVy6JxigEgQVGnCKqclDPgPe6JCsMLVcL7eBB3EDG/N8CvSwYvIBopryX1zTSbR1G
 WPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ySARoLfSzmE74D4LscfR58zxrdoE7jaYed6YBL0jQs8=;
 b=oVwMfl9SsEiAz4lwhTsTD+9ZC4FHCHiUQUgADGBTht4KLfBwMdLnDRv7TlVZ0E/mwI
 BNlkVuhato9Lz+FS/9yQEqwVrAOhnwrnoBvXWV+bmXDphpbD4QfXEkMJd03ISnpkYcjf
 ULcYaeLImEGKeXOyEo4jFQbLwuIrx2pEKGsDRXZrandBkAHflqdAL8MfJCgkz4ahS3Q0
 v0xCVJSCsRTsDtEDjA3OZB9yCxjL8mRCfjoQqSiHAvRT9yODPm1SPvEaSQz8Ni4VOOF3
 HmZhOwgu+f+6EameTVs+1t87r0y3O+ZTLvye15AlIYpPnwnhoRI7IeH/a1XXbufg584O
 pygg==
X-Gm-Message-State: AOAM531JtVPLFnlEfyIyjA3/Hal3SeKJ6Gu1nvf/Z1Qa7J3LqN0MCd+O
 0jGX5VexsjOoVQ9mymWQjemtgiy4ufONQA==
X-Google-Smtp-Source: ABdhPJzGpkkHCP1WvXwZmRjCw+bv9KcD9FXFFZaRCk6sEbaZzjNeS8JBvV/frJY59vynRVJM27gkSQ==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr1027379pla.277.1598890029912; 
 Mon, 31 Aug 2020 09:07:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/76] target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
Date: Mon, 31 Aug 2020 09:05:34 -0700
Message-Id: <20200831160601.833692-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that FSR is no longer a tcg global temp, we can say that
the fpu helpers do not write to tcg temps.  All temps are
read implicitly by the fpu exception path.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 79e1e8ecc7..64816c89e1 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -3,21 +3,21 @@ DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-DEF_HELPER_3(fadd, i32, env, i32, i32)
-DEF_HELPER_3(frsub, i32, env, i32, i32)
-DEF_HELPER_3(fmul, i32, env, i32, i32)
-DEF_HELPER_3(fdiv, i32, env, i32, i32)
-DEF_HELPER_2(flt, i32, env, i32)
-DEF_HELPER_2(fint, i32, env, i32)
-DEF_HELPER_2(fsqrt, i32, env, i32)
+DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
 
-DEF_HELPER_3(fcmp_un, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_lt, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_eq, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_le, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_gt, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_ne, i32, env, i32, i32)
-DEF_HELPER_3(fcmp_ge, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_eq, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_le, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_gt, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-- 
2.25.1


