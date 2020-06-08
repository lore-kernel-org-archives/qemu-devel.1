Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F134D20760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCsP5t7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F134D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDjf-0002LF-7l
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfZ-0005D3-0a; Mon, 08 Jun 2020 05:02:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfM-0004Jr-97; Mon, 08 Jun 2020 05:02:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id g10so14532037wmh.4;
 Mon, 08 Jun 2020 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GIhXAw4hO0rsp7xfE0WleKuNym34yW50KXceAXKBDO8=;
 b=XCsP5t7PplE4AfM4ph0HUK5+LxEY6Rf+e8VFW6aXOCgB4uiC+BHMzkisHNAhaFa2TT
 5NURvdEfPw9FZG0L/GIZyFEmX2N+mfAqgziWBdspsXvN2Uu8RnjPP0JR2tW6cQY7WdhB
 TE6PlLp1fvmn6Xola+IzbYF1hUV0GbIKRivk3iWg9xBYz2IqiYR3s5agM0Kw1jfMQBqB
 5sH8pt4jCGJxs5tVtsW35v9WSZ8mcxWz8wrl0qE9Fd75xQiTu5W980I5qgqlsc6cwtwc
 R8tObq643cGBTDis9rPKyGHAPKXgC2CfqJJT10RIFRe4YqiJRdS/5+bwnXLLPuACTraQ
 tedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GIhXAw4hO0rsp7xfE0WleKuNym34yW50KXceAXKBDO8=;
 b=ML0XLsS+frClN8w0WePvuBKkJJenyr611IBNSMHTS97NdLyB1nsZC9dIAmKZVnCP5F
 /muZZWbQ6WNhVnaVoKes2mTAHXtSLTnsQHJ4NZUaX4bT8WmPjYDNb/mF+yZ8LrKDDB9N
 eXSDgNQNAmVsH4qWmlB6Wb75/EtPHZePIA5E3nQgoSTFqsoVtfaZtNt0HAElnoV97sUS
 6ruAeHYmeSIViSkxZOGDKyQz5vCVBkVoLBA+JcOOtnOAepWVXjEBDK9UhArDroS8ovFO
 i8exsMxsMW7AP9H31khu0CYgY8klMDdUuaUYQlR91EvDtrWYjf/3iBJtYBKz72lbFF23
 yplg==
X-Gm-Message-State: AOAM532QfMP+A8kU+rtMBc2DeCyPoy7C2t01rEMZtp345d3Y+FPp0k/N
 DYgZzsu1EW86gsUmN7d2+ztHHrv0
X-Google-Smtp-Source: ABdhPJxtaFetxfOC/b45Gy5OTKd0LbHmNacR4nsHMVQ7kfizV/AFJeBXBU86otpLUygmf52SC/ZAow==
X-Received: by 2002:a05:600c:2284:: with SMTP id
 4mr14780685wmf.57.1591606918366; 
 Mon, 08 Jun 2020 02:01:58 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
Date: Mon,  8 Jun 2020 11:01:41 +0200
Message-Id: <20200608090142.6793-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_PASS=-0.001,
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
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
index 12725d4529..d4fb2bce82 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -827,12 +827,12 @@ def test_m68k_q800(self):
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
@@ -906,6 +906,15 @@ def test_ppc_mac99(self):
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


