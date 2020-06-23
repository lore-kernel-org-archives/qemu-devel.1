Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A1820776
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1XHmtOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A1820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhSz-0007YY-N7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGu-0002gJ-EA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGs-0003CN-Mh
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id o8so922773wmh.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+2zDeEiCTHBTGs+Yj4qcOYD6SxZptA1+PpcqVpemOu4=;
 b=t1XHmtOavjRV1hx9LxkRQ6E1WIJ2h7ucu3BPdLf5ZJvjUAljM4fvL1QUracdqOuOWb
 Lla3WSEHp/5YFu/3d5DZ6F0e7JLTOuHpiKaOjjpjt3ULsq3q4nFJpd7T7Jj/Bu/QRIvJ
 Fmk1ORTnqQqhFWVCx0yPNZZtsoV05dkuOSqKULXd+GTlb9NJcKYxDVfkwxU3yjCAcQIn
 dk4yzEI+P2NOBYTwytgqQBzsugdxZKM2Ke7+ggIzw2jK3zIllAqWFbQ2BMaYQ0Ss2IJR
 QvrqW1cR6eIbSS7mpQY0wfFmEH57J3RryAOcSkpinDcDUJZxu08wfYSX/OitWdK5H83F
 MHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+2zDeEiCTHBTGs+Yj4qcOYD6SxZptA1+PpcqVpemOu4=;
 b=WxNSphs/D3tTJib5Ur8WzSWKkQsY9D6V0ceZMwE8g46Wk2sVXGK6Kq7HINK7dXlfWy
 ZpX0SQ4unGgAi3sSB1QAnYjSSDqfkZ0q6xeZExYfL6k3qxYUd9y5JRBhjQN/SnmvVyce
 KqRcZuGhs22OIJ37KCBsgM1LgRk0txCAR5muEwg3TCHjMOR2GeTUTlGL9/4wArLjsn5X
 BhnK4kGThHTfJA3o4s3c9A4olDcS5yBaogCq4dNiU8PZggJ53g8CkRUif1H0AUa483iN
 vXREUKDLeecocbR9CubBfa/CFa70yFO9y6gkwIbIQ+xqCfxivYHxYYUCvk3DrW1LpOjE
 ZLBg==
X-Gm-Message-State: AOAM530zjW1rHByKJ3nLJ3URTeh/QdG8LzXVuzenNorTYK9IMRWw3QUU
 aS/+9a+ufxfcRYE67BqlnKxGkIMnSvbjTg==
X-Google-Smtp-Source: ABdhPJwP+MqLjXq64PEAe6U/gZHWUn8RqqXjMqBYImpx2IOn1HlN1M30PAQ5tNEQ6pQjqikqL/4ujA==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr24134196wmb.116.1592912361081; 
 Tue, 23 Jun 2020 04:39:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/42] target/arm: Make gen_swap_half() take separate src and
 dest
Date: Tue, 23 Jun 2020 12:38:35 +0100
Message-Id: <20200623113904.28805-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make gen_swap_half() take a source and destination TCGv_i32 rather
than modifying the input TCGv_i32; we're going to want to be able to
use it with the more flexible function signature, and this also
brings it into line with other functions like gen_rev16() and
gen_revsh().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-12-peter.maydell@linaro.org
---
 target/arm/translate-neon.inc.c |  2 +-
 target/arm/translate.c          | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index c39443c8cae..4967e974386 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3007,7 +3007,7 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
                 tcg_gen_bswap32_i32(tmp[half], tmp[half]);
                 break;
             case 1:
-                gen_swap_half(tmp[half]);
+                gen_swap_half(tmp[half], tmp[half]);
                 break;
             case 2:
                 break;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 38644995ab2..64b18a95b64 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -378,9 +378,9 @@ static void gen_revsh(TCGv_i32 dest, TCGv_i32 var)
 }
 
 /* Swap low and high halfwords.  */
-static void gen_swap_half(TCGv_i32 var)
+static void gen_swap_half(TCGv_i32 dest, TCGv_i32 var)
 {
-    tcg_gen_rotri_i32(var, var, 16);
+    tcg_gen_rotri_i32(dest, var, 16);
 }
 
 /* Dual 16-bit add.  Result placed in t0 and t1 is marked as dead.
@@ -4960,7 +4960,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VREV32:
                             switch (size) {
                             case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-                            case 1: gen_swap_half(tmp); break;
+                            case 1: gen_swap_half(tmp, tmp); break;
                             default: abort();
                             }
                             break;
@@ -8046,7 +8046,7 @@ static bool op_smlad(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2);
+        gen_swap_half(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
@@ -8104,7 +8104,7 @@ static bool op_smlald(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     t1 = load_reg(s, a->rn);
     t2 = load_reg(s, a->rm);
     if (m_swap) {
-        gen_swap_half(t2);
+        gen_swap_half(t2, t2);
     }
     gen_smul_dual(t1, t2);
 
-- 
2.20.1


