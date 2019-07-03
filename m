Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D794C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C42121882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C42121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hik3f-0001mb-Nb
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijgn-0005W8-Rk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijgm-00017B-JH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijgm-00016c-Ao
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 966BF44BD1;
 Wed,  3 Jul 2019 18:09:03 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C69258C9D;
 Wed,  3 Jul 2019 18:09:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:07:23 -0300
Message-Id: <20190703180726.31267-41-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 18:09:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 40/43] i386: Add Cascadelake-Server-v2 CPU
 model
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new version of Cascadelake-Server CPU model, setting
stepping=3D5 and enabling the IA32_ARCH_CAPABILITIES MSR
with some flags.

The new feature will introduce a new host software requirement,
breaking our CPU model runnability promises.  This means we can't
enable the new CPU model version by default in QEMU 4.1, because
management software isn't ready yet to resolve CPU model aliases.
This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
if "-cpu Cascadelake-Server" is specified.

Includes a test case to ensure the right combinations of
machine-type + CPU model + command-line feature flags will work
as expected.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-10-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c                          | 14 +++++
 tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9b16cffb22..0298396a91 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2343,6 +2343,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon Processor (Cascadelake)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            { .version =3D 2,
+              .props =3D (PropValue[]) {
+                  { "stepping", "5" },
+                  { "arch-capabilities", "on" },
+                  { "rdctl-no", "on" },
+                  { "ibrs-all", "on" },
+                  { "skip-l1dfl-vmentry", "on" },
+                  { /* end of list */ }
+              },
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Icelake-Client",
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index 165c0c7601..1c9fd6a56e 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -25,6 +25,10 @@
 import avocado_qemu
 import re
=20
+def get_cpu_prop(vm, prop):
+    cpu_path =3D vm.command('query-cpus')[0].get('qom_path')
+    return vm.command('qom-get', path=3Dcpu_path, property=3Dprop)
+
 class X86CPUModelAliases(avocado_qemu.Test):
     """
     Validation of PC CPU model versions and CPU model aliases
@@ -229,3 +233,72 @@ class X86CPUModelAliases(avocado_qemu.Test):
                          'qemu64-v1 must not be an alias')
=20
         self.validate_aliases(cpus)
+
+    def test_Cascadelake_arch_capabilities_result(self):
+        # machine-type only:
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server should not =
have arch-capabilities')
+
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.0 + Cascadelake-Server should not =
have arch-capabilities')
+
+        # command line must override machine-type if CPU model is not ve=
rsioned:
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,+arch-capabilities')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabi=
lities should have arch-capabilities')
+
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,-arch-capabilities')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server,-arch-capab=
ilities should not have arch-capabilities')
+
+        # versioned CPU model overrides machine-type:
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
+
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should h=
ave arch-capabilities')
+
+        # command line must override machine-type and versioned CPU mode=
l:
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,+arch-capabilities')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-ca=
pabilities should have arch-capabilities')
+
+        vm =3D self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don=
,check=3Doff,enforce=3Doff,-arch-capabilities')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-ca=
pabilities should not have arch-capabilities')
--=20
2.18.0.rc1.1.g3f1ff2140


