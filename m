Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD962C47423
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BF221548
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmpq7tj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BF221548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwzS-0004Kq-DO
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwl2-0004Yr-PH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwl0-0006Oa-TM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:16:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id v12so1932687wmh.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ENJHSv8VXYAWPuujTGIt+mHmdRqFl7rTYSd0cE3/B20=;
 b=lmpq7tj11VTVov7XY2zxHgbglGaDDqre9rTLWCLMAcGynyRVby1Frcud0cHGSoT8kp
 nnnYWbqrBq9X0+g0q/X8N04RrodY4dl1qptM4OcASSb4mSVWZ7Q+rowQDL/p3ymXvLjJ
 A+T07p29DpvdMPg6ZwtBc5o1efKT8cZBwnjHYof+WHPAOVD1NZillGUB5X7eBzCPjfEP
 l9EAKC6T0NnjZVahUwJfdQOG9jKLMsJu74OFC95AYCqnEXJITIZ0Dw536Q1nfjpkEWQy
 J7nb6AjjIiOyRlLNI7nKOW/GDKlRzQALc17Fmk4s1t7YLhgUO3NAljpMGatr9GBeh4ND
 tsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ENJHSv8VXYAWPuujTGIt+mHmdRqFl7rTYSd0cE3/B20=;
 b=dmI7bmJNuE++wQf7R3DLNiJGMswLUTYeMjrImHS52LXfUMM0fmL/YeXz5I8NZyKijw
 7paOzzESgYnUob5yvvNt+WdUvQ4S+vl4eL9unVgDOOJy0MJB2mSNl/pix1J0DA3Ctd0W
 zivAgpIIeE77J5Yghz5DttvJT23b4khoIl1gK1zBCqvsaXS1xGtOSD6AUds5b1vRNrpr
 u/CcXgB4zYfDKno3fQUMCv5pZ5ZTSMwFP5p2Bj+DbfspqBnM0iNgNmGTYEq9Yoox7uwZ
 aF+zW/JkLyslKx3Q7TqbvJFnJEL2xZVctf4Y9UZaz+fmN54f60TAkpA1zHNvxzIoC1gv
 zdFg==
X-Gm-Message-State: AOAM530zmGalfrU9/iYE3+w7zH4sIiHw6oSMjZx6fA/bAuQpuZfTyAnV
 fe4H+yHDVh+zBDKO4c1Va9qpGmBDO1g=
X-Google-Smtp-Source: ABdhPJyos6VUzX1cU5nl3QJKAOfuagC+XEbjQ4PzP9e5ZpQ7iJte/XbXKONMX9qryaucJ7zsJj/xIA==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr170102wme.179.1601313369081; 
 Mon, 28 Sep 2020 10:16:09 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
Date: Mon, 28 Sep 2020 19:15:39 +0200
Message-Id: <20200928171539.788309-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test for the mipssim machine, based on the recommended
test setup from Thomas Huth:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html

The test is quick and can be run as:

  $ avocado --show=console run -t machine:mipssim tests/acceptance/
   (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mipssim_linux_console:
  console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
  console: Setting default memory size 0x02000000
  console: bootconsole [early0] enabled
  console: CPU revision is: 00019300 (MIPS 24Kc)
  console: FPU revision is: 00739300
  ...
  console: CPU frequency 12.00 MHz
  console: Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
  ...
  console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Technologies, Inc.
  ...
  console: Welcome to Buildroot
  console: buildroot login: root
  console: # root
  console: -sh: root: not found
  console: # ping -c 3 10.0.2.2
  console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
  console: 64 bytes from 10.0.2.2: seq=0 ttl=255 time=48.231 ms
  console: 64 bytes from 10.0.2.2: seq=1 ttl=255 time=9.407 ms
  console: 64 bytes from 10.0.2.2: seq=2 ttl=255 time=2.298 ms
  console: --- 10.0.2.2 ping statistics ---
  console: 3 packets transmitted, 3 packets received, 0% packet loss
  PASS (7.99 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS                              |  1 +
 tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/acceptance/machine_mips_mipssim.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eed1e692b4..17d8a012b0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
 F: include/hw/timer/mips_gictimer.h
 F: tests/acceptance/linux_ssh_mips_malta.py
 F: tests/acceptance/machine_mips_malta.py
+F: tests/acceptance/machine_mips_mipssim.py
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/machine_mips_mipssim.py
new file mode 100644
index 00000000000..b2749917b08
--- /dev/null
+++ b/tests/acceptance/machine_mips_mipssim.py
@@ -0,0 +1,56 @@
+# Functional tests for the MIPS simulator (MIPSsim machine)
+#
+# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import logging
+import time
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import interrupt_interactive_console_until_pattern
+from avocado_qemu import wait_for_console_pattern
+
+class MipsSimMachine(Test):
+
+    timeout = 30
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_mipssim_linux_console(self):
+        """
+        Boots the Linux kernel and checks that the console is operational
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:mipssim
+        :avocado: tags=device:mipsnet
+        """
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
+                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
+                      'mips/mipssim/mipsel/vmlinux')
+        kernel_hash = '0f9aeca3a2e25b5b0cc4999571f39a7ad58cdc43'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
+                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
+                      'mips/mipssim/mipsel/rootfs.cpio')
+        initrd_hash = 'b20359bdfae66387e5a17d6692686d59c189417b'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        interrupt_interactive_console_until_pattern(self,
+                                                    interrupt_string='root\r',
+                                                    success_message='#')
+        pattern = '3 packets transmitted, 3 packets received, 0% packet loss'
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2', pattern)
-- 
2.26.2


