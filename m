Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528692068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528692068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFTO-0006CQ-Ho
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR8-0001WT-NL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR6-00024R-2I
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:10 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsDe-1k457h45g0-008uTH; Tue, 14 Jul 2020 09:33:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] linux-user: Fix Coverity CID 1430271 / CID 1430272
Date: Tue, 14 Jul 2020 09:32:55 +0200
Message-Id: <20200714073259.1464675-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7Gfc1ASwvj47EHlnETkYlECSSDUswwk4+KQ5UOe0YwXlWEQdfyP
 VYRFiI+B8j8/95bdHhdglNHcmMc7kN5Xq2oWyvmWleS/Q9CQMoVBn0I2lBsdkRaM9/uedQK
 orUmdjZa5W324LNCAtjRGCmADvTHEnNGJrcAKLWnwVYeCXPBx23DV5luVpebe8pYmKIcJ82
 zgbQjRvvaOzsYD/ZlEOzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+TspCWpgr5Y=:Y6SOb9c/f6KtzLoYN1kUpl
 FxWUXfxAJQvudDRkfNlMGi8yEjnSqmyiAsARIcWKYJh6M+7lCm18pTdyrBKxcFgu0eEPou8jx
 oByM/Fc1Glv1sfT2aa9gtuJtUCvdbAWQIIqURobYCoTuKGV0Md1bhn3wJpI/+XPdQuyu3un1h
 oofRTmNOnqfN9fhufoxHEWlfzRcSOqhaOrPesu0ZUI7Nohj6VT73ozg3u5UwHrP38bLpxgMBs
 vS8FcrzBFVWwsZWEmh9RGHdyaDj9UA5u2rrh1RUpq/8JNUYRcEODON8HsRaUdiExPX4+O2piX
 nBnXh3CwmMhB0f6+zhRTlR5lsppjyVAAqzJNouDWoSNK0JeSAHEVKeZkTW/DOO+RkiP7facrq
 xmL13akBiuxKxgMZuRR7yV/YYbqv7a/jL6WM1iaEgqHaoOs76kWSvdLz1ZrIK11REozO/WzdW
 LcuCeWZcOeAQaFMfRjNIYW2j8z8vzzj9cP3Ahiu04th5HGScZ79Holy3dofTvkSiNn9j08nUm
 SeTkttYItNUxs3BBdVMw5BpUYRKkd8BgqlXN9DQxjk+kbEgrHIuNC4oafqEupjXhWTvszk25m
 jrLdE7n9QEULkFAARQEKUPL/EzTMdSIwlGy4i0EOAu/iCcF6SFLEBZX/vX6pSPhCjM86twCqh
 MYMohC7GOaxzm2tOycu9HRTF11+ET1kfm53rMZFM6slHgT4KyJb4w3xgo64rYAFNoRGsBdYOy
 0+YoDKulrVRzKKjUbE7puW3RZ5nlYIWcebqnbAiGxE/ucM9Ntyjezr5GD+fbQD63z7lIM0KWQ
 ruJ/fpPYOCH3/RLbgds4oeizTKxgSwcXCjbnPn/xFOKUA8sJMOEEchqdrh3e5Gvh8cwf5Wu
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:05
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
 Laurent Vivier <laurent@vivier.eu>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


