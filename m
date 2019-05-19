Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E5520657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEGoWLAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E5520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSqg-000178-CY
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:56:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZB-0003Be-9R
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZA-0003pH-Av
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZA-0003oM-56
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:56 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so5725712pgi.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ivbPF9AA08UpYLCiKojYQPTAvKrugZNh3dcbIM2DPu8=;
	b=SEGoWLAg+RZ4riZbIc9naxcWLRTzjediGWpq+QTz2q69v76H7vtAdmobl0AGbDZdoI
	MaGzazjNCp4ynnWbZItcjih5THmw/jn2+9wY8iLQ4YrqdfClw1SlkwkLAfPDhQbZ7v9L
	88CrbuuuVAEo6g//NygY64sQOKlLLwnNIC+dw4gaLWju+cxxPq0sQqjW32LAL1qz78ca
	/X14LNquJlWDSmmHYJlU6uEwAC97etaUIJp8O8mZj3Gg3C4VCO2moZEPfZivYkSMg/It
	e8UsBBR2Vvmkq9FLGG63ndnoq6Bg431KBrwaYnmSo3p/WGQmoW6uNgKyWtcSsa0bEYUy
	G3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ivbPF9AA08UpYLCiKojYQPTAvKrugZNh3dcbIM2DPu8=;
	b=Q0cp8bvm7KlfLfL1YaK42JC16p+KNZwPP1kJyhslKBoYy9vaQOpXCwWSGcsZ1iezeS
	EWqAMCX6BtK3f8YittEaxz8p+aoAanLsqfTI+V5wIy+4JaOP8p6MoDF/FzU0y4om7vqG
	K6QPvsWm10CmlVGgO6dJemm5b1xWqiWej+baBSRW0s5J9HMP3KxNGWhNiRsfoWictVa1
	+4zwzUQR78W9ZtTgava4aqJsbzH38EXapoPC3ibh4gQEB3nPL+6I1dKqA4nkHvbXPGgn
	3SNOslEjOtgJ68BZWgC9W9FH3DhNygBUhjYfRHaKcnXn35Z0PYc8j9gExv/1w1u0AG+m
	GcWw==
X-Gm-Message-State: APjAAAUMHd+W/t2omA5JDvCRIgOKIhPlBGcQjlhd04fKfA2e9EPK3Z7B
	VBFBnGXRgyAE0fkLVIUmSpgJpR0YKsM=
X-Google-Smtp-Source: APXvYqxIGTBrg7G8je7P/IoNYuvdq60tbKOD27NbsfReN8nFlGdSa5GxWchyIyfzmPh3MXS3+ZxN0g==
X-Received: by 2002:a62:d205:: with SMTP id c5mr75464414pfg.219.1558298274771; 
	Sun, 19 May 2019 13:37:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:31 -0700
Message-Id: <20190519203726.20729-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 19/74] linux-user: Implement rusage argument
 to waitid
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel interface, which we are supposed to be implementing,
takes a fifth argument: an rusage pointer akin to wait4.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  2 +-
 linux-user/syscall-proc.inc.c | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index a84050a318..f099d98fa3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -119,7 +119,7 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 SYSCALL_DEF_FULL(vfork, .impl = impl_fork);
 #endif
 SYSCALL_DEF(wait4, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
-SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX);
+SYSCALL_DEF(waitid, ARG_HEX, ARG_DEC, ARG_PTR, ARG_HEX, ARG_PTR);
 #ifdef TARGET_NR_waitpid
 SYSCALL_DEF(waitpid, ARG_DEC, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 7c647f36d7..b7304b7a42 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -370,19 +370,30 @@ SYSCALL_IMPL(waitid)
     id_t id = arg2;
     abi_ulong target_info = arg3;
     int options = arg4;
+    abi_ulong target_rusage = arg5;
     siginfo_t info, *info_ptr = target_info ? &info : NULL;
+    struct rusage rusage;
+    struct rusage *rusage_ptr = target_rusage ? &rusage : NULL;
     abi_long ret;
 
     info.si_pid = 0;
-    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, NULL));
-    if (!is_error(ret) && target_info && info.si_pid != 0) {
-        target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
-                                        sizeof(target_siginfo_t), 0);
-        if (!p) {
-            return -TARGET_EFAULT;
+    ret = get_errno(safe_waitid(idtype, id, info_ptr, options, rusage_ptr));
+    if (!is_error(ret)) {
+        if (target_info && info.si_pid != 0) {
+            target_siginfo_t *p = lock_user(VERIFY_WRITE, target_info,
+                                            sizeof(target_siginfo_t), 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            host_to_target_siginfo(p, &info);
+            unlock_user(p, target_info, sizeof(target_siginfo_t));
+        }
+        if (target_rusage) {
+            abi_long err = host_to_target_rusage(target_rusage, &rusage);
+            if (err) {
+                ret = err;
+            }
         }
-        host_to_target_siginfo(p, &info);
-        unlock_user(p, target_info, sizeof(target_siginfo_t));
     }
     return ret;
 }
-- 
2.17.1


