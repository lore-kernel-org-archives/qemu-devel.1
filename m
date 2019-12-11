Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E14C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D7E20409
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORQaYPXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D7E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5dR-0001iT-Kk
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QZ-00050E-P9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5QY-0003AH-8G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5QY-00038z-1Q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:05:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so24896955wru.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lyIoUe/ZVUEe7f58GiHMN33OAajnqHTLc8UAK5dR3Hs=;
 b=ORQaYPXDUmapxEgYA4QmzGPpVypfJbsTXyYnvi+cpghEHkOg+SWGhyzNiT0pJbJ/IH
 nBStOt8fawHG7oQ5Gp4t0ZD1NTXyc/8dqIyeLOgKn1H5lOUWVlSbxsuXVKbjG5GBab1A
 DWEtVEtlUcYDe35OY2fx4JGqUJjO9vT64MBuB3QFrywc21ZYUeWVXecjQSUp/2OP+RA4
 xw+OD2/nYSWJoYZAxSOnB+p6lve3FhBHBaFFmDYKoFYOcZ0Ofj6Ar8cqATePhFo5SKxl
 Ozr6Lf4GFjRdP8/g68QN/FuziInwLniGAtKmc6e7To4ajmagfmsH8u8Fub+eQEnqEKtW
 7YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lyIoUe/ZVUEe7f58GiHMN33OAajnqHTLc8UAK5dR3Hs=;
 b=g1IkmgTJpGlWYBS1FXg6NGJMq1ZI/iYBkFX6iAawZJYugi/OEIlsMlqfIcNOoqrqsB
 QYaV29Tcc0ykTZEmvLdIAi8V2scv5ZGeDswgGY+ThOEA5mt4O6M6/pIeRhjAtcXu5k4l
 XsLmQviOc2z7Oizxo2GDBJGxzYx+RmaSyVXi7z8aSFTUebSi+WXNzDXEfx5hVnkXm0xc
 dHH9hDrIiI3TIfbO7BqJHcO0YJKHUKifPv0NGq3vBL+sryTEfR+hE+2K6ZiRDQD5xa6x
 RsXo07hN4p12+mTsbAMnitZKubk6UikqQoDYq8l2fS1eIYvd3bc1jc+UzYTh8AOPb9O4
 A4TA==
X-Gm-Message-State: APjAAAWPi0X37ped7fmZdzy+v+3iOhZNfZCLb+GsdPrCCdmhxfi0fv5r
 oaUb11uZDqNsAIzbbWwjEICutA==
X-Google-Smtp-Source: APXvYqxBBLNCVL4ujlJpoOfQ4xuIHdOvTJjpvp/5kT5y6mNziWpAWtIZ6IPyEVqxxKqnxYLX9cUoIw==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
 i6mr912446wrx.178.1576083928928; 
 Wed, 11 Dec 2019 09:05:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i127sm2918724wma.35.2019.12.11.09.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:05:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3F2C1FF93;
 Wed, 11 Dec 2019 17:05:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 06/20] target/arm: use gdb_get_reg helpers
Date: Wed, 11 Dec 2019 17:05:06 +0000
Message-Id: <20191211170520.7747-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2
  - make sure we pass hi/lo correctly as quads are stored in LE order
---
 target/arm/helper.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b8..0ac950d6c71 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -105,21 +105,17 @@ static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
-        /* 128 bit FP register */
-        {
-            uint64_t *q = aa64_vfp_qreg(env, reg);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
-        }
+    {
+        /* 128 bit FP register - quads are in LE order */
+        uint64_t *q = aa64_vfp_qreg(env, reg);
+        return gdb_get_reg128(buf, q[1], q[0]);
+    }
     case 32:
         /* FPSR */
-        stl_p(buf, vfp_get_fpsr(env));
-        return 4;
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
     case 33:
         /* FPCR */
-        stl_p(buf, vfp_get_fpcr(env));
-        return 4;
+        return gdb_get_reg32(buf,vfp_get_fpcr(env));
     default:
         return 0;
     }
-- 
2.20.1


