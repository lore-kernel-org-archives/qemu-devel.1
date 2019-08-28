Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8ECB22CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ECB22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34dC-0001EC-JA
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i33kG-0008WQ-EW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i33kF-0001o6-9L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i33kF-0001nm-4i
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D196C0021D7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 19:36:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6DE6107E;
 Wed, 28 Aug 2019 19:36:37 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 15:36:27 -0400
Message-Id: <20190828193628.7687-3-crosa@redhat.com>
In-Reply-To: <20190828193628.7687-1-crosa@redhat.com>
References: <20190828193628.7687-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 28 Aug 2019 19:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] Acceptance test x86_cpu_model_versions:
 fix mismatches between test and messages
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

This fixes a few mismatches between the test and the error messages
produced in case of failures.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/x86_cpu_model_versions.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
index e6c76b0d4c..220d18f68d 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -280,7 +280,7 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
         vm.launch()
         self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
+                         'pc-i440fx-4.0 + Cascadelake-Server-v1 should n=
ot have arch-capabilities')
         vm.shutdown()
=20
         vm =3D self.get_vm()
@@ -289,14 +289,14 @@ class X86CPUModelAliases(avocado_qemu.Test):
         vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3Don=
,check=3Doff,enforce=3Doff')
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server-v1 should h=
ave arch-capabilities')
+                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should h=
ave arch-capabilities')
         vm.shutdown()
=20
         # command line must override machine-type and versioned CPU mode=
l:
         vm =3D self.get_vm()
         vm.add_args('-S')
         vm.set_machine('pc-i440fx-4.0')
-        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,ch=
eck=3Doff,enforce=3Doff,+arch-capabilities')
+        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3Don=
,check=3Doff,enforce=3Doff,+arch-capabilities')
         vm.launch()
         self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
                          'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-ca=
pabilities should have arch-capabilities')
--=20
2.21.0


