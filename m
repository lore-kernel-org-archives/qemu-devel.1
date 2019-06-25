Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0B5C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719E120656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 05:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719E120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfdjD-000586-SX
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 01:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZQ-0007BQ-Va
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfdZP-0002ki-1y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfdZO-0002iP-8L
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 01:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61B5036899;
 Tue, 25 Jun 2019 05:00:31 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4AB3600C7;
 Tue, 25 Jun 2019 05:00:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 02:00:08 -0300
Message-Id: <20190625050008.12789-7-ehabkost@redhat.com>
In-Reply-To: <20190625050008.12789-1-ehabkost@redhat.com>
References: <20190625050008.12789-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 05:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/6] i386: Add Cascadelake-Server-4.1.1 CPU
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
stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR.

The new feature will introduce a new host software requirement,
breaking our CPU model runnability promises.  This means we can't
enable the new CPU model version by default in QEMU 4.1, because
management software isn't ready yet to resolve CPU model aliases.
This is why the feature is being enabled in a
Cascadelake-Server-4.1.1 CPU model instead of
Cascadelake-Server-4.1.

Includes a test case to ensure the right combinations of
machine-type + CPU model + command-line feature flags will work
as expected.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Hu, Robert" <robert.hu@intel.com>
Cc: Tao Xu <tao3.xu@intel.com>
Cc: jingqi.liu@intel.com,
Cc: "Lai, Paul C" <paul.c.lai@intel.com>
---
 target/i386/cpu.c                          | 15 +++++
 tests/acceptance/x86_cpu_model_versions.py | 71 ++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 121f568954..8edae04161 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2607,6 +2607,21 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
+        .versions = (X86CPUVersionDefinition[]) {
+            /*
+             * 4.1 won't have arch-capabilities enabled yet, to not break
+             * older management software
+             */
+            { .name = "4.1" },
+            { .name = "4.1.1",
+              .props = (PropValue[]) {
+                  { "stepping", "5" },
+                  { "arch-capabilities", "on" },
+                  { /* end of list */ },
+              },
+            },
+            { /* end of list */ },
+        }
     },
     {
         .name = "Icelake-Client",
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index c0660a552f..127239e2a1 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -49,6 +49,8 @@ class X86CPUModelAliases(avocado_qemu.Test):
                          'unversioned Cascadelake-Server CPU model must not be static')
         self.assertNotIn('alias-of', cpus['Cascadelake-Server'],
                          'Cascadelake-Server must not be an alias')
+        self.assertNotIn('alias-of', cpus['Cascadelake-Server-4.1'],
+                         'Cascadelake-Server-4.1 must not be an alias')
 
         self.assertFalse(cpus['qemu64']['static'],
                          'unversioned qemu64 CPU model must not be static')
@@ -100,3 +102,72 @@ class X86CPUModelAliases(avocado_qemu.Test):
                           'qemu64 must be an alias of versioned CPU model')
         self.assertNotIn('alias-of', cpus['qemu64-4.1'],
                          'qemu64-4.1 must not be an alias')
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
+        vm.add_args('-cpu', 'Cascadelake-Server-4.1,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should not have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server-4.1.1,x-force-features=on,check=off,enforce=off')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should have arch-capabilities')
+
+        # command line must override machine-type and versioned CPU model:
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.0')
+        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=on,check=off,enforce=off,+arch-capabilities')
+        vm.launch()
+        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.0 + Cascadelake-Server-4.1,+arch-capabilities should have arch-capabilities')
+
+        vm = self.get_vm()
+        vm.add_args('-S')
+        vm.set_machine('pc-i440fx-4.1')
+        vm.add_args('-cpu', 'Cascadelake-Server-4.1.1,x-force-features=on,check=off,enforce=off,-arch-capabilities')
+        vm.launch()
+        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
+                         'pc-i440fx-4.1 + Cascadelake-Server-4.1.1,-arch-capabilities should not have arch-capabilities')
-- 
2.18.0.rc1.1.g3f1ff2140


