Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F5A21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GealTQ1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F5A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrsc-00068h-6i
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:39:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYv-0005pM-Tq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYu-0004we-CW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hSrYs-0004sq-Cw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:19:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so16381291wrb.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AQeFho+GAF0XNyv3/66Q7+XaAILCa23wijwHXatigto=;
	b=GealTQ1/MAq8B1XUh0r4MAFDG57cwOkNLgMg1rzn0Jb/J+zasngSn/fLYngnKtRddg
	09yxNv5MZ0Hjvd1GnSVzsz9kixgoNaS1oN/WnfVZ69v8TxYAt7Tt86rCVPAXDYA+g2cx
	HcR5BBB6lUxnVWIipjL6jiiOBrUS+zqOIGJb70OE1YppYrajNqgaoL2PF+f35a/E4iYd
	seyachZ0LRRzjM/rQKhL5BJjS4tySJYbRdJjHYU6cnNOj2Dj5bTLsTYjNW1DrY7i9isS
	eBlo0dxsgSuEpNNs1s/584iL8LUb2JzPFlm7pnEnTttg1r64tcapxnZmJ/P3D/zoi+Jo
	2Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=AQeFho+GAF0XNyv3/66Q7+XaAILCa23wijwHXatigto=;
	b=fhyxlMHTJirsCvyr2KD7QRp1b1+lBk3gpZ7SIm0LXf+As8+YiF7R2tLBsUKi1qH+RV
	NBkuiRZVK7nDw/HWCjo5HIb83O3q8ejN8DlqSKTPEbEkSpWuccBox/pK8OV034fu/0t7
	YUwdClOzl8FZdO2IzSPNRaxwc+nAOWu76ea+VPNk+HLQy+/3QuyqOjUoDeQ3EYsb+rgu
	Ru+f2AympKZZxiJ3CvDeKZXp7t2/zs35JI1bLhgRY61L5JECg2hOVZjLq993+8y5U7jx
	Ydp76DSaTiGwgTX9k+B7jFXnTiOjbqUecHX3SE41+B0XlUsxz+Ol9lbzpwYzRx7aFVaK
	ogdQ==
X-Gm-Message-State: APjAAAVfVzl915V5NTGlsFjjM38zwGzqs3X2lx45VjkyvcCKQY6D1iAk
	iF9YkpnrBsSUaw0srPvb9+LB7smuf6A=
X-Google-Smtp-Source: APXvYqzfFPII2wd1qhWENl6tWnfA14B24Vq1U98pPBCfw5iOFb52KXHsIkRnwQK3MAF7l4GhobGTcg==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr45979193wrs.73.1558394356042; 
	Mon, 20 May 2019 16:19:16 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	b10sm44261849wrh.59.2019.05.20.16.19.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 16:19:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 01:19:09 +0200
Message-Id: <20190520231910.12184-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520231910.12184-1-f4bug@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 3/4] BootLinuxConsoleTest: Run kerneltests
 BusyBox on Malta
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests boots a Linux kernel on a Malta machine up to a
busybox shell on the serial console. Few commands are executed
before halting the machine (via reboot).

We use the initrd cpio image from the kerneltests project:
https://kerneltests.org/

If MIPS is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:mips" tags.

Alternatively, this test can be run using:

  $ avocado --show=console run -t arch:mips tests/acceptance/boot_linux_console.py
  [...]
  console: Boot successful.
  [...]
  console: / # uname -a
  console: Linux buildroot 4.5.0-2-4kc-malta #1 Debian 4.5.5-1 (2016-05-29) mips GNU/Linux
  console: / # reboot
  console: / # reboot: Restarting system

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 1c330871c0..60ea240ab6 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -11,6 +11,7 @@
 import os
 import logging
 import lzma
+import gzip
 import shutil
 
 from avocado_qemu import Test
@@ -47,6 +48,11 @@ class BootLinuxConsole(Test):
                 fail = 'Failure message found in console: %s' % failure_message
                 self.fail(fail)
 
+    def exec_command_and_wait_for_pattern(self, command, success_message):
+        command += '\n'
+        self.vm.console_socket.sendall(command.encode())
+        self.wait_for_console_pattern(success_message)
+
     def extract_from_deb(self, deb, path):
         """
         Extracts a file from a deb package into the test workdir
@@ -138,6 +144,49 @@ class BootLinuxConsole(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_mips_malta_cpio(self):
+        """
+        :avocado: tags=arch:mips
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:big
+        """
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20160601T041800Z/pool/main/l/linux/'
+                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
+        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+                      'mips/rootfs.cpio.gz')
+        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+
+        with gzip.open(initrd_path_gz, 'rb') as f_in:
+            with open(initrd_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'BogoMIPS')
+        self.exec_command_and_wait_for_pattern('uname -a',
+                                               'Debian')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting system')
+
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
         kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
         kernel_path = self.workdir + "kernel"
-- 
2.19.1


