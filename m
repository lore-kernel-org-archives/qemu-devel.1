Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE7EC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7949524650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf2BqYAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7949524650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76iU-0006XA-J3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j76hY-0004pY-CR
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j76hX-0005tD-3U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j76hW-0005rd-V3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582762010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUAtYoK1mo8ZCVBHN8tRD6IeZlFlvmbrhWxQafc7JFs=;
 b=Lf2BqYAy9cokx6ufNNBUYwHvYp/9JQV0SrZfRj8hSwk8HgXb4CNn1U98pZZrm6dPsHG8KC
 fmFa4h1+hFt/fbqjnLyoNsocb9QyahoMJAVqb9bQag2BlcEr5uCtkUsEW4bfm24iC1Vc4E
 T5gzfDisN9PBG1LLqE9/AaB2NNcJBIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-yuR_qSaePYOKtOztcf64bw-1; Wed, 26 Feb 2020 19:06:48 -0500
X-MC-Unique: yuR_qSaePYOKtOztcf64bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D698800D50;
 Thu, 27 Feb 2020 00:06:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A228390;
 Thu, 27 Feb 2020 00:06:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/9] iotests: Mark verify functions as private
Date: Wed, 26 Feb 2020 19:06:35 -0500
Message-Id: <20200227000639.9644-6-jsnow@redhat.com>
In-Reply-To: <20200227000639.9644-1-jsnow@redhat.com>
References: <20200227000639.9644-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Discourage their use.

(Also, make pending patches not yet using the new entry points fail in a
very obvious way.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9eb96561b6..b02d7932fa 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -968,7 +968,7 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
+def _verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -982,7 +982,7 @@ def verify_image_format(supported_fmts=3D(), unsupporte=
d_fmts=3D()):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
=20
-def verify_protocol(supported=3D(), unsupported=3D()):
+def _verify_protocol(supported=3D(), unsupported=3D()):
     assert not (supported and unsupported)
=20
     if 'generic' in supported:
@@ -992,7 +992,7 @@ def verify_protocol(supported=3D(), unsupported=3D()):
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported=3D(), unsupported=3D()):
+def _verify_platform(supported=3D(), unsupported=3D()):
     if any((sys.platform.startswith(x) for x in unsupported)):
         notrun('not suitable for this OS: %s' % sys.platform)
=20
@@ -1000,11 +1000,11 @@ def verify_platform(supported=3D(), unsupported=3D(=
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
@@ -1126,11 +1126,11 @@ def execute_setup_common(supported_fmts: Collection=
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


