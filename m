Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E74ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FBE20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnThgWja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FBE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP43d-000462-F9
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vx-0001dl-Eg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vw-0001Ow-6Z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vw-0001Ol-3F
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxpTgjhe4LBYsfVnIw1qeVBA6HbE1S152Eb+XejyuR8=;
 b=QnThgWjaCY0b2a5SNv/ke5ueza8CLpaIC7hz8OTaADTFgv9Ksil2oKS7IVHrCTvgldjDBg
 DBDdGwja5fBHgJCFzCxVk9h5z+ft8WJmcRURksA+oOG0vsowftFLzu2c00eF7P0zdfhf3W
 5Oe1hitaALNEgrX34OvwzvrULPyP+Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-dCOJTIVOO7We15riUcbxEg-1; Mon, 28 Oct 2019 08:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23ED180496E;
 Mon, 28 Oct 2019 12:15:34 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7433F100194E;
 Mon, 28 Oct 2019 12:15:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/69] iotests.py: Add @base_dir to FilePaths etc.
Date: Mon, 28 Oct 2019 13:14:07 +0100
Message-Id: <20191028121501.15279-16-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: dCOJTIVOO7We15riUcbxEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Specifying this optional parameter allows creating temporary files in
other directories than the test_dir; for example in sock_dir.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9bfcef1f14..075f4739da 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -386,10 +386,10 @@ class FilePaths(object):
             qemu_img('create', img_path, '1G')
         # migration_sock_path is automatically deleted
     """
-    def __init__(self, names):
+    def __init__(self, names, base_dir=3Dtest_dir):
         self.paths =3D []
         for name in names:
-            self.paths.append(os.path.join(test_dir, file_pattern(name)))
+            self.paths.append(os.path.join(base_dir, file_pattern(name)))
=20
     def __enter__(self):
         return self.paths
@@ -406,8 +406,8 @@ class FilePath(FilePaths):
     """
     FilePath is a specialization of FilePaths that takes a single filename=
.
     """
-    def __init__(self, name):
-        super(FilePath, self).__init__([name])
+    def __init__(self, name, base_dir=3Dtest_dir):
+        super(FilePath, self).__init__([name], base_dir)
=20
     def __enter__(self):
         return self.paths[0]
@@ -420,7 +420,7 @@ def file_path_remover():
             pass
=20
=20
-def file_path(*names):
+def file_path(*names, base_dir=3Dtest_dir):
     ''' Another way to get auto-generated filename that cleans itself up.
=20
     Use is as simple as:
@@ -436,7 +436,7 @@ def file_path(*names):
     paths =3D []
     for name in names:
         filename =3D file_pattern(name)
-        path =3D os.path.join(test_dir, filename)
+        path =3D os.path.join(base_dir, filename)
         file_path_remover.paths.append(path)
         paths.append(path)
=20
--=20
2.21.0


