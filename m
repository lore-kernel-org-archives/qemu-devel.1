Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B41C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB72320820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB72320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOgN-0004Yi-PU
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCOZz-0007Pr-Fg
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCOZy-0007ZS-8K
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCOZy-0007ZG-0D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DD4B20E3;
 Mon, 23 Sep 2019 13:40:37 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C6C019C58;
 Mon, 23 Sep 2019 13:40:36 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 6/7] tests/acceptance: Add new test cases in
 linux_ssh_mips_malta.py
Date: Mon, 23 Sep 2019 09:40:18 -0400
Message-Id: <20190923134019.8548-7-crosa@redhat.com>
In-Reply-To: <20190923134019.8548-1-crosa@redhat.com>
References: <20190923134019.8548-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 23 Sep 2019 13:40:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add 15 new tests cases. They all rely on simple commands used for
detecting hardware configuration information.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1564760158-27536-3-git-send-email-aleksandar.markovic@rt-rk.=
com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 7fc44f43d1..1d334432a0 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -154,6 +154,51 @@ class LinuxSSH(Test):
             self.fail('"%s" output does not contain "%s"' % (cmd, exp))
=20
     def run_common_commands(self):
+        self.ssh_command_output_contains(
+            'cat /proc/cpuinfo',
+            '24Kc')
+        self.ssh_command_output_contains(
+            'uname -m',
+            'mips')
+        self.ssh_command_output_contains(
+            'uname -r',
+            '3.2.0-4-4kc-malta')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'timer')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'i8042')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'serial')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'ata_piix')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'eth0')
+        self.ssh_command_output_contains(
+            'cat /proc/interrupts',
+            'eth0')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'input')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'usb')
+        self.ssh_command_output_contains(
+            'cat /proc/devices',
+            'fb')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'serial')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'ata_piix')
+        self.ssh_command_output_contains(
+            'cat /proc/ioports',
+            'piix4_smbus')
         self.ssh_command_output_contains(
             'lspci -d 11ab:4620',
             'GT-64120')
--=20
2.21.0


