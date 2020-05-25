Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733CB20723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733CB20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBGp-0006Zh-L0
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jdB93-0001mS-Ni
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:54882)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jdB92-0008QJ-Ns
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:19:49 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id C68BCCD466;
 Mon, 25 May 2020 14:19:47 +0300 (MSK)
Subject: [PATCH 8/9] tests/acceptance: record/replay tests with advcal images
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 25 May 2020 14:19:47 +0300
Message-ID: <159040558755.2615.4869959098521372877.stgit@pasha-ThinkPad-X280>
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

This patch adds more record/replay tests with kernel images.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 tests/acceptance/replay_kernel.py |   80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 4c786b1565..3849db7f3a 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -191,3 +191,83 @@ class ReplayKernel(Test):
                                'console=ttyS0 vga=off')
         console_pattern = 'No filesystem could mount root'
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
+
+    def do_test_advcal_2018(self, day, tar_hash, kernel_name, args=()):
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day' + day + '.tar.xz')
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+
+        kernel_path = self.workdir + '/day' + day + '/' + kernel_name
+        kernel_command_line = ''
+        console_pattern = 'QEMU advent calendar'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern,
+            args=args)
+
+    def test_arm_vexpressa9(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:vexpress-a9
+        """
+        tar_hash = '32b7677ce8b6f1471fb0059865f451169934245b'
+        self.do_test_advcal_2018('16', tar_hash, 'winter.zImage',
+            ('-dtb', self.workdir + '/day16/vexpress-v2p-ca9.dtb'))
+
+    def test_m68k_mcf5208evb(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:mcf5208evb
+        """
+        tar_hash = 'ac688fd00561a2b6ce1359f9ff6aa2b98c9a570c'
+        self.do_test_advcal_2018('07', tar_hash, 'sanity-clause.elf')
+
+    def test_microblaze_s3adsp1800(self):
+        """
+        :avocado: tags=arch:microblaze
+        :avocado: tags=machine:petalogix-s3adsp1800
+        """
+        tar_hash = '08bf3e3bfb6b6c7ce1e54ab65d54e189f2caf13f'
+        self.do_test_advcal_2018('17', tar_hash, 'ballerina.bin')
+
+    def test_ppc64_e500(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:ppce500
+        """
+        tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
+        self.do_test_advcal_2018('19', tar_hash, 'uImage', ('-cpu', 'e5500'))
+
+    def test_ppc_g3beige(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:g3beige
+        """
+        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf',
+            ('-M', 'graphics=off'))
+
+    def test_ppc_mac99(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:mac99
+        """
+        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
+        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf',
+            ('-M', 'graphics=off'))
+
+    def test_sparc_ss20(self):
+        """
+        :avocado: tags=arch:sparc
+        :avocado: tags=machine:SS-20
+        """
+        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
+        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
+
+    def test_xtensa_lx60(self):
+        """
+        :avocado: tags=arch:xtensa
+        :avocado: tags=machine:lx60
+        """
+        tar_hash = '49e88d9933742f0164b60839886c9739cb7a0d34'
+        self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf',
+            ('-cpu', 'dc233c'))


