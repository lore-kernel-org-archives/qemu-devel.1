Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B9C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985612146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985612146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFDa-0005VM-1t
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEy7-0006ux-RC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDEy1-0006qW-4t
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDExh-0006f9-Eb; Wed, 25 Sep 2019 17:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18B3E85540;
 Wed, 25 Sep 2019 21:36:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2E819C5B;
 Wed, 25 Sep 2019 21:36:30 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/13] LUKS: better error message when creating too large
 files
Date: Thu, 26 Sep 2019 00:35:27 +0300
Message-Id: <20190925213527.9117-14-mlevitsk@redhat.com>
In-Reply-To: <20190925213527.9117-1-mlevitsk@redhat.com>
References: <20190925213527.9117-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 25 Sep 2019 21:36:33 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently if you attampt to create too large file with luks you
get the following error message:

Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Dsec=
0
qemu-img: test.luks: Could not resize file: File too large

While for raw format the error message is
qemu-img: test.img: The image size is too large for file format 'raw'


The reason for this is that qemu-img checks for errono of the failure,
and presents the later error when it is -EFBIG

However crypto generic code 'swallows' the errno and replaces it
with -EIO.

As an attempt to make it better, we can make luks driver,
detect -EFBIG and in this case present a better error message,
which is what this patch does

The new error message is:

qemu-img: error creating test.luks: The requested file size is too large

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6e822c6e50..19c2ac602c 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -102,10 +102,12 @@ static ssize_t block_crypto_create_init_func(QCrypt=
oBlock *block,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data =3D opaque;
+    Error *local_error =3D NULL;
+    int ret;
=20
     if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
-        error_setg(errp, "The requested file size is too large");
-        return -EFBIG;
+        ret =3D -EFBIG;
+        goto error;
     }
=20
     /*
@@ -115,6 +117,21 @@ static ssize_t block_crypto_create_init_func(QCrypto=
Block *block,
      */
     return blk_truncate(data->blk, data->size + headerlen, data->preallo=
c,
                         errp);
+
+    if (ret >=3D 0) {
+        return ret;
+    }
+
+error:
+    if (ret =3D=3D -EFBIG) {
+        /* Replace the error message with a better one */
+        error_free(local_error);
+        error_setg(errp, "The requested file size is too large");
+    } else {
+        error_propagate(errp, local_error);
+    }
+
+    return ret;
 }
=20
=20
--=20
2.17.2


