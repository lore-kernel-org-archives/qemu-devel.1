Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F219C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828302084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9WNIX/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828302084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2Il-0003l5-G5
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2I0-0003L4-QF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:12:36 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc2Hz-0002Pw-70
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:12:36 -0500
Received: by mail-wm1-x332.google.com with SMTP id t67so2711262wmt.5
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n5fS+vsfFKppP3uSOkL4lCaMOqh8ILi80x/RhpvFPts=;
 b=b9WNIX/ZLeMIlH5OwP9N2o7HcoyNarM89QENHROR+wrWd5qBhvjrs6IuD9sdu9NOZi
 eiWndmArLfNsOlohEY+BqYaite1CvGJMO6qqVS0rdrA/VStCHqtpjs0ioeS33GMhYQSp
 FUDyZ/1t4b0OP6v+TwozLqZBUYdgoXN6JiXpgbPW79vAkdwR0LI+PiI7lXDhiLD9dJob
 8Qakv1AQcHnhdcmYoiFFRTlCyLU8bW6d2Dt2WRqs8sR+6BUBc0Irmgml+ly+mvBOtqK+
 g9Pb9ds27FMnp98/0EyCdKweOF5J6gquZrCqITorh+fs1NmH7nVqN1TGno3x3XXoToGI
 LYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n5fS+vsfFKppP3uSOkL4lCaMOqh8ILi80x/RhpvFPts=;
 b=OxSvasKo7cA1DyUZaok19C0ZBq2WetUNu1xTi/d1fk70+mk3k/krHDizebh8wzoGQy
 1weKmdYAACxecBlvudxTqlsLONiTg4I+ZLFZONBQE8yulzS8wrFk7HC2ET3Hymsa861Z
 EHNlyH7DwMuJcSC1RqJ+Aq6eVzzeLJeBBv6BJOICG0cZvQUs/hWPVMpyPu5KvclNcx0Y
 lEvvIMQ1jifP8LlQhQWQn/OobzqhX+ga/n3wtL9c3TxGmNz7chbzbF5UAa4Qn6mMe+cf
 HPTZwmD0W7Rkck9RYawK6gS3NbQ3bppIzdg6S7h4JOvoIpmxWSWGwV1w/e28eo38MBpu
 MFeQ==
X-Gm-Message-State: AOAM530+YAozv61WaWkD+/Lz4S2oKtDmr/zfgoILe3H9hoXHHuKOlDtE
 x2nF5s1RKwTH+03gNeIJqWRlrDGt878=
X-Google-Smtp-Source: ABdhPJy/mC6BE7X1UFzuI/lEKvVQS98U2C9UZXgZLuH33Xf1Yud7tHLFAOcjb1mIGMHgwfrwu42CQA==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr11907613wmh.88.1604909553277; 
 Mon, 09 Nov 2020 00:12:33 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s4sm5335820wro.10.2020.11.09.00.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 00:12:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 v2] tests/acceptance: Disable Spartan-3A DSP 1800A
 test
Date: Mon,  9 Nov 2020 09:12:31 +0100
Message-Id: <20201109081231.2409773-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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

Do not run it automatically (it can still be run setting
AVOCADO_TIMEOUT_EXPECTED=1 environment variable).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Include failure log
---
 tests/acceptance/boot_linux_console.py | 1 +
 tests/acceptance/replay_kernel.py      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8f433a67f84..010e8790c0f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -1025,6 +1025,7 @@ def test_m68k_mcf5208evb(self):
         tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
         self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 00c228382bd..c1f5fa4de71 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -280,6 +280,7 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
-- 
2.26.2


