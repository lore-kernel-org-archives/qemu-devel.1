Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF51C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD395218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxH3ziJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD395218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FlZ-0001br-VZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgy-0004PC-AZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0001tF-8x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgx-0001qa-0P
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z3so7010630wru.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UM5sTdj2EYOtgEuwYW49VvaCFPwcbtuVqRLWhdo1ojU=;
 b=uxH3ziJk0qIPc1YVZiQQH+XoWOHB5dpNXtOuw2FKgNoVQv5xi0MmKvYZmZhB1VUt5A
 lHqQ6Nr0McGN5Z/dAOrkxHfk0aulpd6UBN8Dd7ZTcgTzkmYB9YSITIUgcE7Rp+UvEj4h
 DX2TcpIAKfG7HqDRIziSSu0l1guaZsoZtNCffPQV7+6NVPlFEeNI7iBACv3wD8c/hgBS
 UElWmnU3pzy/RpYBJ4Xcc4ltC5bBaDTJk4WnBU1BwHGGt26hc/U9e421QQvRIMJDsyet
 s2EaNr5A5uW3piTymqzeaQjfijtGzuxFjkss+DFGEz5rfV7gQItl6Qhu2r+7N/SMexaD
 qYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UM5sTdj2EYOtgEuwYW49VvaCFPwcbtuVqRLWhdo1ojU=;
 b=ICPdakCVMMU2oguG77aPLnBTZw+JTdmEpYFR44yhz0pBIex7S8PjqyDi4hGrAOAhl+
 e4MsEZyV0OcULXyHLRDASyTLhdWL3Y23hgLy+UIYRJ03qxHxtgFyMyhRfI7rkxVPWK2A
 o6zTB6+zesRj721JV5paXzGWOucKmstIKXSrDios1rx/ca3fTRIVj2cRaKhNLTfD5gRf
 S0UHBG1KiT45Sd/eymwc4oBqOxCK8GCsSmX/HPEhc4LLG3KvhCy2OIvajutFOVnNg0od
 xhJLk4qpIR1bkGASsxuZF7AlwFtI14Gz9dMWc6XoFIYjkNWMnoV/JoP+cjjvgz0Ip/8k
 4u3g==
X-Gm-Message-State: APjAAAX9sgBs8K/SS76a/KyKUTp5/0w5anf7NjM4tMFKyU9/6n9r3jJ3
 ImyG7Z9Lzzn4ChMNd+aDFi9HC3pWsZ0=
X-Google-Smtp-Source: APXvYqziaRDFKqcP9fPh/ja2IXC4Q/rOn/gUaeO2ip1QZbl/l0zqs8RHl33ZH3OwcZ7Og0NxYUjwXQ==
X-Received: by 2002:adf:c453:: with SMTP id a19mr22318154wrg.341.1581604927704; 
 Thu, 13 Feb 2020 06:42:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/46] target/arm: Replace CPSR_ERET_MASK with
 aarch32_cpsr_valid_mask
Date: Thu, 13 Feb 2020 14:41:15 +0000
Message-Id: <20200213144145.818-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

From: Richard Henderson <richard.henderson@linaro.org>

CPSR_ERET_MASK was a useless renaming of CPSR_RESERVED.
The function also takes into account bits that the cpu
does not support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       | 2 --
 target/arm/op_helper.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08b2f5d73e4..694b0742983 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1209,8 +1209,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
 /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
 #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
-/* Mask of bits which may be set by exception return copying them from SPSR */
-#define CPSR_ERET_MASK (~CPSR_RESERVED)
 
 /* Bit definitions for M profile XPSR. Most are the same as CPSR. */
 #define XPSR_EXCP 0x1ffU
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 27d16ad9ad9..acf1815ea3e 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -400,11 +400,14 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    uint32_t mask;
+
     qemu_mutex_lock_iothread();
     arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
-    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
+    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
-- 
2.20.1


