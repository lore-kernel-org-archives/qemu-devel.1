Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51569CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2779921E6F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2779921E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2ut-0000xh-6K
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ij-0005Af-RR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iO2ii-0002Ml-Cy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34491 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iO2ii-0002Fg-54
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:45:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 471241A21F7;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 206F41A2290;
 Fri, 25 Oct 2019 18:44:30 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] tests/ssh_linux_malta: Fix 64-bit target tests
Date: Fri, 25 Oct 2019 18:44:22 +0200
Message-Id: <1572021862-28273-21-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1572021862-28273-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Commit 9090d3332cdcc added tests for specific to the 32-bit
machines, which inadvertently make the 64-bit tests failing.
Now than we have this information available in the CPU_INFO
array, use it to have the 64-bit tests back.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20191019153437.9820-12-f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 14b8a5b..aa12001 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -43,8 +43,8 @@ class LinuxSSH(Test):
               }
         }
     CPU_INFO =3D {
-        32: {'kernel_release': '3.2.0-4-4kc-malta'},
-        64: {'kernel_release': '3.2.0-4-5kc-malta'}
+        32: {'cpu': 'MIPS 24Kc', 'kernel_release': '3.2.0-4-4kc-malta'},
+        64: {'cpu': 'MIPS 20Kc', 'kernel_release': '3.2.0-4-5kc-malta'}
         }
=20
     def get_url(self, endianess, path=3D''):
@@ -155,16 +155,16 @@ class LinuxSSH(Test):
         else:
             self.fail('"%s" output does not contain "%s"' % (cmd, exp))
=20
-    def run_common_commands(self):
+    def run_common_commands(self, wordsize):
         self.ssh_command_output_contains(
             'cat /proc/cpuinfo',
-            '24Kc')
+            self.CPU_INFO[wordsize]['cpu'])
         self.ssh_command_output_contains(
             'uname -m',
             'mips')
         self.ssh_command_output_contains(
             'uname -r',
-            '3.2.0-4-4kc-malta')
+            self.CPU_INFO[wordsize]['kernel_release'])
         self.ssh_command_output_contains(
             'cat /proc/interrupts',
             'XT-PIC  timer')
@@ -221,7 +221,7 @@ class LinuxSSH(Test):
         stdout, _ =3D self.ssh_command('uname -a')
         self.assertIn(True, [uname_m + " GNU/Linux" in line for line in =
stdout])
=20
-        self.run_common_commands()
+        self.run_common_commands(wordsize)
         self.shutdown_via_ssh()
=20
     def test_mips_malta32eb_kernel3_2_0(self):
--=20
2.7.4


