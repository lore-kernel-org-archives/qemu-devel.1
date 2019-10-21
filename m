Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2BCA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C0020873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETlLvDsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C0020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVMB-0006Sv-2W
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMVKI-0004CR-4C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMVKF-0001hP-Ud
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMVKD-0001f2-QY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifHsHTBcMhSqGAy591LJdMSm21J89JLOA6i3bO9Pwso=;
 b=ETlLvDspKQXhvBibm7JeztfzPnASF7z0uHFDZQkbGc3AEWZtzXB1KnxpkK0E3ISMngwdvb
 /u8zZlMznDPsIP5PsM4Up7grXQ9Yqwb2+mi5Vm9SZV2rcrdD93eHDEKCsCPkvKMikHNd+z
 IScJsogp+3YU6w+Gjw85zN004cJXPN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-8rBsMvk6NpWwA3bqoVFs8Q-1; Mon, 21 Oct 2019 06:54:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CE20107AD31;
 Mon, 21 Oct 2019 10:54:06 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4DD360BE2;
 Mon, 21 Oct 2019 10:54:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v2 1/6] iotests: remove 'linux' from default supported
 platforms
Date: Mon, 21 Oct 2019 12:53:45 +0200
Message-Id: <20191021105350.1710-2-thuth@redhat.com>
In-Reply-To: <20191021105350.1710-1-thuth@redhat.com>
References: <20191021105350.1710-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8rBsMvk6NpWwA3bqoVFs8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

verify_platform will check an explicit whitelist and blacklist instead.
The default will now be assumed to be allowed to run anywhere.

For tests that do not specify their platforms explicitly, this has the effe=
ct of
enabling these tests on non-linux platforms. For tests that always specifie=
d
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

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5373149ae1..7d6c2d3641 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -871,9 +871,14 @@ def verify_protocol(supported=3D[], unsupported=3D[]):
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
     if supported_cache_modes and (cachemode not in supported_cache_modes):
@@ -935,7 +940,8 @@ def execute_unittest(output, verbosity, debug):
                                     r'Ran \1 tests', output.getvalue()))
=20
 def execute_test(test_function=3DNone,
-                 supported_fmts=3D[], supported_oses=3D['linux'],
+                 supported_fmts=3D[],
+                 supported_platforms=3DNone,
                  supported_cache_modes=3D[], unsupported_fmts=3D[],
                  supported_protocols=3D[], unsupported_protocols=3D[]):
     """Run either unittest or script-style tests."""
@@ -952,7 +958,7 @@ def execute_test(test_function=3DNone,
     verbosity =3D 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
-    verify_platform(supported_oses)
+    verify_platform(supported=3Dsupported_platforms)
     verify_cache_mode(supported_cache_modes)
=20
     if debug:
--=20
2.18.1


