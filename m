Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E82C206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E82C206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO21M-0000Sb-OQ
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:28:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rg-000830-QJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rf-00042I-U8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rd-000419-Tk; Tue, 07 May 2019 11:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E62581F11;
	Tue,  7 May 2019 15:18:41 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C38E75D9D1;
	Tue,  7 May 2019 15:18:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:16 +0200
Message-Id: <20190507151819.17401-9-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 07 May 2019 15:18:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/11] block/ssh: Implement .bdrv_dirname()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ssh_bdrv_dirname() is basically the generic bdrv_dirname(), except it
takes care not to silently chop off any query string (i.e.,
host_key_check).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Message-id: 20190225190828.17726-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 2eaeab84d5..12fd4f39e8 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1283,6 +1283,26 @@ static void ssh_refresh_filename(BlockDriverState =
*bs)
     }
 }
=20
+static char *ssh_bdrv_dirname(BlockDriverState *bs, Error **errp)
+{
+    if (qdict_haskey(bs->full_open_options, "host_key_check")) {
+        /*
+         * We cannot generate a simple prefix if we would have to
+         * append a query string.
+         */
+        error_setg(errp,
+                   "Cannot generate a base directory with host_key_check=
 set");
+        return NULL;
+    }
+
+    if (bs->exact_filename[0] =3D=3D '\0') {
+        error_setg(errp, "Cannot generate a base directory for this ssh =
node");
+        return NULL;
+    }
+
+    return path_combine(bs->exact_filename, "");
+}
+
 static const char *const ssh_strong_runtime_opts[] =3D {
     "host",
     "port",
@@ -1310,6 +1330,7 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_co_truncate             =3D ssh_co_truncate,
     .bdrv_co_flush_to_disk        =3D ssh_co_flush,
     .bdrv_refresh_filename        =3D ssh_refresh_filename,
+    .bdrv_dirname                 =3D ssh_bdrv_dirname,
     .create_opts                  =3D &ssh_create_opts,
     .strong_runtime_opts          =3D ssh_strong_runtime_opts,
 };
--=20
2.20.1


