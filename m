Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B905ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F3C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOL4-00086i-QV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7l-0004YB-Ll
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7k-0007pC-97
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7a-0007hM-Sk; Tue, 01 Oct 2019 15:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB9B9308402D;
 Tue,  1 Oct 2019 19:47:38 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88496614C1;
 Tue,  1 Oct 2019 19:47:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 09/67] iotests.py: Add @hide_fields to img_info_log
Date: Tue,  1 Oct 2019 21:46:17 +0200
Message-Id: <20191001194715.2796-10-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 19:47:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You can specify fields here that should be hidden from the output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 9737dd881b..f3c80ba4e9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -201,7 +201,8 @@ def qemu_img_log(*args):
     log(result, filters=3D[filter_testfiles])
     return result
=20
-def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D[]):
+def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D[],
+                 hide_fields=3D[]):
     args =3D [ 'info' ]
     if imgopts:
         args.append('--image-opts')
@@ -210,7 +211,13 @@ def img_info_log(filename, filter_path=3DNone, imgop=
ts=3DFalse, extra_args=3D[]):
     args +=3D extra_args
     args.append(filename)
=20
-    output =3D qemu_img_pipe(*args)
+    output =3D qemu_img_pipe(*args).splitlines(keepends=3DTrue)
+
+    output =3D [line for line in output
+              if not any(line.strip().startswith(field)
+                         for field in hide_fields)]
+    output =3D ''.join(output)
+
     if not filter_path:
         filter_path =3D filename
     log(filter_img_info(output, filter_path))
--=20
2.21.0


