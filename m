Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A219C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6059E206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6059E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hznRR-0000QU-IA
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hznQh-0008Gb-KL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hznQg-0006C3-Kx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 15:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hznQe-0006BA-8l; Mon, 19 Aug 2019 15:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93C9DA38181;
 Mon, 19 Aug 2019 19:34:55 +0000 (UTC)
Received: from [10.3.117.3] (ovpn-117-3.phx2.redhat.com [10.3.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AA5450;
 Mon, 19 Aug 2019 19:34:55 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
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
Message-ID: <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>
Date: Mon, 19 Aug 2019 14:34:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819185602.4267-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yIatP1svSXok5JHcyK2vcrHVjrRNbqgnX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 19 Aug 2019 19:34:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/16] qcow2: Keep unknown extra
 snapshot data
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
--yIatP1svSXok5JHcyK2vcrHVjrRNbqgnX
Content-Type: multipart/mixed; boundary="SE5eowyH54Z7ATU3w2ugNsdyWe8HXzaTi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <85d04ded-0bf6-ab67-7af9-cc97f30ad366@redhat.com>
Subject: Re: [PATCH v2 04/16] qcow2: Keep unknown extra snapshot data
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-5-mreitz@redhat.com>

--SE5eowyH54Z7ATU3w2ugNsdyWe8HXzaTi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 1:55 PM, Max Reitz wrote:
> The qcow2 specification says to ignore unknown extra data fields in
> snapshot table entries.  Currently, we discard it whenever we update th=
e
> image, which is a bit different from "ignore".
>=20
> This patch makes the qcow2 driver keep all unknown extra data fields
> when updating an image's snapshot table.
>=20

> @@ -80,31 +80,53 @@ int qcow2_read_snapshots(BlockDriverState *bs, Erro=
r **errp)
>          sn->date_sec =3D be32_to_cpu(h.date_sec);
>          sn->date_nsec =3D be32_to_cpu(h.date_nsec);
>          sn->vm_clock_nsec =3D be64_to_cpu(h.vm_clock_nsec);
> -        extra_data_size =3D be32_to_cpu(h.extra_data_size);
> +        sn->extra_data_size =3D be32_to_cpu(h.extra_data_size);
> =20
>          id_str_size =3D be16_to_cpu(h.id_str_size);
>          name_size =3D be16_to_cpu(h.name_size);
> =20
> -        /* Read extra data */
> +        if (sn->extra_data_size > QCOW_MAX_SNAPSHOT_EXTRA_DATA) {
> +            ret =3D -EFBIG;
> +            error_setg(errp, "Too much extra metadata in snapshot tabl=
e "
> +                       "entry %i", i);
> +            goto fail;

We fail if extra_data_size is > 1024...


> +        if (sn->extra_data_size > sizeof(extra)) {
> +            /* Store unknown extra data */
> +            size_t unknown_extra_data_size =3D
> +                sn->extra_data_size - sizeof(extra);
> +

But read at most 1008 bytes into sn->unknown_extra_data.

> @@ -234,6 +257,22 @@ static int qcow2_write_snapshots(BlockDriverState =
*bs)
>          }
>          offset +=3D sizeof(extra);
> =20
> +        if (sn->extra_data_size > sizeof(extra)) {
> +            size_t unknown_extra_data_size =3D
> +                sn->extra_data_size - sizeof(extra);
> +
> +            /* qcow2_read_snapshots() ensures no unbounded allocation =
*/
> +            assert(unknown_extra_data_size <=3D BDRV_REQUEST_MAX_BYTES=
);

So this assertion is quite loose in what it permits; tighter would be

assert(unknown_extra_data_size <=3D QCOW_MAX_SNAPSHOT_EXTRA_DATA -
sizeof(extra))

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SE5eowyH54Z7ATU3w2ugNsdyWe8HXzaTi--

--yIatP1svSXok5JHcyK2vcrHVjrRNbqgnX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1a+d4ACgkQp6FrSiUn
Q2rqlggArKP87NFD3iaj1hPLzlZbdOLox2KuGHzBazi5Lmk2EtnyCYFdvfm02Dw+
TsUWwr5K4JH9BRBfMPMxCE1++dLNlnT30z2t6e4aBepQW9z4kJoOkWgY5QZrnXst
D6L/5mqT8alSl+jiu13nXwaz86O/nkbYZIkCFXoc4peMnC9vad2w9QMKZaph7Ncv
51mHbonLwInSai4bHg+hsyTnJ6rrJtHfKbVDkyoHBROLl3ge15SpvX09Y/TuZtqM
5hD1ioXxL0EgwoLzqRch0O2UxeLo47Ol6BCcUisJ7BbUIuOxeWCnUqz+2mPuEDiO
w9BwhzDsTDac+4bS3T7wjPmbFhM8nQ==
=WlJ4
-----END PGP SIGNATURE-----

--yIatP1svSXok5JHcyK2vcrHVjrRNbqgnX--

