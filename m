Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A9EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F04207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F04207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Ers-0004n7-69
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i5Er2-00043Y-9U
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i5Er1-0004vv-74
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:52:40 -0400
Received: from kerio.kamp.de ([195.62.97.192]:51406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i5Eqy-0004sX-Ks; Tue, 03 Sep 2019 15:52:36 -0400
X-Footer: a2FtcC5kZQ==
Received: from ac2.vpn.kamp-intra.net ([172.20.250.2])
 (authenticated user pl@kamp.de) by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Tue, 3 Sep 2019 21:52:28 +0200
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <20190903145650.GO4582@localhost.localdomain>
Date: Tue, 3 Sep 2019 21:52:30 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
To: Kevin Wolf <kwolf@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH] block/nfs: add support for nfs_umount
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
Cc: ronniesahlberg@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
>=20
> Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
>> libnfs recently added support for unmounting. Add support
>> in Qemu too.
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>=20
> Looks trivial enough to review even for me. :-)
>=20
> Thanks, applied to the block branch.
>=20
> Kevin


I am not sure what the reason is, but with this patch I sometimes run =
into nfs_process_read being called for a cdrom mounted from nfs after I =
ejected it (and the whole nfs client context is already destroyed).

It seems that the following fixes the issue. It might be that the =
nfs_umount call just reveals this bug. nfs_close is also doing sync I/O =
with the libnfs library. If we mount a nfs share we are doing everything =
with sync calls and then set up the aio stuff with nfs_set_events. I =
think that we need to stop the aio before we are executing the sync =
calls to nfs_close and nfs_umount.
Also not sure if holding the mutex is necessary here.

diff --git a/block/nfs.c b/block/nfs.c
index ffa6484c1a..cb2e0d375a 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -389,6 +389,10 @@ static void nfs_attach_aio_context(BlockDriverState =
*bs,
 static void nfs_client_close(NFSClient *client)
 {
     if (client->context) {
+        qemu_mutex_lock(&client->mutex);
+        aio_set_fd_handler(client->aio_context, =
nfs_get_fd(client->context),
+                           false, NULL, NULL, NULL, NULL);
+        qemu_mutex_unlock(&client->mutex);
         if (client->fh) {
             nfs_close(client->context, client->fh);
             client->fh =3D NULL;
@@ -396,8 +400,6 @@ static void nfs_client_close(NFSClient *client)
 #ifdef LIBNFS_FEATURE_UMOUNT
         nfs_umount(client->context);
 #endif
-        aio_set_fd_handler(client->aio_context, =
nfs_get_fd(client->context),
-                           false, NULL, NULL, NULL, NULL);
         nfs_destroy_context(client->context);
         client->context =3D NULL;
     }


Peter



