Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B9C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB723214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB723214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiaI-0001vF-OK
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfiUp-0005qy-7u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfiUn-0007Vc-JI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfiUn-0007A3-BV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 675803086262;
 Tue, 25 Jun 2019 10:15:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 903BB5D717;
 Tue, 25 Jun 2019 10:15:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 12:15:21 +0200
Message-Id: <20190625101524.13447-3-philmd@redhat.com>
In-Reply-To: <20190625101524.13447-1-philmd@redhat.com>
References: <20190625101524.13447-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 10:15:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/5] tests/acceptance: Make
 pick_default_qemu_bin() more generic
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make pick_default_qemu_bin() generic to find qemu-system or
qemu-user binaries.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 84fe090458..6785c7399e 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -23,7 +23,7 @@ def is_readable_executable_file(path):
     return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
=20
=20
-def pick_default_qemu_bin(arch=3DNone):
+def pick_default_qemu_bin(path_fmt, bin_fmt, arch=3DNone):
     """
     Picks the path of a QEMU binary, starting either in the current work=
ing
     directory or in the source tree root directory.
@@ -39,8 +39,7 @@ def pick_default_qemu_bin(arch=3DNone):
     """
     if arch is None:
         arch =3D os.uname()[4]
-    qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
-                                          "qemu-system-%s" % arch)
+    qemu_bin_relative_path =3D os.path.join(path_fmt % arch, bin_fmt % a=
rch)
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
=20
@@ -51,14 +50,15 @@ def pick_default_qemu_bin(arch=3DNone):
=20
=20
 class Test(avocado.Test):
-    def setUp(self):
+    def base_setUp(self, path_fmt, bin_fmt):
         arches =3D self.tags.get('arch', [])
         if len(arches) =3D=3D 1:
             arch =3D arches.pop()
         else:
             arch =3D None
         self.arch =3D self.params.get('arch', default=3Darch)
-        default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
+        default_qemu_bin =3D pick_default_qemu_bin(path_fmt, bin_fmt,
+                                                 arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
         if self.qemu_bin is None:
@@ -68,7 +68,7 @@ class Test(avocado.Test):
 class MachineTest(Test):
     def setUp(self):
         self._vms =3D {}
-        super().setUp()
+        self.base_setUp("%s-softmmu", "qemu-system-%s")
=20
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin)
--=20
2.20.1


