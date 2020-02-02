Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C403C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E504A20658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvJbbi/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3jq-0001Jf-3h
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h5-0003nq-IE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h0-0002AK-JQ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3h0-00029E-CN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:54 -0500
Received: by mail-pg1-x541.google.com with SMTP id s64so5713299pgb.9
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=kvJbbi/e/ah++Z8bA/jeiNK/zEI8r+LxCSD2L8Lxo5j+OSUFuisYSgMiVvBOZheMZ7
 oRX4ZCxjIA3W0hknMWH+UXvHInePAb5qk6wMlhLsDks14BjDegd4kFg0dS+fBjcUgsyq
 MlyliUefO/Gv6xYraceKqStJs7n+n/rm/GlDlw1gU5QMas5ftWBtlAWIRJ0H2Ut/jwhx
 V9KG/90ff3HdZQVN/XdXmKZrxhugBolpqtDfxoeejDW7nYYb2b3mwTo5QmH0ZyOc/Bn9
 EAGA2ZWy1o9gf5zmHZOsID1b/C0TsQmx8LhtShoILlvyaXx/AY3gaLfGTgzNXyW7E79E
 +RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=DJSdE6tcngm0rmpEnArvCZjjO4rau7t4rkZ7DJjxZcRYgTc0Q8wWpMR40/45ZB1pn7
 0qGpgkydWu8L9EjK9erZgSeZ4+JvytRDoU4lz+5VnP8/tfrh38W5/JNW5Fyjke8PrOro
 YTSv7nbwyr7LJioqqGy/8iYP8oH9a9+0U6PjAXmwM2G7F/1kiGyPZp2NHfV9ycxZeA25
 HYV+dX75/yPGPOkf7P84xeXUSyuqe0fgmTvXXgVtntWphIneOH8cU5XSGZhSfCwG/V8X
 QClot8toaEGRH68TctX0iSx3ilxuSO9I/F123mHYighyibm4+g1snW7G9iNuTDuMI1IV
 rUFA==
X-Gm-Message-State: APjAAAWkteV/p9+lw/EBAFBctJhbMQs3RHng4mOBRdXZrGH0XOmAb4VY
 6ydmYPLkRXsm8rgvncxxPbyfrYVO/cE=
X-Google-Smtp-Source: APXvYqwebZoX+QwJCpH7ZyngcTQRhVgKKtEYExmKLVBaQzzRghWDIkODVpqGwVNcwvziY1cOs63OQw==
X-Received: by 2002:a62:788a:: with SMTP id
 t132mr17931725pfc.134.1580605493230; 
 Sat, 01 Feb 2020 17:04:53 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
Date: Sat,  1 Feb 2020 17:04:35 -0800
Message-Id: <20200202010439.6410-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes enablement of ARMv8.1-PAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/cpu64.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b0762a76c4..de733aceeb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2709,6 +2709,10 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
             cpu->isar.mvfr2 = t;
 
+            t = cpu->id_mmfr3;
+            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
+            cpu->id_mmfr3 = t;
+
             t = cpu->id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             cpu->id_mmfr4 = t;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c80fb5fd43..57fbc5eade 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -693,6 +694,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
+        u = cpu->id_mmfr3;
+        u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
+        cpu->id_mmfr3 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1


