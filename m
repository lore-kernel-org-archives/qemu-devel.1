Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F8C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C762087F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QBgmalqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C762087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlGl1-00027E-T9
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlGjp-0001Sh-1L
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hlGjn-0006l8-RU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:50:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hlGjn-0006jq-KG
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:50:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id c14so1598097plo.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1GCsi4BIUSnxiBHAMkfzcUMMzqZQxWCpZrkscVs0YSU=;
 b=QBgmalqqkDyg6XBfx8a0I35nQZmePG6mk8O1AUr2Az+yGKqB3lA1R04khVzaxVRjw0
 iUx2nNxn4W+IGsWDwHle5meWonmGHKn+l1QKCWGKWwwLb+SeIZbQ+PJHkUR0XAA3+3Ee
 C5BQlcMwG7e+L3usSyJscrjVv4FMeZJYRje6KCiI7KbmRi+tvfqYX1TcQr5NkDbITyw0
 3jjISgoeWVBQBFO8DPVQsodasjYVys17p0UllW2UD94WpwQbX/f+y+X7FzChQDcqic44
 H9wznJXrO/ndCjfhjNbvZU5e9q3QLue7eRc0r+0ZyxpTxsYB1zCjQHN9RZFGqVqxjdm/
 ZSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1GCsi4BIUSnxiBHAMkfzcUMMzqZQxWCpZrkscVs0YSU=;
 b=pWtg2/fAy28AAVUH3r63PIFBlFEHw1BQqkWaUDk6KCtlfaSHvSdcSvfsnNf5a7Yk9V
 sUpaV0P5EnTYHKHpOWIhLD8/sVRv3XY+q9QzO2/odcA16/N0FvmEgvwVXpxEv72OeZEG
 qr61I3GuB9agFX2FbeSRJWMLCiFpTxNiexVpSnrBmG3vL+GS2Q22ZIXcTOFdlk9ysB12
 55uzbmg1sTZuDE1KqBzqeiRWggvKPOt2t6Gxqt2VT8E2qP3RNcgzn+nOrPiqgdz5NUcK
 mbjjYFZ85PUcruLACBoVNj/Mm0R9665iacio78pWf7NpCn8FIKRCxxEspUkC3zjgy/LY
 bvuQ==
X-Gm-Message-State: APjAAAXJ2v/hE/owk+HqVzzPjyCJcciYTzBDdsWnt8e5Qs950t5DZTTJ
 M68B/eRlwcQYKgPuUZFJ81vTb5AspNE=
X-Google-Smtp-Source: APXvYqz0lxMkhLBTuScdgjgw6yensoXAKWGmzQY9A4/SVWMbAI0Uj5A+FCUlpvg8wkc9cEGr4+CSfw==
X-Received: by 2002:a17:902:7c05:: with SMTP id
 x5mr18598444pll.321.1562781037653; 
 Wed, 10 Jul 2019 10:50:37 -0700 (PDT)
Received: from gamma06.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id o11sm7323891pfh.114.2019.07.10.10.50.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 10 Jul 2019 10:50:36 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Wed, 10 Jul 2019 10:50:23 -0700
Message-Id: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>, Cleber Rosa <crosa@redhat.com>,
 Caio Carrara <ccarrara@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the mips + malta test, it boots a Linux kernel on a virt
board and verify the serial is working.  Also, it relies on the serial
device set by the machine itself.

If riscv64 is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:riscv64" tags.

Alternatively, this test can be run using:

  $ avocado run -t arch:riscv64 tests/acceptance

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3215950..bbc6b06 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_riscv64_virt(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        """
+
+        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
+                      '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
+                      'bbl_w_kernel.gz')
+        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
+        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.workdir + "bbl_w_kernel"
+
+        with gzip.open(kernel_path_gz, 'rb') as f_in:
+            with open(kernel_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+                      'riscv64/rootfs.cpio.gz')
+        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'isa')
+        self.exec_command_and_wait_for_pattern('uname -a',
+                                               'sifive')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting system')
-- 
2.7.4


