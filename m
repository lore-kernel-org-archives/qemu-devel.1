Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EEBC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B992133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B992133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPRR-00029z-I2
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9o-0006ra-AR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9m-0000Xj-LJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9j-0000W7-Fv; Tue, 01 Oct 2019 15:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B921630715F9;
 Tue,  1 Oct 2019 19:49:54 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53D4819C6A;
 Tue,  1 Oct 2019 19:49:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 67/67] iotests.py: Drop qemu_img_log(), qemu_img_create()
Date: Tue,  1 Oct 2019 21:47:15 +0200
Message-Id: <20191001194715.2796-68-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 01 Oct 2019 19:49:54 +0000 (UTC)
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

They are both unused now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 2e377b8379..2476f3744a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -111,25 +111,6 @@ def ordered_qmp(qmsg, conv_keys=3DTrue):
         return od
     return qmsg
=20
-def qemu_img_create(*args):
-    args =3D list(args)
-
-    # default luks support
-    if '-f' in args and args[args.index('-f') + 1] =3D=3D 'luks':
-        if '-o' in args:
-            i =3D args.index('-o')
-            if 'key-secret' not in args[i + 1]:
-                args[i + 1].append(luks_default_key_secret_opt)
-                args.insert(i + 2, '--object')
-                args.insert(i + 3, luks_default_secret_object)
-        else:
-            args =3D ['-o', luks_default_key_secret_opt,
-                    '--object', luks_default_secret_object] + args
-
-    args.insert(0, 'create')
-
-    return qemu_img(*args)
-
 def create_test_image(filename, size=3DNone, fmt=3Dimgfmt, opts=3D[],
                       backing_file=3DNone, backing_fmt=3DNone,
                       objects=3D[], unsafe=3DFalse):
@@ -216,11 +197,6 @@ def qemu_img_pipe(*args):
                          (-exitcode, ' '.join(qemu_img_args + args)))
     return subp.communicate()[0]
=20
-def qemu_img_log(*args):
-    result =3D qemu_img_pipe(*args)
-    log(result, filters=3D[filter_testfiles])
-    return result
-
 def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D[],
                  hide_fields=3D[]):
     args =3D [ 'info' ]
--=20
2.21.0


