Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A8ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F602064A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcEbAnS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F602064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Ye-0003Wa-RH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qA-0004Mq-EV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q9-0007XX-6A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q8-0007We-W0
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id v17so17293223wml.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=C8dDTm+pBJ7w7o3eqgdVHBPmAG/ZZRtvP5rfV89Jwa8=;
 b=rcEbAnS5HgLrzGOslAS+A18cA2WG9DietZN9edvXwg9uYZmaguNi2CqEq/AgmNKxc1
 TME+Y2MYWmTNEyJ2oAdpfSnF346o5nsOBjxfgkrbc3CTEyVBFD3zdDabhRVQ1651KP3l
 UZgmhPqFJ8ZILAiQlIwsU1AN1xqKiMJQG8qL5IjYg678UbS2Ma66EFu38YKBLR0dOxV3
 4HJEm889DLIAJ+mR9l1Bd86GiFcvLQS0SpUHAsC+oZacdbeUr3vJ3CfhKjHk6TXV87cD
 yPqadZmkLlg1Hm9XBEJPCxxK9BEaYPRj7MwH1Zw7ZPeN16Yjfb3LNgzpNlY015qbsg1C
 Pdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C8dDTm+pBJ7w7o3eqgdVHBPmAG/ZZRtvP5rfV89Jwa8=;
 b=A2XptBu17PPlG059cBkEVt1pFImItCLI7Sx5jthBTIZaIUHfYTkj970E3Azsj2Qy4i
 m8vQLIE1z3iamdtsHvVF1rJGRbUzWfqV1RXf/3kchTK7TBqoIsrnYiOsX3h+mbm/YpkZ
 /BBeXdtSEyxrcKo6WTHpPYYgNNfuhNlr/MB+0+IdhKYvuYkFZWNAT80xVz4WY/GWyC6F
 JIhykwp9OU0kb9Q/mzF+wymR+NtOGk2WPtmZ+NVtyJxOp1qjgeG/YKciQO3A0MAbWycJ
 hSl6XtPMv2A28NFBss0Dd2oEbt/liuHdIpFQfTUIBDWRIfp+5o5grf5vA0lEtBy0UbE4
 B7lg==
X-Gm-Message-State: APjAAAWvhEfmQopdizcuAcgd78L56OFDL8jNPWv0ZKD4VZD+4m3CzKgd
 aaS2a/hsDf4GCQaL2gib+m3ZFFCp/Q3Ntg==
X-Google-Smtp-Source: APXvYqy9kESmM+IfVYDJpwUSl7UeZJ2HhFWjxRnqWg5jqI08YaeQUjg5nTPb/vtuGrH8M+V5pb9zQg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr16478411wmb.89.1571069095536; 
 Mon, 14 Oct 2019 09:04:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/68] target/arm/arm-semi: Always set some kind of errno for
 failed calls
Date: Mon, 14 Oct 2019 17:03:22 +0100
Message-Id: <20191014160404.19553-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

If we fail a semihosting call we should always set the
semihosting errno to something; we were failing to do
this for some of the "check inputs for sanity" cases.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-3-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 45 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 03e60105c05..51b55816faf 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -232,11 +232,13 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
 #define GET_ARG(n) do {                                 \
     if (is_a64(env)) {                                  \
         if (get_user_u64(arg ## n, args + (n) * 8)) {   \
-            return -1;                                  \
+            errno = EFAULT;                             \
+            return set_swi_errno(ts, -1);               \
         }                                               \
     } else {                                            \
         if (get_user_u32(arg ## n, args + (n) * 4)) {   \
-            return -1;                                  \
+            errno = EFAULT;                             \
+            return set_swi_errno(ts, -1);               \
         }                                               \
     }                                                   \
 } while (0)
@@ -287,12 +289,13 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         GET_ARG(2);
         s = lock_user_string(arg0);
         if (!s) {
-            /* FIXME - should this error code be -TARGET_EFAULT ? */
-            return (uint32_t)-1;
+            errno = EFAULT;
+            return set_swi_errno(ts, -1);
         }
         if (arg1 >= 12) {
             unlock_user(s, arg0, 0);
-            return (uint32_t)-1;
+            errno = EINVAL;
+            return set_swi_errno(ts, -1);
         }
         if (strcmp(s, ":tt") == 0) {
             int result_fileno = arg1 < 4 ? STDIN_FILENO : STDOUT_FILENO;
@@ -413,8 +416,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user_string(arg0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                errno = EFAULT;
+                return set_swi_errno(ts, -1);
             }
             ret =  set_swi_errno(ts, remove(s));
             unlock_user(s, arg0, 0);
@@ -432,11 +435,12 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             char *s2;
             s = lock_user_string(arg0);
             s2 = lock_user_string(arg2);
-            if (!s || !s2)
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                ret = (uint32_t)-1;
-            else
+            if (!s || !s2) {
+                errno = EFAULT;
+                ret = set_swi_errno(ts, -1);
+            } else {
                 ret = set_swi_errno(ts, rename(s, s2));
+            }
             if (s2)
                 unlock_user(s2, arg2, 0);
             if (s)
@@ -456,8 +460,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user_string(arg0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                errno = EFAULT;
+                return set_swi_errno(ts, -1);
             }
             ret = set_swi_errno(ts, system(s));
             unlock_user(s, arg0, 0);
@@ -517,19 +521,22 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
             if (output_size > input_size) {
                 /* Not enough space to store command-line arguments.  */
-                return -1;
+                errno = E2BIG;
+                return set_swi_errno(ts, -1);
             }
 
             /* Adjust the command-line length.  */
             if (SET_ARG(1, output_size - 1)) {
                 /* Couldn't write back to argument block */
-                return -1;
+                errno = EFAULT;
+                return set_swi_errno(ts, -1);
             }
 
             /* Lock the buffer on the ARM side.  */
             output_buffer = lock_user(VERIFY_WRITE, arg0, output_size, 0);
             if (!output_buffer) {
-                return -1;
+                errno = EFAULT;
+                return set_swi_errno(ts, -1);
             }
 
             /* Copy the command-line arguments.  */
@@ -544,7 +551,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
             if (copy_from_user(output_buffer, ts->info->arg_start,
                                output_size)) {
-                status = -1;
+                errno = EFAULT;
+                status = set_swi_errno(ts, -1);
                 goto out;
             }
 
@@ -614,7 +622,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
                 if (fail) {
                     /* Couldn't write back to argument block */
-                    return -1;
+                    errno = EFAULT;
+                    return set_swi_errno(ts, -1);
                 }
             }
             return 0;
-- 
2.20.1


