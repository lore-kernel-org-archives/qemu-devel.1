Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6DC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B57321019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgiYbb/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B57321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hQr-0007rN-60
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNk-0005Nb-21
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNi-0004yO-JD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNi-0004xl-CG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id l16so20757129wrv.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z9gxd6ZnA/tu16GX4u76t9CmQTv6s8qenU28wrY9d9Y=;
 b=WgiYbb/m97Pv6ppe2CbKzjKpvS7dFJb+zzJ+DkMmn9q2TdNEUxLAo4aizxIfdunzfr
 0hM9q+hAi3EHbk5AP37qhV8rBEDQkM6YA8JTF8wGv6vqDDeJ5d8esuUTbP0zdkx88l81
 DvehzHc7ZCldsLYEEUoL5oanNjtjKcJvZatrEjWSa3h+x7/0LsRYm1SD3Zj2+51MI/AP
 3pxqFfop6EMdCqsf3OOAjDuyqBgoV8Q+x3CzdML6uhQ0+3FZnP1O+D8rpnA389ezLgpd
 vWI25Ku1y+Z2Wkrdcwn2ZKBnwonO9MJjzDlOsg0AoGdJcqE5dw4syy4ABW7YJXXDU0u2
 XRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z9gxd6ZnA/tu16GX4u76t9CmQTv6s8qenU28wrY9d9Y=;
 b=oso/Ofr5YeS1J2rZbkDvMaHpUoVf3kmRUsmZE6JX0ywUss2ealOENpyAEC7NiJg34r
 M4vbb4o+o/n9n6GbFAwBuR3UJQC1Qy/JpDTsiM50UC1QCWaUn2a1r2h50fntju3Eb02Y
 ch0gFp5vDXD+/f/V4fCKQn8U1RAYWFf37kUP6bCRdZCNhyj0n9H0WvhvLQbdllKNVN+W
 gD4K9Ra7eHz1DmS3brMWvl17nYeXcd3LxZNDLMNfqthV/3hyrpDJxraROoWiCty9872v
 lJzS7XTtAbrFjSssv05noq+nUCLqHnOQa2JKKNRAjJrnj9esr0oF7FGVWffx1G0/LlhD
 0Egw==
X-Gm-Message-State: APjAAAUP5qEsrCKIJSxejlFcBonMQPPymmADX/9KGfI0rI4Fmo6byhhp
 Dsy5RH6MGIKRJM1ne50Wda82fg==
X-Google-Smtp-Source: APXvYqz37Tlr0pxMNEb8HAnTxvTlANhfgH6rntGG7xY/w1m0zgR9k+RJY3Rz6SAtNKIywz9T29iMHQ==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr27913008wru.249.1568126673412; 
 Tue, 10 Sep 2019 07:44:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:17 +0100
Message-Id: <20190910144428.32597-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 02/13] target/arm/arm-semi: Always set some
 kind of errno for failed calls
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


