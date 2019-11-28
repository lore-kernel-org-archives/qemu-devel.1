Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89300C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C55C21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIyt0Pde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C55C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHN1-00007Z-Q3
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iaHF3-0003PP-8s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iaHF2-0006OL-8s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iaHF2-00067i-2z
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574937699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17RkeYDWridxywAnVAaOpHHRoXawPDSazaZNQZaZtDg=;
 b=XIyt0PdeDprQVWEBGxcbqxiOSOHzP6e6/DCqhCDa4VbfbOlIb7fkoXNLw8GrnTGAvoy5hu
 UJoBepBZ0YAV/TCqpGot0QDmXZQrgDGpe5E8dmyuAlpDVkNuOa+k44SkVDgJihkTDF1OhV
 7Rcb3J/E9Z/a2gca2jj0T9Lm5hwvz/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26--CZf_fJPNYWrt0kANaZ2RA-1; Thu, 28 Nov 2019 05:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17AC6107ACC9;
 Thu, 28 Nov 2019 10:41:37 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7922D10013A7;
 Thu, 28 Nov 2019 10:41:35 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] blockdev: fix coding style issues in
 drive_backup_prepare
Date: Thu, 28 Nov 2019 11:41:26 +0100
Message-Id: <20191128104129.250206-2-slp@redhat.com>
In-Reply-To: <20191128104129.250206-1-slp@redhat.com>
References: <20191128104129.250206-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -CZf_fJPNYWrt0kANaZ2RA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a couple of minor coding style issues in drive_backup_prepare.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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


