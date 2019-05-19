Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D71C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE51820449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/24O4J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE51820449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53641 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST9D-0001ZL-5G
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:15:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZl-0003ky-43
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZk-0004aU-7h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:33 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZk-0004Ze-23
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id c13so5748150pgt.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gMLsvL1jnb8FN6BVtc8z8p85LWUNX5tvXcqS5qNVubg=;
	b=H/24O4J2CtVeAW2bEmUi0Fq2daN8ycHshgm6J7xFzJ7+9qMyu9O9tLWXf3NtBSU9yd
	NsY59B95gfilKGxFAFHZliRhsqeBgw2nEGcatkoqFdD/DTfXeodTIAZIqJgqO2pMY5cB
	XEnqsbq1Q5zgWvyGN/sy/MKFc0OlfX9RzGDBH4Y41oPOXORWb0/efAvqoZqbBzGXGY4q
	i5MhimEObeT8gBBvfH16W7cbJJUmkvrYEueemJdx95zuWXTyPfZzhTB5I9r+CUpOAGzN
	v8zPUNAxDG1/jKY0tTeusQXXa4Z55b4M6pFABIyrIJAeEjUOIOI67dvzuhnfS29+j6Ta
	D6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=gMLsvL1jnb8FN6BVtc8z8p85LWUNX5tvXcqS5qNVubg=;
	b=bJLbH4K5mEAo+KEp7hiwjai00NY7Df9gQNt0Ci4eXuQKs15yZFXXuEzWza2LFY5zc+
	q0u4/KYMlZPd4O8yZDfDHFKAcR9O3wmHES7mRPB5kYNCE7nwtwegROVX36AnKbn6GiSf
	MrmkV5gluHTLd3YX2cGjqSqgQuQKULOUIhY7M2FjwBB1OgqvhsSApbhsmkq85G1lQneI
	ILGi07VpJV8sZWaINEboWXogU7ZywIlDIWMtWDvZWOmQB/s2DX2wiRSLE8mNlNZ5J1d6
	LNJYOp5HLaAGW/Nq5bOKVVVM6m/WmguH/p93JhzTSAFnszYGfAUYzNuB3zzBtLznq7aA
	szrA==
X-Gm-Message-State: APjAAAVKSApRYxdc46gEW4/dzL4eeSoXr7FvgARlhEUUuppwvfvUQyjj
	INR2itbXC10Pd240TU53pajAzY0hkgo=
X-Google-Smtp-Source: APXvYqxfrYyCwBN3w09kV6HKf9URW7pgmL+3V2yt30ScS6fR2hwpT+tVBGMBvbMuVqjJlZaayV8sxQ==
X-Received: by 2002:a63:d045:: with SMTP id s5mr8723728pgi.199.1558298310842; 
	Sun, 19 May 2019 13:38:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:01 -0700
Message-Id: <20190519203726.20729-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 49/74] linux-user: Remove sentinel from
 ioctl_entries
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

Iterate based on the size of the array instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-ioctl.inc.c | 14 +++++++-------
 linux-user/syscall.c           |  6 ++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall-ioctl.inc.c b/linux-user/syscall-ioctl.inc.c
index 15d87b9663..fc7df62017 100644
--- a/linux-user/syscall-ioctl.inc.c
+++ b/linux-user/syscall-ioctl.inc.c
@@ -773,7 +773,6 @@ static IOCTLEntry ioctl_entries[] = {
 #define IOCTL_IGNORE(cmd)                       \
     { TARGET_ ## cmd, 0, #cmd },
 #include "ioctls.h"
-    { 0, 0, },
 };
 
 /* ??? Implement proper locking for ioctls.  */
@@ -789,16 +788,17 @@ SYSCALL_IMPL(ioctl)
     int target_size;
     void *argptr;
 
-    for (ie = ioctl_entries; ; ie++) {
-        if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04x\n", cmd);
-            return -TARGET_ENOSYS;
-        }
+    for (ie = ioctl_entries;
+         ie < ioctl_entries + ARRAY_SIZE(ioctl_entries);
+         ie++) {
         if (ie->target_cmd == cmd) {
-            break;
+            goto found;
         }
     }
+    gemu_log("Unsupported ioctl: cmd=0x%04x\n", cmd);
+    return -TARGET_ENOSYS;
 
+ found:
     arg_type = ie->arg_type;
     if (ie->do_ioctl) {
         return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8f90affe2f..5871d3e711 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8173,7 +8173,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 void syscall_init(void)
 {
-    IOCTLEntry *ie;
     const argtype *arg_type;
     int size;
     int i;
@@ -8203,8 +8202,8 @@ void syscall_init(void)
      * We patch the ioctl size if necessary.  We rely on the fact that
      * no ioctl has all the bits at '1' in the size field.
      */
-    ie = ioctl_entries;
-    while (ie->target_cmd != 0) {
+    for (i = 0; i < ARRAY_SIZE(ioctl_entries); i++) {
+        IOCTLEntry *ie = &ioctl_entries[i];
         if (((ie->target_cmd >> TARGET_IOC_SIZESHIFT) & TARGET_IOC_SIZEMASK) ==
             TARGET_IOC_SIZEMASK) {
             arg_type = ie->arg_type;
@@ -8228,6 +8227,5 @@ void syscall_init(void)
                     ie->name, ie->target_cmd, ie->host_cmd);
         }
 #endif
-        ie++;
     }
 }
-- 
2.17.1


