Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21545C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC70220675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZDbAixz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC70220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST3F-0004HU-0N
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:09:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZK-0003Pi-Ip
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZJ-00041B-Dh
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:06 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZJ-00040H-76
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id n19so6182715pfa.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=D7GWj/lXqLo0o5VRDqbo6Uitm8MC1Kjd/6DUhBjIuPo=;
	b=TZDbAixztVBkqw7lKtMXBgrdRBWHWKYzgjNlobC63Oyqzic4+0AFnhNHmPqTg0KqVp
	tAhqpbYNlYIuYy+dkurt+px0Z9k5E9Dye+MomeyFA3GZLE8W1Rs4gy+a02aldCXc7oRe
	hwTsgckJAro6rmOLrFYRSm6+pdwbNafgu0hmn8VuqXFFJKXLqffUNfT6tJ/YhGFWrKrR
	faLcJM4auzgxvMTSUken3DqYxhMLgwlcU21+PRB8VAyImXQGG5G8SxK9cP3jClrLogD+
	ESJopDhEHrIykxXwmLjjM5j9gK35EeESvDhLcv+BuK6bEuiRJGlE8Q0XSM4NAh+5cg7Y
	iTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=D7GWj/lXqLo0o5VRDqbo6Uitm8MC1Kjd/6DUhBjIuPo=;
	b=MY189kc+NencyN0i6fCyOgHXA34PSKkVO4nv0dWRllwcG80ynSCyWf50RLuEvDk3cG
	l38IE/5cRGgj7myanzPIFlw41BWmiIe3HaPbiUZzDt5WkqYklFkzFPKkl+0raLSQHUJw
	ZhvJyR/9GiSMzWRuQoJkML6+lsE2kqN5XXKAFG+O/TtS1iW5SC+TdOxR92ljBXT2G0ym
	Zoe7cqMqp4L5X/6FLIBx1976Ndr1o1qa8NWDIe9EpOy1/TkrQMc+9nN/xoAJvc917ez2
	0VyV+2DD2kCsyT5GcJH5SHU50L0A0ChSMFQXyaaoG8WdLaB4qiHgIK45h7eeiLiCaH1I
	yxOg==
X-Gm-Message-State: APjAAAUhZDQB84bymJOie0ciC+j+xXXyDCaxDo8VJiECCD36JfkK5qEh
	sz0MnmwHCUcPQ1a6duUPKJn4jveYPmY=
X-Google-Smtp-Source: APXvYqwg3BdZH0jgOk0ACbjlldPECE0nfwJjiHU3eBzT5hdMCQNlRSCQZ24fS/q6XOlPkduwHuQmnw==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr57475214pfp.99.1558298283888; 
	Sun, 19 May 2019 13:38:03 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:38 -0700
Message-Id: <20190519203726.20729-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 26/74] linux-user: Split out time
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
 linux-user/syscall-defs.h     |  3 +++
 linux-user/syscall-time.inc.c | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 13 +------------
 linux-user/strace.list        |  3 ---
 4 files changed, 36 insertions(+), 15 deletions(-)
 create mode 100644 linux-user/syscall-time.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3fad9d51f0..9950b73e76 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -127,6 +127,9 @@ SYSCALL_DEF(shmdt, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_shmget)
 SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+#ifdef TARGET_NR_time
+SYSCALL_DEF(time, ARG_PTR);
+#endif
 #ifdef TARGET_NR_unlink
 SYSCALL_DEF(unlink, ARG_STR);
 #endif
diff --git a/linux-user/syscall-time.inc.c b/linux-user/syscall-time.inc.c
new file mode 100644
index 0000000000..14fec88e47
--- /dev/null
+++ b/linux-user/syscall-time.inc.c
@@ -0,0 +1,32 @@
+/*
+ *  Linux time related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef TARGET_NR_time
+SYSCALL_IMPL(time)
+{
+    time_t host_time;
+    abi_long ret = get_errno(time(&host_time));
+
+    if (!is_error(ret)
+        && arg1
+        && put_user_sal(host_time, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0bf5901014..ea89734706 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5384,18 +5384,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_time
-    case TARGET_NR_time:
-        {
-            time_t host_time;
-            ret = get_errno(time(&host_time));
-            if (!is_error(ret)
-                && arg1
-                && put_user_sal(host_time, arg1))
-                return -TARGET_EFAULT;
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_mknod
     case TARGET_NR_mknod:
         if (!(p = lock_user_string(arg1)))
@@ -9392,6 +9380,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
 #include "syscall-proc.inc.c"
+#include "syscall-time.inc.c"
 
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3f79159b63..95706a696b 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1350,9 +1350,6 @@
 #ifdef TARGET_NR_tgkill
 { TARGET_NR_tgkill, "tgkill" , NULL, print_tgkill, NULL },
 #endif
-#ifdef TARGET_NR_time
-{ TARGET_NR_time, "time" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_timer_create
 { TARGET_NR_timer_create, "timer_create" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


