Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798CC0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769E5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0c5L2nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769E5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0Mn-0003SQ-LR
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IQ-0004FO-3y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IO-0005Qt-N5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0IO-0005Oj-Hv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7jRjEibibgckQjO9NFz+8/WOaFK+Qeu2Tf4flFKXow=;
 b=Z0c5L2nMutKOhnw4f5wdk7emyZznxmLWgfpvWss06GXw5lvA5K4TTpKQ49PMqxC0YL4Z8W
 Tb+z7AE78I3CxRQXp7JW3KbwSCj//KFnENDuwrj8nCGdtE83M81cGenQdLGR4uEjHLqhAY
 k/2Qm8GsGFsk8Y28IIfXR5wLoLcQMzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-jqn__ZfAN-C7o3YXMeWBeQ-1; Mon, 16 Mar 2020 20:41:22 -0400
X-MC-Unique: jqn__ZfAN-C7o3YXMeWBeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F26E100550D;
 Tue, 17 Mar 2020 00:41:21 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACCF7A411;
 Tue, 17 Mar 2020 00:41:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/11] iotests: Mark verify functions as private
Date: Mon, 16 Mar 2020 20:41:04 -0400
Message-Id: <20200317004105.27059-11-jsnow@redhat.com>
In-Reply-To: <20200317004105.27059-1-jsnow@redhat.com>
References: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark the verify functions as "private" with a leading underscore, to
discourage their use.

(Also, make pending patches not yet using the new entry points fail in a
very obvious way.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ec7aa42a70..7d6cc430a4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -988,7 +988,7 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
+def _verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -1002,7 +1002,7 @@ def verify_image_format(supported_fmts=3D(), unsuppor=
ted_fmts=3D()):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
=20
-def verify_protocol(supported=3D(), unsupported=3D()):
+def _verify_protocol(supported=3D(), unsupported=3D()):
     assert not (supported and unsupported)
=20
     if 'generic' in supported:
@@ -1012,7 +1012,7 @@ def verify_protocol(supported=3D(), unsupported=3D())=
:
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported=3D(), unsupported=3D()):
+def _verify_platform(supported=3D(), unsupported=3D()):
     if any((sys.platform.startswith(x) for x in unsupported)):
         notrun('not suitable for this OS: %s' % sys.platform)
=20
@@ -1020,11 +1020,11 @@ def verify_platform(supported=3D(), unsupported=3D(=
)):
         if not any((sys.platform.startswith(x) for x in supported)):
             notrun('not suitable for this OS: %s' % sys.platform)
=20
-def verify_cache_mode(supported_cache_modes=3D()):
+def _verify_cache_mode(supported_cache_modes=3D()):
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
=20
-def verify_aio_mode(supported_aio_modes=3D()):
+def _verify_aio_mode(supported_aio_modes=3D()):
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
=20
@@ -1151,11 +1151,11 @@ def execute_setup_common(supported_fmts: Collection=
[str] =3D (),
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
2.21.1


