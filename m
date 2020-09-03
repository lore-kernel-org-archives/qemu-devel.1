Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B972EC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB99206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7YXVtjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB99206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwgm-00055Z-Lm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLh-0004Zm-Iu; Thu, 03 Sep 2020 17:00:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLg-0007le-3J; Thu, 03 Sep 2020 17:00:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id a65so4001887otc.8;
 Thu, 03 Sep 2020 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nd9Ud5qwe+YYQ0q+uyzFJ7HGCJCNwB347EpetEguZ38=;
 b=Q7YXVtjV08PkuXoPal29fKq1rGAjHbOQyUSXkOWgVKqLdY339NfDytdc4dfto1Szvc
 NwUAqvtWdTlfMwsc1Ku6QdDi4ws6gFHqgmECzkYtRxy37/98kEiVOJkJPierJeKJtBrk
 gxMsNjDauY9xM6Gpfwr+AMN/rkQKplDi40Z+Fl7tzyeweeFVciGrss9x7yh7gUWZUBTg
 I9UUDvABxoWGdWziGAbP32Y0EzMnQIIQaxcsR33clCdN4F96VLO3sCod9O3Td6MaHaNQ
 hB12O6UtrH1vlTJL+YKkNkKxsTQBQw7JG4AQlERdto7ZHxnvc2A5P8pW0NG26J9t16iH
 zgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nd9Ud5qwe+YYQ0q+uyzFJ7HGCJCNwB347EpetEguZ38=;
 b=jQ5ElctZ2EY3fOoImmuV0nMyYUb+VKGnSsz0JW9J9B8UWUtu1BVp5sQxUV6frz6HC8
 XnAcpuh5Q0dtekodW780SjUwevVk1ZbgBNBYw5k0ZPzqCoidy5s/KetREV1it6W5btb1
 sfNrGKGgMRrFZ58s8dMXVr1t5XByBCMVTX/47Kxblbyoaj4kOO4eUXzrgdZnjNE2ziVo
 UtLmhDNxb0uIJ3m2mSifQAcY1Ndas33GWysVQ7soBRubp4XJeSDRlC1J3wLN3YhbTmHC
 Mm3RhsHFD3dUneHMg3U3i/DNvc1312a7+9E07KffWwkyz8Prm7bRgQ2KXtumTGutbVjd
 jI/A==
X-Gm-Message-State: AOAM530Y8ZaSOdTjfA5VEMkS0v1xCpjCy4J2Y4CbonIFyii5Lrc6YJLR
 qMfjoQWEriZUiTeutfnfn67toWXcvQofyw==
X-Google-Smtp-Source: ABdhPJwNe3F7a0p4wQIZ06EGu2v/ssbcYaWdWIL8AR2YCYHvh5EwBprN0RW0b3XBUzRvYXF+LS5tfg==
X-Received: by 2002:a9d:eed:: with SMTP id 100mr3004606otj.20.1599166846385;
 Thu, 03 Sep 2020 14:00:46 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id q15sm761296otl.65.2020.09.03.14.00.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:45 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/77] tests/acceptance: refactor boot_linux_console test to
 allow code reuse
Date: Thu,  3 Sep 2020 15:59:07 -0500
Message-Id: <20200903205935.27832-50-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch splits code in BootLinuxConsole class into two different
classes to allow reusing it by record/replay tests.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159073588490.20809.13942096070255577558.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(cherry picked from commit 12121c496fcc609e23033c4a36399b54f98bcd56)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acceptance/boot_linux_console.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index d864d22ca8..e4204d8f09 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -28,19 +28,13 @@ try:
 except CmdNotFoundError:
     P7ZIP_AVAILABLE = False
 
-class BootLinuxConsole(Test):
-    """
-    Boots a Linux kernel and checks that the console is operational and the
-    kernel command line is properly passed from QEMU to the kernel
-    """
-
-    timeout = 90
-
+class LinuxKernelTest(Test):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    def wait_for_console_pattern(self, success_message):
+    def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing')
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
 
     def extract_from_deb(self, deb, path):
         """
@@ -79,6 +73,13 @@ class BootLinuxConsole(Test):
         os.chdir(cwd)
         return os.path.normpath(os.path.join(self.workdir, path))
 
+class BootLinuxConsole(LinuxKernelTest):
+    """
+    Boots a Linux kernel and checks that the console is operational and the
+    kernel command line is properly passed from QEMU to the kernel
+    """
+    timeout = 90
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
-- 
2.17.1


