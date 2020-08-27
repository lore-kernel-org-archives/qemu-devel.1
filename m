Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1624420714
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1624420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNba-0006lf-8L
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNSB-0004JO-96
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS9-0000IJ-3e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:54 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M8QNy-1kFnIo2N7I-004V66; Thu, 27 Aug 2020 21:20:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] linux-user: Add support for 'mq_timedsend_time64()' and
 'mq_timedreceive_time64()'
Date: Thu, 27 Aug 2020 21:20:15 +0200
Message-Id: <20200827192018.2442099-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uv4eOu/tNfyzww5wB/LIXMENRklNHb+76HLgBz+ZSqV9+a96s/u
 YGyZ+hfxh+9fAG5vWx1LqWyo00EV1yfhnPJoImtyb+RmQ/jvqFqEzTuNESDj67C5aMOtnXH
 yIUWMRCiFFD1Tq/4oGX0mOoezR2cr2IdJiGXyqlG8A1IxiYnSS1N+1eBvDb/4PXoEciWOW6
 rFAKe3i0Uz7kfuVBUpSDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJTvFyXWkLs=:WFD7KveHIPkQ2mAsmq0di7
 +B3d3v74cQlcr4HIF7+uEsCCfZ+uZC3K1Grd9s18ve9mSkIck1YD7eGYfUL5TCoqKtZZxg6bq
 tzdrWl3dgnfBl7F9CSHWhcF99P/udWBgSCBcOATGjMAPwlVsGWb9El5idYLq7DPP5d+hCpq7p
 WAaDDkeDpA7cjY8QGoh8iSin4KQM/e6EeAZFDA8oDya/X/YrCh/6kxKHsuR23Hncr4I8bCb4m
 omzUEwTMy/73uL0GZkcthahOGMrStV4bDwUZ9anka5+rorlyvFII1GywLM4l7/kGPiOLi8Uzs
 H6DoM9IsvY1n8Ukbn+IcQlJvT75nsZtpAQaWKORsxwmpEaKmu5syAI9y0KD35stVliZqF1WeS
 Tp1tZCuECXkXT/jlrIq/omBoeQp/IldxMKunWidsfHqB0A8Z7MtqwRPC6jfyzcsjLQlksaeWP
 TSKqSFXsGoySdXSt4spQKNZCZ7t0VlSQSl1NKEQEZ0YeLNWmgmC+CjdPRphDQB7iENaK0BKaC
 FnyYFC0oiItSzUxqjMRaJ0hxjpwVNLmGbVZfC7UFDFjDcGRHViQuWb0l2x1W22qxGeoBGQ4gK
 MFUJg80/mBDR8Xi3fmmkFcLdYt0RZj6tC1fsz3Gv0yKdnsyKbqVT9zgbV18b5G5dVtTvOPe9n
 JhEah4mvK0bdGC4aBIXBJSM8D5hgbH6IYgLchnDw443TgZqkEi06cZJFJKyjqWrTQpjMIlPpE
 NwA6mGu0nQNtEOURBw2TJac63LgAMYqT1Z5v4IGdaAV3rV0uXiaAlYj3FLxzinfUU0LgIrTtr
 zzWcPmQssYfZJK08baqKUW/GPRbB7c+cIYuUU8et+T1IFq4jZJa5NelxNHiSnbUaUVAeL46
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:29
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following time64 syscalls:

*mq_timedsend_time64()

    This is a year 2038 safe vairant of syscall:

    int mq_timedsend(mqd_t mqdes, const char *msg_ptr,
                     size_t msg_len, unsigned int msg_prio,
                     const struct timespec *abs_timeout)
    --send a message to a message queue--
    man page: https://www.man7.org/linux/man-pages/man2/mq_timedsend.2.html

*mq_timedreceive_time64()

    This is a year 2038 safe variant of syscall:

    ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr,
                            size_t msg_len, unsigned int *msg_prio,
                            const struct timespec *abs_timeout)
    --receive a message from a message queue--
    man page: https://man7.org/linux/man-pages/man3/mq_receive.3.html

Implementation notes:

    These syscalls were implemented in similar ways like
    'mq_timedsend()' and 'mq_timedreceive' except that
    functions 'target_to_host_timespec64()' and
    'host_to_target_timespec64()' were used to convert
    values of 'struct timespec' between host and target.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824193752.67950-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3b725bbe2513..b28c8edb421e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -799,11 +799,13 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
               unsigned, nsops, const struct timespec *, timeout)
 #endif
-#ifdef TARGET_NR_mq_timedsend
+#if defined(TARGET_NR_mq_timedsend) || \
+    defined(TARGET_NR_mq_timedsend_time64)
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
               size_t, len, unsigned, prio, const struct timespec *, timeout)
 #endif
-#ifdef TARGET_NR_mq_timedreceive
+#if defined(TARGET_NR_mq_timedreceive) || \
+    defined(TARGET_NR_mq_timedreceive_time64)
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
@@ -1218,6 +1220,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 
 #if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
     defined(TARGET_NR_timer_settime64) || \
+    defined(TARGET_NR_mq_timedsend_time64) || \
+    defined(TARGET_NR_mq_timedreceive_time64) || \
     (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
@@ -12059,6 +12063,27 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_mq_timedsend_time64
+    case TARGET_NR_mq_timedsend_time64:
+        {
+            struct timespec ts;
+
+            p = lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (arg5 != 0) {
+                if (target_to_host_timespec64(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
+                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
+            }
+            unlock_user(p, arg2, arg3);
+        }
+        return ret;
+#endif
 
 #ifdef TARGET_NR_mq_timedreceive
     case TARGET_NR_mq_timedreceive:
@@ -12086,6 +12111,33 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_mq_timedreceive_time64
+    case TARGET_NR_mq_timedreceive_time64:
+        {
+            struct timespec ts;
+            unsigned int prio;
+
+            p = lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (arg5 != 0) {
+                if (target_to_host_timespec64(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
+                                                     &prio, &ts));
+                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
+                                                     &prio, NULL));
+            }
+            unlock_user(p, arg2, arg3);
+            if (arg4 != 0) {
+                put_user_u32(prio, arg4);
+            }
+        }
+        return ret;
+#endif
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
-- 
2.26.2


