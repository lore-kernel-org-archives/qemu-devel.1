Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85246C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4D4207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4D4207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBedN-0003ap-LE
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaE-0004Dc-3u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea9-0007I8-T0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:21 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1cvQ-1ka5EG3NVY-011wni; Fri, 28 Aug 2020 15:38:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] linux-user: Add support for 'mq_timedsend_time64()' and
 'mq_timedreceive_time64()'
Date: Fri, 28 Aug 2020 15:37:50 +0200
Message-Id: <20200828133753.2622286-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7g9EO+XNkkRxUPt03hR/FcciOk5jXl6jJ2ZSU9AT3e3sNF8C3vX
 rFHYTliG8SgsajUd2do1LWhIasnLcJP9fnqiN1cVd1dhc3P8Dw3Uyac68/337KkgwP7c+In
 SP0uuOJVoNWrD+Kl5eqWyfUWFqjvEs2ShccVlgsRZ1R8PHjPRMV51fDhAmospbQ616CWy78
 N/r7G1d9crNHzNWcrYmqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnZH9lp5PNs=:45UB/2oyfL7DUk74XYnOcC
 Jn9xhMWocVoQegdj6J6yfziPnz0F0DXHWNZtelXfh2NFH4wz518Aoo1SRfyy14iwotkdGtxys
 zad/o3u+SI7xWzLiPzCXzeRB5IYpyB1JBzonAO3kky61PYY9Ge0EG83qCU1rRFU7McLCnorcw
 SddWDYoqMHzDmywYpZabfhUaVSQF6OE0ePlJiLncGWG8dnXUbN8ca3XvGZ/whIxdLnER+Ol7h
 7as0f1oUKF1v9/buMBgBAobkZtjBKzLMcEHNK7z+mWbzhq6BF1H2VRjODRuEbuRVZ0N+/MjTg
 nJTKEJYFPFOg136eQ/MQF31SaAodnkZVb9ol1WJvZUVx5TSYQxBh2rTcce1zTS/kZjNHAslY0
 ySRlcDPV5sOuthomQCjpSE0ZbhPfoctHCvUYMaDLtHI92uQs3nIaKig4XCQI87T+oD+oBVHvL
 nrp26b4eMLp8viplkn/+pEw9t1S/4jF84YBcQgTRUc+pPexMB9soOfmgOmH4dYsG/MCaS1UW+
 51tBJ+IfWwn+AvmuLFebGW4I8u29tyAOlOOOEs1E9piGLP4ShL1sMgxDqnrpbu57ypU6RLa07
 A82aOjRCa4mczxvtnWCuzzddUuOrqpfnw6qWcNqahkEZp6PIpAN7RvIvodkqGK6pZkFcgDpGJ
 yj95qwrcx2szacCjnbjRGrik1a/hfJ0px04hWtrpfXicmoeDO096Bv9YXR84G2SzGAuEaIEJX
 Z8JJ/CllknOOLEEn+AhLlYV3IDDq4XS+kfj5AYvVR2hLVmwrE5uqg1Kr99YpJ7tSjvhs0SqI0
 J4fy0/M/3AiKjCnOkWj8Sp2cTfXRxobLQL8q3KAm1rgdilf8Ul3qXOWvDa1bHEOBMosymdi
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:01
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


