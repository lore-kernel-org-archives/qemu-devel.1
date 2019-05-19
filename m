Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FEEC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE6320644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wyiyg66m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTKm-0003uy-AB
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:27:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa6-00043I-PW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa5-00050k-La
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa5-0004zu-Fl
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id c6so6150984pfa.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aU9d9lkpIFkrBaZRLnqRF/xt/eULyJKQva2sHtEVO2Y=;
	b=Wyiyg66mNE27W+tMaD3QGbxM7UM/xGOPeWqBMI2iw8v8/TM3SiNv2LyrY6PucPGRPn
	nTXLOyc6CPNeeg/zdB4Br3Q/tmlsS9mccTrAgBpNcye/HHfi0l5TZwXp+5uCBSFJd2xM
	IrCJrgIEpTgdoR1W9+0GFZRoDTuI09wDdIHJ9DtBEh8JvqELkA21k7IgkF/VYxFw+yKa
	JRLkxnt1zrdXAEi8FuY2M2oWbsOWo1xLjZ+yqPZXw8Wn7dCdQdS8Gx+E+TKo8huuQ3ci
	Uiz56Xp3/bSIiEOYhAYc9g45vFxCZteZkydvKb8QnIt+7kfCkAxiefDFzC7ZOFhw7vCp
	LcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=aU9d9lkpIFkrBaZRLnqRF/xt/eULyJKQva2sHtEVO2Y=;
	b=YnFUYpEHkqFbc/jXdkEBSYEEWVz6FoMGH8oJTyPh0Rx+YOz0vUQnQ0BPhqQsW6VWsd
	HG/XQ5OjTlV2nEmNGJ4CFtScD74n1sYppBd11LHEH904/tHPQfR0NXxyDYMXVpkEGuMR
	pkdawOiv8Rk+BTsf0wV1UmcEIoGjjbqa3IKuGXoog4ppK14wnzu3CiA2L6kSXbK7gZHn
	uRokgKi5l/CakCBYMDw1uEGdlGkNIqpZrHGlJIHTjEB3SDmFQVJkxex1Bv+32qB87y0e
	VrCP3srtGa4MR8LNbHs40RsR0qaXLi/oKVkGR2ckImJ0FMS80QiX1pzZgxDY2E3BtNcM
	khpw==
X-Gm-Message-State: APjAAAVH0706r+GBJh3Pijzjl7eCpl7c3bL1rIjXVRaYfqMEAfWJ5Mku
	DVLZV6XbNmTR/CiWPyx59Wamgea6FjI=
X-Google-Smtp-Source: APXvYqwbQEu8iczkhLqkzwJvVvTaBqPi2+RANP+nmsrZ0pChsJd+oZzF3lMPyfOcRHF533TDTFnucw==
X-Received: by 2002:a63:2d6:: with SMTP id 205mr70853544pgc.114.1558298332183; 
	Sun, 19 May 2019 13:38:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:19 -0700
Message-Id: <20190519203726.20729-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 67/74] linux-user: Split out gettimeofday,
 settimeofday
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
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-time.inc.c | 33 +++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 31 -------------------------------
 linux-user/strace.list        |  6 ------
 4 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 446175af84..d109754c5f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -77,6 +77,7 @@ SYSCALL_DEF(getrlimit, ARG_DEC, ARG_PTR);
 #endif
 SYSCALL_DEF(getrusage, ARG_DEC, ARG_PTR);
 SYSCALL_DEF(getsid, ARG_DEC);
+SYSCALL_DEF(gettimeofday, ARG_PTR);
 #ifdef TARGET_NR_getxpid
 SYSCALL_DEF(getxpid);
 #endif
@@ -220,6 +221,7 @@ SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
 SYSCALL_DEF(setrlimit, ARG_DEC, ARG_PTR);
 #endif
 SYSCALL_DEF(setsid);
+SYSCALL_DEF(settimeofday, ARG_PTR, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semop)
 SYSCALL_DEF(semop, ARG_DEC, ARG_PTR, ARG_DEC);
 #endif
diff --git a/linux-user/syscall-time.inc.c b/linux-user/syscall-time.inc.c
index d1fb72bde0..1308af64ac 100644
--- a/linux-user/syscall-time.inc.c
+++ b/linux-user/syscall-time.inc.c
@@ -16,6 +16,39 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_IMPL(gettimeofday)
+{
+    struct timeval tv;
+    abi_long ret = get_errno(gettimeofday(&tv, NULL));
+
+    if (!is_error(ret) && copy_to_user_timeval(arg1, &tv)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+SYSCALL_IMPL(settimeofday)
+{
+    struct timeval tv, *ptv = NULL;
+    struct timezone tz, *ptz = NULL;
+
+    if (arg1) {
+        if (copy_from_user_timeval(&tv, arg1)) {
+            return -TARGET_EFAULT;
+        }
+        ptv = &tv;
+    }
+
+    if (arg2) {
+        if (copy_from_user_timezone(&tz, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        ptz = &tz;
+    }
+
+    return get_errno(settimeofday(ptv, ptz));
+}
+
 #ifdef TARGET_NR_stime
 SYSCALL_IMPL(stime)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5fe52c775d..b8bc44364d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,37 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_gettimeofday:
-        {
-            struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
-            if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    case TARGET_NR_settimeofday:
-        {
-            struct timeval tv, *ptv = NULL;
-            struct timezone tz, *ptz = NULL;
-
-            if (arg1) {
-                if (copy_from_user_timeval(&tv, arg1)) {
-                    return -TARGET_EFAULT;
-                }
-                ptv = &tv;
-            }
-
-            if (arg2) {
-                if (copy_from_user_timezone(&tz, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-                ptz = &tz;
-            }
-
-            return get_errno(settimeofday(ptv, ptz));
-        }
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 00a32bc616..635b952d2f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -296,9 +296,6 @@
 #ifdef TARGET_NR_gettid
 { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
 #endif
-#ifdef TARGET_NR_gettimeofday
-{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getuid
 { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
 #endif
@@ -1068,9 +1065,6 @@
 #ifdef TARGET_NR_set_tid_address
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


