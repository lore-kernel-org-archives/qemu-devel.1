Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885BDC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486BB20659
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tso0Pvde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486BB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RPF-0006IC-8k
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3ROZ-0005na-UT
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3ROY-00066W-S2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:24:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3ROY-00065s-NS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581888246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNIBiFBsyxAl6U20sUbxcUGuXEag6acn/Ocwxb9ZItk=;
 b=Tso0Pvdel39KSu/AkDzO99xWEZxwjDROHSr8EzJLp3r28GNgHiYi0yBgKHz6kRm4WIxxWB
 yR1b1dY2BV1VcPZNaHhhOKPcNF3aMrLrBe/44w1OLUJZa/bESks2xw9mQ1wUYO18nqBbzB
 BXdoWK+tX3tvKH+Sw2J3ADwDnFEt8Qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-X0ZQAx2YOUqd6okBXzU_Mw-1; Sun, 16 Feb 2020 16:24:00 -0500
X-MC-Unique: X0ZQAx2YOUqd6okBXzU_Mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828A91005516
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 21:23:59 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E4385DA2C;
 Sun, 16 Feb 2020 21:23:52 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:23:49 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Message-ID: <20200216212349.GC745061@lpt>
References: <20200215160716.1262-1-philmd@redhat.com>
 <20200215160716.1262-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200215160716.1262-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2020 at 05:07:15PM +0100, Philippe Mathieu-Daud=E9 wrote:
>Fix warning reported by Clang static code analyzer:
>
>    CC      tools/virtiofsd/passthrough_ll.o
>  tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to 'newfd'=
 is never read
>          newfd =3D -1;
>          ^       ~~
>  tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to 'newfd'=
 is never read
>          newfd =3D -1;
>          ^       ~~
>
>Fixes: 7c6b66027
>Reported-by: Clang Static Analyzer
>Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>---
> tools/virtiofsd/passthrough_ll.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthroug=
h_ll.c
>index e9e71d5fc2..b38e0e4d84 100644
>--- a/tools/virtiofsd/passthrough_ll.c
>+++ b/tools/virtiofsd/passthrough_ll.c
>@@ -922,7 +922,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
>     inode =3D lo_find(lo, &e->attr);
>     if (inode) {
>         close(newfd);
>-        newfd =3D -1;
>     } else {
>         inode =3D calloc(1, sizeof(struct lo_inode));
>         if (!inode) {
>@@ -938,8 +937,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
>         g_atomic_int_set(&inode->refcount, 2);
>
>         inode->nlookup =3D 1;
>-        inode->fd =3D newfd;
>-        newfd =3D -1;
>+        inode->fd =3D -1;

The functional equivalent is:
     inode->fd =3D newfd;

newfd cannot contain -1 here, as checked a few lines above:
      newfd =3D openat(dir->fd, name, O_PATH | O_NOFOLLOW);
      if (newfd =3D=3D -1) {
          goto out_err;
      }

Jano

>         inode->key.ino =3D e->attr.st_ino;
>         inode->key.dev =3D e->attr.st_dev;
>         pthread_mutex_init(&inode->plock_mutex, NULL);
>--=20
>2.21.1
>
>

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5JsuUACgkQ+YPwO/Ma
t51T8Af7BEI+53Lflz2TO8z2fjbmfdB7pSuN74SCBdcOzBCmwX5TGls+ykUHsVY2
99HPEbgBUpEDomYtipxNxMLkwMASk8q9dzM+sdAmTyxnVL0bLgyh8wl/rJ3DaOyo
UZpJRhEXVPvjGjLhPRWtX9/8bBtc00RH/Pg5E1nwdKXMJoUe63CF0Qr5sJkWVIgo
rj34mIItNHmYQDzoyT3CN6BWEqeuzFOUi0T8y6QuOqMhO+KQcgWJCcTKQyY7iu47
E8jCHL2y+v9J03SBzyFvQkL2eca7VlrmI3MAEAv7r+7vj9cBApdtzTzjXLzNscyi
RAoYQS8qOoOQ0hpIHDqRcTvuONlMZg==
=dd2Y
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--


