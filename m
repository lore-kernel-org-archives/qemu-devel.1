Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E81ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1532A217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NItQnYJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532A217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3dm-0002U2-SD
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qG-0004Ve-Lm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qE-0007dr-MA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qE-0007dD-Fh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id 3so17312063wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=P12DoS+rA3nBtcPr1QDa4HW7BsMEp7pCZK2/B+8/vgI=;
 b=NItQnYJ9Qg5ptNQLqapJPCtDu6XX037a/wPhMuv+iPfyjKnVKUMc2tSWfLWX3J1C74
 OHoWvH2zKnQAjNxpbcT1OI721FgWPHYtWMvQHSofLXKIChhlk/GQN29e9QshRy1oq/Hf
 0T5SkVQ0EBZHlHTSuRqm1IrwIcMhURjO87mdRnteWesq0yDswDJHFLEFTrbr58GuJrtz
 LrPJwFA8ACUCBHRYr8ccxpzaaUvF7LpslzrNd8C+MxLr/Z2ByIfyuqbN++5b05myKrei
 rA48GORkCfwCveqAJNTjBMkBiqzslFH6G62DKvMAGkiBSwjwsCakElSbHW8tdYGMahjY
 Jc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P12DoS+rA3nBtcPr1QDa4HW7BsMEp7pCZK2/B+8/vgI=;
 b=OYEIyTiigUmQpB3cXi2KR1lNUhsMItwcIQz19EVp97Lz/V13duiHB0q0yvOLzc/PZ9
 BEGCtBO4q9aPAlWoqyepoDpvG6T1D0bup6RVt1eVcRmNUf7gBNLnLwK2koF6SKTHWsr/
 UYs9nFZy5KoWjwSmxvfN+VR07yXvp9rXIPK+71Wn/+t3Dy6y7y2nkG57SHI6GJOtSqbT
 7gQREavLjscr1vwHpRRxd+arEBQtux1coLkPOf79PALDKzY9OBfPoQF4lPRUR68jGAj/
 fWcSbsfWXEED/cjaRVF9yZV4krhRHZ0p9Sdroy3V+KHFNnspGUdawDF6vcfb0UW0y5IP
 VLgA==
X-Gm-Message-State: APjAAAW0NbtDf5oNfO6wKw5RNoKHI0ne9A7Y/aAx/i3H0e6IHBDpXFXK
 i90x6Go7is4kcbyhMyklpUTeuHEIsOOiwQ==
X-Google-Smtp-Source: APXvYqzCeHwGgzWJN8ndMOYw5GNA69xe5HbBc+j6CmO1QYr3LsvMD96x7ckG7RsgmDnODCgEooju0w==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr16483069wma.39.1571069101239; 
 Mon, 14 Oct 2019 09:05:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/68] target/arm/arm-semi: Use set_swi_errno() in gdbstub
 callback functions
Date: Mon, 14 Oct 2019 17:03:26 +0100
Message-Id: <20191014160404.19553-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

When we are routing semihosting operations through the gdbstub, the
work of sorting out the return value and setting errno if necessary
is done by callback functions which are invoked by the gdbstub code.
Clean up some ifdeffery in those functions by having them call
set_swi_errno() to set the semihosting errno.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-7-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 2618588076f..02cd673d47d 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -259,17 +259,11 @@ static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#endif
     target_ulong reg0 = is_a64(env) ? env->xregs[0] : env->regs[0];
 
     if (ret == (target_ulong)-1) {
-#ifdef CONFIG_USER_ONLY
-        ts->swi_errno = err;
-#else
-        syscall_err = err;
-#endif
+        errno = err;
+        set_swi_errno(env, -1);
         reg0 = ret;
     } else {
         /* Fixup syscalls that use nonstardard return conventions.  */
@@ -326,11 +320,8 @@ static void arm_semi_flen_cb(CPUState *cs, target_ulong ret, target_ulong err)
     } else {
         env->regs[0] = size;
     }
-#ifdef CONFIG_USER_ONLY
-    ((TaskState *)cs->opaque)->swi_errno = err;
-#else
-    syscall_err = err;
-#endif
+    errno = err;
+    set_swi_errno(env, -1);
 }
 
 static int arm_semi_open_guestfd;
@@ -339,15 +330,9 @@ static void arm_semi_open_cb(CPUState *cs, target_ulong ret, target_ulong err)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#endif
     if (ret == (target_ulong)-1) {
-#ifdef CONFIG_USER_ONLY
-        ts->swi_errno = err;
-#else
-        syscall_err = err;
-#endif
+        errno = err;
+        set_swi_errno(env, -1);
         dealloc_guestfd(arm_semi_open_guestfd);
     } else {
         associate_guestfd(arm_semi_open_guestfd, ret);
-- 
2.20.1


