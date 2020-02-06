Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2AAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0AB217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEnN2vD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0AB217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgpP-0003SD-Vp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdK-000342-SN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdJ-0000gO-Jd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdJ-0000eb-F9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJqKDqnfNNXLC7lxEHA7EJIDSxFvBpjiZBpMeywV1Cg=;
 b=VEnN2vD3NLXYaIFpGDBadxThRvZJabmAWMFlbBVebdpGlL687mWKOod2EAUwFzlflwptR5
 jr/BpE4X3Amy11EzASWnfmD/sggLtTHjIsMrNFLpnnJca3FvALefIMtFT4j2Q0cvKEBX7g
 cibbwsJ+p6PZFjk4n8/REEa3i3H+o8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-hlkiwJT0NQu9Tpzzm05VVQ-1; Thu, 06 Feb 2020 07:51:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A03D8014DB;
 Thu,  6 Feb 2020 12:51:44 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B8E21036B25;
 Thu,  6 Feb 2020 12:51:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/17] iotests: remove 'linux' from default supported platforms
Date: Thu,  6 Feb 2020 13:51:20 +0100
Message-Id: <20200206125132.594625-6-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hlkiwJT0NQu9Tpzzm05VVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
Message-id: 20200121095205.26323-2-thuth@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 89aa2df2f3..ead04a1ab5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -931,9 +931,14 @@ def verify_protocol(supported=3D[], unsupported=3D[]):
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
@@ -1028,7 +1033,8 @@ def execute_unittest(output, verbosity, debug):
             sys.stderr.write(out)
=20
 def execute_test(test_function=3DNone,
-                 supported_fmts=3D[], supported_oses=3D['linux'],
+                 supported_fmts=3D[],
+                 supported_platforms=3DNone,
                  supported_cache_modes=3D[], supported_aio_modes=3D{},
                  unsupported_fmts=3D[], supported_protocols=3D[],
                  unsupported_protocols=3D[]):
@@ -1046,7 +1052,7 @@ def execute_test(test_function=3DNone,
     verbosity =3D 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
-    verify_platform(supported_oses)
+    verify_platform(supported=3Dsupported_platforms)
     verify_cache_mode(supported_cache_modes)
     verify_aio_mode(supported_aio_modes)
=20
--=20
2.24.1


