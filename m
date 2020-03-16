Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B83C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C4520409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C4520409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu6H-0008Nf-Rs
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPe-0007uR-DK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPd-0008KB-8K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPc-0008AT-V9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfL5v-1joKxH1kap-00glYi; Mon, 16 Mar 2020 17:16:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Mon, 16 Mar 2020 17:15:23 +0100
Message-Id: <20200316161550.336150-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E5zxhOXJJ3t7m3Z20tOxSleG9nVmiKdnpH+eTyNTpG7FgbczEw6
 0UNAIHImIYojHqyqJULjz8klSh0a7q5EmzwDpMCfm3SdCVVfSsC5lw/GC5q5HU53zIVgwcX
 jvbkJWmrITFp3FllJd5Oe43l6vJ8pNnQZ7C26Hv9ryAQVcV48Dm9NZvHaA9O3MqeJ82QSFT
 fmpYaVDZVKIf70C88s9/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPljKfhmlKA=:xlxSBG02YJsoahLq4LaOkY
 PRWVtPR1mvumRAu+hDpQ3zhVNRlsc4npal+fbWMn19qvkjlUSlGGFakVkGTlZGJ/1vR+Owept
 r8RYyCHKdm6Ndc5SrzvP5+zWIa6+7+uN8+jCo21jMDXGFRAjrqHXxJcrSos0ihPDbvLQJKH/2
 JH9qT42Xwv/i6kz3Yt7a/+PSG2X6pgPlyUGA1aL+j4wmgtI1ShFNY46956s64XLn5QEoLvs7T
 M2XRZc9v/h/CO9scSZoxjEqhz7LkFhCLcoGkANLMuzXI93wqC1I5qnaIqYzGTb5VV0RTQemzB
 EUTEF8THcXnCNxH6+8GKXK1FXjZQrdtoeO2Z2aX+0l6/VPsnYxnr69JgO9p39ErTUioawar8h
 hSo+c2wtIZyTTHGsTJD0eUi8VjfXXaUMQYLH2c5GF4fBa1PCamFwGIl/ilOkes2kNFBbHIuvB
 oNsp9O6q9VpaP8XJWbhJwxo1P0H8HZilXGw1NUIdWtUE0vxihQ1CZCb0R1/2IM0OVQFAo9vK8
 yJlQOIJNE+44sD0y7lx2CzmADA3wsmIYOWgQ1lzjiCoMqJn2cXSq9OKk6Cnwmk9B9EGxH+Olf
 JDDFjDB4QciokxnUTN9svegcvWLF3uV5GBcf+smjNqygkI7SPfFHkoDsdjUEtyFcnXUyh72Y8
 i2wtI2l3oAZk6uc1kAShHFZDrgJWl6fBFeuUxF0RbuX49OSjKVpKzWVeu6ag1qScFfC1M3vFy
 Gx8+LBZvCzBvD21Zk8qACTfLRexo+9rIbpD3fDmrHpN2H9CBEcsJNvjpzmWrPx4CNtb/hVPsf
 WLZweNRxV+yn15O3mRaQN9i6x3eJDGGagYsc6/Y2aRxDcFKajgVNcrOlf8WTWsyPVcrjI7+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
index 479db1940ee9..aaf62d48992a 100644
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
@@ -11491,6 +11507,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11502,6 +11530,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
2.24.1


