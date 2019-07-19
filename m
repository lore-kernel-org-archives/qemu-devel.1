Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D463C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7F62184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 14:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F62184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUAS-0003qb-CK
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 10:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hoUAD-0003Kl-GG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hoUAA-0005B0-Uj
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 10:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hoUA3-00056R-OL; Fri, 19 Jul 2019 10:47:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B0B5300D1C7;
 Fri, 19 Jul 2019 14:47:01 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E325D97A;
 Fri, 19 Jul 2019 14:46:58 +0000 (UTC)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716100731.29843-1-marcandre.lureau@redhat.com>
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
Message-ID: <bcad5a90-6588-79c8-1ed1-02b75fa17be6@redhat.com>
Date: Fri, 19 Jul 2019 09:46:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716100731.29843-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="huqZKFto3jaiLbruIxdMHErBnnWn1QV6k"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 19 Jul 2019 14:47:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] nbd: fix uninitialized variable warning
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--huqZKFto3jaiLbruIxdMHErBnnWn1QV6k
Content-Type: multipart/mixed; boundary="hoY9ze68Q2Ebv005dwzddoq1aMsGGUsBW";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <bcad5a90-6588-79c8-1ed1-02b75fa17be6@redhat.com>
Subject: Re: [PATCH v2] nbd: fix uninitialized variable warning
References: <20190716100731.29843-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190716100731.29843-1-marcandre.lureau@redhat.com>

--hoY9ze68Q2Ebv005dwzddoq1aMsGGUsBW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/19 5:07 AM, Marc-Andr=C3=A9 Lureau wrote:
> ../block/nbd.c: In function 'nbd_co_request':
> ../block/nbd.c:745:8: error: 'local_reply.type' may be used uninitializ=
ed in this function [-Werror=3Dmaybe-uninitialized]
>      if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
>         ^
> ../block/nbd.c:710:14: note: 'local_reply.type' was declared here
>      NBDReply local_reply;
>               ^~~~~~~~~~~
> ../block/nbd.c:710:14: error: 'local_reply.flags' may be used uninitial=
ized in this function [-Werror=3Dmaybe-uninitialized]
> ../block/nbd.c:738:8: error: 'local_reply.<U4be0>.magic' may be used un=
initialized in this function [-Werror=3Dmaybe-uninitialized]
>      if (nbd_reply_is_simple(reply) || s->quit) {
>         ^
> ../block/nbd.c:710:14: note: 'local_reply.<U4be0>.magic' was declared h=
ere
>      NBDReply local_reply;
>               ^~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Actually, since this patch didn't fix all the cases of use of an uninit
variable, I'm wondering if this one-liner would be a better patch for
the issue (that is, fix it so that nbd_co_receive_one_chunk never leaves
reply uninit, rather than chasing down which callers might need init),
and with a perk of not relying on a gcc extension:

diff --git i/block/nbd.c w/block/nbd.c
index 8d565cc624ec..f751a8e633e5 100644
--- i/block/nbd.c
+++ w/block/nbd.c
@@ -640,6 +640,7 @@ static coroutine_fn int nbd_co_receive_one_chunk(
                                           request_ret, qiov, payload,
errp);

     if (ret < 0) {
+        memset(reply, 0, sizeof *reply);
         s->quit =3D true;
     } else {
         /* For assert at loop start in nbd_connection_entry */

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hoY9ze68Q2Ebv005dwzddoq1aMsGGUsBW--

--huqZKFto3jaiLbruIxdMHErBnnWn1QV6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0x1+EACgkQp6FrSiUn
Q2rcbQf/UM/msUNIH992F/evK0MyO7iDxJDhue39H9HrRxawFIIx6m8jnL1mLDZw
ARL9IauaZaeTabzuFxpVlaOiBUrY6DnSRdlYQDxYfxlDDMAfySea611kfNwyE497
z+pUFaiMuO5KEWbJNPrEg9iO/JmiaJwJFOeOmBbesBk9rihIxB7uqP9/xxhfCucb
nvghx7fo3lBoWg0wCbrDUhRlSDLaBOnmGxqeH4lw802qApcxqvYJhfdkvYBEvkQP
GAnlos+zeu+ufalObdunBEA5jvXtp6HtsLwbw6DajW4zm12VsanhYYyJ8tfVbMqZ
mGahSOhnCjJLWrQYyh2AVyQlwDbyrA==
=O2A2
-----END PGP SIGNATURE-----

--huqZKFto3jaiLbruIxdMHErBnnWn1QV6k--

