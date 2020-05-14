Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C11C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14CF2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTCA2i63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14CF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJAm-0003pi-Rb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZJ9g-0003Ep-J3; Thu, 14 May 2020 15:04:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZJ9f-00030k-Ir; Thu, 14 May 2020 15:04:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id j5so14230wrq.2;
 Thu, 14 May 2020 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5c/cqTSBeacgrG9vD8SV8joXa3WDKDX9leqs1xGxGE4=;
 b=cTCA2i63BCynziUv2M2XCPslY5UixvstTkS2yccWkf8NTPuna/VM0Rgebf6n0H10l4
 x5dkIM161msa23IeE4gdg8Brlli3oF5DB8En8Ufy9KjWfLisOtJQupBrzvFTlgBfTrFn
 uL7h5xrbJBURJOWGdE7Xmr/VK/AgKGiMWxv5C4ZlDJfLDhHvn17k1O2k1N5b8laJ6P8Q
 aJQGzzuqfgQAfYIhnit4d0ajndkibXnCIrDaQrdi8v+vC2kriEblkvtzv3Cc7q6+U5l0
 RSLQjJHd+8XlYnhxBeLnRsklvLkPEeRl+DlnspXjB3hy3Ilr4rLan60c0YJI6ge1G2dT
 OJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5c/cqTSBeacgrG9vD8SV8joXa3WDKDX9leqs1xGxGE4=;
 b=NuZptyAvLBARsft3T15I66COgoyQdYZ+7MTdSmllxQfbbUz+X1xh1ClNtGYohKFuJ7
 zPO0DmE6qZE85c7/o+sXvp4Cnn2jSXTg2QZA9XlDyrH9uGqbF3HL2akTr58NeP60Ar7l
 3BWWr+TYXUcl+9U1S5fiwVsQyWqhrvoErxnGd8/gxfwfaqCRfX9JAR866yp5S8UQj/pQ
 9QJn3BUIkBKijAU2a5ruCTM5ArVVx3e3403FlNycI+dQ8b+wUchp5NJAPkEKMW0ngC+Z
 jdl/LFZKQpiNTBEqvJYzC8kugT43+WzEhXTJSbuxbm+v2s3g6Bec9MLXTjJQ3SV/zgZw
 Z7Tw==
X-Gm-Message-State: AOAM533rohURc/xTa0JW5F2swBmL14J+plU6hgdd3R3HspnJYPb74E4j
 IXwieCL8rsQjOOGry9ldNthLZzY1CyE=
X-Google-Smtp-Source: ABdhPJxYwHFf6u5sEWyh0j+AtzU8mQAsGL7LLSAlCPSMiJm5k1I1T0WYXwl83uMOik296ZGnAIKqqw==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr2895092wrr.417.1589483065073; 
 Thu, 14 May 2020 12:04:25 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w15sm5225773wrl.73.2020.05.14.12.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] tests/acceptance: Add a test for the canon-a1100 machine
Date: Thu, 14 May 2020 21:04:22 +0200
Message-Id: <20200514190422.23645-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The canon-a1100 machine can be used with the Barebox firmware. The
QEMU Advent Calendar 2018 features a pre-compiled image which we
can use for testing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200129090420.13954-1-thuth@redhat.com>
[PMD: Rebased MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Thomas asked me to watch for few of his patches to get merged,
but I missed this one.
Peter: I suppose it is flushed of your REVIEW folder, so resending.
---
 MAINTAINERS                                |  1 +
 tests/acceptance/machine_arm_canona1100.py | 35 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_canona1100.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f02e290702..d1fb688c0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -607,6 +607,7 @@ S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
+F: tests/acceptance/machine_arm_canona1100.py
 
 Goldfish RTC
 M: Anup Patel <anup.patel@wdc.com>
diff --git a/tests/acceptance/machine_arm_canona1100.py b/tests/acceptance/machine_arm_canona1100.py
new file mode 100644
index 0000000000..0e5c43dbcf
--- /dev/null
+++ b/tests/acceptance/machine_arm_canona1100.py
@@ -0,0 +1,35 @@
+# Functional test that boots the canon-a1100 machine with firmware
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+
+class CanonA1100Machine(Test):
+    """Boots the barebox firmware and checks that the console is operational"""
+
+    timeout = 90
+
+    def test_arm_canona1100(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:canon-a1100
+        :avocado: tags=device:pflash_cfi02
+        """
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day18.tar.xz')
+        tar_hash = '068b5fc4242b29381acee94713509f8a876e9db6'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-bios',
+                         self.workdir + '/day18/barebox.canon-a1100.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'running /env/bin/init')
-- 
2.21.3


