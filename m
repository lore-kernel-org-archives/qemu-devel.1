Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFD720787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFD720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBAy-0005Vr-Td
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jdB8h-00011a-3L
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54756)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jdB8g-0008N0-B0
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:26 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6001DCD460;
 Mon, 25 May 2020 14:19:25 +0300 (MSK)
Subject: [PATCH 4/9] tests/acceptance: add record/replay test for aarch64
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 25 May 2020 14:19:25 +0300
Message-ID: <159040556513.2615.16719113739608959515.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:19:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, NML_ADSP_CUSTOM_MED=0.9,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a test for record/replay of the kernel
image boot for aarch64 platform.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 tests/acceptance/replay_kernel.py |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 00abe1e872..1d2cfebc85 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -94,3 +94,21 @@ class ReplayKernel(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    def test_aarch64_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:virt
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/aarch64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+            args=('-cpu', 'cortex-a53'))


