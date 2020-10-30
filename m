Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C891C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E39420739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fA6Cp8KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E39420739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKE4-0005gZ-29
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7k-0005HC-5m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7i-0005vr-IA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:39 -0400
Received: by mail-pl1-x643.google.com with SMTP id j5so2243464plk.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ctNmX935/85OBzb+3yZO19vwGcb5IjbGDXkuOiA+8s=;
 b=fA6Cp8KTlfM9f4jjDGWhBRINgApSSCd4hcIlys/IMuxBB97mnHCitWV6TQQhSj28ZI
 uFB4BrKaUSI1jF+FPwZCgEtlG5+CQGlIY9oRn5WhWtREuxtXUMHfcTFrKJ0ua/EgbDO3
 g1MPh2JBCxim9BpwaKXPElyCPiKsSLWJGKv+8KfEuuLFO3w0ocW4STXhGvFxXFU8nug8
 5fGE+385YXidNxMujonxZDbmtDBEBwaJQapCYsVYuiOQPTttnV4XXoz+Y0Ig5Sxcf3FH
 VEz36k9jc1p5vya1wz/G85aBZz+lHzGnQITwSK4fDiSh7PCcmt/DC1Hml5YF31QA6bz0
 c5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ctNmX935/85OBzb+3yZO19vwGcb5IjbGDXkuOiA+8s=;
 b=DnVjBViWwlgIUCTxdJhmrClevT4DlO00qaGf/Rg+06v/GTQqkGpHCcnXItZ+rX6jgO
 By+VBqqNBL3ZGjF9/EQCaKGshTQSjMNoC8qN8G3/+YOm/8aVkgtkw3lHo7d85eeJdFzy
 SA7UomXArOl8nmYPVhElgdcidfbpsqV0546YViApJo2YtJuBnSnJqTduec9CbyAwx+C2
 Km9hcmOKxjuZ5YfMOJuwP38QEDsitB9p8bidvnoXJ8snFjFV4Pa24lNLsFIdrM/VIyXN
 d1JfQHhJxIKzphqR9BlM0Rug7PqYO1M1SWZRxINsRetwZ6c6UP0apUx9zxyt8RGEHTLv
 7gBw==
X-Gm-Message-State: AOAM531HDuDtASTJ0J6/KRcRWbaoUtDjiIWLgq5zDmUPhGD70VtkYgMG
 BRIM7HLkrzMqp+/xiOLkZmCVJTps9hbDZg==
X-Google-Smtp-Source: ABdhPJxFbMrOtvDvNCdkSh+udcFXJkIHeMNmNirO5qXldHQ/H/dLOEUoPUez2W1+PxJXyP/ONWfwuA==
X-Received: by 2002:a17:902:7d89:b029:d5:cfb6:e44 with SMTP id
 a9-20020a1709027d89b02900d5cfb60e44mr7136707plm.28.1604024793684; 
 Thu, 29 Oct 2020 19:26:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/11] target/arm: Simplify do_long_3d and do_2scalar_long
Date: Thu, 29 Oct 2020 19:26:17 -0700
Message-Id: <20201030022618.785675-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In both cases, we can sink the write-back and perform
the accumulate into the normal destination temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-neon.c.inc | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index c2d67160f9..1c16c56e7e 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2037,17 +2037,14 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     if (accfn) {
         tmp = tcg_temp_new_i64();
         read_neon_element64(tmp, a->vd, 0, MO_64);
-        accfn(tmp, tmp, rd0);
-        write_neon_element64(tmp, a->vd, 0, MO_64);
+        accfn(rd0, tmp, rd0);
         read_neon_element64(tmp, a->vd, 1, MO_64);
-        accfn(tmp, tmp, rd1);
-        write_neon_element64(tmp, a->vd, 1, MO_64);
+        accfn(rd1, tmp, rd1);
         tcg_temp_free_i64(tmp);
-    } else {
-        write_neon_element64(rd0, a->vd, 0, MO_64);
-        write_neon_element64(rd1, a->vd, 1, MO_64);
     }
 
+    write_neon_element64(rd0, a->vd, 0, MO_64);
+    write_neon_element64(rd1, a->vd, 1, MO_64);
     tcg_temp_free_i64(rd0);
     tcg_temp_free_i64(rd1);
 
@@ -2670,16 +2667,14 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
     if (accfn) {
         TCGv_i64 t64 = tcg_temp_new_i64();
         read_neon_element64(t64, a->vd, 0, MO_64);
-        accfn(t64, t64, rn0_64);
-        write_neon_element64(t64, a->vd, 0, MO_64);
+        accfn(rn0_64, t64, rn0_64);
         read_neon_element64(t64, a->vd, 1, MO_64);
-        accfn(t64, t64, rn1_64);
-        write_neon_element64(t64, a->vd, 1, MO_64);
+        accfn(rn1_64, t64, rn1_64);
         tcg_temp_free_i64(t64);
-    } else {
-        write_neon_element64(rn0_64, a->vd, 0, MO_64);
-        write_neon_element64(rn1_64, a->vd, 1, MO_64);
     }
+
+    write_neon_element64(rn0_64, a->vd, 0, MO_64);
+    write_neon_element64(rn1_64, a->vd, 1, MO_64);
     tcg_temp_free_i64(rn0_64);
     tcg_temp_free_i64(rn1_64);
     return true;
-- 
2.25.1


