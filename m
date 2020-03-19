Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDDBC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316AD20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316AD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErW1-0005bE-7q
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRy-0005Qu-D5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRx-0004F3-29
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:50 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRw-0004E8-P7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:48 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mc1hn-1jqfIn2n7f-00dTuI; Thu, 19 Mar 2020 10:26:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 11/16] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
Date: Thu, 19 Mar 2020 10:26:22 +0100
Message-Id: <20200319092627.51487-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L9uGFhJuOpdqZ11JjA5qmhOkxad9EpMTdmTYCQSsFM3t3oRux9s
 k+BgrnC5/eJteZAE9/PDuRyaqem/D1lL6qPWSFXmPDBAu5llwvv0sq4IzY4Dq7YSO3EA9o9
 oT3PHJr3rHsb7Z0yGknnN3Mu6leuCRKLCUkTWqUHShJeFAxVY41nx0P0iGY0D4BrdMhddKJ
 HC0jVu6OrwIa+SziKXy2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdwfzrX7RyI=:tEUyfOLVlQEw+D9J8JjgEQ
 ROJL9gJcpmjkuU1LkdJsQN80MJWfEWKfUMLksAwvUoWUPDBDToTDfMTOEAYYB0vhypynlBavk
 /FRVCQWsn7ILmSBl3MkyZ9uv6aCJwVIOXCxZRj5fNirNbETJmJytb6LMt+WOaVGYMyqT0lMjB
 cuLWKC9Fl0TlfKBRnLbT+ggOY5XJGDvqhaD0KOSkmQ7r9o/qRIWv+ZwuxKswlbSBmTXpF6BqS
 CqeUqJDax8M7kM7ieYop32weMJYxNuZ8QXF8yP67DQt1WHmGIDX5XC1gHKDQ2C1zOuc0FQC1Z
 JbWDxJ8b2rnOXSfvu5ttEh7H2hziA/sBMmela003kY38Mhvx15BeT9aBB0m2SWM12NYhTmDJ9
 hC6cdYF0TelsdAlQev0L2UAV4jRHA35lhgflQToVE7QiKOeu49RsP13Bqql9GopjtOzPQQmzL
 xob2bAqQ3ew//DYdioNDFiaynQ26t/14RtPqpSxsy4ouVjy23ZqU1mrhhYhXHt1NSD9BlZwqw
 Lbw7WCxzJyNTBpBgQTIuzp4YzA5G7Cf9iisvpysgb+ZAA3kT1oNoDsPkad272LW5SpsjrmSkD
 05cmHoYs9FkUOJ5Wb5zRAs3MLXSpiAfJbcULLJg+oFCtIWWIlLBE9hkkDSI+4A2K88K+UBAfW
 +uqlRu5EAizIal94cWkdjR/UFdpnm3a1OwIpjp+0QWN+Ea/XpFnDXSNpW4eBo6JN+vWl7LbB9
 mkEa/T5gIeOundFokfmYEwBcy2Wx1BdVPLbn0dJiAtNoPtHmoUlOFljChYz74hRc/+XI1SIaF
 2Au8ADBgXexxtlZuCHQRZjmYRdhShWOaBV8UXSV6sKhVdIrfr5UfTW+33d1U8zIXYrVrPwk
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
index ea1c84dc5de5..661404687080 100644
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
@@ -11493,6 +11509,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -11504,6 +11532,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


