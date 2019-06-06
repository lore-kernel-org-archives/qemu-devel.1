Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C1EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F9E206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F9E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ00p-0001ju-Bv
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu9-00064z-9B
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziZ-00087N-G4
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziZ-00086Q-9R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E40D308A951;
 Thu,  6 Jun 2019 21:14:26 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7D1108F83B;
 Thu,  6 Jun 2019 21:14:25 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:10 -0400
Message-Id: <20190606211414.8681-4-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 06 Jun 2019 21:14:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 3/7] Acceptance tests: add the build
 directory to the system PATH
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
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So that when binaries such as qemu-img are searched for, those in the
build tree will be favored.  As a clarification, SRC_ROOT_DIR is
dependent on the location from where tests are executed, so they are
equal to the build directory if one is being used.

The original motivation is that Avocado libraries such as
avocado.utils.vmimage.get() may use the matching binaries, but it may
also apply to any other binary that test code may eventually attempt
to execute.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index ac59d36a4c..47c57a9221 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -52,6 +52,12 @@ def pick_default_qemu_bin(arch=3DNone):
=20
 class Test(avocado.Test):
     def setUp(self):
+        # Some utility code uses binaries from the system's PATH.  For
+        # instance, avocado.utils.vmimage.get() uses qemu-img, to
+        # create a snapshot image.  This is a transparent way of
+        # making sure those utilities find and use binaries on the
+        # build tree by default.
+        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PATH=
'])
         self._vms =3D {}
         arches =3D self.tags.get('arch', [])
         if len(arches) =3D=3D 1:
--=20
2.21.0


