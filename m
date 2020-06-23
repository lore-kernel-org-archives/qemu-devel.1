Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0818C206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMGn71k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0818C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnp66-0006Ab-7Q
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnokB-0005ZS-ML
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok7-0005xn-G6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id e9so11600pgo.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BIDI4y8eFVZNzUa8YjAQRJHPznr6ueMv70vaNDO/hJo=;
 b=EMGn71k/3JlSw7+jy10c1fOQ2PLVQgFaTYgv5Wn3Mu5p6pOq6cXXIdeHjA3CM7CBm6
 CDuxnVxqHaClWrhmrLfHvrs9g1/0flqWwozVbs3A66QNBX7YRqivGhZbkiT3uNAfaU9g
 YtzqlwJKr6XYynwx2ZPXoS9QHtZRUcXCDtCj4WDyeMXBVayrLXPBXmsOnaNxnurzSE9P
 FmJ8RSJAR+C5EYmrGhWP6eg6BjbEdcbe/IlEmQGsG5OrbBiVz4eYVSXl0sSF9ysesizZ
 i6WIMW4tOL8ywte8TTDd5eIs1ybpDwwWUCnp4QWrzlAmYaamRcbSdFQXEhHY197NkYaV
 GH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BIDI4y8eFVZNzUa8YjAQRJHPznr6ueMv70vaNDO/hJo=;
 b=slgZlsaxIPcf7Wwt3uwH+3dtKP5CI2zdnEUFTuF8pJmY/A9snPin+39tfhDxmaY12z
 xtMUtrJTj2kcCjOj8JdXYkMILp9T0ropSPYJTW/2a7XRUrIqjEeG8wjB4gtBJqj7qVS8
 gY3pWQ2puD1elZsL3EFZ5Cvp7RM8OEp5rRD4ylxg2C0XYIRxcdZQAUNBtZ6eStmqTmTX
 LgBLdWrjkICE6FljdmW+H/2UcFDb5N5QczQNf7D4gBQaatR62tmhrTfFVKNImWYSXb8T
 OQ807C4qlKU1U5PF2qhtGxMher2vEYXMUHyCBcvC1VjngsfejnowzzPquENI+h+duBsg
 KPwQ==
X-Gm-Message-State: AOAM532vRJ2bzpX2Im73QMtPbHxOdDDfJgukGCy/gXkscj2lqq85EAsm
 5ZiwAFlWjM13KEKa5gnI2m2IK6Y7bzE=
X-Google-Smtp-Source: ABdhPJxJYlUAbDbxwEDI0gUEPYTQyYaWRG+SUxX4f9jLIbj76KPl6nvqvl8SN0Id6F2CQtANDdwxog==
X-Received: by 2002:a62:8fd1:: with SMTP id n200mr146449pfd.3.1592941081904;
 Tue, 23 Jun 2020 12:38:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 45/45] target/arm: Enable MTE
Date: Tue, 23 Jun 2020 12:36:58 -0700
Message-Id: <20200623193658.623279-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Delay user-only cpu reset bits to the user-only patch set.
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 778cecc2e6..45b0ca7188 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,6 +654,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.25.1


