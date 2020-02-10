Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE53C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94A920863
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wg++NkWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94A920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CVd-0004OD-AY
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1CRz-00010M-Uc
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1CRx-0001j6-14
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1CRw-0001hr-S6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581354140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=joVqO0LAAtUumbvnGIQSo3huRexd8380oAt8VaQc3Hw=;
 b=Wg++NkWh22tmZ7cSX/SV2l4cw2KaA9l3FcTIE9/KHjwQRSb1WKn1bg+6WnUBI6GO7OnC4K
 mm7qFBqEHjn72navhDTaB4aCqEM+1fKy4QXt/wLEFOVGsEJukhMRFC978rbS7npkeQMtoz
 qFsakFT3jqtS2vTMH99L+51Me2IEgVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-W1wCJ2ilOye80dW2IkDznA-1; Mon, 10 Feb 2020 12:02:16 -0500
X-MC-Unique: W1wCJ2ilOye80dW2IkDznA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7E819251AE
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 17:02:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BCF25C21B;
 Mon, 10 Feb 2020 17:02:03 +0000 (UTC)
Date: Mon, 10 Feb 2020 17:02:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
Message-ID: <20200210170203.GH411895@stefanha-x1.localdomain>
References: <20200207095412.794912-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207095412.794912-1-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 10:54:11AM +0100, Laurent Vivier wrote:
> vhost-user-bridge is not a test. Move it to contrib/ and
> add it to the tools list.
>=20
> It will be built only if tools (--enable-tools) and
> vhost-user (--enable-vhost-user) are enabled (both are set
> by default).
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>=20
> Notes:
>     v2: update docs
>=20
>  Makefile                                                      | 3 +++
>  Makefile.objs                                                 | 1 +
>  configure                                                     | 3 +++
>  contrib/vhost-user-bridge/Makefile.objs                       | 1 +
>  tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c | 0
>  docs/devel/migration.rst                                      | 2 +-
>  tests/Makefile.include                                        | 1 -
>  7 files changed, 9 insertions(+), 2 deletions(-)
>  create mode 100644 contrib/vhost-user-bridge/Makefile.objs
>  rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c (=
100%)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5BjIoACgkQnKSrs4Gr
c8jHMAgAhemJJyhVkuRK/pat8SD/c5itxF8rDBiHikUVJd7ZJoBI4n6Q+nxM6hk+
/tEawq/vIHXzYaM48m+TxxiNu3mZIgAFGtc5Ygtm6eqTcE+y9zH4SVk8n4FWcp3w
+L09Jh+8HD+1ijDb9os6vvvJ1BIhz6sKJi9t8yFffRWrjJCV+0pit/T1Yyzp1HD7
gknEfrBcCZnIMrzj3Kt4toHOAS4LboEssASdpiLtvbsDhtwJ1TUmp1EOKHkMUnvV
GsQljjsIx2pAZIIO0nzgnWIFI8mmKnzQXFKftJEnfw3agaJxC3xqICs5u47zkeJd
73EC+ig60ISItcJ9UHC+uDjJ2Mx13w==
=Xfvi
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--


