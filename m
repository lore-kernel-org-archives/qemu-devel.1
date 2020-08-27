Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A3C207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A3C207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNZr-0003Uj-Hz
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNSA-0004Ie-On
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS6-0000Hs-3E
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:54 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRmsG-1k12PK3FPu-00TBcq; Thu, 27 Aug 2020 21:20:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] linux-user: Fix 'mq_timedsend()' and 'mq_timedreceive()'
Date: Thu, 27 Aug 2020 21:20:13 +0200
Message-Id: <20200827192018.2442099-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5dyNkvOh6Z1u0ZcfiYHQ9lBcwo5/HgdFcUFLCj7x+AR83Ht23CU
 cEpov2qXrAikOMzcAen9W2NZiKUfN5ZudJsww4NFvuum+OPDAUC9z9iS8JAHsAt5KhN+LC7
 cG2Dsld0DOMqOesHdQqflBrcojPif08YjaSBsGQIwQvyuKJXS6YX+woyJgI0pAtmGcHTSuH
 eq8Ngws2esKF9WpSr34Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YtvA9Vr2q9k=:cFUQ3jZdjsawVGl0wt6DZG
 ujPOV2asFZUAowjUKstfPJywpj085Fsg7U7O05IJuLEnh+2KBkjuQdWRcC2pQnaO/pxl3h3TU
 Ame8aTyZMJ3WmUqnM6l3k0dFwvP4qzgKlVjo2J1tXmTaYR5E+lk5o9NiJrTcBuxc7AJYIazuL
 eXCjfVSm0UUsS5k3u8ou+ZBR6S4X3XsMvkaR0Boone7/EHtgLjr1CnW/ktbG3tPJ98ACBvVFC
 9ZSOno6OLsvJnWnoaQO2dVl8GCa5EcTBd12reOtwYMnQSyfifU5OfXFCk7K30ldoqRi+JwI2w
 dq7Zd760oFH2Yvqr36y4KnVpTlFq/wxoWgRJcpE6jTZBX6CCE/VGsbGqntTr42QlHYlRiugvX
 SqR8ypEOTb9CaZiPpP79X6d4PDikq275gPodHqDOqHj4iO0ZxIg9tuCzDm3c9B2l74nHF9aCz
 JZpgoGvJTCKd5BNNZk3bi6OTK9MQj9GWu7GE5FnwgaabJR3smENHXlJ8NrnvqgI2OYae/LQ3A
 DFNX07o+v2GVOJNbsS1waZqxO7EkNGmTJzRzlxuTnViqlModwFdHLFMUDLQt/I7RXF1Y42A3b
 ktPLSgZBP2KgDS6ybUKBssUo9/VX9PTA62YzWStE6fSyDfL69UJPvTRvgyzumMaYfNNKJ3hyJ
 ZWD0EspyeSXkUuuCr4Nbzgsbk9vf8qbLWZJQW+3/a8tr8jfee6w0uULs1RxXHB8YL/u/fqMD8
 MghNYNUD2moAbqY5eQQs1owWCTvXPhEcmI0sQenPqmFdWOtRuU+x+2vDh3DI3XFIqhyoJSifL
 u74UCJt3fpYS7Le/SmvA64cEooAqLynmlRszLF3V1wXukXVpxTxLW7a6zCSdeP6xa2Jph/M
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:33
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

Implementations of syscalls 'mq_timedsend()' and 'mq_timedreceive()'
in 'syscall.c' use functions 'target_to_host_timespec()' and
'host_to_target_timespec()' to transfer the value of 'struct timespec'
between target and host. However, the implementations don't check whether
this conversion succeeds and thus can cause an unaproppriate error instead
of the 'EFAULT (Bad address)' which is supposed to be set if the conversion
from target to host fails. This was confirmed with the modified LTP
test suite where test cases with a bad adress for 'timespec' were
added. This modified test suite can be found at:
https://github.com/bozutaf/ltp

Without the changes from this patch the bad adress testcase for 'mq_timedsend()'
succeds unexpectedly, while the test returns errno 'ETIMEOUT' for
'mq_timedreceive()':

mq_timedsend01.c:190: FAIL: mq_timedsend() returned 0, expected -1: SUCCESS (0)
mq_timedreceive01.c:178: FAIL: mq_timedreceive() failed unexpectedly,
expected EFAULT: ETIMEDOUT (110)

After the changes from this patch, testcases for both syscalls fail with EFAULT
as expected, which is the same test result that is received with native execution:

mq_timedsend01.c:187: PASS: mq_timedsend() failed expectedly: EFAULT (14)
mq_timedreceive01.c:180: PASS: mq_timedreceive() failed expectedly: EFAULT (14)

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824193752.67950-2-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 78e404c23cad..fd13e72305de 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12043,9 +12043,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
             }
@@ -12062,10 +12066,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, NULL));
-- 
2.26.2


