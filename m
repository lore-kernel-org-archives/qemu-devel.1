Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F0FC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C27D2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C27D2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6a9-000382-VI
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hw6ZP-0001s6-8k
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hw6ZO-0005IR-80
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hw6ZL-0005Gn-9D; Fri, 09 Aug 2019 11:12:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13FC83002F44;
 Fri,  9 Aug 2019 15:12:38 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C582608C2;
 Fri,  9 Aug 2019 15:12:34 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-6-vsementsov@virtuozzo.com>
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
Message-ID: <f49e0d24-4b00-0b58-6d72-a865910bc514@redhat.com>
Date: Fri, 9 Aug 2019 10:12:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618114328.55249-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pEIGa389cuGIqq2oJ5IYc1yggaLWKUoeW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 09 Aug 2019 15:12:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 5/9] block/nbd: refactor nbd connection
 parameters
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pEIGa389cuGIqq2oJ5IYc1yggaLWKUoeW
Content-Type: multipart/mixed; boundary="GTrsvRoUxEfKZzngxb2R3dn0C2OaykJct";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <f49e0d24-4b00-0b58-6d72-a865910bc514@redhat.com>
Subject: Re: [PATCH v7 5/9] block/nbd: refactor nbd connection parameters
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
 <20190618114328.55249-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190618114328.55249-6-vsementsov@virtuozzo.com>

--GTrsvRoUxEfKZzngxb2R3dn0C2OaykJct
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/18/19 6:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> We'll need some connection parameters to be available all the time to
> implement nbd reconnect. So, let's refactor them: define additional
> parameters in BDRVNBDState, drop them from function parameters, drop
> nbd_client_init and separate options parsing instead from nbd_open.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd.c | 125 +++++++++++++++++++++++++++-------------------------=

>  1 file changed, 64 insertions(+), 61 deletions(-)
>=20

> @@ -1659,20 +1630,19 @@ static int nbd_open(BlockDriverState *bs, QDict=
 *options, int flags,
>              error_setg(errp, "TLS only supported over IP sockets");
>              goto error;
>          }
> -        hostname =3D s->saddr->u.inet.host;
> +        s->hostname =3D s->saddr->u.inet.host;
>      }
> =20
> -    /* NBD handshake */
> -    ret =3D nbd_client_init(bs, s->saddr, s->export, tlscreds, hostnam=
e,
> -                          qemu_opt_get(opts, "x-dirty-bitmap"),
> -                          qemu_opt_get_number(opts, "reconnect-delay",=
 0),
> -                          errp);
> +    s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"=
));
> +    s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay"=
, 0);
> +
> +    ret =3D 0;
> =20
>   error:
> -    if (tlscreds) {
> -        object_unref(OBJECT(tlscreds));
> -    }
>      if (ret < 0) {
> +        if (s->tlscreds) {
> +            object_unref(OBJECT(s->tlscreds));
> +        }

Pre-existing, but object_unref(NULL) is safe, making this a useless 'if'.=



> @@ -1726,9 +1725,13 @@ static void nbd_close(BlockDriverState *bs)
> =20
>      nbd_client_close(bs);
> =20
> +    if (s->tlscreds) {
> +        object_unref(OBJECT(s->tlscreds));
> +    }

and copied here.

>      qapi_free_SocketAddress(s->saddr);
>      g_free(s->export);
>      g_free(s->tlscredsid);
> +    g_free(s->x_dirty_bitmap);

Do we need to duplicate s->x_dirty_bitmap with s->info.x_dirty_bitmap,
or make the latter be const char * and reuse the pointer from the former
rather than strdup'ing it? (I don't think it affects the refactoring
done in this patch, but is possibly worth a separate cleanup patch).

I can fix up the two useless 'if's.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--GTrsvRoUxEfKZzngxb2R3dn0C2OaykJct--

--pEIGa389cuGIqq2oJ5IYc1yggaLWKUoeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1NjWEACgkQp6FrSiUn
Q2rHAgf+MPpqYp7hJ7OIveFQXyJs3mHZcN6fOHtOuAHuovMl41OdD2uYIiM25kd/
Az997tH+bbiiIQXUtbSoh0dmtlQGc4JRNnr2joYKZ23FoBPL5QlwnKMLf6rfUXYq
CMucJDtgCgdXsV9KMhWMfFXq9H3B0NzYKKtiA9G7i4cZhRBaMFt7LEr4g7Gq1hz8
pabx++65W679mm0FNVi6oopKn1jT+XgQTt7yxkuXGUbt6rjkkbXogePVrZi2VjyN
2jjt3A2m36Ygd3A/N1r2J845bR2MLfvREOriRSGtHc3VuV17EPdD7oQL5zBrVcKc
1d3fFUrXJ6CwfEmxdUa68vWT9pn6kg==
=XHnK
-----END PGP SIGNATURE-----

--pEIGa389cuGIqq2oJ5IYc1yggaLWKUoeW--

