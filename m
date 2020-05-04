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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9748220705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOdI6x7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9748220705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVgo3-0006vf-Mf
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVgn8-0006AD-Co; Mon, 04 May 2020 15:30:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVgn7-0000wm-Fm; Mon, 04 May 2020 15:30:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id 18so6037203pfx.6;
 Mon, 04 May 2020 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4MNjzkbAJCWvqiKh2DZRO4y4MY5dOBDH4eK8eltsp9I=;
 b=nOdI6x7SUBh+voS9Yx6N1ersUOM/JIk2sokBKxfVTzONvTGZy2TJ7ZexT7K2giesrn
 3uA7ikOF1X2HFEg2W3txDmz3WQcfJddj4wWI+5N260vZN3KzlNZGjPQL4phy61ANzfQn
 DI7scojw2UlNZdtNA77haBkJEtyHS3qwwpC52LAIP32PAEbIT4HioZv7awQuI02d9ycN
 xf1We5eQvFUzX/3aEVKd9PzrXnwb6IhB0l15p/CEULKdMGUFmUXEHJJHZnEbJmfGNrKB
 kFFahM/fQ71h7fGA53f94/wrSIYUVHobFY3Db42JERLJneoOsxwRSQKuk7yxGr2hTYbY
 QoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4MNjzkbAJCWvqiKh2DZRO4y4MY5dOBDH4eK8eltsp9I=;
 b=IUyb4VQN2aNCESXH9CIo/rUMJ7ukUFY4w5J7BIpMOpyl9bI75+4GI1PcMbix7ElSWH
 D/spGMW+CGMzMMN8KwXV8ihxH0ZQYiZIkAx4F6XDFzT/MK4lK8HdSzGBMIgfY8isbTSX
 BOmj0WoQqyFZCj9G4xn7G1elw5xtqhIlobIQmrVI9jQnsVKYF0MdPBfo32p9eWIFjHrE
 0mzWTloe/gTCV4rsM/gFu6L3+2tQffr1jAzvnDEwhgT5mU/jvNmNJsn7610PjW3l/3A6
 yCLnRSTeNG9UPpqSJzV+JGC2omRczM+a1W0MxKngluT7XeGniVeCb3am3PVTWkPy6r/a
 +I9A==
X-Gm-Message-State: AGi0PuaatVNbJIj27Zuzd9ZRYAyAM+3hznpRVxYX5VLfLVRZiXND7YzO
 W8lCVMHS6LrNKS1f3nf3QdYa8jiCnlpGdQ==
X-Google-Smtp-Source: APiQypKqmOjPNfsRcHkH0xiaq+6BL67uZ6FlcgZipnLT27eNdqU9hZqenaDDPu/bARrpQ/mpBXI5fg==
X-Received: by 2002:a63:f30a:: with SMTP id l10mr499003pgh.372.1588620610121; 
 Mon, 04 May 2020 12:30:10 -0700 (PDT)
Received: from localhost.localdomain ([117.62.175.86])
 by smtp.googlemail.com with ESMTPSA id y78sm9527842pfb.127.2020.05.04.12.30.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 May 2020 12:30:09 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ppc: Use hard-float in ppc fp_hlper as early as possible.
 This would increase the performance better than enable hard-float it in
 soft-float.c;
 Just using fadd fsub fmul fdiv as a simple bench demo. With this patch,
 performance are increased 2x. and 1.3x than the one enable hard-float in
 soft-float.c Both version are not considerate inexact fp exception yet.
Date: Tue,  5 May 2020 03:29:54 +0800
Message-Id: <20200504192954.1387-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
With this idea, we have no need to adjust the helper orders.

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


