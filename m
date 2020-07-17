Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C6620717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bys4P6c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C6620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwO2O-0004Iw-Ph
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy7-0004dF-0Z
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwNy4-0003s1-B0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:51:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z2so10539504wrp.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x6Qu/8ZzxFPQUproM48qagEF+BvBJ1cNZWgjUdSHRNw=;
 b=bys4P6c6EdCnXc8njtPUgz7H36Mcb+WZk0Y855tSXOjCTjQN0O41mWGtFzuFg0Oo3b
 LcCXfZLH5YGhXEtkphRRmiJVF+8I/6+2xfVAf5QVPM6sMQg4TMUx5wkglk7KPvsMGJer
 7kCAoVWKJPRyr+Hw5g24Bd/24trj/f+N9g9rfkEKdvuXHxsj90Jy8SQ5eg6o5njMwzHT
 ygnpJ2ko7e3PWKLOtFygaQUETGdlNOQXN1r1vgkn6trOL9AuCrRM7nLc0VUUjrSW2Nsa
 RMh7AXpRJjTa7neHyqx290TUn1zUX6jot6oK5fmzmJO/8RFPPmRpeg76apLXF1372bKy
 Pumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x6Qu/8ZzxFPQUproM48qagEF+BvBJ1cNZWgjUdSHRNw=;
 b=XCgdOfd/MZPkf6MyBYAq8E6dxIz/UqHz8rJP0jPBwE53EIfcwONIacOpm9leN9vGm5
 z9ZwUHUUMydaLggYg38nKdBvL6u4xZeCD45oiaXWkvN3OYbvgKduqMLelN5tl/lrYOvh
 8O4mgUVSEOugkc8G1E6NebOpMDOTS+tIwncXVJsqeGBw/Lh4UVuCiIv/uTKyyTPO0BpQ
 cumGcZSf+/D3wEtxLF8dKODXo/IjKt2p+0EmL1X55vTCSu5SwtIAdc9Ky98NJ1fuRkEA
 psWZoaFN53mKXWxdnfBIkP+b4pepvlh75U+jNr8Rgm8F3prh5+qoR2ZiuZYrQY+awZFy
 gicQ==
X-Gm-Message-State: AOAM531+sJdzKgXVjcPy3y6XyhdBvKsXAptcNejlteBUbuq+Z6bm2uEC
 aTs4Dk00BlDXfv2leX2Rb+iQug==
X-Google-Smtp-Source: ABdhPJw/yUg68Gw0SgqvHgZ+Y1Pb5+AS8wB1I5oPLmtzekrfL9+TJ9aFH9abanY8n/AK1xWJjV8MOA==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr9520799wrp.349.1594983106576; 
 Fri, 17 Jul 2020 03:51:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm15570518wrb.59.2020.07.17.03.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:51:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4FE91FF8F;
 Fri, 17 Jul 2020 11:51:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/5] semihosting: don't send the trailing '\0'
Date: Fri, 17 Jul 2020 11:51:37 +0100
Message-Id: <20200717105139.25293-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717105139.25293-1-alex.bennee@linaro.org>
References: <20200717105139.25293-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Don't send the trailing 0 from the string.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
---
 hw/semihosting/console.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 22e7827824a..9b4fee92602 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
-            s = g_string_append_c(s, c);
+            if (c) {
+                s = g_string_append_c(s, c);
+            }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
-- 
2.20.1


