Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F0DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73C121841
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTAtBtWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73C121841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqWy-0006yt-VC
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:25:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQU-0002PD-LK
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQS-0006W0-Oz
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQS-0006VJ-G6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id d9so6971919wrx.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1CN1+hmeRqyhzENLo1lRVIkezDGwSHYANWwJbh9tmqU=;
	b=WTAtBtWf9uy70FNVkbFUQ4PVDAXEpYN4d3+IGodqLVbBMNgqpmNbBBsWaI8PU8oB40
	aS5BZ4WFy4o4McSy5PFSU7MEp1X/kQIsqNj70M+D2hsSCNhLilo6b1jQJcwdNqD4j7gj
	tnDyZHVRlRvAB29DHFR2uaO9rrprl5zkafAsdOBdnInGpIfxl69cddhfg5g5LEQcWXMf
	aQ2KbHJ+2yCEkArbGD45/92G9zOFXw3h1kSfA4VionFx9LFBMMUid0heRTmMnAjdOGt+
	309Q/L+QdaqlUa7wxZ92yvQJeVIcyu0MDsA3hq+K9Uu61ZbESy29Vl+KYGAnTwZKpWB6
	FUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=1CN1+hmeRqyhzENLo1lRVIkezDGwSHYANWwJbh9tmqU=;
	b=KgzE0TAZTXJ1O+WVFeGCjsJB+GDQvVL6Aln4D4ZgLM5QPc4ZU1qZjbw8Ji6dV1Dj21
	2Via54xLtIrriGNvTSHf1Tj5q8UAlgRmzxR0Ek4gY6lc9eh4plNrSRpzUQmpzXaEBPSS
	6oEsA3IBgV9J6Wezmvr+ADqTaQFEm44q3y+DRS7cnJ5soQV/O0tnl/jTNpSqeaxkjD4L
	5Qd3mDFL9nkozA71U+2eIS8lp0FMF+eUJcc0AuV3sUh8eRbeTu5aZ4ZjHALyUazBOyO5
	CoJmqpdlYjmt/1d70O690QaiUKSE1M0mxh6Unk5UOkWLpZcET9FEymq8gFdpMnlCNslO
	w2Xg==
X-Gm-Message-State: APjAAAUV/qwghvl0QO4YfGQNvUgrVS6DakNRawWPtIwtbGP49fUfyyYj
	Q/bdWzO7gpw8Rmt4LQM0V7s=
X-Google-Smtp-Source: APXvYqwkugNIRsRog1C3bRR4+22Q/13fhe0UnvQsSdZWwZqDg7uvbBU1YgA7nBoKXbHGSBvIci4J8A==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr4960650wrq.158.1558628319334; 
	Thu, 23 May 2019 09:18:39 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q16sm10273222wmj.17.2019.05.23.09.18.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 09:18:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu, 23 May 2019 18:18:32 +0200
Message-Id: <20190523161832.22490-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190523161832.22490-1-f4bug@amsat.org>
References: <20190523161832.22490-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 4/4] BootLinuxSshTest: Test some userspace
 commands on Malta
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests boot a full VM and check the serial console until
the SSH daemon is running, then start a SSH session and run
some commands.

This test can be run using:

  $ avocado --show=ssh run -t arch:mips tests/acceptance/linux_ssh_mips_malta.py
  ssh: Entering interactive session.
  ssh: # uname -a
  ssh: Linux debian-mips 3.2.0-4-4kc-malta #1 Debian 3.2.51-1 mips GNU/Linux
  ssh: # lspci -d 11ab:4620
  ssh: 00:00.0 Host bridge: Marvell Technology Group Ltd. GT-64120/64120A/64121A System Controller (rev 10)
  ssh: # cat /sys/bus/i2c/devices/i2c-0/name
  ssh: SMBus PIIX4 adapter at 1100
  ssh: # cat /proc/mtd
  ssh: dev:    size   erasesize  name
  ssh: mtd0: 00100000 00010000 "YAMON"
  ssh: mtd1: 002e0000 00010000 "User FS"
  ssh: mtd2: 00020000 00010000 "Board Config"
  ssh: # md5sum /dev/mtd2ro
  ssh: 0dfbe8aa4c20b52e1b8bf3cb6cbdf193  /dev/mtd2ro
  ssh: # poweroff

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Add skipIf(getenv(CONTINUOUS_INTEGRATION))
---
 MAINTAINERS                              |   1 +
 tests/acceptance/linux_ssh_mips_malta.py | 230 +++++++++++++++++++++++
 tests/requirements.txt                   |   1 +
 3 files changed, 232 insertions(+)
 create mode 100644 tests/acceptance/linux_ssh_mips_malta.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cacd751bf..8c34d5c34b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,6 +934,7 @@ M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <arikalo@wavecomp.com>
 S: Maintained
 F: hw/mips/mips_malta.c
+F: tests/acceptance/linux_ssh_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <amarkovic@wavecomp.com>
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
new file mode 100644
index 0000000000..aafb0c39f6
--- /dev/null
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -0,0 +1,230 @@
+# Functional test that boots a VM and run commands via a SSH session
+#
+# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import re
+import base64
+import logging
+import paramiko
+import time
+
+from avocado import skipIf
+from avocado_qemu import Test
+from avocado.utils import process
+from avocado.utils import archive
+
+
+class LinuxSSH(Test):
+
+    timeout = 150 # Not for 'configure --enable-debug --enable-debug-tcg'
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    VM_IP = '127.0.0.1'
+
+    IMAGE_INFO = {
+        'be': {
+            'image_url': 'https://people.debian.org/~aurel32/qemu/mips/'
+                         'debian_wheezy_mips_standard.qcow2',
+            'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
+            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQCca1VitiyLAdQOld'
+                           b'zT43IOEVJZ0wHD78GJi8wDAjMiYWUzNSSn0rXGQsINHuH5'
+                           b'IlF+kBZsHinb/FtKCAyS9a8uCHhQI4SuB4QhAb0+39MlUw'
+                           b'Mm0CLkctgM2eUUZ6MQMQvDlqnue6CCkxN62EZYbaxmby7j'
+                           b'CQa1125o1HRKBvdGm2zrJWxXAfA+f1v6jHLyE8Jnu83eQ+'
+                           b'BFY25G+Vzx1PVc3zQBwJ8r0NGTRqy2//oWQP0h+bMsgeFe'
+                           b'KH/J3RJM22vg6+I4JAdBFcxnK+l781h1FuRxOn4O/Xslbg'
+                           b'go6WtB4V4TOsw2E/KfxI5IZ/icxF+swVcnvF46Hf3uQc/0'
+                           b'BBqb',
+        },
+        'le': {
+            'image_url': 'https://people.debian.org/~aurel32/qemu/mipsel/'
+                         'debian_wheezy_mipsel_standard.qcow2',
+            'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
+            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQClXJlBT71HL5yKvv'
+                           b'gfC7jmxSWx5zSBCzET6CLZczwAafSIs7YKfNOy/dQTxhuk'
+                           b'yIGFUugZFoF3E9PzdhunuyvyTd56MPoNIqFbb5rGokwU5I'
+                           b'TOx3dBHZR0mClypL6MVrwe0bsiIb8GhF1zioNwcsaAZnAi'
+                           b'KfXStVDtXvn/kLLq+xLABYt48CC5KYWoFaCoICskLAY+qo'
+                           b'L+LWyAnQisj4jAH8VSaSKIImFpfkHWEXPhHcC4ZBlDKtnH'
+                           b'po9vhfCHgnfW3Pzrqmk8BI4HysqPFVmJWkJGlGUL+sGeg3'
+                           b'ZZolAYuDXGuBrw8ooPJq2v2dOH+z6dyD2q/ypmAbyPqj5C'
+                           b'rc8H',
+        },
+    }
+
+    def wait_for_console_pattern(self, success_message,
+                                 failure_message='Oops'):
+        console = self.vm.console_socket.makefile()
+        console_logger = logging.getLogger('console')
+        while True:
+            msg = console.readline()
+            console_logger.debug(msg.strip())
+            if success_message in msg:
+                break
+            if failure_message in msg:
+                fail = 'Failure message found in console: %s' % failure_message
+                self.fail(fail)
+
+    def get_portfwd(self):
+        res = self.vm.command('human-monitor-command',
+                              command_line='info usernet')
+        line = res.split('\r\n')[2]
+        port = re.split(r'.*TCP.HOST_FORWARD.*127\.0\.0\.1 (\d+)\s+10\..*',
+                        line)[1]
+        self.log.debug("sshd listening on port:" + port)
+        return port
+
+    def ssh_connect(self, username, password, rsa_hostkey_b64=None):
+        self.ssh_logger = logging.getLogger('ssh')
+        self.ssh_username = username
+        self.ssh_ps1 = '# ' if username is 'root' else '$ '
+        self.ssh_client = paramiko.SSHClient()
+        port = self.get_portfwd()
+        if rsa_hostkey_b64:
+            rsa_hostkey_bin = base64.b64decode(rsa_hostkey_b64)
+            rsa_hostkey = paramiko.RSAKey(data = rsa_hostkey_bin)
+            ipport = '[%s]:%s' % (self.VM_IP, port)
+            self.ssh_logger.debug('ipport ' + ipport)
+            self.ssh_client.get_host_keys().add(ipport, 'ssh-rsa', rsa_hostkey)
+        for i in range(10):
+            try:
+                self.ssh_client.connect(self.VM_IP, int(port),
+                                        username, password, banner_timeout=90)
+                self.ssh_logger.info("Entering interactive session.")
+                return
+            except:
+                time.sleep(4)
+                pass
+        self.fail("sshd timeout")
+
+    def ssh_disconnect_vm(self):
+        self.ssh_client.close()
+
+    def ssh_command(self, command, is_root=True):
+        self.ssh_logger.info(self.ssh_ps1 + command)
+        stdin, stdout, stderr = self.ssh_client.exec_command(command)
+        stdout_lines = [line.strip('\n') for line in stdout]
+        for line in stdout_lines:
+            self.ssh_logger.info(line)
+        stderr_lines = [line.strip('\n') for line in stderr]
+        for line in stderr_lines:
+            self.ssh_logger.warning(line)
+        return stdout_lines, stderr_lines
+
+    def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel_path):
+        image_url = self.IMAGE_INFO[endianess]['image_url']
+        image_hash = self.IMAGE_INFO[endianess]['image_hash']
+        image_path = self.fetch_asset(image_url, asset_hash=image_hash)
+        rsa_hostkey_b64 = self.IMAGE_INFO[endianess]['rsa_hostkey']
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 root=/dev/sda1')
+        self.vm.add_args('-no-reboot',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-hda', image_path,
+                         '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                         '-device', 'pcnet,netdev=vnet')
+        self.vm.launch()
+
+        self.log.info('VM launched, waiting for sshd')
+        console_pattern = 'Starting OpenBSD Secure Shell server: sshd'
+        self.wait_for_console_pattern(console_pattern)
+        self.log.info('sshd ready')
+
+        self.ssh_connect('root', 'root', rsa_hostkey_b64=rsa_hostkey_b64)
+
+    def shutdown_via_ssh(self):
+        self.ssh_command('poweroff')
+        self.ssh_disconnect_vm()
+        self.wait_for_console_pattern('Power down')
+
+    def run_common_commands(self):
+        stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
+        self.assertIn(True, ["GT-64120" in line for line in stdout])
+
+        stdout, stderr = self.ssh_command('cat /sys/bus/i2c/devices/i2c-0/name')
+        self.assertIn(True, ["SMBus PIIX4 adapter" in line
+                             for line in stdout])
+
+        stdout, stderr = self.ssh_command('cat /proc/mtd')
+        self.assertIn(True, ["YAMON" in line
+                             for line in stdout])
+
+        # Empty 'Board Config'
+        stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
+        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
+                             for line in stdout])
+
+    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
+        self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_path)
+
+        stdout, stderr = self.ssh_command('uname -a')
+        self.assertIn(True, [uname_m + " GNU/Linux" in line for line in stdout])
+
+        self.run_common_commands()
+        self.shutdown_via_ssh()
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_mips_malta32eb_kernel3_2_0(self):
+        """
+        :avocado: tags=arch:mips
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:big
+        :avocado: tags=device:pcnet32
+        """
+        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
+                      'vmlinux-3.2.0-4-4kc-malta')
+        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.do_test_mips_malta('be', kernel_path, 'mips')
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_mips_malta32el_kernel3_2_0(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        :avocado: tags=device:pcnet32
+        """
+        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
+                      'vmlinux-3.2.0-4-4kc-malta')
+        kernel_hash = 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.do_test_mips_malta('le', kernel_path, 'mips')
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_mips_malta64eb_kernel3_2_0(self):
+        """
+        :avocado: tags=arch:mips64
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:big
+        :avocado: tags=device:pcnet32
+        """
+        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
+                      'vmlinux-3.2.0-4-5kc-malta')
+        kernel_hash = 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta('be', kernel_path, 'mips64')
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_mips_malta64el_kernel3_2_0(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        :avocado: tags=device:pcnet32
+        """
+        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
+                      'vmlinux-3.2.0-4-5kc-malta')
+        kernel_hash = '6a7f77245acf231415a0e8b725d91ed2f3487794'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta('le', kernel_path, 'mips64')
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 002ded6a22..3ae0e29ad7 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -2,3 +2,4 @@
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
 avocado-framework==68.0
+paramiko
-- 
2.19.1


