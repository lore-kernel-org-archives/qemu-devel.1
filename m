Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3143C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA1C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA1C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtf8-00007R-MY
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCs72-00053T-E2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCs71-0007vY-4J
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCs6u-0007tj-Lf; Tue, 24 Sep 2019 17:12:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 525CA308AA12;
 Tue, 24 Sep 2019 21:12:35 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4B75B69A;
 Tue, 24 Sep 2019 21:12:34 +0000 (UTC)
Subject: Re: [PATCH v3 24/25] nbd: Fix error_append_hint usage
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-25-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <e417c54c-9f14-09af-7857-a62f60fe8212@redhat.com>
Date: Tue, 24 Sep 2019 16:12:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924200902.4703-25-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q8f6rSisyKwZua5d3NWKqG4sirxFPoE92"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 24 Sep 2019 21:12:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8f6rSisyKwZua5d3NWKqG4sirxFPoE92
Content-Type: multipart/mixed; boundary="sQEyhC4TlOWt3q4RuQkGvBScsxyAHummC";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-block@nongnu.org
Message-ID: <e417c54c-9f14-09af-7857-a62f60fe8212@redhat.com>
Subject: Re: [PATCH v3 24/25] nbd: Fix error_append_hint usage
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-25-vsementsov@virtuozzo.com>
In-Reply-To: <20190924200902.4703-25-vsementsov@virtuozzo.com>

--sQEyhC4TlOWt3q4RuQkGvBScsxyAHummC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 3:09 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want append hint to errp, we must use ERRP_FUNCTION_BEGIN macro.
> Otherwise hint will not be appended in case of errp =3D=3D &fatal_err
> (program will exit before error_append_hint() call). Fix such cases.
>=20

Copy-and-pasted, but if you want to tweak the grammar to all of the
patches with identical bodies:

If we want to append a hint to errp, we must use the ERRP_FUNCTION_BEGIN
macro.  Otherwise, the hint will not be appended when errp =3D=3D &fatal_=
err
(the program will exit prior to the error_append_hint() call).  Fix such
cases.

> This commit (together with its neighbors) was generated by
>=20
> git grep -l 'error_append_hint(errp' | while read f; do \
> spatch --sp-file scripts/coccinelle/fix-error_append_hint-usage.cocci \=

> --in-place $f; done
>=20
> and then
>=20
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first=

> command and then do one huge commit.
>=20
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Should the commit-per-subsystem.py script append a distinct CC: line as
long as it is already grouping files by maintainer?

>  nbd/client.c | 1 +
>  nbd/server.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

It's probably easier to take this entire series through one maintainer
(Markus, since it is error-related), than to have me pick up this patch
by itself through the NBD tree.

>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index b9dc829175..4d90a26c00 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -153,6 +153,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc=
, uint32_t opt,
>  static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply=
,
>                                  bool strict, Error **errp)
>  {
> +    ERRP_FUNCTION_BEGIN();
>      g_autofree char *msg =3D NULL;
> =20
>      if (!(reply->type & (1 << 31))) {
> diff --git a/nbd/server.c b/nbd/server.c
> index 28c3c8be85..09565ad8dc 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1616,6 +1616,7 @@ void nbd_export_close(NBDExport *exp)
> =20
>  void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error=
 **errp)
>  {
> +    ERRP_FUNCTION_BEGIN();
>      if (mode =3D=3D NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->=
clients)) {
>          nbd_export_close(exp);
>          return;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sQEyhC4TlOWt3q4RuQkGvBScsxyAHummC--

--q8f6rSisyKwZua5d3NWKqG4sirxFPoE92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KhsIACgkQp6FrSiUn
Q2of+QgAhMqS889MSuIwiFsMRgV4+Oq7lcjgsUaORpZXaSayLhkBpHzffj6NjQ6b
ZPPNHsRSRGS2bYl43DxAJHxBDA9EhzmOsG66AA79cIFXC2exmGD6vK4u9e5eb+0a
vviDKROdUhmNMGQoxuHhLD+uBStIW0dsL/6/EmZMqVhSQ59RNYJrxm/tCni6wYtD
eWOeYACxEK1QCTFpUzZSID6WYVvRSBpDDdyfhhjO0Dq9gXEfI+LQ+6UElFITWivY
gVPfMG4zNtV1viqS7jNaGQ8QsynkuLI7T0rUWs3Yd6bZwygLuFUlDDd/V1Otw6VI
BceClBW1/TxJVA0Xlh9jI2NS+QB6lg==
=0Dvi
-----END PGP SIGNATURE-----

--q8f6rSisyKwZua5d3NWKqG4sirxFPoE92--

