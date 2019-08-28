Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91639C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBE320856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBE320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Wd-000301-7Z
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i33kK-0000AE-E4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i33kJ-0001pP-1r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i33kI-0001p4-QX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 290EE308FC20
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 19:36:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D6260F82;
 Wed, 28 Aug 2019 19:36:38 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 15:36:28 -0400
Message-Id: <20190828193628.7687-4-crosa@redhat.com>
In-Reply-To: <20190828193628.7687-1-crosa@redhat.com>
References: <20190828193628.7687-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 28 Aug 2019 19:36:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] Acceptance test x86_cpu_model_versions:
 split into smaller tests
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The justifications being automatic destruction of the vm instances
when no longer needed and more compact test naming under a common
class.

Besides those, a smaller test makes the one and only assertion rather
obvious, which suggests that we could even get rid of the more verbose
(and manual) error messages (to be decided).

Naming of the tests tries to follow the following pattern:

 test_($cpu_version)_($no_arch_capabitilies_set_or_unset)_($machine_versi=
on)

The presence of each naming component is optional, depending on
whether the test manually sets it or not.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/x86_cpu_model_versions.py | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 220d18f68d..5fc9ca4bc6 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -234,7 +234,14 @@ class X86CPUModelAliases(avocado_qemu.Test):
=20
         self.validate_aliases(cpus)
=20
-    def test_Cascadelake_arch_capabilities_result(self):
+
+class CascadelakeArchCapabilities(avocado_qemu.Test):
+    """
+    Validation of Cascadelake arch-capabilities
+
+    :avocado: tags=3Darch:x86_64
+    """
+    def test_4_1(self):
         # machine-type only:
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -243,8 +250,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server should not =
have arch-capabilities')
-        vm.shutdown()
=20
+    def test_4_0(self):
         vm =3D self.get_vm()
         vm.add_args('-S')
         vm.set_machine('pc-i440fx-4.0')
@@ -252,8 +259,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server should not =
have arch-capabilities')
-        vm.shutdown()
=20
+    def test_set_4_0(self):
         # command line must override machine-type if CPU model is not ve=
rsioned:
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -262,8 +269,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                         'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabi=
lities should have arch-capabilities')
-        vm.shutdown()
=20
+    def test_unset_4_1(self):
         vm =3D self.get_vm()
         vm.add_args('-S')
         vm.set_machine('pc-i440fx-4.1')
@@ -271,8 +278,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.1 + Cascadelake-Server,-arch-capab=
ilities should not have arch-capabilities')
-        vm.shutdown()
=20
+    def test_v1_4_0(self):
         # versioned CPU model overrides machine-type:
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -281,8 +288,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
-        vm.shutdown()
=20
+    def test_v2_4_0(self):
         vm =3D self.get_vm()
         vm.add_args('-S')
         vm.set_machine('pc-i440fx-4.0')
@@ -290,8 +297,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v2 should h=
ave arch-capabilities')
-        vm.shutdown()
=20
+    def test_v1_set_4_0(self):
         # command line must override machine-type and versioned CPU mode=
l:
         vm =3D self.get_vm()
         vm.add_args('-S')
@@ -300,8 +307,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-ca=
pabilities should have arch-capabilities')
-        vm.shutdown()
=20
+    def test_v2_unset_4_1(self):
         vm =3D self.get_vm()
         vm.add_args('-S')
         vm.set_machine('pc-i440fx-4.1')
--=20
2.21.0


