Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A635C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DCE20774
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdAOJEI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DCE20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4NI-0006XG-5X
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Kv-000462-48
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Ks-0000aV-AJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jJ4Ks-0000Z6-5y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585612853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHVRo+5quKttKHISufrwtZ6W2tw4qXG/UlwoexJS/lA=;
 b=DdAOJEI85XkwMf7tRkbv+/QY2MYmTzuN8wZg5bKM9OwhrgSTfBArUj4g9NZYGqhjSbfa7i
 FblHDwSkM96eT5lkdQ8SHXtwch6EG9cnG65Gv0jHmjjldW7cTt1LyTFF4wYyqFi6T8XmBs
 2mFD/+DjlNQDTnRScb5Z3wGnjmwH58g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-RVqs6zoONHSnwzFeZ3lopg-1; Mon, 30 Mar 2020 20:00:52 -0400
X-MC-Unique: RVqs6zoONHSnwzFeZ3lopg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DDC318A5502;
 Tue, 31 Mar 2020 00:00:51 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650D5100EBB6;
 Tue, 31 Mar 2020 00:00:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 13/14] iotests: Mark verify functions as private
Date: Mon, 30 Mar 2020 20:00:13 -0400
Message-Id: <20200331000014.11581-14-jsnow@redhat.com>
In-Reply-To: <20200331000014.11581-1-jsnow@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark the verify functions as "private" with a leading underscore, to
discourage their use. Update type signatures while we're here.

(Also, make pending patches not yet using the new entry points fail in a
very obvious way.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 21f96b35e4..fd8cb36622 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1005,7 +1005,8 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
+def _verify_image_format(supported_fmts: Sequence[str] =3D (),
+                         unsupported_fmts: Sequence[str] =3D ()) -> None:
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -1019,7 +1020,8 @@ def verify_image_format(supported_fmts=3D(), unsuppor=
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
@@ -1029,7 +1031,8 @@ def verify_protocol(supported=3D(), unsupported=3D())=
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
@@ -1037,11 +1040,11 @@ def verify_platform(supported=3D(), unsupported=3D(=
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
@@ -1169,11 +1172,11 @@ def execute_setup_common(supported_fmts: Sequence[s=
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
2.21.1


