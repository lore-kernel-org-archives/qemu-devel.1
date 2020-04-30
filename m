Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB7C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE4020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeEeQAr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE4020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7sm-0004cM-ME
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jm-0003Sa-3p
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jj-0000SE-HF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jj-0000Rj-2X
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id f13so6474952wrm.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RCca2W4lwjdzEpAu/gQsnddTCCmaj3klMrOHk+9dWSk=;
 b=aeEeQAr8VBAx9n24ThCp5ebWUh4vi2a5sCZlQwsvRzgpleLR9stUw1UuMFxKT/CBRl
 7+gTnn3P50N+v2zzi9BQAAQprNSFOaH42XF1K7YeqIoKcvC0GTXFbFxKnDNNk4K/MPX6
 seiYTp8qmqtsGiF1pHgPWhU+gCrWkXAAPqLDDAOdNBLkOH5M70AKPRF3Mwy6qO9rVthB
 2iTawhlHanvS5U1PlnGRuLfuAD+tGiGXxR2ubxCbAqDVbbGWseZhCuyNDikeqpwM6463
 0RVjnDERzK5G0htZHxH2U+tin9j00VfRhUtbyohuR3IPFMCy05xpK61fcGyfIxf34ry4
 iRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RCca2W4lwjdzEpAu/gQsnddTCCmaj3klMrOHk+9dWSk=;
 b=otnpwP7I1Q/uVXomafBQaEk4aLWiIXmOC89Z3AdaZZmtcI7GzF5lU2wgnduv1W3yhi
 nHkzqy7upJxLiMsHKOBDiDnIDgd4UDBBxEUuDnYFPYWLQQI9ELfgpPVa8CAyZYRy+LCo
 wZZBKkDwJeARw9IoImrDoIQoA0knLXJyYkPcFpQGFBMk/3eV3a4FIMBR18XQjc8mmhYO
 JLaLRytj1IHqwnTd10onNa6RXi38d1jvFHNdrOn9Dx8QXa1/Y/0k3GHdR0P2ftw1eJtk
 7dYKuYMd/sFj2CgkFC0S7cGCMFnugKDP1KVn7JtY/hvQshLBtXuWxoVRtjtsuCVWvPes
 eCPg==
X-Gm-Message-State: AGi0PubeDwOCeMh3sp5lOQskaF0WYb8vpXkP5R+QyebrMDxS6fdCz5xg
 VBzZ3vSuTNIkHs183/gGhRvKhdyplvIO5g==
X-Google-Smtp-Source: APiQypJZbKGjMN5I0Qx70Gbvr2IR3EDbOQI3dTRk09lPpxdTzEYKpD+Bb2vRKx81y9ZHi4fEV5AwnA==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr2258511wro.112.1588247533476; 
 Thu, 30 Apr 2020 04:52:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
Date: Thu, 30 Apr 2020 12:51:37 +0100
Message-Id: <20200430115142.13430-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::436
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200423073358.27155-4-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 8 +++-----
 target/arm/cpu64.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 47e35400da2..30e961f7754 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2745,7 +2745,6 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "any",         .initfn = arm_max_initfn },
 #endif
 #endif
-    { .name = NULL }
 };
 
 static Property arm_cpu_properties[] = {
@@ -2893,14 +2892,13 @@ static const TypeInfo idau_interface_type_info = {
 
 static void arm_cpu_register_types(void)
 {
-    const ARMCPUInfo *info = arm_cpus;
+    size_t i;
 
     type_register_static(&arm_cpu_type_info);
     type_register_static(&idau_interface_type_info);
 
-    while (info->name) {
-        arm_cpu_register(info);
-        info++;
+    for (i = 0; i < ARRAY_SIZE(arm_cpus); ++i) {
+        arm_cpu_register(&arm_cpus[i]);
     }
 
 #ifdef CONFIG_KVM
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 74afc28d537..b8177f59f5a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -742,7 +742,6 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
     { .name = "cortex-a72",         .initfn = aarch64_a72_initfn },
     { .name = "max",                .initfn = aarch64_max_initfn },
-    { .name = NULL }
 };
 
 static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
@@ -848,13 +847,12 @@ static const TypeInfo aarch64_cpu_type_info = {
 
 static void aarch64_cpu_register_types(void)
 {
-    const ARMCPUInfo *info = aarch64_cpus;
+    size_t i;
 
     type_register_static(&aarch64_cpu_type_info);
 
-    while (info->name) {
-        aarch64_cpu_register(info);
-        info++;
+    for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
+        aarch64_cpu_register(&aarch64_cpus[i]);
     }
 }
 
-- 
2.20.1


