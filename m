Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8057FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553152086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55457 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgexf-0002zo-MT
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgelN-0000dw-Ik
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgelM-0006xF-5Y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgelL-0006wo-Tn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3064B3084288;
 Fri, 28 Jun 2019 00:29:11 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5828600CC;
 Fri, 28 Jun 2019 00:29:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:44 -0300
Message-Id: <20190628002844.24894-10-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 28 Jun 2019 00:29:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 9/9] i386: Add Cascadelake-Server-v2 CPU
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jingqi.liu@intel.com,
 Tao Xu <tao3.xu@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Hu, Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "Lai, Paul C" <paul.c.lai@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new version of Cascadelake-Server CPU model, setting
stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR
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
---
Changes v1 -> v2:
* Enable rdctl-no, ibrs-all, skip-l1dfl-vmentry
  (Suggested by Tao Xu)

Cc: "Hu, Robert" <robert.hu@intel.com>
Cc: Tao Xu <tao3.xu@intel.com>
Cc: jingqi.liu@intel.com,
Cc: "Lai, Paul C" <paul.c.lai@intel.com>
---
 target/i386/cpu.c                          | 14 +++++
 tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 10a09c971a..570890a7dd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2343,6 +2343,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            { .version = 2,
+              .props = (PropValue[]) {
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
         .name = "Icelake-Client",
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index 165c0c7601..1c9fd6a56e 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -25,6 +25,10 @@
 import avocado_qemu
 import re
 
+def get_cpu_prop(vm, prop):
+    cpu_path = vm.command('query-cpus')[0].get('qom_path')
+    return vm.command('qom-get', path=cpu_path, property=prop)
+
 class X86CPUModelAliases(avocado_qemu.Test):
     """
     Validation of PC CPU model versions and CPU model aliases
@@ -229,3 +233,72 @@ class X86CPUModelAliases(avocado_qemu.Test):
                          'qemu64-v1 must not be an alias')
 
         self.validate_aliases(cpus)
+
+    def test_Cascadelake_arch_capabilities_result(self):
+        # machine-type only:
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server should not have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.0 + Cascadelake-Server should not have arch-capabilities')
+
+        # command line must override machine-type if CPU model is not versioned:
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,+arch-capabilities')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                        'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabilities should have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,-arch-capabilities')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
+
+        # versioned CPU model overrides machine-type:
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should not have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should have arch-capabilities')
+
+        # command line must override machine-type and versioned CPU model:
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,+arch-capabilities')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capabilities should have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=on,check=off,enforce=off,-arch-capabilities')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
-- 
2.18.0.rc1.1.g3f1ff2140


