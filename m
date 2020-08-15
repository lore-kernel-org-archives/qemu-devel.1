Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A96C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D44A23110
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 14:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPt+fJPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D44A23110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xeh-00026e-Qh
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 10:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xcD-0007Ne-Mc
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:01 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xcB-00053z-VX
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 10:57:01 -0400
Received: by mail-pl1-x641.google.com with SMTP id y10so3865476plr.11
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9NRH6u0bui4FSFIzrZ7Rwk8xUdSDUIfSDtkVwDeXJ9Q=;
 b=ZPt+fJPTvTouF096Ftttct1ge3AFLeLp7SUJP5rXJ14/8qg5ok6E1zKQT+MWWMR2Fh
 7jAWUa6xD6kgzj+vFRs544VOMzUpsu76jdA/Yjtju5vrZwNpGV0xqj/A94DzhgzFSX/N
 zyje21Vc8p1O6UavOtCF52wOYNPP8IWsIrP81wlTvAc/Qq4caePlnYTH1DI8IT/1TWDf
 CxFny6kl60iNkUffU7GUIUuw6XskYyVY6TbpNpMGBoZQwomIuGYmjQbnzFTKUDUG24xn
 I9+X+lOB1+uUTX5nCQKgTEV0ch79vvuwE7JK4jSbVCtWXaaGW6+OE31u5aCYKSA7+l/3
 jjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9NRH6u0bui4FSFIzrZ7Rwk8xUdSDUIfSDtkVwDeXJ9Q=;
 b=g0sxeoCyZx5dIIJWcfiQBE1sOlAYFTvb3lLdpfxgdN3Uz9LF7XJcr8JDiLfnHP/Z7O
 ExFiVpbJbKxm2BuV/aq1tsbpVhN6mdfh5ILEFIo9ZvrxaUQ0B/dCITbNLO/QAoGBb0Rk
 9B37an9As2C9mWTY+2G+HfP3QP71YHKWjY1kshnsxs79G21a0w8QBbxAqu6z3NeY3Mju
 MflA/UTUtur6/FAUeQJUM22gVXmKqLRjAQph+Efxkd7flFx9HoIZtqrzX8QBmEbhML1t
 tbPry8xdVe6iikJE+GZzHYPak0IJUUj7iFol37ha5OYExUyhV88A6uB6Pb2DfxkM69Qo
 3ZYQ==
X-Gm-Message-State: AOAM533ZMGpzEIBDds5qX/jWGv4wEUOu+TPtJDu94gjm/B79OUABZMd/
 LeIGe2wesPqDmRCHeMRX/CezobTCHsb/OQ==
X-Google-Smtp-Source: ABdhPJxcDG39X7lAhrEW0N5LH1kepnQrTZbGpAbLYOb2My0GrXTJB0UZuZW8iNe/PKnQBoPsCxFqnw==
X-Received: by 2002:a17:902:40a:: with SMTP id
 10mr3861114ple.180.1597455123858; 
 Fri, 14 Aug 2020 18:32:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/20] target/arm: Split out gen_gvec_ool_zz
Date: Fri, 14 Aug 2020 18:31:37 -0700
Message-Id: <20200815013145.539409-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3a90a645fd..a2948b5128 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,16 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 2 Zregs. */
+static void gen_gvec_ool_zz(DisasContext *s, gen_helper_gvec_2 *fn,
+                            int rd, int rn, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 3 Zregs. */
 static void gen_gvec_ool_zzz(DisasContext *s, gen_helper_gvec_3 *fn,
                              int rd, int rn, int rm, int data)
@@ -995,10 +1005,7 @@ static bool trans_FEXPA(DisasContext *s, arg_rr_esz *a)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zz(s, fns[a->esz], a->rd, a->rn, 0);
     }
     return true;
 }
@@ -2050,10 +2057,7 @@ static bool trans_REV_v(DisasContext *s, arg_rr_esz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zz(s, fns[a->esz], a->rd, a->rn, 0);
     }
     return true;
 }
-- 
2.25.1


