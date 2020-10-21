Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B4C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5E32098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUM04qTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5E32098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBmE-0001kC-5d
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhx-0005Df-CR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhv-0000im-Lj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:51:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id n18so2531772wrs.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=quiicLeYyNWtIdMVLHoYPSS0nbnwlfIHdSBUJ8b+yp4=;
 b=KUM04qTDjwucoELmfnRqT+UP9GYd3ajKwUohOneavzzC9KKV6mPzv3kzuC7UWPArk3
 e7+AsLP0PkjLKdxLHXEbtlHEwiWA0XInHvo31rm7afddWyNvT6pY8vVKbHt39aDp5rkm
 lLNp920aRYaQ7CQ80Nk0zGAbjKM0zq/scOdTpLEds//deJXhip7evbXwZw9kb2rlLTv5
 486m5ueE+TBSdT80MU9MSpVXV8LE3vyusW7xqNYshY1pIp4htucztZMjqSlAolwVipTj
 DemWtYOJxEsp+J4GB4aFaEm/TUwt5ZzPgmhaMdiPHFQKTViJb0N5bjE6ynJEOhl12jBW
 iFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=quiicLeYyNWtIdMVLHoYPSS0nbnwlfIHdSBUJ8b+yp4=;
 b=SO1V4hWOLfvc3APSSCQCvZ54o6o/jv/GtQdf4zJqeSm7Eio7GOeKqzUE7MmYlDU4bq
 VAop9H2WZSrt5nVRShe8dZ+LrbDYQxBr6o6j3GGyW95CWYAgYgqGomqwNM8lPzH8fNpX
 IjoxoNuDZ3PcDmjq+jEC5v2pL/z/YyJs25I64F4TKoMY4G6gcVPavVjpkKCWvlrCxL5i
 bT2VTgDAcusnp9aywz76FBoSPAQ0wWIjpQWadisf6hrj1Omp3K+r9geDK9dk1kPdx4kf
 FSGrv2HTwWvx1EKU4r1tDzs4CIxNjvG8i+VDJKrEVIyvu0pMQOXAsSu/0OXjV2qX9quL
 ulTg==
X-Gm-Message-State: AOAM533Q0Y8IgAkFbfmYdjhaN7mUY2ElYoUv+P25pYK/TWun2NRXUa6h
 xQi0yjlF8/efeec1cIjmtdgmxmY8qhQ=
X-Google-Smtp-Source: ABdhPJzeIBwrr+pkrOwqouBDUhBndtvACFR+6D611LA0RySwBS85XEQ1/cv/jWswj/Y9oj6kcXqJfw==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr4135266wro.326.1603277462131; 
 Wed, 21 Oct 2020 03:51:02 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s19sm7710935wmc.0.2020.10.21.03.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:51:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] tests/acceptance: Test Linux on the Fuloong 2E machine
Date: Wed, 21 Oct 2020 12:50:34 +0200
Message-Id: <20201021105035.2477784-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial test booting the rescue image provided by Lemote:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=1 \
    avocado --show=app,console run tests/acceptance/machine_mips_fuloong2e.py
  Fetching asset from tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_linux_kernel_isa_serial
   (1/1) tests/acceptance/machine_mips_fuloong2e.py:MipsFuloong2e.test_linux_kernel_isa_serial:
  console: Linux version 2.6.27.7lemote (root@debian) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)) #6 Fri Dec 12 00:11:25 CST 2008
  console: busclock=33000000, cpuclock=-2145008360,memsize=256,highmemsize=0
  console: console [early0] enabled
  console: CPU revision is: 00006302 (ICT Loongson-2)
  PASS (0.16 s)
  JOB TIME   : 0.51 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS                                |  1 +
 tests/acceptance/machine_mips_fuloong2e.py | 42 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tests/acceptance/machine_mips_fuloong2e.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a7f0acf8663..1720a383e6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1152,6 +1152,7 @@ F: hw/mips/fuloong2e.c
 F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
+F: tests/acceptance/machine_mips_fuloong2e.py
 
 Loongson-3 virtual platforms
 M: Huacai Chen <chenhc@lemote.com>
diff --git a/tests/acceptance/machine_mips_fuloong2e.py b/tests/acceptance/machine_mips_fuloong2e.py
new file mode 100644
index 00000000000..5fd3da09e7c
--- /dev/null
+++ b/tests/acceptance/machine_mips_fuloong2e.py
@@ -0,0 +1,42 @@
+# Functional tests for the Lemote Fuloong-2E machine.
+#
+# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+
+class MipsFuloong2e(Test):
+
+    timeout = 60
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_linux_kernel_isa_serial(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:fulong2e
+        :avocado: tags=endian:little
+        :avocado: tags=device:bonito64
+        :avocado: tags=device:via686b
+        """
+        # Recovery system for the Yeeloong laptop
+        # (enough to test the fuloong2e southbridge, accessing its ISA bus)
+        # http://dev.lemote.com/files/resource/download/rescue/rescue-yl
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
+                      'raw/f6b2e7e4/mips/yeeloong/mips64el/rescue-yl')
+        kernel_hash = 'ec4d1bd89a8439c41033ca63db60160cc6d6f09a'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Linux version 2.6.27.7lemote')
+        cpu_revision = 'CPU revision is: 00006302 (ICT Loongson-2)'
+        wait_for_console_pattern(self, cpu_revision)
-- 
2.26.2


