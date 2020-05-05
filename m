Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F6C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66F02073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCJCdH6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66F02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxJR-00013X-QL
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxA6-0001nF-Hc
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxA4-00016x-UX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eK05NuIwz2Yp0URQsMdJJWvulUGEqKMDdJ/JSnMJrSM=;
 b=XCJCdH6PfRZVtRqtBPM/9SldCHL3r1Bh9wmE0EjuP9Jf8ZULqdMgf0ZNr5C9aY7BUHnRvv
 FSZeA4oJwTbZXR2byJ6IaKevugEjOnupUiIKiLjR8up9Y6BlhyoI59X0xgF/axUlt8dT9S
 FRBcdWl/WUkhwTo8ZJjhjWXbRbRd0MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-cp1snBgVMnWygZAZuZPi_A-1; Tue, 05 May 2020 08:58:58 -0400
X-MC-Unique: cp1snBgVMnWygZAZuZPi_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC12A0C14;
 Tue,  5 May 2020 12:58:57 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D58095C1D4;
 Tue,  5 May 2020 12:58:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/24] iotests: Mark verify functions as private
Date: Tue,  5 May 2020 14:58:15 +0200
Message-Id: <20200505125826.1001451-14-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Mark the verify functions as "private" with a leading underscore, to
discourage their use. Update type signatures while we're here.

(Also, make pending patches not yet using the new entry points fail in a
very obvious way.)

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200331000014.11581-14-jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9f85e1fba3..35d8cae997 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1006,7 +1006,8 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
+def _verify_image_format(supported_fmts: Sequence[str] =3D (),
+                         unsupported_fmts: Sequence[str] =3D ()) -> None:
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -1020,7 +1021,8 @@ def verify_image_format(supported_fmts=3D(), unsuppor=
ted_fmts=3D()):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
=20
-def verify_protocol(supported=3D(), unsupported=3D()):
+def _verify_protocol(supported: Sequence[str] =3D (),
+                     unsupported: Sequence[str] =3D ()) -> None:
     assert not (supported and unsupported)
=20
     if 'generic' in supported:
@@ -1030,7 +1032,8 @@ def verify_protocol(supported=3D(), unsupported=3D())=
:
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported=3D(), unsupported=3D()):
+def _verify_platform(supported: Sequence[str] =3D (),
+                     unsupported: Sequence[str] =3D ()) -> None:
     if any((sys.platform.startswith(x) for x in unsupported)):
         notrun('not suitable for this OS: %s' % sys.platform)
=20
@@ -1038,11 +1041,11 @@ def verify_platform(supported=3D(), unsupported=3D(=
)):
         if not any((sys.platform.startswith(x) for x in supported)):
             notrun('not suitable for this OS: %s' % sys.platform)
=20
-def verify_cache_mode(supported_cache_modes=3D()):
+def _verify_cache_mode(supported_cache_modes: Sequence[str] =3D ()) -> Non=
e:
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
=20
-def verify_aio_mode(supported_aio_modes=3D()):
+def _verify_aio_mode(supported_aio_modes: Sequence[str] =3D ()):
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
=20
@@ -1170,11 +1173,11 @@ def execute_setup_common(supported_fmts: Sequence[s=
tr] =3D (),
         sys.stderr.write('Please run this test via the "check" script\n')
         sys.exit(os.EX_USAGE)
=20
-    verify_image_format(supported_fmts, unsupported_fmts)
-    verify_protocol(supported_protocols, unsupported_protocols)
-    verify_platform(supported=3Dsupported_platforms)
-    verify_cache_mode(supported_cache_modes)
-    verify_aio_mode(supported_aio_modes)
+    _verify_image_format(supported_fmts, unsupported_fmts)
+    _verify_protocol(supported_protocols, unsupported_protocols)
+    _verify_platform(supported=3Dsupported_platforms)
+    _verify_cache_mode(supported_cache_modes)
+    _verify_aio_mode(supported_aio_modes)
=20
     debug =3D '-d' in sys.argv
     if debug:
--=20
2.26.2


