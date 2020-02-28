Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902B324691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTzyJPNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902B324691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7j6r-0005N7-PR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifS-00084x-FB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifR-00023B-54
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifQ-00022m-US
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id p18so3638157wre.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7pnRJmXnO6IweO9cucbS1G2R/qlgmQQw2whsHVhkaZE=;
 b=UTzyJPNqpQqlyXniKbEloNDMOAKtEzXo39ufOq2/p2LTGqGhnK6MkV2V9fkPJD2r22
 NPnwbwi97+oSRoYuogSJv9h5Bz8OpUuRd0iz352HrYMdrjmj8BTZT7MUPkyV3dcbY6zv
 ozosodw0hFBxX28fIwsufXWifPX3wpsBFSL2kpaFd/q8zm30NWdMvKdZHKEg2d8YcGUv
 bj/uNI3gvnUZn9O0iELpCdeWmnCgHoKtTrXmhXRulwklPVHFOXuRyZnrolYqI88VX6fU
 bSlvYasapLp45T7KuljWM6j+eDGsJ/Zzz4pZm/FeKO8JtpHY9JDvaP/aJQVgz0URSMOQ
 aOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7pnRJmXnO6IweO9cucbS1G2R/qlgmQQw2whsHVhkaZE=;
 b=eF8AktvlFi+BKE+weRlq/GcOSyJ66RjiBjWC8GEL1THB1ggyDOGl5WeR4GeLNfNOdf
 nqOiegAfOD4rU18yIYdN05MiXq3VwVIQrC86YU/okFyPq+dg3WR4BzGuzxsWmFsMxPVM
 HG8Eb0ppDtSDKfsf11oXy3lvvUYK+vF6OeGvL6Jz6fWc5zBRw8NATxxt8uEbHp3ixdW5
 fnNgV9Ur/1ymoyNsSjo4fFwzvRXpMRjrgc56OpXN58ub82qrnN27pKYJixVOj5rueDps
 xuQf/Kb3gsfNtogmBlh407UxX92U3n7yT5TnG2+o34/zZKq/C9cxFZhRyFVEo8jv4ZGV
 twaQ==
X-Gm-Message-State: APjAAAUzsHHSs6xOm+cc3mupeFkbexC61kL/hTBk0CMWbaG1IXctbsaC
 RYRCPS9v8wjL0JfXtQzoy7JKhVESHCCysw==
X-Google-Smtp-Source: APXvYqwc6DYlF7hCRuwxyonVI3wnlvADI2R3tbkx2C2e4xdIXmLcjGa4w9N0VITc7OjFlIc4ANA7Xw==
X-Received: by 2002:adf:9521:: with SMTP id 30mr5484988wrs.349.1582907951611; 
 Fri, 28 Feb 2020 08:39:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810 arm
 machines
Date: Fri, 28 Feb 2020 16:38:32 +0000
Message-Id: <20200228163840.23585-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

Old kernels from the Meego project can be used to check that Linux
is at least starting on these machines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200225172501.29609-2-philmd@redhat.com
Message-Id: <20200129131920.22302-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                          |  1 +
 tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_n8x0.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b66c46dcb9f..264374adbe8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -686,6 +686,7 @@ F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
+F: tests/acceptance/machine_arm_n8x0.py
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/machine_arm_n8x0.py
new file mode 100644
index 00000000000..e5741f2d8d1
--- /dev/null
+++ b/tests/acceptance/machine_arm_n8x0.py
@@ -0,0 +1,49 @@
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
+class N8x0Machine(Test):
+    """Boots the Linux kernel and checks that the console is operational"""
+
+    timeout = 90
+
+    def __do_test_n8x0(self):
+        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
+                      'meego-arm-n8x0-1.0.80.20100712.1431-'
+                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
+        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', 'printk.time=0 console=ttyS1')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'TSC2005 driver initializing')
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_n800(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:n800
+        """
+        self.__do_test_n8x0()
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_n810(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:n810
+        """
+        self.__do_test_n8x0()
-- 
2.20.1


