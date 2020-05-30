Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A37C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931D6207D0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAQwx7ER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931D6207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexkO-0006MP-Ov
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexi1-0001zW-2P; Sat, 30 May 2020 05:23:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexi0-00074M-8D; Sat, 30 May 2020 05:23:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id u13so6130247wml.1;
 Sat, 30 May 2020 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YT0XNNfFt5Id6xyIWIcJqNlTERULj3wWWT87iAfvWRU=;
 b=SAQwx7ERzXd8YggUZ3HXTQrU0QGUEXxnjfUjvusCnCx2UKw5fF1aI9pGKFAMO9ohwx
 Qc33VhJl3FRbCPNUgz6bs81liR/ts8tGj0GR876jglkipUHdEG5S0yQd0T2R45G30ogS
 6SGfZE3U+KgGmcWhTO1m2+l9KeuX8JYt601GKpmwl963NWreWIi5Sbr2cd3tD0hwUlsn
 1BOjVZ9DtNa4e05ajEHOclGZKg6vdAYgf9cfRQcRoUn427BdAHb2p7Tma7rcXx7aY3vb
 x+f0YtJETF7iUS9fdTYHRojYiG5OzxDDxdcfUx5HN+6Gaf8va6OTyxJ6fUsx7cOPz0fp
 eJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YT0XNNfFt5Id6xyIWIcJqNlTERULj3wWWT87iAfvWRU=;
 b=Nmmv+6kC3MSa4xemGv2AVBFozvxKbWSy3bASlh/9c1NjStSYJHtg6KtDomkiJSqj+Z
 khErimQRi+vsupXzt1hIfY7ymT3ad7MRApm74xKIxhsU9WLuQNWJxaQWuKsc//81YIVh
 HyYlQXoszR53SjGpiGDac2M4jb+avv5SkaMMcelHNs19OD7Er1bj2uX6xi6qGV2R7wL+
 XwErkG/HaFoKz/DRNWaTQdd6u0w0oRX+J2JOVKyEq9tS0xFtOYtKmyrOXE/mKd9wq2bK
 2Z0ePEmNSDzkpx+reEDOhE6hqHnqVjApRcc+0OsUmx4edrxhNoeqN/N4tPCsJWkjUaez
 ofPQ==
X-Gm-Message-State: AOAM532IgXKvnDu+pj2LR+eOQyzLMklR+y8EKf0KMRqVf7yBscOf14nd
 VNoAMQ3Z+60nVeAdh2IymuRb6Gj4
X-Google-Smtp-Source: ABdhPJyy4FPDacDFTF7oVZOqwh9tgWoBLPWa98LLgATRn1ewYQQb5LJWIrbbO14NlZ5HAOk7qmts1g==
X-Received: by 2002:a1c:67c3:: with SMTP id
 b186mr11826217wmc.167.1590830594356; 
 Sat, 30 May 2020 02:23:14 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
Date: Sat, 30 May 2020 11:23:05 +0200
Message-Id: <20200530092306.26628-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200530092306.26628-1-f4bug@amsat.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that we can select the second serial console in the acceptance tests
(see commit 746f244d9720 "Allow to use other serial consoles than default"),
we can also test the sh4 image from the QEMU advent calendar 2018.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200515164337.4899-1-thuth@redhat.com>
[PMD: Split .travis.yml change in separate patch]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index c6b06a1a13..0653c8c1bf 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -826,12 +826,12 @@ def test_m68k_q800(self):
         console_pattern = 'No filesystem could mount root'
         self.wait_for_console_pattern(console_pattern)
 
-    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
+    def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
         tar_url = ('https://www.qemu-advent-calendar.org'
                    '/2018/download/day' + day + '.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         archive.extract(file_path, self.workdir)
-        self.vm.set_console()
+        self.vm.set_console(console_index=console)
         self.vm.add_args('-kernel',
                          self.workdir + '/day' + day + '/' + kernel_name)
         self.vm.launch()
@@ -905,6 +905,15 @@ def test_ppc_mac99(self):
         self.vm.add_args('-M', 'graphics=off')
         self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
 
+    def test_sh4_r2d(self):
+        """
+        :avocado: tags=arch:sh4
+        :avocado: tags=machine:r2d
+        """
+        tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
+        self.vm.add_args('-append', 'console=ttySC1')
+        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
+
     def test_sparc_ss20(self):
         """
         :avocado: tags=arch:sparc
-- 
2.21.3


