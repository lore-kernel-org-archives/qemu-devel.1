Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67806C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A89C2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A89C2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rWh-0002xL-IE
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSt-0004sx-7u
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSp-0006dr-Bo
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7rxE-1kDjLq3A02-0052nm; Sun, 23 Aug 2020 16:59:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] linux-user: Modify
 'target_to_host/host_to_target_itimerspec()'
Date: Sun, 23 Aug 2020 16:59:10 +0200
Message-Id: <20200823145912.1171738-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qzRTM4JadDYb+V6mlA5gjbKDsZO7qiQWhJaSMJ2yYYRnK5JDHFA
 UAQh8ycIyiOi0ZAVCQGkEDPEShUFhSlq9Itrye8gggZgaA1yH5bEEkJpWXszAbY0gOzYCy3
 uca5QnApIwPLyhZESLfHd9SGe/8sTiFZ8AK8mg0wCIC8DN0pTynwKCJyw8l9EVUv5i59Dew
 qNMUdSaUvVD2pi9aNC7fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yymeIl/U/Pk=:kaRXpyWuYUpDCSt+1AO4gU
 omIz47GLNqI2rjacaGaJa8CEqOJQTB8uv0xgbdbDPnb/De3hnoVq++EgpUR0kwEaSpy/hA2d+
 D+8Za1KR3V6IK0YMsPueFk3iK30CsDe/RFTgSFXuMtDRAwsVsqULIyGv3oG56pQytsD1/B4cD
 F3HKpWefrZV270q9or44mmjoUvEPH+iVb9Z1yo4aO+cjOF3EGbEM3AEjnwTqA8540g3PsB4tb
 gR7GRiAy6aU2tE76uK/t9T/UBK8WPmRUzq+nPRAhYM3vDQ3xaR/QwfyWhu1u8GVOhm35L+s2U
 bU2OPCxUKSy5vbZuzevP2/eDo5fdthLFdqZ9T+ZA20o6WMT35gfKxTH15aBn4LAgbNZyGAGze
 zn0SUBaGN5PEIuBEo2ApaRMK26QOUmUydzg9tOsQfS+JhznyA6yLiETXZZIbNrWZam7hqBhnQ
 mjIQI82jT3dwoLPgfbTcTOYWOLCqcUfgIA+gu9ILwIl5vNYfm8ym6DkCyeFHmrb+yW2i/XkLi
 136W1AKiRVuvtUFIuR1TaLFDJZlozyznYZBWVWBvDrMtAUz2NiDWmNBHaHKg9Ej3zXfat2XsC
 q/Pywn9xEp87RztkKDMVt87QNOHHf0KDB8vJmw9uq4lAFIcj+wF5RWVIv2TA8RakLiG93SjrN
 WQ8IfF1y9qVXDPeW/0RnGhm3wFbvU2cLikuBLXP/SSuaAQYjdLlxWJpCF1m+5+H/B6PNSZn1G
 SpGHkzeF9Wkiyf39R2thvxXvXglP0lNFWtsPCa0uC1gNPFH2h4d4yi5slKrcqFFCGrF4Yg44o
 ecgX/fYjY6nIIWeNpZapXuA3k6CnCy8+MzjJLrI4b2+uEikEBe6i984hAIH8lonqY3bP2qX
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Functions 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()'
are used to convert values of type 'struct itimerspec' between target and
host. This type has 'struct timespec' as its fields. That is the reason
why this patch introduces a little modification to the converting functions
to be implemented using already existing functions that convert 'struct timespec':
'target_to_host_timespec()' and 'host_to_target_timespec()'. This makes the
code of 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()' more
clean and readable.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200722153421.295411-2-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 46 ++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 945fc252791c..aea1160804a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1229,7 +1229,9 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
     defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
     defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
-    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
+    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop) || \
+    defined(TARGET_NR_timer_settime) || \
+    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -6783,46 +6785,36 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 
 #if defined(TARGET_NR_timer_settime) || \
     (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
-static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
                                                  abi_ulong target_addr)
 {
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
+    if (target_to_host_timespec(&host_its->it_interval, target_addr +
+                                offsetof(struct target_itimerspec,
+                                         it_interval)) ||
+        target_to_host_timespec(&host_its->it_value, target_addr +
+                                offsetof(struct target_itimerspec,
+                                         it_value))) {
         return -TARGET_EFAULT;
     }
 
-    host_itspec->it_interval.tv_sec =
-                            tswapal(target_itspec->it_interval.tv_sec);
-    host_itspec->it_interval.tv_nsec =
-                            tswapal(target_itspec->it_interval.tv_nsec);
-    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
-    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
-
-    unlock_user_struct(target_itspec, target_addr, 1);
     return 0;
 }
 #endif
 
 #if ((defined(TARGET_NR_timerfd_gettime) || \
       defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
-    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
+      defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
 static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
-                                               struct itimerspec *host_its)
-{
-    struct target_itimerspec *target_itspec;
-
-    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
+                                                 struct itimerspec *host_its)
+{
+    if (host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
+                                                       it_interval),
+                                &host_its->it_interval) ||
+        host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
+                                                       it_value),
+                                &host_its->it_value)) {
         return -TARGET_EFAULT;
     }
-
-    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
-    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
-
-    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
-    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
-
-    unlock_user_struct(target_itspec, target_addr, 0);
     return 0;
 }
 #endif
-- 
2.26.2


