Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14041207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14041207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNSp-0005QE-6j
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRt-0003nM-NO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRr-00009i-Ht
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:37 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1HmG-1k9jYB3AWw-002p4O; Thu, 27 Aug 2020 21:20:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] linux-user: Fix 'clock_nanosleep()' implementation
Date: Thu, 27 Aug 2020 21:20:02 +0200
Message-Id: <20200827192018.2442099-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gVJJqO4UfM0NVrnQSTRoplZEqH3X65aSH2sPjICx5FnPh3l4m/k
 kdqU7ChqTDqXPYvZ2yeZI3/TLc9afqKp8pmpJ8aWQNyKoHbvXpeOmdN7t6ARbnUkN9Is2vg
 6JclEb0CXIP7mF37xtlcIMkJ851erhVgT6DWDPmVGjAWfF7l0kitCYoLoIrZ9zw8qtgcZ9i
 rSAnIdA+VIbfYoZMaYRdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KI4mpl7U7vU=:QBTjR1DmnMbkPyb2rwAT5I
 TeJw0mefJw5m2K2ykXw1x62Y/n5d0jR5F9lhItWgrF/gUFpn+gmRcBI8Z6gfGl7ZVNhVAiUjM
 ch6V3THqngqOqCMUGGHxMBnWsCVgqfe7+Y+mMrh0t94Q2A7ioDdx/TX5JRRjQ5gR7rnsG+EhU
 /L+tBpg6/MV+L96hC0F+LBCaR3kMFdjfueq71baeNqs50Wsvv5uSMJBILt//cpDOZXfPcPvoV
 XF2r7Mtkl9p4rajNXoQQaLITn4QRscs5gNPTuWZfzNBEMs6+kP2/Tiyuw1V7qEo0kqD1e5HEK
 VU+N7gbwCHxIn3G1Lcyh870t7Az5h3TYcLu5M8ritDXOa0arKkDoYktb2bOmPhc0uZ/NDRWD3
 UQVWGHmweRnPM2RtsdApSDzJRZxrlFv/KFhLOpoI2j/mFm1QrKI9hM0XJ+UgO23x3Az8p1zdP
 a8jxtT2e3QGzivD4mGLl9LjfkdKGUZCFoxXJVkv3VTvR17if4r/N1uI6kdpeMBXK8FPAoT2EN
 qOYxL4KhD/U+ZRgoxj1cxr9oFodLe3MP5gxGJHSxE96511RxGBb3QLs7QaYIb4YKhTb0YTov5
 JDDZMpsOlL/1YKWwOZeu0oyvbDYwpFdVbs2euXaKic1SzKwKmcECK5kyEv3lST4OWjG/bOWqf
 WSNgNJO0mgQo8FYLwh3ICA6LjwcKrx7zBK6M9b0fpxX2WlF8UfjAAoe8wBR0xgfXRTP+tUKZj
 SgApOujeUPU6eXY6RX4WqmaHRhLlk6Qiet7fEO2lVllVHChYAo4asCp9lWHZiLSfH9U9FpBO8
 Tk1byBLZlWpgyx8Wswlk2WfpYHKLnA38gr78+O6xH9vcSP4t3q7EcTZN2ZGiw90p4pAxHSU
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:34
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

Implementation of syscall 'clock_nanosleep()' in 'syscall.c' uses
functions 'target_to_host_timespec()' and 'host_to_target_timespec()'
to transfer the value of 'struct timespec' between target and host.
However, the implementation doesn't check whether this conversion
succeeds and thus can return an unaproppriate error instead of 'EFAULT'
that is expected. This was confirmed with the modified LTP test suite
where testcases with bad 'struct timespec' adress for 'clock_nanosleep()'
were added. This modified LTP suite can be found at:
https://github.com/bozutaf/ltp

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200727201326.401519-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5b3fce3dc0cb..e387246d7196 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11875,7 +11875,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_clock_nanosleep:
     {
         struct timespec ts;
-        target_to_host_timespec(&ts, arg3);
+        if (target_to_host_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
         /*
@@ -11883,8 +11885,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
          * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
          */
-        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
-            host_to_target_timespec(arg4, &ts);
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec(arg4, &ts)) {
+              return -TARGET_EFAULT;
         }
 
         return ret;
-- 
2.26.2


