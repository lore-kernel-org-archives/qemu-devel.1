Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C0622CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C0622CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i390z-0007yi-Kc
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i38zX-0006yM-MX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i38zW-0000OY-6M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i38zW-0000OQ-1H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:12:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46FA23DE04;
 Thu, 29 Aug 2019 01:12:45 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 242055D712;
 Thu, 29 Aug 2019 01:12:39 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 21:12:36 -0400
Message-Id: <20190829011237.29954-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 29 Aug 2019 01:12:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] Boot Linux Console Test: add a test for
 ppc64 + pseries
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just like the previous tests, boots a Linux kernel on a ppc64 target
using the pseries machine.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190607152223.9467-5-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index caf0a1f8fa..92b00927d4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -232,7 +232,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu,ppc64-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 32159503e9..2504ef0150 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -354,3 +354,22 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
+
+    def test_ppc64_pseries(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:pseries
+        """
+        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora-s=
econdary/'
+                      'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlin=
uz')
+        kernel_hash =3D '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('pseries')
+        self.vm.set_console()
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3Dhvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
--=20
2.21.0


