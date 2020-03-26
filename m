Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E9AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D142220714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMuL-0000TF-WB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHMs7-0005Lt-HZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHMs6-0007tS-Fu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHMs6-0007t8-75
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:10 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLzSD-1izybm4957-00HuPH; Thu, 26 Mar 2020 08:24:00 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] linux-user: Flush out implementation of gettimeofday
Date: Thu, 26 Mar 2020 08:23:52 +0100
Message-Id: <20200326072352.2056553-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326072352.2056553-1-laurent@vivier.eu>
References: <20200326072352.2056553-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AyMp/m+qTp+pVhOJ5OilOky2MM/a0E7P1fmBAFPFBNqJUzH/eqf
 z6fa9u7kayN6my2rQDVSxgacYH9x4Hb9y4jQsFE48Mg6clu12yJqpMzp4wCXC6CN7y4749A
 AqVkYQ0gfEvskjMouQovGbdNF459vI3JkGDDaR5B6Qm0dIL2H1GwMzntz8rzYetNanGVMWC
 dw8735EZa2a+erF5N8Lkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HZRrY2G2UEM=:LhOmrJb75zcWC2H7jLNcHX
 nEvfvu6K/8TN+cKpRbx93xe5VyrxXQQrVBOebGrggvhnsluz5o+RC5VbfUKvB9ybOnW4PdzCJ
 3iOaVjbxenF/BJKUP49Cq8dDU87hm7G9tWRXRVXliB9P/KB5SDotfi0YIZWwW8XIrH1kKHh4p
 PM7wCL6C04m0z08S87+JMJl7zLBqoZcRn2JyD8cJak99N6SGiDJo9iP4bhDBszGM7huTCvYxe
 RhoGiX9ed7rzXR0CU9kfDyHakqhQFia4ct0QEPMzGPZF3kRcFRnkdmuIHeoeeLHYNkYmuZsem
 klpY+ZQG3UYy2HxorEKbR7iNTSn5cxVFXSkdev7O6TkeQR0EHbVU0iZUM+zZtG9jKPU0X9JDk
 7Gs7HjLVgmwP5VBC4+ivmU3QNeMFtwsyOvCBj/M33lPwz4mc1EQDkBeLe6VoEzeJmIg9lzH26
 2adeTkiqZigL8i0xMuiY4mkgI0AAmXFSDKjBrR4ySqnTcTJEVnGqAS+S6h8CjcYbYzyzVrPaC
 mFTK99o8ulMAHU7XAsw3FxoTVU8mUlYqyXtf2KNMYrd/Np5IuT3/Zh5Q+TFzZGNWOixuMqdRG
 xNw2FtQva4fIK/5eLgkDFPRKEycTdlRxxq8K19/prk2rpnfk5juMm9sB3M6a8RiIQntXcE4u+
 mfWR/hkmH4bY4CbT3jIxEOe3rbLld7v/lbf37vcc8ozOwxqOZWY72gD5YuvoAQr638XEENsIz
 e0agLsSS/dq18nAjQapBRSMIK2d7CUJPCmlzY5H/ieET1aPgY/TI9M+RcvIuSMML5INczJSgw
 QJChRHj/rYYsdBgpLNAeBavaNQybZ0I8c0/FG+ekSo+SVYsXIoXw8E5yn7HT1W7kGKnt0Jr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The first argument, timeval, is allowed to be NULL.

The second argument, timezone, was missing.  While its use is
deprecated, it is still present in the syscall.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-6-richard.henderson@linaro.org>
[lv: add "#if defined(TARGET_NR_gettimeofday)"]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dbdd56e42077..49395dcea978 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1273,6 +1273,25 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_gettimeofday)
+static inline abi_long copy_to_user_timezone(abi_ulong target_tz_addr,
+                                             struct timezone *tz)
+{
+    struct target_timezone *target_tz;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tz, target_tz_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(tz->tz_minuteswest, &target_tz->tz_minuteswest);
+    __put_user(tz->tz_dsttime, &target_tz->tz_dsttime);
+
+    unlock_user_struct(target_tz, target_tz_addr, 1);
+
+    return 0;
+}
+#endif
+
 #if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
@@ -8710,10 +8729,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
-            ret = get_errno(gettimeofday(&tv, NULL));
+            struct timezone tz;
+
+            ret = get_errno(gettimeofday(&tv, &tz));
             if (!is_error(ret)) {
-                if (copy_to_user_timeval(arg1, &tv))
+                if (arg1 && copy_to_user_timeval(arg1, &tv)) {
+                    return -TARGET_EFAULT;
+                }
+                if (arg2 && copy_to_user_timezone(arg2, &tz)) {
                     return -TARGET_EFAULT;
+                }
             }
         }
         return ret;
-- 
2.25.1


