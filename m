Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756A1C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2AD2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLd16Hzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2AD2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MIr-0007eV-34
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7f-00048Y-Es
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7e-0005oj-Cw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:43 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7e-0005oE-72
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so6053207pfg.12
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LpDXkMJymCkBigdAeSGEBRetKSjrJSWM6nnEjxNkcOs=;
 b=qLd16HzsDhSXKCYXkXTlKuDt3c3IGFTybZKTVNQZ0oLUH6Q+wFmc3ojgqTmTBF+lga
 reJBMEOc3d0HGrcJWT+5pwn2YuKZCj7XZZFktyRYUhs1t4j4rUnLOdTd279+hI3k80bV
 7RThRAywKqCbT/aTKrIhDoNm2C6MZf+TOEC3UhL1Ol0t3Vm3pWHsjiEbXyRmCZ2ra/Pa
 2G6G2HWCRPzSaPEW79O9mQAyX6IG9oQ5EQKhoYUlE1K4dTiQ3dSsZxZT9esq71c5YkvW
 r+wS9B8Givx3o6jzFYJt8CABwk4oq0ENTfg9MiHRnkRh0xNyLIWCYVvIcODDOxRQPdyO
 GFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LpDXkMJymCkBigdAeSGEBRetKSjrJSWM6nnEjxNkcOs=;
 b=HCeAlyaA3NXMvIwIalmKDYQK7jzQxcG0/AfGqydIWq6mrlK4EfF0DWNMHOiPapTLct
 4cZnSOlxPyFjSibiqbIiyMxw4VO7DHnCxmtuvzP7TlVE3UZkrval56VPVGcTx3M5xjAi
 1V+2HsGgOvm6UA84gUqJjWK/snSY1F7PpSYkucaw1ARnSkSe0a/5taL7XxTzV1LcfetF
 r2YAXwjyAjlZTMQD0nUbbP/0XoJ9DtFJ76JgYw8N9DzDyakck8ks7Fw8z5CKkIylLsHn
 vY5t1NqffO8wnAufKzAIbk5D80VT/cADrkRjNXNueKWI/JHzVEzMEevdYd+7EzYMoHWj
 l2/Q==
X-Gm-Message-State: APjAAAXrF8sJuT2co9hAjS9tCeW9ITARIK5z/sm3CqIBaEPatYL+yoUy
 iNNxDmvRwuFQzRyZqYkUsgVNgPzJoKM=
X-Google-Smtp-Source: APXvYqxUqTghpaDeKoQr9pJhTaH+ZpirDQn9KSLY7+11maLTmtJwJ7cVBJL4eLRqPA3iOo1dWn+RpQ==
X-Received: by 2002:a63:2842:: with SMTP id o63mr56554627pgo.317.1582582960842; 
 Mon, 24 Feb 2020 14:22:40 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] target/arm: Improve ID_AA64PFR0 FP/SIMD validation
Date: Mon, 24 Feb 2020 14:22:20 -0800
Message-Id: <20200224222232.13807-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When sanity checking id_aa64pfr0, use the raw FP and SIMD fields,
because the values must match.  Delay the test until we've finished
modifying the id_aa64pfr0 register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5be4c25809..f10f34b655 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1427,17 +1427,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
-        cpu->has_vfp != cpu->has_neon) {
-        /*
-         * This is an architectural requirement for AArch64; AArch32 is
-         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
-         */
-        error_setg(errp,
-                   "AArch64 CPUs must have both VFP and Neon or neither");
-        return;
-    }
-
     if (!cpu->has_vfp) {
         uint64_t t;
         uint32_t u;
@@ -1537,6 +1526,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->isar.mvfr0 = u;
     }
 
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, FP) !=
+        FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, ADVSIMD)) {
+        /*
+         * This is an architectural requirement for AArch64.  Not only
+         * both vfp and advsimd or neither, but further both must
+         * support fp16 or neither.
+         */
+        error_setg(errp, "AArch64 CPUs must match VFP and NEON");
+        return;
+    }
+
     if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
         uint32_t u;
 
-- 
2.20.1


