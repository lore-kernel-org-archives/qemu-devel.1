Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B11C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64C020658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPos7bLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64C020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtzH-00069g-Vn
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXo-0003lR-J7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtXn-0002Jo-1A
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtXm-0002A3-MZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:28:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id t13so12654169wmi.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rvaiifYyk1RViqBZpnA3TLxfK5zQc95A6+zRBD5/52M=;
 b=FPos7bLbtVGgbCB5ORjcjH1hMavXhVb44sAoP/fHBoS2tEKejLToGziqcOqnhKYWdn
 47cA+PK2PMnN9QR8ojn0Hs4OrpO3HSceXk/aBU79ACfwljwAhav0FAAGu0myjrmVLIW2
 kCDR+DdkMnSmMBaYzRkhBWmRw9bJDjp9M98DpV9gmbP9a859RWBFA8Z/vcVCrMVIJTyu
 sY+U5iXTYbMpkIp4PkEgpPl74up/3eAUVEvpqL1eJqi6DzmHRc7NYNwHRrmtACDaKSee
 q/xJgYbeJXr7ZbSfgH7a4epo+ts2fQXDCjPVNNpqmxCSNCA01sS5lGH6b6hQ7XBmqG8P
 begA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rvaiifYyk1RViqBZpnA3TLxfK5zQc95A6+zRBD5/52M=;
 b=CB60BIatgXog1f6hQHrvCevh07v/4VHCrcG2IKDB/ogKW8TjwZS5EeYgJSz0DUStcv
 91X0MxJLAU8iwsXw2sPKp2Ry2vnnigRTdbN2Sh7ob7LbfkPlTUkBgbMsPo+usLiVVsb3
 yB168uERuGbYcLAPAdW8TBgGwC3R1hoOuTsBJk4K0w4014i9K+vixVZfFb7zNOGAOjR+
 AS3yOJQw6fAHi3VRr6c026TLMQSYowDWuwROAsKBkMrncSJiRZiuLSp0iRV9du1hk+1d
 Hz+6L2MviK00hPj0n15870vRUOWWyFd/cYI20SUDw63xuuo3xM2YMFdWPpLRj6HzoHSy
 3OQw==
X-Gm-Message-State: ANhLgQ2YB7WV1C5z4QCOAvU6IuiOSV79jI8D6VZSuUYh3y2AMWMbJdbO
 jK/NSukg9bHDmx39qj5/8ejH9Q==
X-Google-Smtp-Source: ADFU+vsoILpgjQ4Ub1NvESZwH0gNTN69XRh69vh8mikRXMAhTz2ctFJi0b5swPmodo7e5M9/Lo/L4w==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr206700wmk.104.1584379728017; 
 Mon, 16 Mar 2020 10:28:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 19sm497839wma.3.2020.03.16.10.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:28:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C17A1FFA9;
 Mon, 16 Mar 2020 17:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 19/28] target/arm: don't bother with id_aa64pfr0_read for
 USER_ONLY
Date: Mon, 16 Mar 2020 17:21:46 +0000
Message-Id: <20200316172155.971-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For system emulation we need to check the state of the GIC before we
report the value. However this isn't relevant to exporting of the
value to linux-user and indeed breaks the exported value as set by
modify_arm_cp_regs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - extend the ifdef and make type CONST with no accessfn
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e560ea7db6..d2ec2c53510 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6697,6 +6697,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return pfr1;
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6707,6 +6708,7 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+#endif
 
 /* Shared logic between LORID and the rest of the LOR* registers.
  * Secure state has already been delt with.
@@ -7280,16 +7282,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * define new registers here.
          */
         ARMCPRegInfo v8_idregs[] = {
-            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
-             * know the right value for the GIC field until after we
-             * define these regs.
+            /*
+             * ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST in system
+             * emulation because we don't know the right value for the
+             * GIC field until after we define these regs.
              */
             { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
-              .access = PL1_R, .type = ARM_CP_NO_RAW,
+              .access = PL1_R,
+#ifdef CONFIG_USER_ONLY
+              .type = ARM_CP_CONST,
+              .resetvalue = cpu->isar.id_aa64pfr0
+#else
+              .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
               .readfn = id_aa64pfr0_read,
-              .writefn = arm_cp_write_ignore },
+              .writefn = arm_cp_write_ignore
+#endif
+            },
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.20.1


