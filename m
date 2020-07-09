Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D646C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20619207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20619207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcj9-0004Yu-7f
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 16:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtciR-00043h-8H
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:00:19 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtciP-0002Kk-Bo
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:00:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQusJ-1kDbTe1K0F-00NxSR; Thu, 09 Jul 2020 22:00:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix Coverity CID 1430271 / CID 1430272
Date: Thu,  9 Jul 2020 22:00:10 +0200
Message-Id: <20200709200010.1016741-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GpyrjEUPqB6WnAbaC/p+nEawQ3wS2xVRtIpW+rzD4S00smM/Wsl
 DicUY42NHeggKh40PsCHI3tg8L+1udI11piTmBu3tvqx1n5y1J4JEpADY6TVjRwXOW0Oe06
 aWl31bIcyhBjQzEY28SFl6Z4ios/pO7C58+3BnwuB6zXAgBYvytF6gsJhsbJHTyPoU/c/8g
 Rxgn0j9GmYBs9k4vryCpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GTONDieBkDk=:stD3rtAlMkvlA1Otk59oIV
 rP/ujvJ9SmNJrtq1mV3dpgMUe/5xfKuPnTgfJ/dOopQ74/rcv5QVm1kt+NZo4e/4apqDdbtCQ
 y13Q0Qi86m8NBlHiC+V5CHoKwb+T63Y3hvRvu6FFkQRTqD/cT9ew27H/K47BCBEyeVr8yjRxt
 OiBEOC2Yw13EhJDPjklWt5mcnqf1YEmYueS6bZOxL/0LQtii4pulfrhfr8vWLa1jmJqhGzk65
 S2v3CbAEoxBdztWv5Dnx8zGiO/S1Q8mYuBD/tyFIyg8LHvfed/ZkUGgDpHKg0mMe6wKiaTsrZ
 802NhkpxLpeSqeE5l2gAIDiFnEAPtQGH1QncSf/sKLIpR7yVEfVHzH7n4s5l8UGHVgcXfDVvy
 w5NaenO1fBBlKsy/f15ghDFgt8K3K0OFbFEck5OjlFeczTbagWDGkc3mBRk54IKgpc5O/7PLp
 ehhtyjummdjkpu3xsf+h+8eqg1i3c/kvhTWzUE/xMm8J4W7pDmqBlGW4s7l1a2hgyLqRYZVPR
 K54P6Anognx7YI/cHvPXVh3WnG733uTr3lAtO5sOIxTqFzThdk/Lqg3+kERkspDyhNCPNCJbO
 9jxvyb3j8KNWGikXVCofJMvhNh3IlCmk0z5cUeDKpqLzTzdU4FfaW0Gw9gqT30h1sAyUwQrge
 PMoLip/jGCMnaoUqYR6mozv6WJ/1h1T2GQBE8XSSr6RXURdrvIchgJmHZgGfidCE/k6XLgc+1
 Z06YpQLqnMLIMObmeRNGFFZoZ7tMcjjPN10Tp1QKxijDfVg70I6/vkncR0OWNtLsCM67/DdhQ
 O1/b04YiYKC18BBQtzokBM0GqpZIg+39f0zw+iR0w/92XxCk/YBf5lxO6FeGsvQoY8OYx86
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 16:00:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In new functions print_ioctl() and print_syscall_ret_ioctl(), we don't
check if lock_user() returns NULL and this would cause a segfault in
thunk_print().

If lock_user() returns NULL don't call thunk_print() but prints only the
value of the (invalid) pointer.

Tested with:

    # cat ioctl.c
    #include <unistd.h>
    #include <sys/ioctl.h>

    int main(void)
    {
        int ret;

        ret = ioctl(STDOUT_FILENO, TCGETS, 0xdeadbeef);
        ret = ioctl(STDOUT_FILENO, TCSETSF, 0xdeadbeef);
        return 0;
    }
    # QEMU_STRACE= ./ioctl
    ...
    578 ioctl(1,TCGETS,0xdeadbeef) = -1 errno=2 (Bad address)
    578 ioctl(1,TCSETSF,0xdeadbeef) = -1 errno=2 (Bad address)
    ...
    # QEMU_STRACE= passwd
    ...
    623 ioctl(0,TCGETS,0x3fffed04) = 0 ({})
    623 ioctl(0,TCSETSF,{}) = 0
    ...

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 79482e5987c8 ("linux-user: Add strace support for printing arguments of ioctl()")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5235b2260cdd..39554d903911 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -889,8 +889,12 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
             arg_type++;
             target_size = thunk_type_size(arg_type, 0);
             argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
-            thunk_print(argptr, arg_type);
-            unlock_user(argptr, arg2, target_size);
+            if (argptr) {
+                thunk_print(argptr, arg_type);
+                unlock_user(argptr, arg2, target_size);
+            } else {
+                print_pointer(arg2, 1);
+            }
             qemu_log(")");
         }
     }
@@ -3119,8 +3123,12 @@ print_ioctl(const struct syscallname *name,
                     arg_type++;
                     target_size = thunk_type_size(arg_type, 0);
                     argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
-                    thunk_print(argptr, arg_type);
-                    unlock_user(argptr, arg2, target_size);
+                    if (argptr) {
+                        thunk_print(argptr, arg_type);
+                        unlock_user(argptr, arg2, target_size);
+                    } else {
+                        print_pointer(arg2, 1);
+                    }
                     break;
                 }
                 break;
-- 
2.26.2


