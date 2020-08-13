Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEABC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9237120771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9237120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6788-0004by-Op
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673V-0006WD-Tg
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673K-0004c2-NC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:41 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdeKd-1kfRw61xJ3-00Zgix; Thu, 13 Aug 2020 08:49:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] linux-user: Modify
 'target_to_host/host_to_target_itimerspec()'
Date: Thu, 13 Aug 2020 08:49:13 +0200
Message-Id: <20200813064923.263565-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zuSGs6czlh0CirxHVbZlJY/8PBEHKVCR7jiWGDildMGndVr0kLj
 KgSpUpF4wHq2wRGYQOD2+XOsBpyYk4sotSBQc7OWa8iJwGpY1Ku3Nw1FIdRqwGCAFrRXeWS
 lCn3f0eKG+i7+cofus4yyUh4Ga515DFSeNKC+ZrPCVtjFDh/4b+Ho5l2ptHaKj574wkJZEt
 rLPZ7MGvRsbxcyFA1SRPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rimmTGr4uw=:1AqsU3sQC2R80cRyI2kxQX
 rLy3FsusP9OyqztdNZXKoUH8rNe0/uH6CrfpZf9dV0aXRkxvE9XJzT1ujE9lEIBAsLLcaZldY
 LDwu8A2pJaFICyVkyoS6VH8c4JqA4xYQzQniStlPlou22OYtPju2d9nV0il9/6fitUxZVMZCU
 BNhYDE2vHEROE+QbgvY9G6VGY/ylJkubdHdhS5KU8XL+3ijNC0lfTE37RAr2oIjDNJrHT8ufU
 NSpPxms9v9U+kQ8UJMZ1RT6Y16Ndjt/R4+YyZreu4DKyd2a/Bgr+FD8d9XyzOv8NZnNFckFch
 xpMTVEp4fsn8UPl409RyGzpDEK2JkWW575I0OPHMzftfQs8v/v+g3hcIGKP7K+8yI5g9oK76A
 Qj49DAI0y1zIfampmkHBlv81Y4zbnJcraP7qPLAPISj+Bauw4LEToxJhJlEn25vaJ+1t0rXOw
 trWLX4V2NXZIjqxfUB3mC5qKbuq57VD4dY+3mW26o19CEDE85//prltofNTIVzTHNewTvdM+P
 FfSOWArcJNzZyheqGSDsm6WJxdAZGkSbGSOEkzB9EIdDED7vXLhVClnD9s7mhwwoUwhr4Yln0
 aXxc9Z48DqrTWK0A1IJX+DlJ6Ku/zmaX5REELvyRtyfEyiT2aPNzesRmqQg1XzKI010aP0zVp
 m/u6XmthE5nuvXtl8XqK0O91I6egnjfLoefEHi9mvnvKj3cxrn2Rfgt9sWLTFNmddW3L7t9vs
 9uZtgzsBc89qO+ElrSrGKWtNm+dmKOKG3Uh/FR91stQD60D9jiqvaX4aacsD825+aXoeSgQd1
 LIM/Wbb+X8LLqXq32I+UcJ5g+DfCFlE0wzShEkAJLX3EJyTXRGrFKdkONyyd9YcYNq8kaDz
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


