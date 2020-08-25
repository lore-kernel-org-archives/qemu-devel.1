Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D64F206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBHxp79q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D64F206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgcx-0002CE-69
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3s-0008RD-VN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:56 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3q-0001yH-TL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id m34so7662900pgl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=92AClQgNXABacQ0i61DaYrNKkj8PxXy6qywPLdGfziI=;
 b=KBHxp79qnB44H5MyTBLuOwUI1CUO5kzYtE2cLl+IS2YRaYx0dK3lIqZDU7yENZQjc4
 yQAelPZqpY1p5DnzJMBC/HyP++d97PGcRcbat40mM/MHZZkeh9Hu8LiUXnxYICFAigAN
 fkb3XSVDezESkxuPSZQuo42oVOagi2F3j8rLclIW0wyURj3VNmJPZQAr1He0XleiWtv9
 NDRxn6VS/iqDj5Z9+t3cBoopsyGkQfektf9aVSEkQ2Jw3MTvyWWwlZ06gXEX/enOKGVD
 yX9fUQ1Wh1AF4LIAx50i5n3yizLRqzEFz6VdO2kC2a5iuDgBxXfDumtZt8R3BjQErpZ+
 xOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=92AClQgNXABacQ0i61DaYrNKkj8PxXy6qywPLdGfziI=;
 b=cS1oInutvkylfuBCY1qRD5D8n7789b/b7YdukxTgw1xgqJrcc1eja5MklkA0kp09gy
 tT6a+rQahIaSO/kao9U+fCwQCh8Pyr9fAjt+OPRwdUwt1JYHTAktk4pLmVwc9L59UVvh
 qIIgyUXqy7M3U6knT6anaFrP+0nOt7HGq0cDbC4FcFKzvnVentwz2ikSOdo7Ug/DnJoD
 /AvEWTTatU4nb4EQunZqs/YApabmhr7+PB8NGHKDyaoHU8GvnAPJPJM+K3KORJ3gKeH+
 d5lP5nkbs3ss4bOn7v6MyhFR+D1DZmz9IZs6dmdGmmsKv5CgswqCoshNqKPNvhWLrUQp
 Js1g==
X-Gm-Message-State: AOAM530FUu5EoMOpdz4/8tYBCNIfzJZWNWByyPGE1grYtqQYmVKPc6HL
 gkcyjzpDytUNhtSudDnCdZTUtQEg23rH3Q==
X-Google-Smtp-Source: ABdhPJxw8zA6ZN4TKbN2+ABXBvzw8JwlC4F6Yl4aDDu3MLwomwmrW6fc1IHgkdty5lENgdUPzMdFaQ==
X-Received: by 2002:a63:4e56:: with SMTP id o22mr7715010pgl.381.1598389253174; 
 Tue, 25 Aug 2020 14:00:53 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/77] target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
Date: Tue, 25 Aug 2020 13:59:22 -0700
Message-Id: <20200825205950.730499-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that FSR is no longer a tcg global temp, we can say that
the fpu helpers do not write to tcg temps.  All temps are
read implicitly by the fpu exception path.

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


