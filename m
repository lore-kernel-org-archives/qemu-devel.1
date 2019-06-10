Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C19DC4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A75320862
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A75320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQLN-0002L7-KR
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1haQJU-0000qL-Ei
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1haQJT-0003rC-3r
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:50:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42368 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1haQJJ-00032k-8p
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:50:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1DD7E1A2092;
 Mon, 10 Jun 2019 21:49:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CCC5A1A2045;
 Mon, 10 Jun 2019 21:49:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 21:49:10 +0200
Message-Id: <1560196150-30436-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH] tests/acceptance: Improve failure reporting in
 linux_ssh_mips_malta.py
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
Cc: ccarrara@redhat.com, f4bug@amsat.org, ehabkost@redhat.com,
 amarkovic@wavecomp.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rather than optputing a cryptic message:

FAIL: True not found in [False],

the following will be reported too, if the command output does not meet
specified expectations:

'lspci -d 11ab:4620' output doesn't contain the word 'GT-64120'

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index aafb0c3..cbf1b34 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -147,20 +147,27 @@ class LinuxSSH(Test):
 
     def run_common_commands(self):
         stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
-        self.assertIn(True, ["GT-64120" in line for line in stdout])
+        self.assertIn(True, ["GT-64120a" in line for line in stdout],
+                      "'lspci -d 11ab:4620' output doesn't contain "
+                      "the word 'GT-64120'")
 
         stdout, stderr = self.ssh_command('cat /sys/bus/i2c/devices/i2c-0/name')
-        self.assertIn(True, ["SMBus PIIX4 adapter" in line
-                             for line in stdout])
+        self.assertIn(True, ["SMBus PIIX4 adaptera" in line
+                             for line in stdout],
+                      "cat /sys/bus/i2c/devices/i2c-0/name' doesn't contain "
+                      "the words 'SMBus PIIX4 adapter'")
 
         stdout, stderr = self.ssh_command('cat /proc/mtd')
-        self.assertIn(True, ["YAMON" in line
-                             for line in stdout])
+        self.assertIn(True, ["YAMONa" in line
+                             for line in stdout],
+                      "'cat /proc/mtd' doesn't contain the word 'YAMON'")
 
         # Empty 'Board Config'
         stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
-        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
-                             for line in stdout])
+        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193a" in line
+                             for line in stdout],
+                      "'md5sum /dev/mtd2ro' doesn't contain "
+                      "the word '0dfbe8aa4c20b52e1b8bf3cb6cbdf193'")
 
     def do_test_mips_malta(self, endianess, kernel_path, uname_m):
         self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
-- 
2.7.4


