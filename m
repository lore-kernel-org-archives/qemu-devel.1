Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8DFC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75E820644
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75E820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiWh-0007Ck-5S
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34076)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfiUp-0005r7-E4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfiUn-0007Vh-Jz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfiUn-0007KI-BQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 77F8F2F8BDF;
 Tue, 25 Jun 2019 10:16:02 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94FE05B68D;
 Tue, 25 Jun 2019 10:15:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 12:15:23 +0200
Message-Id: <20190625101524.13447-5-philmd@redhat.com>
In-Reply-To: <20190625101524.13447-1-philmd@redhat.com>
References: <20190625101524.13447-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 25 Jun 2019 10:16:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/5] tests/acceptance: Add bFLT loader
 linux-user test
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add a very quick test that runs a busybox binary in bFLT format:

  $ avocado --show=3Dapp run tests/acceptance/load_bflt.py
  JOB ID     : db94d5960ce564c50904d666a7e259148c27e88f
  JOB LOG    : ~/avocado/job-results/job-2019-06-25T10.52-db94d59/job.log
   (1/1) tests/acceptance/load_bflt.py:LoadBFLT.test_stm32: PASS (0.15 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
  JOB TIME   : 0.54 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
This test currently fails on Aarch64 host, see LP#1833668
https://bugs.launchpad.net/qemu/+bug/1833668
---
 tests/acceptance/load_bflt.py | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 tests/acceptance/load_bflt.py

diff --git a/tests/acceptance/load_bflt.py b/tests/acceptance/load_bflt.p=
y
new file mode 100644
index 0000000000..fdcaf8ad88
--- /dev/null
+++ b/tests/acceptance/load_bflt.py
@@ -0,0 +1,52 @@
+# Test the bFLT format
+#
+# Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import bz2
+import subprocess
+
+from avocado_qemu import LinuxUserTest
+
+
+class LoadBFLT(LinuxUserTest):
+
+    def extract_cpio(self, cpio_path):
+        """
+        Extracts a cpio archive into the test workdir
+
+        :param cpio_path: path to the cpio archive
+        """
+        cwd =3D os.getcwd()
+        os.chdir(self.workdir)
+        with bz2.open(cpio_path, 'rb') as archive_cpio:
+            subprocess.run(['cpio', '-i'], input=3Darchive_cpio.read(),
+                           stderr=3Dsubprocess.DEVNULL)
+        os.chdir(cwd)
+
+    def test_stm32(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dlinux_user
+        :avocado: tags=3Dquick
+        """
+        # See https://elinux.org/STM32#User_Space
+        rootfs_url =3D ('https://elinux.org/images/5/51/'
+                      'Stm32_mini_rootfs.cpio.bz2')
+        rootfs_hash =3D '9f065e6ba40cce7411ba757f924f30fcc57951e6'
+        rootfs_path_bz2 =3D self.fetch_asset(rootfs_url, asset_hash=3Dro=
otfs_hash)
+        busybox_path =3D self.workdir + "/bin/busybox"
+
+        self.extract_cpio(rootfs_path_bz2)
+
+        cmd =3D ''
+        res =3D self.run("%s %s" % (busybox_path, cmd))
+        ver =3D 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) multi-cal=
l binary.'
+        self.assertIn(ver, res.stdout_text)
+
+        cmd =3D 'uname -a'
+        res =3D self.run("%s %s" % (busybox_path, cmd))
+        unm =3D 'armv7l GNU/Linux'
+        self.assertIn(unm, res.stdout_text)
--=20
2.20.1


