Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCAAC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFBA2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DX5wfvfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFBA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvcs-0006qE-Lk
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvNI-0005eH-3Y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvNG-0003t6-Ez
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:39:04 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvNC-0003pm-MM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:39:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id x15so22297600pgg.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rCEnVED33NpbOad0FfG1c7z9lc80+f3mCsiBq0HqyvU=;
 b=DX5wfvfhHx0n2P2s6jl6RwziKqDkDxXUOzDh7/6cIrZEbTQqGsEd+W+FyUdIZ0RkGw
 P5arA1F6Y8ZC6vw5DUFCrz/he4PxGXmFRQJF35Dw3jLQEFo+QFxAjy61gKKerwr2lk9Y
 TNewzFtsTvvoWeenZLzItpoSeulZVmILyKKjRMeSM81X+JANzAn3L9ivEeaDzkmGZVU3
 3rj2vJoEBSFbi8KNDlqG0VZJJ8ZEzVM3H17Y25SD35h6qqPZIAjwffvfOAsThAcK2M+l
 N52mDMflXcUB5Yl1qa1LhqLtrlMBOvc6TFUfo1iJuI3xal2npnqXgi2PbtiyCOTWmc+n
 XvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rCEnVED33NpbOad0FfG1c7z9lc80+f3mCsiBq0HqyvU=;
 b=D5Ph5Lqq7v4om4m69mw5sVFAuBjIf6rYqMISxjy3d0ocQUnHZrQAG8l/5pESu/W5oR
 ZKFgVwfbM1362/C4SPKef9G2LWj3CJ6/wpSEd06H4gJ7WGAc/xU6OGQm8D4mL1L28Toe
 pOt5tiXqzexTlXDhLPX+aszLwZgFx8xJubq6qxcRelb59mwM18q/jyaeB8jvWhwYjKVI
 FdUW2jhXbWX0DfgEWmBNd5faylPdZLJieBCzs20JZGPsaPgjhLNlv6qVvSY9gt13H+x8
 P8W+Dg3bblOWOfeb0qqrvtSh1+veeclhziytXw1BW9yZm6tqWBtxR30N7gJmzIAePD/C
 8fGw==
X-Gm-Message-State: APjAAAUGvYcczvsuTI11/g7weyBzUZbCrE/oMvfBvIrQc3BBVOfJKExz
 OPezRvrs2aSg/ky5qjMrEa2vNxvPq1U=
X-Google-Smtp-Source: APXvYqzT69kO8SA8gFvdvWnfzS57ZpuhMi0E9khqmPD/SwfJjVZy7cSrTQm9JoqEoxEuXVAW+pCVeQ==
X-Received: by 2002:a65:430b:: with SMTP id
 j11mr113663987pgq.383.1564605534112; 
 Wed, 31 Jul 2019 13:38:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:13 -0700
Message-Id: <20190731203813.30765-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 32/32] target/arm: generate a custom MIDR
 for -cpu max
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190726113950.7499-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   |  6 ++++++
 target/arm/cpu64.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c41da1d791..bc9b6db9b4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1605,6 +1605,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
 /*
  * System register ID fields.
  */
+FIELD(MIDR_EL1, REVISION, 0, 4)
+FIELD(MIDR_EL1, PARTNUM, 4, 12)
+FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
+FIELD(MIDR_EL1, VARIANT, 20, 4)
+FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
 FIELD(ID_ISAR0, BITFIELD, 8, 4)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b1bb394c6d..3a1e98a18e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,25 @@ static void aarch64_max_initfn(Object *obj)
         uint32_t u;
         aarch64_a57_initfn(obj);
 
+        /*
+         * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
+         * one and try to apply errata workarounds or use impdef features we
+         * don't provide.
+         * An IMPLEMENTER field of 0 means "reserved for software use";
+         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
+         * to see which features are present";
+         * the VARIANT, PARTNUM and REVISION fields are all implementation
+         * defined and we choose to define PARTNUM just in case guest
+         * code needs to distinguish this QEMU CPU from other software
+         * implementations, though this shouldn't be needed.
+         */
+        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
+        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
+        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
+        t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
+        t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
+        cpu->midr = t;
+
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
-- 
2.17.1


