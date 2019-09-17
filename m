Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05847C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F62216C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F62216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iANDC-0000eI-Vo
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iANAU-0006zt-Ji
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iANAT-0003lm-7y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:45:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iANAQ-0003kL-Oq; Tue, 17 Sep 2019 19:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1FF1D30917AA;
 Tue, 17 Sep 2019 23:45:54 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82699600C4;
 Tue, 17 Sep 2019 23:45:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 19:45:45 -0400
Message-Id: <20190917234549.22910-2-jsnow@redhat.com>
In-Reply-To: <20190917234549.22910-1-jsnow@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 23:45:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 1/5] iotests: remove 'linux' from default
 supported platforms
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

verify_platform will check an explicit whitelist and blacklist instead.
The default will now be assumed to be allowed to run anywhere.

For tests that do not specify their platforms explicitly, this has the ef=
fect of
enabling these tests on non-linux platforms. For tests that always specif=
ied
linux explicitly, there is no change.

For Python tests on FreeBSD at least; only seven python tests fail:
045 147 149 169 194 199 211

045 and 149 appear to be misconfigurations,
147 and 194 are the AF_UNIX path too long error,
169 and 199 are bitmap migration bugs, and
211 is a bug that shows up on Linux platforms, too.

This is at least good evidence that these tests are not Linux-only. If
they aren't suitable for other platforms, they should be disabled on a
per-platform basis as appropriate.

Therefore, let's switch these on and deal with the failures.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..3c8c121fd5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -844,9 +844,14 @@ def verify_protocol(supported=3D[], unsupported=3D[]=
):
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported_oses=3D['linux']):
-    if True not in [sys.platform.startswith(x) for x in supported_oses]:
-        notrun('not suitable for this OS: %s' % sys.platform)
+def verify_platform(supported=3DNone, unsupported=3DNone):
+    if unsupported is not None:
+        if any((sys.platform.startswith(x) for x in unsupported)):
+            notrun('not suitable for this OS: %s' % sys.platform)
+
+    if supported is not None:
+        if not any((sys.platform.startswith(x) for x in supported)):
+            notrun('not suitable for this OS: %s' % sys.platform)
=20
 def verify_cache_mode(supported_cache_modes=3D[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes=
):
@@ -908,7 +913,8 @@ def execute_unittest(output, verbosity, debug):
                                     r'Ran \1 tests', output.getvalue()))
=20
 def execute_test(test_function=3DNone,
-                 supported_fmts=3D[], supported_oses=3D['linux'],
+                 supported_fmts=3D[],
+                 supported_platforms=3DNone,
                  supported_cache_modes=3D[], unsupported_fmts=3D[],
                  supported_protocols=3D[], unsupported_protocols=3D[]):
     """Run either unittest or script-style tests."""
@@ -925,7 +931,7 @@ def execute_test(test_function=3DNone,
     verbosity =3D 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
-    verify_platform(supported_oses)
+    verify_platform(supported=3Dsupported_platforms)
     verify_cache_mode(supported_cache_modes)
=20
     if debug:
--=20
2.21.0


