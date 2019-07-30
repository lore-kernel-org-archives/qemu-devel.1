Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A23320679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A23320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXFg-0005ie-PL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 14:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsXFG-0005Dk-PO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsXFF-0008CY-Pt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsXFD-00088s-Gx; Tue, 30 Jul 2019 14:53:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 797023086272;
 Tue, 30 Jul 2019 18:53:06 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E52B1000321;
 Tue, 30 Jul 2019 18:53:05 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-7-mreitz@redhat.com>
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
Message-ID: <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>
Date: Tue, 30 Jul 2019 13:53:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="StrImInytB38eG4o56rM1JiyjxZ4jPqnH"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 30 Jul 2019 18:53:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 06/13] qcow2: Separate
 qcow2_check_read_snapshot_table()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--StrImInytB38eG4o56rM1JiyjxZ4jPqnH
Content-Type: multipart/mixed; boundary="QyqF92DyJCEA47cfK6u6LJacWjfe1ocWH";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>
Subject: Re: [PATCH for-4.2 06/13] qcow2: Separate
 qcow2_check_read_snapshot_table()
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-7-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-7-mreitz@redhat.com>

--QyqF92DyJCEA47cfK6u6LJacWjfe1ocWH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:25 PM, Max Reitz wrote:
> Reading the snapshot table can fail.  That is a problem when we want to=

> repair the image.
>=20
> Therefore, stop reading the snapshot table in qcow2_do_open() in check
> mode.  Instead, add a new function qcow2_check_read_snapshot_table()
> that reads the snapshot table at a later point.  In the future, we want=

> to handle errors here and fix them.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.h          |  4 +++
>  block/qcow2-snapshot.c | 58 ++++++++++++++++++++++++++++++++
>  block/qcow2.c          | 76 ++++++++++++++++++++++++++++++++----------=

>  3 files changed, 120 insertions(+), 18 deletions(-)
>=20

> +++ b/block/qcow2-snapshot.c
> @@ -321,6 +321,64 @@ fail:
>      return ret;
>  }
> =20
> +int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,=

> +                                                 BdrvCheckResult *resu=
lt,
> +                                                 BdrvCheckMode fix)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Error *local_err =3D NULL;
> +    int ret;
> +    struct {
> +        uint32_t nb_snapshots;
> +        uint64_t snapshots_offset;
> +    } QEMU_PACKED snapshot_table_pointer;
> +
> +    /* qcow2_do_open() discards this information in check mode */
> +    ret =3D bdrv_pread(bs->file, 60, &snapshot_table_pointer,
> +                     sizeof(snapshot_table_pointer));

Should that '60' be a named constant or offsetof() expression?  (I know,
you just copied this instance from elsewhere)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--QyqF92DyJCEA47cfK6u6LJacWjfe1ocWH--

--StrImInytB38eG4o56rM1JiyjxZ4jPqnH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AkhAACgkQp6FrSiUn
Q2pthQf/a5kMhEQraJoB2tTjdakYLxmd8AIwddYirx6RFDbUXk7DimCzd/OtuWbC
oVy+by6TCPxcqBuB1LouMn+g8qRt9RSqucX0wpntC4f0AXHpS2+D90VFbHwqawRZ
WjgWtVAUllcZL04CWK2ptfSn6qyeFW4rlZpB6K1ASoxJfRfhOoFbqkHNYE2huCPA
eW+B0G4lyyiZHeRKCo6t/4NjYqVkZ9INk77LW0csKvNGDt3hvdsNOa+/VCY9X6L5
2Syy3BRIiinhcIvoMUwnqHDKz4zlz2KZvBBc5EaWdv/EhPy+Ra0qwciqy60+uiiL
TmvQMG7np6diW+F2X7qihjxh9BvxEA==
=VuOR
-----END PGP SIGNATURE-----

--StrImInytB38eG4o56rM1JiyjxZ4jPqnH--

