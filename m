Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA11ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1507217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qY0wItT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1507217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3KH-00016P-8r
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qI-0004Wi-4T
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qG-0007g9-Uf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qG-0007fO-OU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so20392196wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2d2NWDTxvn9CUO0BmKuXZlgXMFS+/AeH+wIL004pWtk=;
 b=qY0wItT00l8quQLKfvvYnCBP1n1fTkXtH3b2caqVYpJGNGUsp4l9canusvi+ENhdP5
 5Rk7IfcJSS0uU7AhendPZvpSo4btK9xQsOTtiB1I+te7aTHldyOQDhVzN0E4h+ZopY3D
 1nvSPV1Z/PzBTjfFetSyHgRLOU8LXH8/A2EsXM8hK7c+Mv8etqqCcNqTg6JPeQtn00MP
 9wWdLU1LO7VC82Hf4ZozFSdMk9sE/66qcJKprl8D6E7ifE4oaP4kCFl7AGBlYWX1+w/E
 ZZjgj6E4BhW4sTk7LZ3S3Ij9CmZUH+hGbldZNSFqO50//YNhhw9Kmv8z6jcGmP/dmNsr
 kJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2d2NWDTxvn9CUO0BmKuXZlgXMFS+/AeH+wIL004pWtk=;
 b=IYLyIUhqktlUuBUX92V5+FpQvvZ3DQuPrKE8O63qGQxmoiLTah3b5w9bP/dfO1oVHP
 VIDkLcI8mOFyO4ymHcX38NUu2AJ5kqGVb7GdNDnrbV0uC5gcEwt+r1cnzdGZMJkwJgi7
 17ZJuVGZK+i/EB9X/XaNmBL7Hl/5Ki4EZXMSgeLMPoryTfQoRiPt7YMuTPefGDDfifZo
 2X5h6FzRPcuMFpRALweYSbFijY5iyljhu8rxrINNJs+FIh/ZiiqeA+mduIv1XSox5PUO
 yAQ8oPGL/HeIQGCz5jrb+la3oXa24SVauRJ+NvZVxgmKrD+hrteyzMbyPbGnfKetlyER
 nL0A==
X-Gm-Message-State: APjAAAWLOfaoFidkRL+51pA18QhY9FQZVLfHWQl1YopIuVCYK3zJrNi8
 b61awwn/jTxOHAfsBX7/7yFqErSXAqwG/w==
X-Google-Smtp-Source: APXvYqwrEfp3LzbymNuKSBmkTTb1B7wbI4mGxnvONV2sMV/2L+1SaIFiO9/nJ0G9lSARHeuoCSf7Zw==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr11048023wrs.158.1571069103483; 
 Mon, 14 Oct 2019 09:05:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/68] target/arm/arm-semi: Factor out implementation of
 SYS_WRITE
Date: Mon, 14 Oct 2019 17:03:28 +0100
Message-Id: <20191014160404.19553-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Factor out the implementation of SYS_WRITE via the
new function tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-9-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index e5f1e2aaaf2..c21cbb97bc1 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -384,6 +384,8 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
  * setting the guest errno if appropriate.
  */
 typedef uint32_t sys_closefn(ARMCPU *cpu, GuestFD *gf);
+typedef uint32_t sys_writefn(ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len);
 
 static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
@@ -392,21 +394,51 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
     return set_swi_errno(env, close(gf->hostfd));
 }
 
+static uint32_t host_writefn(ARMCPU *cpu, GuestFD *gf,
+                             target_ulong buf, uint32_t len)
+{
+    uint32_t ret;
+    CPUARMState *env = &cpu->env;
+    char *s = lock_user(VERIFY_READ, buf, len, 1);
+    if (!s) {
+        /* Return bytes not written on error */
+        return len;
+    }
+    ret = set_swi_errno(env, write(gf->hostfd, s, len));
+    unlock_user(s, buf, 0);
+    if (ret == (uint32_t)-1) {
+        ret = 0;
+    }
+    /* Return bytes not written */
+    return len - ret;
+}
+
 static uint32_t gdb_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     return arm_gdb_syscall(cpu, arm_semi_cb, "close,%x", gf->hostfd);
 }
 
+static uint32_t gdb_writefn(ARMCPU *cpu, GuestFD *gf,
+                            target_ulong buf, uint32_t len)
+{
+    arm_semi_syscall_len = len;
+    return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
+                           gf->hostfd, buf, len);
+}
+
 typedef struct GuestFDFunctions {
     sys_closefn *closefn;
+    sys_writefn *writefn;
 } GuestFDFunctions;
 
 static const GuestFDFunctions guestfd_fns[] = {
     [GuestFDHost] = {
         .closefn = host_closefn,
+        .writefn = host_writefn,
     },
     [GuestFDGDB] = {
         .closefn = gdb_closefn,
+        .writefn = gdb_writefn,
     },
 };
 
@@ -539,24 +571,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(env, -1);
         }
 
-        if (use_gdb_syscalls()) {
-            arm_semi_syscall_len = len;
-            return arm_gdb_syscall(cpu, arm_semi_cb, "write,%x,%x,%x",
-                                   gf->hostfd, arg1, len);
-        } else {
-            s = lock_user(VERIFY_READ, arg1, len, 1);
-            if (!s) {
-                /* Return bytes not written on error */
-                return len;
-            }
-            ret = set_swi_errno(env, write(gf->hostfd, s, len));
-            unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1) {
-                ret = 0;
-            }
-            /* Return bytes not written */
-            return len - ret;
-        }
+        return guestfd_fns[gf->type].writefn(cpu, gf, arg1, len);
     case TARGET_SYS_READ:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


