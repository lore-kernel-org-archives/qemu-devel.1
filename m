Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F69C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5619F207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5619F207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBebz-0000F3-HG
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaB-00045J-1V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea8-0007Hc-C1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:18 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mq1GE-1kyn5p14yY-00nB44; Fri, 28 Aug 2020 15:38:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] linux-user: Fix 'mq_timedsend()' and 'mq_timedreceive()'
Date: Fri, 28 Aug 2020 15:37:48 +0200
Message-Id: <20200828133753.2622286-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jfDu4dBgaWC1O+LIKt7nKn3VZ/TMnY227cCw9Q7eF40zJ/Cpi3a
 qnmLvj8cDrHqnPATN9FcPfVItulLia+Ou6RhpmJGWmgtTGDnJVHt/jGsNlBD0eCCFrxEXZg
 X2fH1XASzxTgX/nIhn5DsArGwxV/FZh27PqoBpFz2oVdm411awNExbov4CWZcMN2c7FYxPk
 QnqkHpMLih9kkkmLaOsCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oktaPHaxQ4M=:hhvpAsOoMYeXlj76aoAn1R
 vAEE2e/PIERGirgxeKlzLFMqegYobrKWDJjoy54lj0qjWCbTVUeEaVA2V/tczW1ZLIACWlyMs
 dwRNuRAuLpMQ1fuLM1wTz8cvKDix0iKB+Kgubdnerl4gdU13zmhDd+T9LHDlrHiXZIqzVs9jj
 G1gQEFAv2WBd9u3naZ5xYMM6HuxZtMpfdtlmfWeUbcevkYzDew1dDX9B9YC4KaehK5N5ZQs5C
 zQd/yi/mFbC2bJgLirJPWNOAgW6u4sYiEX/WP4rm2aTBp9CcrUerixL45ld45SrQ5TbJcH5HN
 UCaEmjMbriO2b9HbYp2zNl6JioHNfy4eBfe/KGL+P3A5mw91qXsF6zIqnEwQZi0WJlQ9NIr8M
 Uk5qUfeJ9NhN3lH7eO/NArDRDL89TRFOpFKm6hA0M+gkVq5mGjuYK5AWvLxJY5Zek9EOI7wAF
 fdI0XzI24WM0RnKscHN1iXXLntZmZa5tU80WR4B5q/dVIHFR5+jXnrrZYGB7A7vc0OfsetZhr
 vcR/Y0rCjA+mJXQn3ZK6NmvPW39OiYNf4rQIkIaRzccsfvLc6wM6DIownepBZtHpaEE3QM7eO
 F618VmkyGkfcjpk2Zb1TQ1juEJJorAMei3kTdamrip4BVviqqc4qzsX4MTzbhxsqZPYokh4LU
 lTFKtTDRQuUi+fpdmAqVpP6j8y4NISnEZ51o09Ga865gyexI4aFKsfc9czBvg3xadT3v6D3Vv
 LB6d9NgDKBSqmWMRtAVId14e+SqVtbkFUWeLn2KE+sS9Nyv5rZfVhExajYfDFL5/Dtn2oe+Dl
 xBtOcBLJQnIEgSZ3mm5ocewrXqMBS0+QCeCnDn9kxFoMidPTB+iCURwlLC7nrn1T+VbAz15
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:08
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


