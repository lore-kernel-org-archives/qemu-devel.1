Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B72C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6FA206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go/t8Raj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6FA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn9K-0002C1-Li
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5a-0005Wq-C3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5Z-0001Xd-5z
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so77353wmh.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KLSUgMn8z8HS4y/cukG+SgOuvLLwHPQH27GL6WIk32I=;
 b=Go/t8RajS17By99j6nkDCUHNpn/QouXOmEjpwegiBZaEU1PeGxUm+9ZRG6PtmZafjM
 PNbw0Mm7XmRI0NR47+/w32qkCrbDyMM2XLNYfTwZI8nnznIxTOqscYYKH6UaF/jF2PEe
 3Z0XtkSJx3bP4SMGKQnAkr8vqcJLsIODgjszIOBpqZV2q/lh2RAClw8l+LzqbjQ0ZZnZ
 7TMI4vsEhZW5M1/Jf/t+E9qLx+cLAHug7ztPSD6Um6HneSdMRGyVGBvcuxPVzke/xMDy
 IPrCwrf2lWMu3RtDsKxnr82I/uQIzAYWZF7a5ZA3UZGO/uwsTIMEUmlfqMB+lrwWOk5a
 rYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KLSUgMn8z8HS4y/cukG+SgOuvLLwHPQH27GL6WIk32I=;
 b=k566SI3wwcsklwkRTikskIj3sECx1YH0f3iMdrJ6npu/5T1tpWaaWh0aFx38PEkcCG
 NwW+2eQj/YSJjRcemLOcEzA1X8IU9REVqx7bU/mE/YgH/iHcqarSnhAhA5Ck6yIVIgHK
 3xGaY3oY903HklC9E0xv8E6X67MkoFVh2Jyl7rhEYXOtS9GJzodQ/2amvJep3GgV5+v3
 M7ckUK44D/0cNzu4coJWJrOLfJ2iCGYoSK/nOnEuRGp0xMYqR14F+Z7bMox9rUqGJFat
 ZdDqTBPfBHL4XtSiwslGpGMWsB9YDZOcpIZkzmSAmJP01+IMD//jowghqP1Ra8x/Rpap
 PTfw==
X-Gm-Message-State: AOAM532bQKRnWf3V0/XrMsKJYvCvkuDbbOHCKOzHGsb9h+0FX2h7SOEe
 lCveo4aL5LX+QzdE8U8OXr4bfP44
X-Google-Smtp-Source: ABdhPJxWvkwmuoqyRA0855EZkzqYXeAjyIPllAr9yL5XsvZ9u0misUFmsEydLef0++iCAumqJXRzRg==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr122949wmf.18.1591028099721; 
 Mon, 01 Jun 2020 09:14:59 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 11/12] BootLinuxConsoleTest: Test the RX GDB simulator
Date: Mon,  1 Jun 2020 18:14:40 +0200
Message-Id: <20200601161441.8086-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add two tests for the rx-gdbsim machine, based on the recommended
test setup from Yoshinori Sato:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03586.html

- U-Boot prompt
- Linux kernel with Sash shell

These are very quick tests:

  $ avocado run -t arch:rx tests/acceptance/machine_rx_gdbsim.py
  JOB ID     : 84a6ef01c0b87975ecbfcb31a920afd735753ace
  JOB LOG    : /home/phil/avocado/job-results/job-2019-05-24T05.02-84a6ef0/job.log
   (1/2) tests/acceptance/machine_rx_gdbsim.py:RxVirtMachine.test_uboot: PASS (0.11 s)
   (2/2) tests/acceptance/machine_rx_gdbsim.py:RxVirtMachine.test_linux_sash: PASS (0.45 s)
  RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0

Tests can also be run with:

  $ avocado --show=console run -t arch:rx tests/acceptance/machine_rx_gdbsim.py
  console: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty (Feb 05 2019 - 21:56:06 +0900)
  console: Linux version 4.19.0+ (yo-satoh@yo-satoh-debian) (gcc version 9.0.0 20181105 (experimental) (GCC)) #137 Wed Feb 20 23:20:02 JST 2019
  console: Built 1 zonelists, mobility grouping on.  Total pages: 8128
  ...
  console: SuperH (H)SCI(F) driver initialized
  console: 88240.serial: ttySC0 at MMIO 0x88240 (irq = 215, base_baud = 0) is a sci
  console: console [ttySC0] enabled
  console: 88248.serial: ttySC1 at MMIO 0x88248 (irq = 219, base_baud = 0) is a sci

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20200224141923.82118-22-ysato@users.sourceforge.jp>
[PMD: Replace obsolete set_machine() by machine tag, and rename as gdbsim]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_rx_gdbsim.py | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tests/acceptance/machine_rx_gdbsim.py

diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
new file mode 100644
index 0000000000..a44f2c87da
--- /dev/null
+++ b/tests/acceptance/machine_rx_gdbsim.py
@@ -0,0 +1,68 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+
+
+class RxGdbSimMachine(Test):
+
+    timeout = 30
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+
+    def test_uboot(self):
+        """
+        U-Boot and checks that the console is operational.
+
+        :avocado: tags=arch:rx
+        :avocado: tags=machine:gdbsim-r5f562n8
+        :avocado: tags=endian:little
+        """
+        uboot_url = ('https://acc.dl.osdn.jp/users/23/23888/u-boot.bin.gz')
+        uboot_hash = '9b78dbd43b40b2526848c0b1ce9de02c24f4dcdb'
+        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
+        uboot_path = archive.uncompress(uboot_path, self.workdir)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', uboot_path,
+                         '-no-reboot')
+        self.vm.launch()
+        uboot_version = 'U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty'
+        wait_for_console_pattern(self, uboot_version)
+        gcc_version = 'rx-unknown-linux-gcc (GCC) 9.0.0 20181105 (experimental)'
+        # FIXME limit baudrate on chardev, else we type too fast
+        #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
+
+    def test_linux_sash(self):
+        """
+        Boots a Linux kernel and checks that the console is operational.
+
+        :avocado: tags=arch:rx
+        :avocado: tags=machine:gdbsim-r5f562n7
+        :avocado: tags=endian:little
+        """
+        dtb_url = ('https://acc.dl.osdn.jp/users/23/23887/rx-qemu.dtb')
+        dtb_hash = '7b4e4e2c71905da44e86ce47adee2210b026ac18'
+        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
+        kernel_url = ('http://acc.dl.osdn.jp/users/23/23845/zImage')
+        kernel_hash = '39a81067f8d72faad90866ddfefa19165d68fc99'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-no-reboot')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Sash command shell (version 1.1.1)',
+                                 failure_message='Kernel panic - not syncing')
+        exec_command_and_wait_for_pattern(self, 'printenv', 'TERM=linux')
-- 
2.21.3


