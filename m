Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B48B20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1xHN6im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B48B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8fd-0007Lu-IB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 12:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cP-00023T-VV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cO-0002jq-Qc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cO-0002je-N4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whY9m/n393v/4z6oCJTlCyXaViieQSRjL7N9uY3PsLg=;
 b=A1xHN6im3K8Noy1nUBLHfnrPnXsTVnyyKGnBeaE4g0T8Fs/1nYMiVOxQKOG22C87/7VinK
 CoNg3/oimfXlxZ2qRJqE+oIxvksLDwiDr1NOJyYXwvr9YyWSp/vcxCgFRzOwqS+fH2dH5l
 IOZjV7MJmX6QD4Qxh5IrHxy1KH9M3Mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-2GPKQLrXNhWu7L_D8_AbTg-1; Mon, 27 Jan 2020 12:56:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52E6D10054E3;
 Mon, 27 Jan 2020 17:56:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A8DA811FA;
 Mon, 27 Jan 2020 17:56:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/13] blockdev: fix coding style issues in drive_backup_prepare
Date: Mon, 27 Jan 2020 18:55:49 +0100
Message-Id: <20200127175559.18173-4-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2GPKQLrXNhWu7L_D8_AbTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Fix a couple of minor coding style issues in drive_backup_prepare.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 8e029e9c01..553e315972 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3620,7 +3620,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup,=
 JobTxn *txn,
=20
     if (!backup->has_format) {
         backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING ?
-                         NULL : (char*) bs->drv->format_name;
+                         NULL : (char *) bs->drv->format_name;
     }
=20
     /* Early check to avoid creating target */
@@ -3630,8 +3630,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup=
, JobTxn *txn,
=20
     flags =3D bs->open_flags | BDRV_O_RDWR;
=20
-    /* See if we have a backing HD we can use to create our new image
-     * on top of. */
+    /*
+     * See if we have a backing HD we can use to create our new image
+     * on top of.
+     */
     if (backup->sync =3D=3D MIRROR_SYNC_MODE_TOP) {
         source =3D backing_bs(bs);
         if (!source) {
--=20
2.20.1


