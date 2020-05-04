Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95713C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6666C20707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6hVWoV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6666C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVgiN-0003Az-AM
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVgh0-0001W6-MH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVggx-0005yM-A9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id x2so6029956pfx.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XhxyK+kkO2Y8hUw/ZAxBXnrBF6bTSYi2MZ+Sv+Ux6CU=;
 b=n6hVWoV2XE3Zct0JzbqbToZJUuMcwwHOspHkh5EbtXXix57aW+YMKjqKusbz38H+C0
 jB3ecQJEEBlyXIBjW3RHIpsdcCbaQKFTK50dEyhhuw+7oOi5GuvkThAkKld1LWQJJWJV
 8QSdp9z0IlRP0B3sIfBysJ131SAyeKIwpBle3m92NThb445hF9zWl6F/R+vE0G8uggq+
 a7Wcg4FR5zhk9D0Qmuy2NJuHzuFSkp+TlLJfAs/kW8wsbsvvQ0SifPfJ6mtoRNdvdStx
 VftGgwDf536F1dMGbrkBd4ryp0iEEjtLLv/TJ7ovEbSrwWXEMeim6yE1iWbknVKrJLxn
 ZjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XhxyK+kkO2Y8hUw/ZAxBXnrBF6bTSYi2MZ+Sv+Ux6CU=;
 b=hq8SUUu3SPpwKLhDD5FI4/9aFjEPR+zDVBwaIf3cD6Zt8b+1Rl4TD31bNdYfIhEktj
 LBNbS9n7Y/7DDX5Wt5HV3Ed4V7c7CvCR8A23KlHvu8zJj2W2cl5vHYhbavOwgQ4u1ype
 1gwFaLS3polsFU2LqbQ4CF5oXSi/kxLvNOfhLIjHzc0NFRt5NHp402C0d076EaVqb8K/
 hSwEwxYQvyTdfeBOAGGJO2/WcD+SSmJIVIw5GQk6MUkR0sswoqhmLwtvIttd6Vh5YowD
 bXmBc+9XvtbnFkYpmMvvhEuHYZG7a6P8MmL0O77BciZ3IvZJBOmHugR2iFRnRhXHZCLq
 UkBA==
X-Gm-Message-State: AGi0Pub5Ct0v5t158LYRShNqxATqUrQexCAgKC+1lJXvEmlox9fyVrhU
 6VxFBebKa/Y9E+LPt5yvuT8Be6Chy+I=
X-Google-Smtp-Source: APiQypL9g3ME3tvyCdPuPuQI5PyMFWIYOrZgfy3u/DnhUzKVaQKGoapSjGdThVGywEi3dxzdc6E/Ig==
X-Received: by 2002:a63:4ce:: with SMTP id 197mr462934pge.240.1588620228563;
 Mon, 04 May 2020 12:23:48 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b9sm9407364pfp.12.2020.05.04.12.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 12:23:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] target/arm: Use tcg_gen_gvec_mov for clear_vec_high
Date: Mon,  4 May 2020 12:23:43 -0700
Message-Id: <20200504192344.13404-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504192344.13404-1-richard.henderson@linaro.org>
References: <20200504192344.13404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 8-byte store for the end a !is_q operation can be
merged with the other stores.  Use a no-op vector move
to trigger the expand_clr portion of tcg_gen_gvec_mov.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a896f9c4b8..729e746e25 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -496,14 +496,8 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
     unsigned ofs = fp_reg_offset(s, rd, MO_64);
     unsigned vsz = vec_full_reg_size(s);
 
-    if (!is_q) {
-        TCGv_i64 tcg_zero = tcg_const_i64(0);
-        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
-        tcg_temp_free_i64(tcg_zero);
-    }
-    if (vsz > 16) {
-        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
-    }
+    /* Nop move, with side effect of clearing the tail. */
+    tcg_gen_gvec_mov(MO_64, ofs, ofs, is_q ? 16 : 8, vsz);
 }
 
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
-- 
2.20.1


