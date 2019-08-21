Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EBBC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A27322DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A27322DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0S2D-0004wG-KY
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0S1X-0004S7-Sg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0S1W-000774-Ft
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i0S1T-00073D-Mk; Wed, 21 Aug 2019 10:55:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E07FD30821BF;
 Wed, 21 Aug 2019 14:55:38 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EF0A60603;
 Wed, 21 Aug 2019 14:55:38 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190819175751.18075-1-eblake@redhat.com>
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
Message-ID: <d7e0a76e-dd3f-aa64-933a-8557afcab1c0@redhat.com>
Date: Wed, 21 Aug 2019 09:55:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819175751.18075-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5LfOEAti7TorWQ3tNcnS317bpBl8n69jK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 21 Aug 2019 14:55:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd: Tolerate more errors to structured
 reply request
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
Cc: vsementsov@virtuozzo.com, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5LfOEAti7TorWQ3tNcnS317bpBl8n69jK
Content-Type: multipart/mixed; boundary="rjRKemFedhcc1uNe4bjvY15LiJKjE3iyw";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <d7e0a76e-dd3f-aa64-933a-8557afcab1c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: Tolerate more errors to structured
 reply request
References: <20190819175751.18075-1-eblake@redhat.com>
In-Reply-To: <20190819175751.18075-1-eblake@redhat.com>

--rjRKemFedhcc1uNe4bjvY15LiJKjE3iyw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 12:57 PM, Eric Blake wrote:
> A server may have a reason to reject a request for structured replies,
> beyond just not recognizing them as a valid request.  It doesn't hurt
> us to continue talking to such a server; otherwise 'qemu-nbd --list'
> of such a server fails to display all possible details about the
> export.
>=20
> Encountered when temporarily tweaking nbdkit to reply with
> NBD_REP_ERR_POLICY.  Present since structured reply support was first
> added (commit d795299b reused starttls handling, but starttls has to
> reject all errors).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>=20

> -/* If reply represents success, return 1 without further action.
> - * If reply represents an error, consume the optional payload of
> - * the packet on ioc.  Then return 0 for unsupported (so the client
> - * can fall back to other approaches), or -1 with errp set for other
> - * errors.
> +/*
> + * If reply represents success, return 1 without further action.  If
> + * reply represents an error, consume the optional payload of the
> + * packet on ioc.  Then return 0 for unsupported (so the client can
> + * fall back to other approaches), where @strict determines if only
> + * ERR_UNSUP or all errors fit that category, or -1 with errp set for
> + * other errors.
>   */
>  static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply=
,
> -                                Error **errp)
> +                                bool strict, Error **errp)
>  {
>      char *msg =3D NULL;
> -    int result =3D -1;
> +    int result =3D strict ? -1 : 0;
>=20
>      if (!(reply->type & (1 << 31))) {
>          return 1;
> @@ -162,6 +164,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
>              error_setg(errp, "server error %" PRIu32
>                         " (%s) message is too long",
>                         reply->type, nbd_rep_lookup(reply->type));
> +            result =3D -1;
>              goto cleanup;
>          }
>          msg =3D g_malloc(reply->length + 1);
> @@ -169,6 +172,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
>              error_prepend(errp, "Failed to read option error %" PRIu32=

>                            " (%s) message: ",
>                            reply->type, nbd_rep_lookup(reply->type));
> +            result =3D -1;
>              goto cleanup;
>          }
>          msg[reply->length] =3D '\0';

Previously - nbd_handle_reply_err() left errp unchanged when returning
0, now if strict=3Dfalse and return is 0, errp may be set.

Doesn't affect callers that pass strict=3Dtrue, but...


> -static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error *=
*errp)
> +static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool st=
rict,
> +                                     Error **errp)
>  {
>      NBDOptionReply reply;
>      int error;
> @@ -562,7 +569,7 @@ static int nbd_request_simple_option(QIOChannel *io=
c, int opt, Error **errp)
>      if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
>          return -1;
>      }
> -    error =3D nbd_handle_reply_err(ioc, &reply, errp);
> +    error =3D nbd_handle_reply_err(ioc, &reply, strict, errp);
>      if (error <=3D 0) {
>          return error;
>      }

> @@ -950,7 +957,7 @@ static int nbd_start_negotiate(AioContext *aio_cont=
ext, QIOChannel *ioc,
>              if (structured_reply) {
>                  result =3D nbd_request_simple_option(ioc,
>                                                     NBD_OPT_STRUCTURED_=
REPLY,
> -                                                   errp);
> +                                                   false, errp);
>                  if (result < 0) {
>                      return -EINVAL;
>                  }

=2E..this now can leave errp set, which can wreck callers.  I'll need to
post v2.

Also, I suspect that nbd_negotiate_simple_meta_context() should consider
the use of a non-strict error check (STARTTLS is really the only case
where if the server fails with an unexpected error, we really can't
continue on with some sane fallback regardless of the error).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rjRKemFedhcc1uNe4bjvY15LiJKjE3iyw--

--5LfOEAti7TorWQ3tNcnS317bpBl8n69jK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1dW2kACgkQp6FrSiUn
Q2qmbQf9GqYguhK4tXOBZaGieWt43fbOaCEp0faMhdsP79Bm+JKbnWk+yH0cUwu+
s/VuOkklXfVt3cTLR8cVmy9PdJU/zG9DjR0vKCWqZhOIot06eyJv1AbnDJfZf7dV
EGKsNtY9LJLpFvJphG45FoKIrBndCUxIsR+XRm3qVdmt0im2R9Ko1o3PT2RtmwRg
9RqT7XmABfVIIr3GqNjQxdDHX7S1eIKefJs+C5khK3RuMLFW5+rtgvGeTMEjZ9Qx
lP74q3Ysadz3zrMWDesryeg9ENyG0HoypGxqZpO5h37JaLowODsipRM0O6Z6DvsZ
UeMpbKO9IXzQgSllP3Yl1y/l/ZO4lQ==
=Qcpl
-----END PGP SIGNATURE-----

--5LfOEAti7TorWQ3tNcnS317bpBl8n69jK--

