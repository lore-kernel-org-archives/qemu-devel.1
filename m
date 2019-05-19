Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F7EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E7F20675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBCN5yrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E7F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST23-0003HP-Qx
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:07:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZg-0003gT-QI
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZe-0004Sg-P8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:28 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZe-0004R4-HU
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id f12so5707249plt.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hCKl3WsFFB8I9SyuErlgjzDySDbodc+1SphzTaA0mp0=;
	b=IBCN5yrde7jbvLtsr8VkhNSO50Hr38sFL8xFDuu0FVnf2s6cIEXyIBnmK9UlbEud3L
	iUjQ/MuneVRfAdmbcV+9WDNHoDuZTH9QWqJYqPygkULjpzD2R9oSpnzFlJVgyYgD1/rh
	veE9EY5y/IopR81L8oPkbPRjK62wHs4fe1K0O0N8CgVZZHkYohMHm6nAPtdlPJE0EtA8
	ZgTI4NzJ5jo5nAF2Xa6c5X4dXc9SXdIqPJM+9UOrKSyEADTXLS6hsdxT/LVr9wj+uifZ
	H4mqwUU3zme7MaRpHWEC+R/tu8FMfmxrKT+1xtkqO7L0vzlqEAejHPlrC97u7b1ErZow
	EiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hCKl3WsFFB8I9SyuErlgjzDySDbodc+1SphzTaA0mp0=;
	b=BG0W6Ru4eLaU8o89lw4KryrvcejqfmrNjPhugdovEzz8v1SVCq40vldiE+ulWRCE1V
	lDtK6Z6bki6/YQWq9FX4uQtMrgw/3jhxso4uhUyxH7Fog1gxWfYq7OnP5BMVvZUF9saY
	quGgHzNJk0k3ySKybtsmLIoSJN0Yp9H6TDnWKMjdLO4VA0LAXiMfFVm0zj/Aa2bU8GCS
	jhgqPJ6YwerD66qrVHZUbqbVsUKBZwa9Nkyg1ZDUJfxiSbkJjSZ1v3junx+jnsW9HIec
	dUdPykjDWhiwJW9YZfwdhjF0ABxV03eoca4uqWXWqtb3SuhIGwQ36D6gcsagI77ktXPS
	QeNQ==
X-Gm-Message-State: APjAAAV9PwbNWiSFKzFdB5/bt6HUH196KUKDDe8BoQfWkha1kES2Avj1
	gHWa+jb6qPo278Oq6EReWjfD8aAlXoE=
X-Google-Smtp-Source: APXvYqxWa7yZt46HyYmaxImDDO8wG2CYq5FLocecukC1T6SC0jg2SGJmJVTGFywFYU41qfOgcN5o4g==
X-Received: by 2002:a17:902:6bc8:: with SMTP id
	m8mr70316262plt.227.1558298305264; 
	Sun, 19 May 2019 13:38:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:56 -0700
Message-Id: <20190519203726.20729-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 44/74] linux-user: Split out times
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  3 ---
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index bd3301a72f..25d5aaccd1 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -204,6 +204,7 @@ SYSCALL_DEF(syncfs, ARG_DEC);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
+SYSCALL_DEF(times, ARG_PTR);
 #ifdef TARGET_NR_umount
 SYSCALL_DEF(umount, ARG_STR);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index e29c2ede25..517f84e139 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -468,6 +468,31 @@ SYSCALL_IMPL(nice)
 }
 #endif
 
+SYSCALL_IMPL(times)
+{
+    abi_ulong target_buf = arg1;
+    struct tms tms;
+    abi_long ret;
+
+    ret = get_errno(times(&tms));
+    if (target_buf) {
+        struct target_tms *tmsp = lock_user(VERIFY_WRITE, target_buf,
+                                            sizeof(struct target_tms), 0);
+        if (!tmsp) {
+            return -TARGET_EFAULT;
+        }
+        tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
+        tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
+        tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
+        tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
+        unlock_user(tmsp, target_buf, sizeof(struct target_tms));
+    }
+    if (!is_error(ret)) {
+        ret = host_to_target_clock_t(ret);
+    }
+    return ret;
+}
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cda1f8a205..cdca0dbe4f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5346,24 +5346,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_times:
-        {
-            struct target_tms *tmsp;
-            struct tms tms;
-            ret = get_errno(times(&tms));
-            if (arg1) {
-                tmsp = lock_user(VERIFY_WRITE, arg1, sizeof(struct target_tms), 0);
-                if (!tmsp)
-                    return -TARGET_EFAULT;
-                tmsp->tms_utime = tswapal(host_to_target_clock_t(tms.tms_utime));
-                tmsp->tms_stime = tswapal(host_to_target_clock_t(tms.tms_stime));
-                tmsp->tms_cutime = tswapal(host_to_target_clock_t(tms.tms_cutime));
-                tmsp->tms_cstime = tswapal(host_to_target_clock_t(tms.tms_cstime));
-            }
-            if (!is_error(ret))
-                ret = host_to_target_clock_t(ret);
-        }
-        return ret;
     case TARGET_NR_acct:
         if (arg1 == 0) {
             ret = get_errno(acct(NULL));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a1c3dd98e0..85e3de87d8 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1290,9 +1290,6 @@
 #ifdef TARGET_NR_timerfd_settime
 { TARGET_NR_timerfd_settime, "timerfd_settime" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_times
-{ TARGET_NR_times, "times" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_tkill
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
-- 
2.17.1


