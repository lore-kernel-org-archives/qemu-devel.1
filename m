Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58759C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E6512076E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6512076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJa3-0005Pr-AG
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVf-0005Rk-Tp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVe-0007Zk-PB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58275)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVe-0007YZ-GZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MacWq-1jr8Qk3fGU-00c5su; Fri, 20 Mar 2020 16:24:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 06/32] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Fri, 20 Mar 2020 16:23:42 +0100
Message-Id: <20200320152408.182899-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DTDJ+5XQk5oBvCVEN7gZQK+dIxGbkSlXKoLb10otPKhfidF3W3j
 wgkXcrKd0VGz/1rXBPgrzBqpw/iaBWCBtfv3rVepiXnQEy1/rLgyrfYzaTfXg+6KLaraqwo
 7El8cwM8zIUq5V++9Jt4ZsAdYQllxz/5BTf3kIMhlFHdTSEaSNoUF3mq1S2U36IpoZwxSbP
 zLzgBKxprI/KAW2lfnvsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y4VVYfoboBg=:/W6TsWcKtajaOeRkXAXXxa
 XjS9PnbNqPcNe2aCg5xX7GPH6OzBvOC7JE/HpidzCCEFSJdbRpvdXZrYYLmWmGBEeEbGr2x5W
 7FZ3vkCLKt26Gargge6vgjRcPu+6KxK/5VRpanEEiOdzpqoKHxB/ZBYcxIOS2nNp/26GiMfVX
 ouV1NGNYwHb3JaFDFiC10n02h4zKDfmFo1eBEgNujoV1njXBFBcy6R0xCZtZsL3Mw0+YmRy5g
 95s23+/lkVIDf7U1uy/uWmFWqMfcpRkCqvdxA53osjWKJQVfoPWVUxtTGQqAKsEOKmxaQKsKc
 enrQzw4QJhgkRQdIeJJmx4awjcEjr+siquvlhS6GufX5bNkhPPmj31BYjKe6iQmX8BjUX5LZi
 Y24zgagzzLyalzz4LJ4j4Urf+f5dGWI5wu69mq+mfq3oFmVyxvuYAMll6ooPCwmy5wNr5ZZV2
 e1Tih0JHOQQH9s3UHNF7XylUQoNwz2bbm+v13bPQqWujl0n7qZ+taPFazMClxDnj28FCUbgaa
 Y6mUyazlfcxDGEdotHhiKFRkGEUwYlQU655EcjvN1K3nACEJqBRrWjhVN0rUsm33wwoReaAva
 yuxnGqHK8K3Zn+dtWZW6TYAzUC5f+760P7BaQh02WNFc+t/MZVZkfzAK9NWJG1ozvg4IwhdjK
 WOiRujOXqeB30CDK0tsvDp3/ai18W7X5CXcKTNC4Pj59Bu4bwGybFlbJM3C3kTHTcdCBGs4fi
 r8hSU/MPzcsOkNtrj0oP5QLUkgA3YcqHMjRBYnHg2eeJcODZd24r/dpNkspU9TZ/nUP/qGdQB
 2/ioTl2+brsNgKyO8G6oaJizWXfdmVHPV9iJa7OeYH0Ul6nAGbm17Kdvn6al4UyfjH0a/hm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add support for the clock_gettime64/clock_settime64 syscalls.

If your host is 64-bit or is 32-bit with the *_time64 syscall then the
timespec will correctly be a 64-bit time_t. Otherwise the host will
return a 32-bit time_t which will be rounded to 64-bits. This will be
incorrect after y2038.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <4a7fd05532400d10aa0f684c9043e2ac7b34d91c.1584051142.git.alistair.francis@wdc.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae279702b2ee..be5f524e0af8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1229,6 +1229,22 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
+#if defined(TARGET_NR_clock_settime64)
+static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
+                                                 abi_ulong target_addr)
+{
+    struct target__kernel_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
+    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_addr, 0);
+    return 0;
+}
+#endif
+
 static inline abi_long host_to_target_timespec(abi_ulong target_addr,
                                                struct timespec *host_ts)
 {
@@ -11458,6 +11474,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_settime64
+    case TARGET_NR_clock_settime64:
+    {
+        struct timespec ts;
+
+        ret = target_to_host_timespec64(&ts, arg2);
+        if (!is_error(ret)) {
+            ret = get_errno(clock_settime(arg1, &ts));
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_gettime
     case TARGET_NR_clock_gettime:
     {
@@ -11469,6 +11497,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_gettime64
+    case TARGET_NR_clock_gettime64:
+    {
+        struct timespec ts;
+        ret = get_errno(clock_gettime(arg1, &ts));
+        if (!is_error(ret)) {
+            ret = host_to_target_timespec64(arg2, &ts);
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_getres
     case TARGET_NR_clock_getres:
     {
-- 
2.25.1


