Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD94C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:36:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253F9206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253F9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5p3-0002TI-FG
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hs5ob-0001vH-4y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hs5oZ-0006DU-Rb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hs5oX-0006AU-6T; Mon, 29 Jul 2019 09:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 853A93082141;
 Mon, 29 Jul 2019 13:35:43 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF1C5D70D;
 Mon, 29 Jul 2019 13:35:39 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190729105343.19250-1-kwolf@redhat.com>
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
Message-ID: <816934c1-419d-10c0-4b13-c6304e832cbb@redhat.com>
Date: Mon, 29 Jul 2019 08:35:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729105343.19250-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xbXoJAgpa9inZuxHGvlaKP0a2s1u570VO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 13:35:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] block/copy-on-read: Fix
 permissions for inactive node
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xbXoJAgpa9inZuxHGvlaKP0a2s1u570VO
Content-Type: multipart/mixed; boundary="Rtgieef7EMHoe5cFD0WzctcmFul8vv4uD";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <816934c1-419d-10c0-4b13-c6304e832cbb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] block/copy-on-read: Fix permissions
 for inactive node
References: <20190729105343.19250-1-kwolf@redhat.com>
In-Reply-To: <20190729105343.19250-1-kwolf@redhat.com>

--Rtgieef7EMHoe5cFD0WzctcmFul8vv4uD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/29/19 5:53 AM, Kevin Wolf wrote:
> The copy-on-read drive must not request the WRITE_UNCHANGED permission
> for its child if the node is inactive, otherwise starting a migration
> destination with -incoming will fail because the child cannot provide
> write access yet:
>=20
>   qemu-system-x86_64: -blockdev copy-on-read,file=3Dimg,node-name=3Dcor=
: Block node is read-only
>=20
> Earlier QEMU versions additionally ran into an abort() on the migration=

> source side: bdrv_inactivate_recurse() failed to update permissions.
> This is silently ignored today because it was only supposed to loosen
> restrictions. This is the symptom that was originally reported here:
>=20
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1733022
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/copy-on-read.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Do any of the iotests cover this?  Should they, especially if you are
trying to get this in for -rc3 tomorrow?

>=20
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 22f24fd0db..6631f30205 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -56,16 +56,14 @@ static void cor_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
>                             uint64_t perm, uint64_t shared,
>                             uint64_t *nperm, uint64_t *nshared)
>  {
> -    if (c =3D=3D NULL) {
> -        *nperm =3D (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANGE=
D;
> -        *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> -        return;
> -    }
> +    *nperm =3D perm & PERM_PASSTHROUGH;
> +    *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
> =20
> -    *nperm =3D (perm & PERM_PASSTHROUGH) |
> -             (c->perm & PERM_UNCHANGED);
> -    *nshared =3D (shared & PERM_PASSTHROUGH) |
> -               (c->shared_perm & PERM_UNCHANGED);

The old code unconditionally returned one set of permissions when c =3D=3D=

NULL, or made a choice based on c's existing permissions on whether to
pass in those two bits.

> +    /* We must not request write permissions for an inactive node, the=
 child
> +     * cannot provide it. */
> +    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
> +        *nperm |=3D BLK_PERM_WRITE_UNCHANGED;
> +    }

The new code changes the condition for or'ing in WRITE_UNCHANGED to
*nperm (it is no longer dependent on whether c =3D=3D NULL, but whether t=
he
drive is inactive), which matches your commit message.

But the new code also changes to always pass in the PERM_UNCHANGED to
*nshared; that used to be skipped if c was non-NULL and did not already
have the permission.  I don't follow that change from the commit
message, am I missing something?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Rtgieef7EMHoe5cFD0WzctcmFul8vv4uD--

--xbXoJAgpa9inZuxHGvlaKP0a2s1u570VO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0+9ioACgkQp6FrSiUn
Q2rptAgAnBECWiJ/VeCE7wWPDbcBdoCItz73oBkBfhvHQ/fncfGJhDaBmq2vND9o
ECduT3qW/F9sXmAg2CM4i/KzNpgKu1vbuOQF1Ls4/AW4eWjG4S2Jq30pZoQbHRHN
7VdOyBuJPaBRK/ALFV/JhsnKBMgugYxk0Q/vDIUtPs/kJujZNeRUtYMs5jkjKqYx
IdtxQfFytt5f6l57oozE3l0qaibKpAKYayvR4CeJLcFyzJmcr7fFCWU0K8Ybc9yQ
KABA3pcQs3f2m5wvT5/kAVugLZDCFn4EMJ9i7XDGL4QaGcwqJsre+c9eU4UsDcc9
JmQSEcsUSfmejig1u8V+zirnulLasg==
=yLbk
-----END PGP SIGNATURE-----

--xbXoJAgpa9inZuxHGvlaKP0a2s1u570VO--

