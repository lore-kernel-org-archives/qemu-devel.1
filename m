Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC143C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DB52146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqre-0002UB-Ad
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCqkV-0005D9-DD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCqkU-0004TL-5c
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCqkT-0004SS-V7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1A44859FB;
 Tue, 24 Sep 2019 19:45:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-0.rdu2.redhat.com
 [10.10.121.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE85761F21;
 Tue, 24 Sep 2019 19:45:19 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] Acceptance tests: introduce utility method for tags
 unique vals
Date: Tue, 24 Sep 2019 15:45:00 -0400
Message-Id: <20190924194501.9303-3-crosa@redhat.com>
In-Reply-To: <20190924194501.9303-1-crosa@redhat.com>
References: <20190924194501.9303-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 24 Sep 2019 19:45:20 +0000 (UTC)
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

Currently a test can describe the target architecture binary that it
should primarily be run with, be setting a single tag value.

The same approach is expected to be done with other QEMU aspects to be
tested, for instance, the machine type and accelerator, so let's
generalize the logic into a utility method.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index bd41e0443c..02775bafcf 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -54,14 +54,21 @@ def pick_default_qemu_bin(arch=3DNone):
=20
=20
 class Test(avocado.Test):
+    def _get_unique_tag_val(self, tag_name):
+        """
+        Gets a tag value, if unique for a key
+        """
+        vals =3D self.tags.get(tag_name, [])
+        if len(vals) =3D=3D 1:
+            return vals.pop()
+        return None
+
     def setUp(self):
         self._vms =3D {}
-        arches =3D self.tags.get('arch', [])
-        if len(arches) =3D=3D 1:
-            arch =3D arches.pop()
-        else:
-            arch =3D None
-        self.arch =3D self.params.get('arch', default=3Darch)
+
+        self.arch =3D self.params.get('arch',
+                                    default=3Dself._get_unique_tag_val('=
arch'))
+
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
--=20
2.21.0


