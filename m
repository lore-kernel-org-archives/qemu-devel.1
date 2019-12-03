Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30227C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E661020656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bT2K3/kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHwK-0000F9-TB
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icHom-0004Bc-H0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icHol-0006hE-BF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:56 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icHol-0006XW-2r
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:55 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so2633650pfc.5
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 15:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LDEaaXMkISHBRBQq2wWOEn0yi/1F+Nwrnq77hCMsb2U=;
 b=bT2K3/kCLVPgrnXrJUuITCBoXoouDNXGn+ITjOme4r9eyi0eeGLWofgQYgUwyx4hLs
 8a/4J5RPHckXgp2rdhfxmXy81j/QJjyMR6RxeC/9Di1Wuogp+SbmCCSsAtmayhqS14V1
 VZDS3nftwm+7N4f2wUuC8+4F2vtJJX8r3LPeSZM+XsAsOsZPmzdyBJtD0LuHIlCAQ/Hf
 i7j6UAVrrt8J8IMkHChDqc29pd2QlQHwksR8Riowb5jLAHEyttpki+v5SyYlCCp9tUib
 gxzb4YsGhq/gI2SXkOYe4FLtI4Lluxvzg/8sVf+itPrHUzzCuiAIiPQa9zXkdyoxG+Og
 Scjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LDEaaXMkISHBRBQq2wWOEn0yi/1F+Nwrnq77hCMsb2U=;
 b=PSq5aqkVJsebGrAb0P50IRcORr6zW+dbd7Zxbp8iW7IRva7xq40+hhFaH9PegTIcVr
 LMw51Xeuwm9MiZfUoqKalQPurbZH3TFSUXR0FBYyn4N8FQNeW8PtHX8kb6sxZ+Wm9nOh
 HDiFdOIUBYY4lXkacWGcLAgWqQ2vSZ1yZuD1sjeUIku5P/oh8nnsGywdPZlE6RKMJFH9
 t+Mii95NgbYCqeKq7d3i93aP6gmSwSPp/So5m5SZQvc0m9Quz45NTPn9jOQWm5f57/qb
 ZyvwOEqhnSzhANdvdrkBxG5PS98N0A6p+5TA4rDH2LJikhqsA1UuU4j7vco6xjholsVl
 olLQ==
X-Gm-Message-State: APjAAAVpNzH7dazM8IVUQwC+G4aeAK3pWVIkuSLdAGfVXnIWIANdAXkd
 K9xOaaQiQOqiDSAJ7qI3pyG9ejk1Jfc=
X-Google-Smtp-Source: APXvYqwVJHifGdBZ2XKr61kQnrDwZUvQAdC5IsUGSe4q2WNvsK4vZ5I7zag1G3hmG+/PJwBawNimHw==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr510848pfh.240.1575416571689;
 Tue, 03 Dec 2019 15:42:51 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4128256pju.14.2019.12.03.15.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 15:42:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Enable ARMv8.2-UAO in -cpu max
Date: Tue,  3 Dec 2019 15:42:44 -0800
Message-Id: <20191203234244.9124-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203234244.9124-1-richard.henderson@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9399253b4c..03377084e3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -674,6 +674,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr2;
+        t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        cpu->isar.id_aa64mmfr2 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
-- 
2.17.1


