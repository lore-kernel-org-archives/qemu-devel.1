Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E075C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299102075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJD8IUlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299102075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjUW-0005eH-8B
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCm-0002fO-JT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCg-000604-FS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id k20so105808wmi.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cOh7GY0pCWe5s/t9AlUFMrvjleZvUswRo8NiK3ZWQJY=;
 b=VJD8IUlkhn6qJWaoowXbizmhXMnBHttNlMzj1KvM2qd0m1U2tli3ZMI/7DUWFqI4gC
 39lGyEODXGJJP3jitEObWf017Lq+sKw8S4nSaYkLxT3nfVfYnOTwS2FkFSVjRHy5o5lM
 QGUmX1XGuClMnUsMBUJ+wwJEvxmTjtdcUQ5b12cHEi+9Icbq68grjJw0SgU8U+rQYwm3
 RHvAKCn4FOjAXmBO5IuYbQc6uNCk02T7ySU7qwW5s3s6hVBNn6m0dh0Nreu6Te1wOHrI
 RHdWfNry4lE1Vpfv+xlp2YgmGbTeATqF5zeGf6z0faA/WLU/9+NeLuattmSvgxXJNmgh
 X/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cOh7GY0pCWe5s/t9AlUFMrvjleZvUswRo8NiK3ZWQJY=;
 b=Cb3ZYZsrkJEyjczcWQfU0Uh3gEMJoGBxVW9RanVRSXzPWTwU+IZkpBNY+HDqoA6vyG
 L73LznTAA+EqVJ9ZT9rYSrj3UohF5oX/3g6wn28/QxCvfb60nHEQEg8Mh5PUMLgzlbfq
 Td/snGuW/kwVwD5UxL4amGOrJU5KOn/XLkLdIRJonvz7qxKue2eupEFW6CfQ0ifRup7q
 621N8y8mweFrrnWX9lSHXculWsJveheSX4rSu/wNIO2D+0DDt7p1dlISapUYsaeOzG12
 kUGOdUHlmHDIWQm2xJnktFwFteA+4eZV9BgHsKSSAGS3M8v3/Kz3Z8LwoQICVB0M9v/G
 /0wQ==
X-Gm-Message-State: AOAM533Rr0dk1KyQb3hzABPkPhehMSotTtmRFXDUPudlNB5dmD9MBKLe
 1s93jdBKo9Wc/JkELEhhVmK88A==
X-Google-Smtp-Source: ABdhPJyeTgZjsNzll7nVj9zK5rcb0s+pInaiM97upqo7GsXyQaacxvs2k4sKbNQUNTB9nhieTeLhgw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr45064wmh.74.1598639660995;
 Fri, 28 Aug 2020 11:34:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/45] target/arm: Implement new VFP fp16 insn VMOVX
Date: Fri, 28 Aug 2020 19:33:29 +0100
Message-Id: <20200828183354.27913-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fp16 extension includes a new instruction VMOVX, which copies the
upper 16 bits of a 32-bit source VFP register into the lower 16
bits of the destination and zeroes the high half of the destination.
Implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp-uncond.decode   |  3 +++
 target/arm/translate-vfp.c.inc | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 39dc8f6373a..8891ab3d549 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -75,5 +75,8 @@ VCVT        1111 1110 1.11 11 rm:2 .... 1010 op:1 1.0 .... \
 VCVT        1111 1110 1.11 11 rm:2 .... 1011 op:1 1.0 .... \
             vm=%vm_dp vd=%vd_sp sz=3
 
+VMOVX       1111 1110 1.11 0000 .... 1010 01 . 0 .... \
+            vd=%vd_sp vm=%vm_sp
+
 VINS        1111 1110 1.11 0000 .... 1010 11 . 0 .... \
             vd=%vd_sp vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index bda3dd25136..4b26156eccc 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -3482,3 +3482,28 @@ static bool trans_VINS(DisasContext *s, arg_VINS *a)
     tcg_temp_free_i32(rd);
     return true;
 }
+
+static bool trans_VMOVX(DisasContext *s, arg_VINS *a)
+{
+    TCGv_i32 rm;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* Set Vd to high half of Vm */
+    rm = tcg_temp_new_i32();
+    neon_load_reg32(rm, a->vm);
+    tcg_gen_shri_i32(rm, rm, 16);
+    neon_store_reg32(rm, a->vd);
+    tcg_temp_free_i32(rm);
+    return true;
+}
-- 
2.20.1


