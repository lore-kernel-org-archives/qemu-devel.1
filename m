Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FB82469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHTEuaiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FB82469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ipq-0002FP-QU
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifT-00087h-Es
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifS-000242-1u
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:15 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifR-00023P-Qr
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:13 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so3813325wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MzcpXPRjhRqp+Fy3j7b0AOUvrSs6C4ggJpK7+di/i9I=;
 b=YHTEuaiywv6TwkaEpQ6y0Pr/eYo/MuLd+bW/CxXYFyS6XLWRgpJalfRmsEv33czlkp
 CqCSUX+5Z7hZ/8oYAf2G8WE2CIhmigaeQW9BURErQCN3FwoSLjQ12sQwyPGUn7fUnEt4
 nUlbcTPXSA5R/eabQ5y9Oz1s4IExO/BELOocxKtzhgzVmU9N/jICp/lTSeRQxRKZGech
 WYKYumSxWRX6fbOnOiryoFmvFqPcGJ8om6ZcKcAC8Awj/pl5iauel4NedTOv15Eucu9K
 OHGW1Jf3iYJogkSZvhKjdIEl/Ofsf6TaaG3hqXSH7Sk2YC02TiuM9g8C6h24P1MxRYbN
 rzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MzcpXPRjhRqp+Fy3j7b0AOUvrSs6C4ggJpK7+di/i9I=;
 b=b0JbWh8vlZH4uvpynV1gEEhI5MWpofN4wkg15DpaqJCg2mdZDn0/Moue0gYVienWd+
 SzShAnr/L3rgZKVrzcaM2G95tuX/3PUpxIrWiwZSS8rE2IAn2Yr3ZGd/jQ4kN3RCiz3W
 L2DyVge6jFHbsAtG3r/yBG/M/5en9QqN/ueKxxYHP51Z8960WWi5+qGJmYN5oVpifICq
 uYSHuwuqQvwS2rH9s5uCSY2EbWPLqaPqqS9J5bm86A25BxnOEhAqujqzp2wNZ1tB7tl/
 UvTMMoYvzhDsv1Xcft/i9Txwu14/xAR6bQDxMsRiB/FzLzkjoRgSN8olIQmD10fVxgk/
 luMw==
X-Gm-Message-State: APjAAAWPnAxQNvzHKv4aL3cGdDhf60fsYSjwF+ImhEb9Al0SwNhDVYUk
 8LcQXQWrC+k/JsTtpe2yLKyAwnMuE+tVLA==
X-Google-Smtp-Source: APXvYqweZBabnXeP+wV5O8uhPd4pdXk68ewudzcBz+O6ExOQJezLLbXdz/4m5kUMfvBq/PKV8r82Og==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr5856634wme.26.1582907952559; 
 Fri, 28 Feb 2020 08:39:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/33] tests/acceptance: Add a test for the integratorcp arm
 machine
Date: Fri, 28 Feb 2020 16:38:33 +0000
Message-Id: <20200228163840.23585-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

There is a kernel and initrd available on github which we can use
for testing this machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200225172501.29609-3-philmd@redhat.com
Message-Id: <20200131170233.14584-1-thuth@redhat.com>
[PMD: Renamed test method, moved description from class to method]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                  |  1 +
 tests/acceptance/machine_arm_integratorcp.py | 43 ++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_integratorcp.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 264374adbe8..c258391cad8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -613,6 +613,7 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
+F: tests/acceptance/machine_arm_integratorcp.py
 
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptance/machine_arm_integratorcp.py
new file mode 100644
index 00000000000..d928ed79b4c
--- /dev/null
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -0,0 +1,43 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+
+class IntegratorMachine(Test):
+
+    timeout = 90
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_integratorcp_console(self):
+        """
+        Boots the Linux kernel and checks that the console is operational
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:integratorcp
+        """
+        kernel_url = ('https://github.com/zayac/qemu-arm/raw/master/'
+                      'arm-test/kernel/zImage.integrator')
+        kernel_hash = '0d7adba893c503267c946a3cbdc63b4b54f25468'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('https://github.com/zayac/qemu-arm/raw/master/'
+                      'arm-test/kernel/arm_root.img')
+        initrd_hash = 'b51e4154285bf784e017a37586428332d8c7bd8b'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', 'printk.time=0 console=ttyAMA0')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Log in as root')
-- 
2.20.1


