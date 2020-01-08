Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C20BC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE12320692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBMa6WyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE12320692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCOw-0002SH-Iz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ipCNI-0000gX-DH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ipCNG-0005ob-Mr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ipCNG-0005nO-IQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvYlu68bOy1PzKkK9O/Mmhwh8vYQj/D3MzAyFSyYUnc=;
 b=DBMa6WyRZJ66TpAlUOPR7kFBY5sG6/95upa8zg2JmEKYzVym05JMdvjLk5uQtUzbybXqM8
 7IrDg8D356hJvm2RWMu8Q6cXjiCUYYR68I3fzi1uIXcR4KMPeoFiALD1NoMZ0kP5y3SwnR
 w/KDjkJrGE6iiTW1OqrvRQSX2pbnxms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-ysPRWEs5MXesGRm4f3JX-Q-1; Wed, 08 Jan 2020 09:31:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70006800D41;
 Wed,  8 Jan 2020 14:31:48 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9517A6FF0F;
 Wed,  8 Jan 2020 14:31:46 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/8] blockdev: fix coding style issues in
 drive_backup_prepare
Date: Wed,  8 Jan 2020 15:31:31 +0100
Message-Id: <20200108143138.129909-2-slp@redhat.com>
In-Reply-To: <20200108143138.129909-1-slp@redhat.com>
References: <20200108143138.129909-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ysPRWEs5MXesGRm4f3JX-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a couple of minor coding style issues in drive_backup_prepare.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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
2.23.0


