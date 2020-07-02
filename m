Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6352A20781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6352A20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Cv-00013v-LX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17Y-0000Wb-VL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17U-0006Iy-Rq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:28 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLAF0-1jZtwK3fyk-00IH9H; Thu, 02 Jul 2020 17:27:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/12] linux-user: Add strace support for printing arguments
 of chown()/lchown()
Date: Thu,  2 Jul 2020 17:27:06 +0200
Message-Id: <20200702152710.84602-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Div1Oj4QFV38XvoLfpAS/N2QSRDhF4/3VWi+zsYAXkIQbOAyZTN
 PcPebioBEhtv6qfKDGIqsj70FUCpEyWZE+yiWqz4LBstjt+SEeC1eM9eGpIiR2jIgoDg6F5
 NhTFsNHI3Ba4jabJhDfIiFC2bMI33hIZnD9q73OrCFhNWuhCCVhEDsxTJchZolmiLX5fu9V
 Vghhks2UDQaJCD/b7Dsdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OPZCB9/iFRE=:uPEyeDln5rs0qNiVXYwlG/
 E2eNVZlpcmcKpJ//hiajeLU8O6lomJOdF/ogbkqp+E5eaQJxYMeYISG3yCcgdVcAt4YQLNKvT
 prb7yi1btC5zUayT9CyVKi5rv5eupcuM0YcyL9Oc4bBSBIj61Og83n6Tew/FStVpgvAR+A4bR
 dKQvnmFPcq+nlJFtBrPX0jq2Vux5rPkm3acZDxGc9TBekIuhp9wxI76Kf4rwwu2CtDV6T1ufu
 SnqxicDK32VQ1V7zsNQPSqJ2hcR8gPc19cc8aNfCuy5AflY+6nNbZ1rq7hQpV7r6NCqKc+G0p
 Tc9NlUKY1JRix4fEQPI0icj/Ga2EcKXMpBmsXUpyInU2Bo7k8n0DiVDn7kIFeJWG61zFOLH8e
 mPKenerTJQl5/JJht3fhwbViSC29C47ukh20r7pZZusJL4eV1H1z5TUFZ9Z9mcZ4rEgUR1NNN
 0pkuIFl7NxKv95sXZY2Al+R2SXjJZ8Hw7NzQ1rhYvtKz2UtNIWLaD51IKRUXk7I67xWbWy9Sg
 BMA8ppSNzIFKT/dV8ov2PTispvghxw4dG6MijoxGrEJjMD8F4RDSdmWzdNBJl6MatB45x2xAY
 X2/sjnfVxO7KAhrVgMxplKTWLHKhwopyxVtvWZrZLEOZ4/j34SLq6a//8fUZsw7LBcEJHLjzP
 H6/4iRljNF/rH89FSMiaU4VoFmanXqhlPdOTSGgi2tJIw/Sde+EczGZT931SKH06kTJS/MavW
 j3Ud8erG8ID48hsmyCXcbpLO+JJnotCeRFF50D+ZurJJN+jAbSpj/M2ScjzRwKlgfhr+cEl5B
 QHBjEbr5wD9kFbi0fsOTqrE+R3CnXyWvrtpCASM6wlqNSVxd/8=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:27:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscalls:

    *chown, lchown - change ownership of a file

        int chown(const char *pathname, uid_t owner, gid_t group)
        int lchown(const char *pathname, uid_t owner, gid_t group)
        man page: https://www.man7.org/linux/man-pages/man2/lchown.2.html

Implementation notes:

    Both syscalls use strings as arguments and thus a separate
    printing function was stated in "strace.list" for them.
    Both syscalls share the same number and types of arguments
    and thus share a same definition in file "syscall.c".
    This defintion uses existing functions "print_string()" to
    print the string argument and "print_raw_param()" to print
    other two arguments that are of basic types.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-6-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index a26736516bab..957f08f1adf2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1452,6 +1452,21 @@ print_chmod(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
+static void
+print_chown(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_raw_param("%d", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lchown     print_chown
+#endif
+
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a4a8c61969cd..e99030c9ef39 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -71,7 +71,7 @@
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
 #ifdef TARGET_NR_chown
-{ TARGET_NR_chown, "chown" , NULL, NULL, NULL },
+{ TARGET_NR_chown, "chown" , NULL, print_chown, NULL },
 #endif
 #ifdef TARGET_NR_chown32
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
@@ -475,7 +475,7 @@
 { TARGET_NR_kill, "kill", NULL, print_kill, NULL },
 #endif
 #ifdef TARGET_NR_lchown
-{ TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
+{ TARGET_NR_lchown, "lchown" , NULL, print_lchown, NULL },
 #endif
 #ifdef TARGET_NR_lchown32
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
-- 
2.26.2


