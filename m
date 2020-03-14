Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A275DC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614F620776
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 13:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYU2R31V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614F620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD6nf-0004D7-Ld
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 09:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jD6n3-0003i2-Lq
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jD6n1-000621-On
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jD6n1-0005zO-Ja
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 09:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584192318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FycYQmNp/Y0y37KskpeGIGZS+QEQdxdNODFV8nVzb8=;
 b=CYU2R31VxoMqgd1n6yojqTgGghSaWFNJMqhGmscdHusOmREPCfILByw+TKD1ggJJg/gMK7
 q1SzfhYvwzEvuDmT4170KN+hHrm63kdOA4DGbJaPxXyoCaOyckt8bWY5uYaskZwJA6ppyR
 5O2nr5OsxWTZL1JU8RpKB3kkMjKIGmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-6GQvYFD7NXq45W81mL--OA-1; Sat, 14 Mar 2020 09:25:11 -0400
X-MC-Unique: 6GQvYFD7NXq45W81mL--OA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D16E107ACCC;
 Sat, 14 Mar 2020 13:25:10 +0000 (UTC)
Received: from localhost (ovpn-116-111.ams2.redhat.com [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11A8392D11;
 Sat, 14 Mar 2020 13:25:09 +0000 (UTC)
Date: Sat, 14 Mar 2020 13:25:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
Message-ID: <20200314132508.GC313613@stefanha-x1.localdomain>
References: <20200312104142.21259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200312104142.21259-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--32u276st3Jlj2kUU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=E9e wrote:
> If you like running QEMU as a normal user (very common for TCG runs)
> but you have to run virtiofsd as a root user you run into connection
> problems. Adding support for an optional --socket-group allows the
> users to keep using the command line.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v1
>   - tweak documentation and commentary
> ---
>  docs/tools/virtiofsd.rst        |  4 ++++
>  tools/virtiofsd/fuse_i.h        |  1 +
>  tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
>  tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
>  4 files changed, 29 insertions(+), 2 deletions(-)

Dan's suggestion sounds like a good idea to me.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5s2zQACgkQnKSrs4Gr
c8jpUQgApR8M8iXRNLlkR4oQeKasN0v0CbH/u45Bu0p/Lw3xm+qt4OPqDxBT7yZy
M4u9Y59b2dMNyWKf0AsTndvOrNgmBvaEfOlBZ+xFuEJHhvW+pzGOuUTD8Jx0+wZQ
oCPl/vgssGLrWwBlr7xxoLhZJvsVxi8j0HUP0lkKtrpkyNVHC42ETnHs+BKRzZam
XswF3L2OjcYACFgbj9FzBeSql+w+HiT0YjloIoj75lTeDgmlDgGVm+Fr4e9Pgwi9
F/4R2GjQbIivjr2wIWVQ7qfNjwrzfl+zr2mQTOKX80ii2PYniAz6hlrnTa4lJHd5
zDgfFtVzFBLSiI+JC6rCj63GRwpYZA==
=UgbL
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--


