Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66986C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA21920675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYI8mMwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA21920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9ts-00016G-OR
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:17:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r3-3L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kV-BP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006R7-08
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c12so17089247wrt.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BkAjqGaX0B2OxEPEkgjNPx5AhDVspw6+QJQ8/auHQ9M=;
	b=XYI8mMwFFqY3hfdHQbRv5xTBpJSGaPcyTIAOnDBB/8rzZ5mUdesczoxV0DFATMDiBk
	sUwR3Pc7aTXjYBjpg6GKxUMFzGBu/GISZWdu3/MK/EETz92lce2OYbBJuVSCUlY5CpOl
	P2misckoZlUc3EpM/efkXl9aeHx9uk3ys86cGQvrhzcq6JuOkhlG9Ktnt5WeW2LDRoHF
	+EDo08vOGBGXwIyEHm8f4gsiJzkzqOentvk/eNlxDeU2hyokAdufPXDBj6HlAZVvNsBN
	bAdbpALqBWg7QbW3Ge8zhkNyoZZa1PSDTEcYvXSx+5QC11g88JpSTvmJSUwdVPZQkDYl
	6BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BkAjqGaX0B2OxEPEkgjNPx5AhDVspw6+QJQ8/auHQ9M=;
	b=pNaMP5uv02IBb0AULX/Me5OsxL0C8MxWmDLmjZgDG4v5xlYvl7TghbIHp3gzCXhXyU
	B3y1N/AAwknqDaTuvvulA4RuTIxdUTeiTkatKZZRNdAFDSoL89560F6dZRyG2a8CH+I8
	5hJCVSV6gNmGP+pAii3cM2pr/ZUrmq/OHFl6JRve6osWU2ewva9SoDLRJ3HGGUTWs9/B
	b1zLew/q7jVFetK9dWx5zlw1RReU40F8RmzedOIcfZlzk5u1gXRWT0kW5vujyKccd1nf
	ojIYQLQkyq1ZDsEVF9SZ7AqgYOO8kciMny67sdhydZ+t1GsapoUg3p05Dt6sfgh3R/X5
	1uhg==
X-Gm-Message-State: APjAAAVPb13PsAwN/BvieodhQT/xTvXCQC+RVvrU0Wgrm7dU409pgyMQ
	c47JmkaEcXTc+Elb5hgLraGIp9Q0WoQ=
X-Google-Smtp-Source: APXvYqxp+8XJskD7/f3IN6qiZJrhICmv27BD0/zoJcP+fRknlWyrsrDsAuWaBr9FOHE+7PPTv1ygrA==
X-Received: by 2002:adf:c002:: with SMTP id z2mr42931189wre.177.1556557252960; 
	Mon, 29 Apr 2019 10:00:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.51
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:04 +0100
Message-Id: <20190429170030.11323-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 16/42] target/arm: Clean excReturn bits when
 tail chaining
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170004.USNuvJQ7Q9Q64iJnDQqDn_XoN4JOJLBhaX6rD4qTKDk@z>

The TailChain() pseudocode specifies that a tail chaining
exception should sanitize the excReturn all-ones bits and
(if there is no FPU) the excReturn FType bits; we weren't
doing this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-14-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 088852ceb96..da0b6202400 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8076,6 +8076,14 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     qemu_log_mask(CPU_LOG_INT, "...taking pending %s exception %d\n",
                   targets_secure ? "secure" : "nonsecure", exc);
 
+    if (dotailchain) {
+        /* Sanitize LR FType and PREFIX bits */
+        if (!arm_feature(env, ARM_FEATURE_VFP)) {
+            lr |= R_V7M_EXCRET_FTYPE_MASK;
+        }
+        lr = deposit32(lr, 24, 8, 0xff);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
             (lr & R_V7M_EXCRET_S_MASK)) {
-- 
2.20.1


