Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0127C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E0120770
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3gEi3/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E0120770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILcm-0008RE-9K
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILax-0006G3-En
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:47 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILav-0001Vx-Rz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:47 -0400
Received: by mail-pl1-x644.google.com with SMTP id e4so2238988pln.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RffEK/rCiFhZmvHDae5MdJFHwlUbrlsn383XqLguch4=;
 b=h3gEi3/slhIcV2djfTfSFVwGQfUeVhbW29GKU+wNBAYZRYASifAYiwU2GhWCopKRrk
 L2cRJicJ2fWTVWiBNOcHYFAz4Qr/dcDtREvGcwoaxy8BN2MEl96W6+FOOlxL+etoCmmV
 vXOHiIIIkQGcTwAY7n/vW6A6O79WtP+H/k9ECczFOK86JyP5D+yF5qVmu0F3Pcz8xnN6
 mrQNM9gkBYfRtKrSmvaYZ8I3tPv+F3t1TF6ejXJ+HAKyJuHDLHlh/eX0OKChTdzNY1gH
 hykkkHPW44bEvk/L/qE95/bsMGOS2aRLAsmVG684xbfTYTPUjRaG63/YNHjVq5w++TDU
 0c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RffEK/rCiFhZmvHDae5MdJFHwlUbrlsn383XqLguch4=;
 b=r0cUaQ1wTIyJZLc1BzNXzdTaKNaQNS8uqbesDhl/kiGKbIJNWkTq9VuYBms6Q7+GuX
 BPY98p1H+uawKkLO1+MjsQq83/udhwbPQheDGXvfDO2uNYhhoi1yajTvbsr63Yk+1knj
 EP9Vn3gupp7vaUAFlzOPktbdhsX5wzlPtuT3OQ4ZVk1jDhoa5AD5wo23MsHrsMetp2/z
 bdPzt88PtIGA5Srl46g1mEm7e7HDMM6EW4T8KOxlYMh0cxc0Lh3MzPW+q9kh9g0F/gsZ
 NxVrmXt7k3+jcG9HJn5gijBfY8Ski5+iqCKNKaLIHvoMDs+Nokgl8A2/GoznRmlDlLqN
 zXqg==
X-Gm-Message-State: AOAM530ITku+g+HzySFpiYhJ//IFDtNj+XjJuIqUfr1zSpfy4T8vNTNG
 yMf5qjy4nWm+H3YvuonaABU6D9mdRedaog==
X-Google-Smtp-Source: ABdhPJx+h+9xqaf8n1Ja6zNGxq0+GezVWStbgn6ST6XO8IRIoMO7Mxy1rvEsCg30nuIQea6aJltR9Q==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id
 s11mr1713407pjq.40.1600217204217; 
 Tue, 15 Sep 2020 17:46:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] target/arm: Set instance_align on CPUARM TypeInfo
Date: Tue, 15 Sep 2020 17:46:35 -0700
Message-Id: <20200916004638.2444147-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916004638.2444147-1-richard.henderson@linaro.org>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPUARMState.vfp.zregs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 target/arm/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7b5ea65fab..a7643deab4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2290,6 +2290,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
         .instance_size = sizeof(ARMCPU),
+        .instance_align = __alignof__(ARMCPU),
         .instance_init = arm_cpu_instance_init,
         .class_size = sizeof(ARMCPUClass),
         .class_init = info->class_init ?: cpu_register_class_init,
@@ -2305,6 +2306,7 @@ static const TypeInfo arm_cpu_type_info = {
     .name = TYPE_ARM_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(ARMCPU),
+    .instance_align = __alignof__(ARMCPU),
     .instance_init = arm_cpu_initfn,
     .instance_finalize = arm_cpu_finalizefn,
     .abstract = true,
-- 
2.25.1


