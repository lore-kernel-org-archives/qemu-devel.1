Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9CC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 03:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A9221773
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 03:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI32ZwNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A9221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU0iS-00057b-L4
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 23:17:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hU0hi-0004kq-3m
	for qemu-devel@nongnu.org; Thu, 23 May 2019 23:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hU0hg-0008Kf-OL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 23:17:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hU0hg-0008Jt-DA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 23:17:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id s17so8367428wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PG4FAiq5fqypNIHzKwV+MQbrRaZAlRnakvPm+gx1m6k=;
	b=FI32ZwNhPlVPrDB/ERy/rSK+rOrEOipSXfn9H0f7c18rpWaUS996GZ37lQ1ocPVRLU
	ClGrYsNFa943f9DeawCc8ECznQ5Kc8uijRZLCVt8BmUilz/iiSF+ohIV1e8+TjH3tKNw
	bK4Dmi7z0GOOuYRDljvUZuwuS/nH7v5Hle8IOjTxfAR87OgDUCwdDGdXv9j0HhrZAWJr
	GDx5oXAMk7SnI7berYsnxtNH3pqLv84cRNKhdBY+RcUJVe3gv1XSnVx9I5v2szkGB6Nk
	AF2dC6QtrALkuWndpXEe2k8NdgYM2Y9Wb1gjrKaz4I0A1n0tWMmnMqNNtkQ/eS7qnhFu
	ITqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=PG4FAiq5fqypNIHzKwV+MQbrRaZAlRnakvPm+gx1m6k=;
	b=rAtVDUpZMamUrYGUq/K1QmnDPyy8GJ5cb+aBChJ/cqEvxtOGwcyUYfoHg8qnwBDGEK
	GG9L/EyTxYrnXY0SyFlUOPHcB55gScqq78SBRPdd8cjv1zp7QJCihVBkfPTRi+AooudT
	JQqIDR2OHEZ0llmnLWSAEQNH5JXeF6O5zMAuH3w2L+F8K2hTqG2HWjl4svgfUi7ASGkK
	5vLSkjnQPlv169D9WShFkR/2AeqsMmoMFPZCS6qMjw/8eWeG3Jg4KEmqJdtLLq8xddJ5
	YjL/Sp4mm0bJSPNpMTbWQtec3RiH0URuX6YOuRUnOBnmcmGyK5hUYcYYIAKnqvjB4lGu
	3sJA==
X-Gm-Message-State: APjAAAVg3cgBZcaD5L8oXqeJSVkA6GGgwpNWYnXdpag7wOJkqe6oGqPf
	b3dYAFueh8EXFOjMvDa8ez0b0EQtwXs=
X-Google-Smtp-Source: APXvYqw9JwTOF5Tdz9j4OIoSOgXhRUfXH017K5rXBwwAPecmEotZdZFf3D076y7YTdzIHfmMM3gRBg==
X-Received: by 2002:adf:c188:: with SMTP id x8mr4033408wre.256.1558667826711; 
	Thu, 23 May 2019 20:17:06 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	c207sm1141456wme.47.2019.05.23.20.17.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 20:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 05:17:04 +0200
Message-Id: <20190524031704.24200-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] BootLinuxConsoleTest: Test the RX-Virt machine
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two tests for the rx-virt machine, based on the recommended test
setup from Yoshinori Sato:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03586.html

- U-Boot prompt
- Linux kernel with Sash shell

These are very quick tests:

  $ avocado run -t arch:rx tests/acceptance/boot_linux_console.py
  JOB ID     : 84a6ef01c0b87975ecbfcb31a920afd735753ace
  JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84a6ef0/job.log
   (1/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_rx_uboot: PASS (0.11 s)
   (2/2) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_rx_linux: PASS (0.45 s)
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0

Tests can also be run with:

  $ avocado --show=console run -t arch:rx tests/acceptance/boot_linux_console.py
  console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 21:56:06 +0900)
  console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
  console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
  ...
  console: SuperH (H)SCI(F) driver initialized
  console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0) is a sci
  console: console [ttySC0] enabled
  console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0) is a sci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 20190517045136.3509-1-richard.henderson@linaro.org
"RX architecture support"
---
 tests/acceptance/boot_linux_console.py | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index d5c500ea30..f68aab1df8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -45,6 +45,11 @@ class BootLinuxConsole(Test):
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
@@ -217,3 +222,49 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_rx_uboot(self):
+        """
+        :avocado: tags=arch:rx
+        :avocado: tags=machine:rx-virt
+        :avocado: tags=endian:little
+        """
+        uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
+        uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
+        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
+        uboot_path = archive.uncompress(uboot_path, self.workdir)
+
+        self.vm.set_machine('rx-virt')
+        self.vm.set_console()
+        self.vm.add_args('-bios', uboot_path,
+                         '-no-reboot')
+        self.vm.launch()
+        uboot_version = 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
+        self.wait_for_console_pattern(uboot_version)
+        gcc_version = 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (experimental)'
+        # FIXME limit baudrate on chardev, else we type too fast
+        #self.exec_command_and_wait_for_pattern('version', gcc_version)
+
+    def test_rx_linux(self):
+        """
+        :avocado: tags=arch:rx
+        :avocado: tags=machine:rx-virt
+        :avocado: tags=endian:little
+        """
+        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb')
+        dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
+        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
+        kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
+        kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('rx-virt')
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Sash command shell (version 1.1.1)')
+        self.exec_command_and_wait_for_pattern('printenv',
+                                               'TERM=linux')
-- 
2.19.1


