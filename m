Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A31C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD312070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD312070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMWi-0000B1-FN
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:58:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHQ-0004A9-Uj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMHP-00072j-So
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMHP-00071Y-NN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 809853D37;
	Fri,  3 May 2019 00:42:21 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9F85C26A;
	Fri,  3 May 2019 00:42:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:26 -0300
Message-Id: <20190503004130.8285-16-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 03 May 2019 00:42:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/19] tests/boot_linux_console: add a test for
 aarch64 + virt
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503004126.GBNWOooDDLpyHwBBCCbwcYcbrkcXFWIRfK_1GFjyzRg@z>

From: Cleber Rosa <crosa@redhat.com>

Just like the previous tests, boots a Linux kernel on a aarch64 target
using the virt machine.

One special option added is the CPU type, given that the kernel
selected fails to boot on the virt machine's default CPU (cortex-a15).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Message-Id: <20190312171824.5134-18-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index cb46098972..753e40a115 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -223,7 +223,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu"
         - TEST_CMD="make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 38b33b25f7..6d9362922f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -134,3 +134,24 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_aarch64_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:virt
+        """
+        kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
+                      'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz')
+        kernel_hash = '8c73e469fc6ea06a58dc83a628fc695b693b8493'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0')
+        self.vm.add_args('-cpu', 'cortex-a53',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
-- 
2.18.0.rc1.1.g3f1ff2140


