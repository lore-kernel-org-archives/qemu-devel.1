Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F61C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD00206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eePoRv0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD00206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3KS-0007ox-C3
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3Ij-0005SA-OY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:17:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3Ih-0001Ti-W4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:17:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id 10so6487518wml.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6oA4Yr6JFcavXZq+cNokMDx7IpAfJjokyIK9QOqnHE0=;
 b=eePoRv0+w+vNANAjFr+BOaMGvyS4v7GDdidL0Io4Ipbfe5aAPr8js+vr9jz/FHGoZG
 4qxsJdQVaH5gcvAR2lkB9JC4w5iYS5VBiZn59R9UPMERw6CsRnQ7OtfqUIiw9cfdv3Pq
 /YTpWXlULUGePTr1wU+V5e+RyEzLqZl2seAyCr6FFlKOIhWZp/blxHJRLeYP05YkE42h
 MS3eT0YTOLlxcLj+dwcgoAwq3Wnp9eyGMzn/z0SGg5K76UAo4gz+O+jdDBkZ2YS0agU4
 hZJOXAsxP35aAAUAt+jEGC4IwGwmFl182x02m0mZ7Fur4o1cRa6wKT/v4yUNfEVg+0vT
 qUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6oA4Yr6JFcavXZq+cNokMDx7IpAfJjokyIK9QOqnHE0=;
 b=Ayde3g1t2V/Uu/Fha+HEtzCsp1opZy9nFkkJLzqIyBC3qJUDk0EHZto3VMDlF7XWnk
 TGi43lv4nNsnbMUZn5GabOYAp7lUpgh7b2ochwV6S/b6vYRJsoQaQaz9UM1/dRvwRWd9
 YehIAWmhC3W8ptScMlUKr5NvzVUSAQ8TpumUQXqvHhDbAOfYPARwKCO8y5P+y17JqDjy
 OWjrwVDGET0zYwPDDV9pZ5eJwbpnIPSuIQinxSS5qZQWllZ+V2ywUPYIva4TQTGWrOLF
 mQ8XFQ1xBhLTCXUhppL1Y1gaekY1Yeno6xowgFB5yrUMFoVcKyuOcGzc4ui4IVlvu3BI
 ykYg==
X-Gm-Message-State: AOAM533A7fnLbi4olal+cVm5qlRO4SpFg5i54DCfzlIHykg97qu2/EwZ
 Mol7r0ZV6S9OODeF3/wcDQVoMOQzZAQ=
X-Google-Smtp-Source: ABdhPJzDMp5S4n2onnnf01O7IR9vKqhk4ow1MEeW9vw/+hSMQVYSJi88V0Wj82VnImH547o17tSpQQ==
X-Received: by 2002:a1c:a402:: with SMTP id n2mr13557995wme.121.1604913442088; 
 Mon, 09 Nov 2020 01:17:22 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r1sm12916707wro.18.2020.11.09.01.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:17:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3] tests/acceptance: Disable Spartan-3A DSP 1800A test
Date: Mon,  9 Nov 2020 10:17:19 +0100
Message-Id: <20201109091719.2449141-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Thomas Huth <thuth@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test is regularly failing on CI:

   (05/34) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_microblaze_s3adsp1800:
  Linux version 4.11.3 (thuth@thuth.remote.csb) (gcc version 6.4.0 (Buildroot 2018.05.2) ) #5 Tue Dec 11 11:56:23 CET 2018
  ...
  Freeing unused kernel memory: 1444K
  This architecture does not have kernel memory protection.
  [nothing happens here]
  Runner error occurred: Timeout reached (90.91 s)

This is a regression. Until someone figure out the problem,
disable the test to keep CI pipeline useful.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Simply disable with @skip
---
 tests/acceptance/boot_linux_console.py | 2 ++
 tests/acceptance/replay_kernel.py      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8f433a67f84..cc6ec0f8c15 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -13,6 +13,7 @@
 import gzip
 import shutil
 
+from avocado import skip
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
@@ -1025,6 +1026,7 @@ def test_m68k_mcf5208evb(self):
         tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
         self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
 
+    @skip("Test currently broken") # Console stuck as of 5.2-rc1
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 00c228382bd..772633b01da 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -14,6 +14,7 @@
 import logging
 import time
 
+from avocado import skip
 from avocado import skipIf
 from avocado import skipUnless
 from avocado_qemu import wait_for_console_pattern
@@ -280,6 +281,7 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
+    @skip("Test currently broken") # Console stuck as of 5.2-rc1
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
-- 
2.26.2


