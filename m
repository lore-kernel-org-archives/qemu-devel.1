Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F1C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3B120578
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3B120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXHA-0001oQ-D6
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1htXGd-0001K2-W3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1htXGc-000182-S1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1htXGc-00015p-Ju
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:06:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00C8A308A958
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 13:06:41 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9899110016EA;
 Fri,  2 Aug 2019 13:06:40 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190802122325.16520-1-armbru@redhat.com>
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
Message-ID: <5478e720-7d1e-a1c2-44cb-75b33f1abe15@redhat.com>
Date: Fri, 2 Aug 2019 08:06:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802122325.16520-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HP2kmzpw2SueSXyiHLOOgy75PTCdMHOwS"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 02 Aug 2019 13:06:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: Make visit_next_list()'s comment
 less confusing
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HP2kmzpw2SueSXyiHLOOgy75PTCdMHOwS
Content-Type: multipart/mixed; boundary="jb5e55zk1llZNky5T8NcTSfYib5J5ybd6";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5478e720-7d1e-a1c2-44cb-75b33f1abe15@redhat.com>
Subject: Re: [PATCH] qapi: Make visit_next_list()'s comment less confusing
References: <20190802122325.16520-1-armbru@redhat.com>
In-Reply-To: <20190802122325.16520-1-armbru@redhat.com>

--jb5e55zk1llZNky5T8NcTSfYib5J5ybd6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/2/19 7:23 AM, Markus Armbruster wrote:
> visit_next_list() returns non-null on success, null on failure.  The
> comment's phrasing "until NULL return or error occurs" is needlessly
> confusing.  Scratch the "or error occurs" part.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 5b2ed3f202..c5b23851a1 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -364,10 +364,10 @@ void visit_start_list(Visitor *v, const char *nam=
e, GenericList **list,
>   * @tail must not be NULL; on the first call, @tail is the value of
>   * *list after visit_start_list(), and on subsequent calls @tail must
>   * be the previously returned value.  Should be called in a loop until=

> - * a NULL return or error occurs; for each non-NULL return, the caller=

> - * then calls the appropriate visit_type_*() for the element type of
> - * the list, with that function's name parameter set to NULL and obj
> - * set to the address of @tail->value.
> + * a NULL return; for each non-NULL return, the caller then calls the
> + * appropriate visit_type_*() for the element type of the list, with
> + * that function's name parameter set to NULL and obj set to the
> + * address of @tail->value.
>   */
>  GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t siz=
e);
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jb5e55zk1llZNky5T8NcTSfYib5J5ybd6--

--HP2kmzpw2SueSXyiHLOOgy75PTCdMHOwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1ENV8ACgkQp6FrSiUn
Q2rJTAgApjYuCLlaweVZ2HERoal4wsZ8ZS52ZahEp21kxntyOimva2XFNEQecpmC
OCMQ+VFpCfqYSzAYo9J0RF0qfbT+6fi3wGZZoxx6wcUk/x5l01i2vAh3yfArCv0P
ZoICWommj5/54kud98Zf4NLWQEqZYHYADXf0imSxfRmS15eCwvn8rLJwGb/1BOCw
Xc21y5XGaTLXj54lkGJWsVvVqvQPB2t5FGnJeXLdMoUz1y/Wuv+mALHImwP1SPRQ
FyumKLIlQXzCICpcyOC4wLF/TCkVM8CNr2h2YxK4CWtAlJ1hj1ma9ng2qi6aNlOL
Q3b1MT5CAW4sZXJmo5khwVq/KByAnw==
=2//G
-----END PGP SIGNATURE-----

--HP2kmzpw2SueSXyiHLOOgy75PTCdMHOwS--

