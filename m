Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB1EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1203B2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPGdw2OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1203B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj94W-0002jD-7y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uU-0005zW-JI; Wed, 10 Jun 2020 18:09:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38213)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uT-0008IL-OD; Wed, 10 Jun 2020 18:09:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id e1so4054078wrt.5;
 Wed, 10 Jun 2020 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w8hUc/1TWyX+gQCAaNVvAefQWKI4RgRqWbvHS2ef4jA=;
 b=QPGdw2OYaWjLZNm0hmBQtaR3QOGaPEDsFvhNy+EdrmbrGuAdoieVsToE5gvBORNXZp
 qPXcucr8QN6tN0bADHgRb5EZ5Psxov+HgeZ+hhv864/s8LuQW20O1OnHuoD+B9aXZpI0
 7ZS2smE6ztXN8ods/Y7YCVQbiZyuzo9eVkok632fumLxy00pdkMriMrDsLuWtmjBJSB9
 rF/QNEFJC9k9WaYYYxnYtao0olYi/9oU+JrjsZ3BUjIk29nMGo5Mq3cwU68p1acrcHW+
 R+GtemHl57509r5JuZ+Gsc9YF1CZVSJBRAcVz4LLCAg+z+cyK2sWwSbb+35Fl9ojEvby
 DNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w8hUc/1TWyX+gQCAaNVvAefQWKI4RgRqWbvHS2ef4jA=;
 b=IhSXEwB8anNwGNFJsw76SCOQzUp63jNB6G1Q+asAVSelosbe3WAz7rba0zxWfmmo2L
 l9xPRvh3lk3um9z80GiPzyYjC0yxKGQctR33W0KkSKGXvP/IeCFl+qAqix59H6peg5vj
 P28kJhQ2/CVQwgERFF/7rKFILav0AolGMAGzfnmar/jNxBkKFIv6+/A+F9XKM1Nwck9n
 qyMtkAI7I5qv6hFupLfLv5lDBvcdLH6NB/S+1J2G27kbr1njhJQFzUvh1xq7rmeg746V
 uHJueSepaeO1JCQWsLzM02i6HOEV+YJ+rQLoYJjIpx+sKGlXfETM61KFw60P6/2TWGaT
 Fkqw==
X-Gm-Message-State: AOAM530wO9x/VeiQHJ3Ruj7CYD/s1wAKFtyqK7E8EUtbQNGbmyL/b/TZ
 DF+uUscLoIhg5n1F7Rs2EjkzK5R6
X-Google-Smtp-Source: ABdhPJyqujrpcZdf9sE1ZE4l53t92y3KJI54iiVaAPOL2qtj6NN4p5cC50dIVdl5GxClIVz1G5Eayw==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr6093091wru.27.1591826951876;
 Wed, 10 Jun 2020 15:09:11 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:09:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/11] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
Date: Thu, 11 Jun 2020 00:08:52 +0200
Message-Id: <20200610220853.8558-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index 3f3aa0c854..3d02519660 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -858,12 +858,12 @@ def test_m68k_q800(self):
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
@@ -937,6 +937,15 @@ def test_ppc_mac99(self):
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


