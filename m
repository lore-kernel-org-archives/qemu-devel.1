Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F4C20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F4C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSC4-0008O7-IH
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsSBe-0007wL-7V
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsSBd-0001f5-1R
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hsSBc-0001ek-Op
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:29:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E1B63082E61;
 Tue, 30 Jul 2019 13:29:04 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D2C19C65;
 Tue, 30 Jul 2019 13:28:58 +0000 (UTC)
To: piaojun <piaojun@huawei.com>, virtio-fs@redhat.com, qemu-devel@nongnu.org
References: <5D3F8F04.3030404@huawei.com>
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
Message-ID: <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
Date: Tue, 30 Jul 2019 08:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5D3F8F04.3030404@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="G4wL2rF1o6vpwhEDCMPunA4sSWwLrOu2n"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 30 Jul 2019 13:29:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
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
--G4wL2rF1o6vpwhEDCMPunA4sSWwLrOu2n
Content-Type: multipart/mixed; boundary="jySfH6if46EYLNKEEZbVY2a8IdMEQcgDX";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: piaojun <piaojun@huawei.com>, virtio-fs@redhat.com, qemu-devel@nongnu.org
Message-ID: <4ec43f2f-1d72-5fe1-3b93-2c75ee6f87b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtiofsd: fix compile error if
 'F_OFD_GETLK' not defined
References: <5D3F8F04.3030404@huawei.com>
In-Reply-To: <5D3F8F04.3030404@huawei.com>

--jySfH6if46EYLNKEEZbVY2a8IdMEQcgDX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/29/19 7:27 PM, piaojun wrote:
> Use F_GETLK for fcntl when F_OFD_GETLK not defined.

Which system are you hitting this problem on?

The problem with F_GETLK is that it is NOT as safe as F_OFD_GETLK.

We already have fcntl_op_getlk and qemu_probe_lock_ops() in util/osdep.c
to not only determine which form to use, but also to emit a warning to
the end user if we had to fall back to the unsafe F_GETLK. Why is your
code not reusing that logic?

>=20
> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  contrib/virtiofsd/passthrough_ll.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/pas=
sthrough_ll.c
> index 9ae1381..757785b 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1619,7 +1619,11 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t =
ino,
>  		return;
>  	}
>=20
> +#ifdef F_OFD_GETLK
>  	ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
> +#else
> +	ret =3D fcntl(plock->fd, F_GETLK, lock);
> +#endif

Hmm. Since this is in contrib, you are trying to compile something that
is independent of util/osdep.c (at least, I assume that's the case, as
contrib/virtiofsd/ is not even part of qemu.git master yet - in which
case, why is this not being squashed in to the patch introducing that
file, rather than sent standalone).  On the other hand, that raises the
question - who is trying to use virtiofsd on a kernel that is too old to
provid F_OFD_GETLK?  Isn't the whole point of virtiofsd to be speeding
up modern usage, at which point an old kernel is just gumming up the
works?  It seems like you are better off letting compilation fail on a
system that is too old to support decent F_OFD_GETLK, rather than
silently falling back to something that is unsafe.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jySfH6if46EYLNKEEZbVY2a8IdMEQcgDX--

--G4wL2rF1o6vpwhEDCMPunA4sSWwLrOu2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1ARhkACgkQp6FrSiUn
Q2rs9wgAqMSwVxi/vv9H+ERxszJDYt/TV+N1VBrB9Od43A61XiwxFy5gyTzp3yvn
1rUnz522LlXars9vD1wVsQYhbGgKn//UlAsJtpSZ4nwDZ+sJy2M2yHjvokveM1nM
nVmwszfYjwBsyH57a1OcKgO7POi7etJuInCBrFIjg9ZLVlqSTiXDV97MM31LB9Vr
Z6fjdHH12Za1BBhQh2yNpQmH0kzhhnXlOAyb2d1WSOMwk3bvF1QTFQNOIqiatIpL
da9FOzwBH+tqTyixNCDPuQMJ0OMExQQlItJJn/Q7C9CajY3P9MBnxx8EsCz6n74e
sjw8pQBZm1QV3OXbSKLsfp39I7GmGQ==
=m/4i
-----END PGP SIGNATURE-----

--G4wL2rF1o6vpwhEDCMPunA4sSWwLrOu2n--

