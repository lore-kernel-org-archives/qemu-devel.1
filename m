Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD199C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 12:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A200B205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAZ5F-0000os-Q2
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 08:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAZ41-0000NJ-B6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 08:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAZ3y-0007zE-U5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 08:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAZ3y-0007yv-PB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 08:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFE4118CB903;
 Wed, 18 Sep 2019 12:28:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-247.brq.redhat.com [10.40.204.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92B1B5D6C8;
 Wed, 18 Sep 2019 12:27:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 14:27:48 +0200
Message-Id: <20190918122748.2144-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 18 Sep 2019 12:28:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] BootLinuxSshTest: Only run the tests when
 explicitly requested
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the Avocado framework does not distinct the time spent
downloading assets vs. the time spent running a test. With big
assets (like a full VM image) the tests likely fail.

This is a limitation known by the Avocado team.
Until this issue get fixed, do not run this tests automatically.

Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
environment variable.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 134f10cac3..7200507a3a 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -12,7 +12,7 @@ import logging
 import paramiko
 import time
=20
-from avocado import skipIf
+from avocado import skipUnless
 from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
@@ -171,7 +171,7 @@ class LinuxSSH(Test):
         self.run_common_commands()
         self.shutdown_via_ssh()
=20
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
     def test_mips_malta32eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips
@@ -186,7 +186,7 @@ class LinuxSSH(Test):
=20
         self.check_mips_malta('be', kernel_path, 'mips')
=20
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
     def test_mips_malta32el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mipsel
@@ -201,7 +201,7 @@ class LinuxSSH(Test):
=20
         self.check_mips_malta('le', kernel_path, 'mips')
=20
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
     def test_mips_malta64eb_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64
@@ -215,7 +215,7 @@ class LinuxSSH(Test):
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
         self.check_mips_malta('be', kernel_path, 'mips64')
=20
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
     def test_mips_malta64el_kernel3_2_0(self):
         """
         :avocado: tags=3Darch:mips64el
--=20
2.20.1


