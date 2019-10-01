Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1678C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951CE21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CE21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOGb-0004lP-BO
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7k-0004XI-P4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7g-0007lC-Om
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7Q-0007em-RJ; Tue, 01 Oct 2019 15:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A80010C094A;
 Tue,  1 Oct 2019 19:47:32 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A59395D6D0;
 Tue,  1 Oct 2019 19:47:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 06/67] iotests.py: Add image_path()
Date: Tue,  1 Oct 2019 21:46:14 +0200
Message-Id: <20191001194715.2796-7-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 19:47:32 +0000 (UTC)
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

Just like we have file_path() as an alternative to FilePath, this is an
alternative fo ImagePath.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 5be6ca674c..280e6c2ec2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -505,8 +505,12 @@ def file_path_remover():
         except OSError:
             pass
=20
+def image_path_remover():
+    for path in reversed(image_path_remover.paths):
+        remove_test_image(path)
=20
-def file_path(*names):
+
+def file_path(*names, remover=3Dfile_path_remover):
     ''' Another way to get auto-generated filename that cleans itself up=
.
=20
     Use is as simple as:
@@ -515,19 +519,22 @@ def file_path(*names):
     sock =3D file_path('socket')
     '''
=20
-    if not hasattr(file_path_remover, 'paths'):
-        file_path_remover.paths =3D []
-        atexit.register(file_path_remover)
+    if not hasattr(remover, 'paths'):
+        remover.paths =3D []
+        atexit.register(remover)
=20
     paths =3D []
     for name in names:
         filename =3D file_pattern(name)
         path =3D os.path.join(test_dir, filename)
-        file_path_remover.paths.append(path)
+        remover.paths.append(path)
         paths.append(path)
=20
     return paths[0] if len(paths) =3D=3D 1 else paths
=20
+def image_path(*names):
+    return file_path(*names, remover=3Dimage_path_remover)
+
 def remote_filename(path):
     if imgproto =3D=3D 'file':
         return path
--=20
2.21.0


