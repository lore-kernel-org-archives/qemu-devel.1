Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57886C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267D9206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8miOtrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVgey-0008Nv-A5
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVge6-00079e-23; Mon, 04 May 2020 15:20:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVge5-0004Zw-2B; Mon, 04 May 2020 15:20:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id x15so6038508pfa.1;
 Mon, 04 May 2020 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+XoYCbANuJjiyhPkdNo9nxfnrPn8pRjZhybcuM/lxH8=;
 b=r8miOtrcZk+JkmO6Rw9Azi7/FqgOD9xOl7QoL2t1/MA2XW2MCeuMsUBmQCAZC6wJ6y
 x3BgDy7xK82QEBm6gbc05ZWXdXWr3Oe+nDOS4Xk4QNIeq7OIYZgDgBa5QpL2I3vRQuwo
 dMpljktOHY8ZqCqjd9dUd+ShYaEdEfGD8xf9TJOEGKG/6QaQLCOLT+hKtEmSLXWJPG7o
 Kl6VSg+euYnhvGJ4IYTHBLB870hOxhc7KCkXQ7iB/2Wah9sbBe6/OVQzWwRnZsfLiIuo
 e/M0nD8i6NLZ9bH4wBnb+sIF1f2W5iLiyYOd4GpYQzBINqdFyuNxSquupnPieRJ4PkAR
 Ki+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+XoYCbANuJjiyhPkdNo9nxfnrPn8pRjZhybcuM/lxH8=;
 b=ItJDcJh5s5lpyl92gEwtQyGBgnuqVrsTtft/+Y8BvpefkKjNbWZPBBlwOUxsSkZ6TZ
 QcC4Gy0hpdpz8re7CqWUtYc4Z9/X1WtRFTkOZ975YKD7nLH+WsWPLDyL7e6ZbzxMRevC
 /hHi/q2jXNwt3caPQkCEuZmLRvsc96AGCTSLG+SAagbaiv4pfyOJMV5oIz/EQNHPDiHP
 FudbdEpCVRIyXaas1DLTejS9nT6QXu0e0wysi3LOF9SyOyIcyl5NYq+M1U1pkm6PXHoK
 vDU4v5zh3zIpujzN4IgHMVvCLR+aJj60lL+2ibpb6dmTUTkF/hx++oGle07KV/dNYR11
 dvaw==
X-Gm-Message-State: AGi0Pua/rxgv3gW3xD1jU449Prma3JaYWXr/Ea/L38C8GFUO81jhKSTH
 C3zQ/G0vqhN1BUx7GQoVfaYyBtuaxFg=
X-Google-Smtp-Source: APiQypKo8dbGdmLJqqfjtvYgp+wrVyX0tfj6iof4rBl3/lVqeA+6CJ/y/BaMQ29H9T3EkDa2GHapQw==
X-Received: by 2002:a62:3287:: with SMTP id
 y129mr19772516pfy.167.1588620049717; 
 Mon, 04 May 2020 12:20:49 -0700 (PDT)
Received: from localhost.localdomain ([117.62.175.86])
 by smtp.googlemail.com with ESMTPSA id m63sm157092pfb.101.2020.05.04.12.20.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 May 2020 12:20:48 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] [ppc] Use hard-float as early as possible for PPC. And this
 would increase the performance better than enable it in soft-float.c;
 Just using fadd fsub fmul fdiv as a demo. With this patch. Performance are
 increased 2x than the old one. and 1.3 than the one enable hard-float in
 soft-float.c Both not considerate inexact fp exception yet.
Date: Tue,  5 May 2020 03:20:17 +0800
Message-Id: <20200504192017.1160-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Just post as an idea to improve PPC fp performance.
Through this path, we have no need to revise the helper orders.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/ppc/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 2bd49a2cdf..79051e4540 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -926,6 +926,17 @@ static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
 /* fadd - fadd. */
 float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
 {
+    CPU_DoubleU u1, u2;
+
+    u1.d = arg1;
+    u2.d = arg2;
+    CPU_DoubleU retDouble;
+    retDouble.nd = u1.nd + u2.nd;
+    if (likely(float64_is_zero_or_normal(retDouble.d)))
+    {
+        /* TODO: Handling inexact */
+        return retDouble.d;
+    }
     float64 ret = float64_add(arg1, arg2, &env->fp_status);
     int status = get_float_exception_flags(&env->fp_status);
 
@@ -941,6 +952,17 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
 /* fsub - fsub. */
 float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
 {
+    CPU_DoubleU u1, u2;
+
+    u1.d = arg1;
+    u2.d = arg2;
+    CPU_DoubleU retDouble;
+    retDouble.nd = u1.nd - u2.nd;
+    if (likely(float64_is_zero_or_normal(retDouble.d)))
+    {
+        /* TODO: Handling inexact */
+        return retDouble.d;
+    }
     float64 ret = float64_sub(arg1, arg2, &env->fp_status);
     int status = get_float_exception_flags(&env->fp_status);
 
@@ -967,6 +989,17 @@ static void float_invalid_op_mul(CPUPPCState *env, bool set_fprc,
 /* fmul - fmul. */
 float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
 {
+    CPU_DoubleU u1, u2;
+
+    u1.d = arg1;
+    u2.d = arg2;
+    CPU_DoubleU retDouble;
+    retDouble.nd = u1.nd * u2.nd;
+    if (likely(float64_is_zero_or_normal(retDouble.d)))
+    {
+        /* TODO: Handling inexact */
+        return retDouble.d;
+    }
     float64 ret = float64_mul(arg1, arg2, &env->fp_status);
     int status = get_float_exception_flags(&env->fp_status);
 
@@ -997,6 +1030,17 @@ static void float_invalid_op_div(CPUPPCState *env, bool set_fprc,
 /* fdiv - fdiv. */
 float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
 {
+    CPU_DoubleU u1, u2;
+
+    u1.d = arg1;
+    u2.d = arg2;
+    CPU_DoubleU retDouble;
+    retDouble.nd = u1.nd / u2.nd;
+    if (likely(float64_is_zero_or_normal(retDouble.d)))
+    {
+        /* TODO: Handling inexact */
+        return retDouble.d;
+    }
     float64 ret = float64_div(arg1, arg2, &env->fp_status);
     int status = get_float_exception_flags(&env->fp_status);
 
-- 
2.23.0.windows.1


