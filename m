Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392E2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A92D2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A92D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqnk-00075y-St
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCqkU-0005CC-Al
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCqkS-0004S2-Rz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCqkS-0004Qq-HA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 805C7300CB28;
 Tue, 24 Sep 2019 19:45:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-0.rdu2.redhat.com
 [10.10.121.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B87061F24;
 Tue, 24 Sep 2019 19:45:13 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] Acceptance test x86_cpu_model_versions: use default vm
Date: Tue, 24 Sep 2019 15:44:59 -0400
Message-Id: <20190924194501.9303-2-crosa@redhat.com>
In-Reply-To: <20190924194501.9303-1-crosa@redhat.com>
References: <20190924194501.9303-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 24 Sep 2019 19:45:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default vm provided by the test, available as self.vm, serves the
same purpose of the one obtained by self.get_vm(), but saves a line
and matches the style of other tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/x86_cpu_model_versions.py | 100 ++++++++++-----------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 5fc9ca4bc6..6eb977954d 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -25,10 +25,6 @@
 import avocado_qemu
 import re
=20
-def get_cpu_prop(vm, prop):
-    cpu_path =3D vm.command('query-cpus')[0].get('qom_path')
-    return vm.command('qom-get', path=3Dcpu_path, property=3Dprop)
-
 class X86CPUModelAliases(avocado_qemu.Test):
     """
     Validation of PC CPU model versions and CPU model aliases
@@ -241,78 +237,74 @@ class CascadelakeArchCapabilities(avocado_qemu.Test=
):
=20
     :avocado: tags=3Darch:x86_64
     """
+    def get_cpu_prop(self, prop):
+        cpu_path =3D self.vm.command('query-cpus')[0].get('qom_path')
+        return self.vm.command('qom-get', path=3Dcpu_path, property=3Dpr=
op)
+
     def test_4_1(self):
         # machine-type only:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not =
have arch-capabilities')
=20
     def test_4_0(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not =
have arch-capabilities')
=20
     def test_set_4_0(self):
         # command line must override machine-type if CPU model is not ve=
rsioned:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,+arch-capabilities')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,+arch-capabilities')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabi=
lities should have arch-capabilities')
=20
     def test_unset_4_1(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,-arch-capabilities')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,-arch-capabilities')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capab=
ilities should not have arch-capabilities')
=20
     def test_v1_4_0(self):
         # versioned CPU model overrides machine-type:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
=20
     def test_v2_4_0(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should h=
ave arch-capabilities')
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server-v2 should ha=
ve arch-capabilities')
=20
     def test_v1_set_4_0(self):
         # command line must override machine-type and versioned CPU mode=
l:
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don=
,check=3Doff,enforce=3Doff,+arch-capabilities')
-        vm.launch()
-        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-ca=
pabilities should have arch-capabilities')
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.0')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=
=3Don,check=3Doff,enforce=3Doff,+arch-capabilities')
+        self.vm.launch()
+        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-cap=
abilities should have arch-capabilities')
=20
     def test_v2_unset_4_1(self):
-        vm =3D self.get_vm()
-        vm.add_args('-S')
-        vm.set_machine('pc-i440fx-4.1')
-        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don=
,check=3Doff,enforce=3Doff,-arch-capabilities')
-        vm.launch()
-        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+        self.vm.add_args('-S')
+        self.vm.set_machine('pc-i440fx-4.1')
+        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=
=3Don,check=3Doff,enforce=3Doff,-arch-capabilities')
+        self.vm.launch()
+        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-ca=
pabilities should not have arch-capabilities')
--=20
2.21.0


