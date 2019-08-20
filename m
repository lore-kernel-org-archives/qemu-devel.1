Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2228FC41514
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED31B2339D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED31B2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i07tB-0006LT-7A
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 13:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i07sW-0005lA-D6
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i07sV-0004YU-Cc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 13:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i07sS-0004Up-B3; Tue, 20 Aug 2019 13:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94BC6A4D5E;
 Tue, 20 Aug 2019 17:24:59 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E38183A5;
 Tue, 20 Aug 2019 17:24:58 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20190820164616.4072-1-dplotnikov@virtuozzo.com>
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
Message-ID: <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>
Date: Tue, 20 Aug 2019 12:24:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820164616.4072-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1tgTX5C6IXNT9Bdp1zgEizQW8oE2AM4RL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 20 Aug 2019 17:24:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10] qemu-io: add pattern file for write
 command
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1tgTX5C6IXNT9Bdp1zgEizQW8oE2AM4RL
Content-Type: multipart/mixed; boundary="luNY7QZUNr4R9r4QJTya9L8dJDxT1Xsdr";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com
Message-ID: <d1de09cd-2243-0ae8-c589-2871be826f66@redhat.com>
Subject: Re: [PATCH v10] qemu-io: add pattern file for write command
References: <20190820164616.4072-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190820164616.4072-1-dplotnikov@virtuozzo.com>

--luNY7QZUNr4R9r4QJTya9L8dJDxT1Xsdr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 11:46 AM, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

> @@ -983,8 +1057,9 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
>      /* Some compilers get confused and warn if this is not initialized=
=2E  */
>      int64_t total =3D 0;
>      int pattern =3D 0xcd;
> +    const char *file_name =3D NULL;
> =20
> -    while ((c =3D getopt(argc, argv, "bcCfnpP:quz")) !=3D -1) {
> +    while ((c =3D getopt(argc, argv, "bcCfnpP:quzs:")) !=3D -1) {

This one looks odd (I would have preserved ordering by sticking s:
between q and u).  But a maintainer could fix that.

>          switch (c) {
>          case 'b':
>              bflag =3D true;
> @@ -1020,6 +1095,10 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>          case 'z':
>              zflag =3D true;
>              break;
> +        case 's':
> +            sflag =3D true;
> +            file_name =3D optarg;
> +            break;

Likewise, sorting the cases in the same order as the getopt() listing
helps in finding code during later edits.

> @@ -1088,7 +1168,14 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>      }
> =20
>      if (!zflag) {
> -        buf =3D qemu_io_alloc(blk, count, pattern);
> +        if (sflag) {
> +            buf =3D qemu_io_alloc_from_file(blk, count, file_name);
> +            if (!buf) {
> +                return -EINVAL;
> +            }
> +        } else {
> +            buf =3D qemu_io_alloc(blk, count, pattern);
> +        }

Pre-existing, but it is odd that qemu_io_alloc() exit()s rather than
returning NULL on huge allocation requests that can't be met.  (Then
again, we have an early exit on any length > 2G, and 2G allocations tend
to succeed on modern development machines).  Perhaps it would be nice to
teach qemu-io to use blk_try_blockalign for more graceful handling even
on 32-bit platforms, but that's not the problem of your patch.

Option ordering is minor enough that I'm fine giving:

Reviewed-by: Eric Blake <eblake@redhat.com>

Now, to figure out which maintainer should take it.  Perhaps you want to
add a patch 2/1 that adds an iotest using this new mode, to a) ensure it
doesn't regress, and b) makes it reasonable to take in through the
iotest tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--luNY7QZUNr4R9r4QJTya9L8dJDxT1Xsdr--

--1tgTX5C6IXNT9Bdp1zgEizQW8oE2AM4RL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1cLOoACgkQp6FrSiUn
Q2pF7wf+JSYkMTdVYBRhPlyC4FkGPcmrs4/QUDL/hKt18YOTra5flXzeJwx3Ct69
MLXSpNdmKF3t0UWgz74/64vVftq6WF4yyNpHNxE+rLifmBiN19XIz1mifKPXBTBY
KhMqIcxqHhypxJD0Cvl1crToo7P5ZrXg78Xr0HmDVejN6fpwRokB1OlaaQYXTOEL
HfKJwidz+gGt1pIeHjQsAgnvtGblG9JpA2W1tvoP1BnUtgox6IOXMqCquIhyO2kL
llWWAs0Kn0xv9W/JfbvEkMG80riIunfsJo4SGV/2S2WyPqUM2tkjtMnuksMWS5a1
lAT7ZVcszs6E5XR2c4X+5oPlyUOcrA==
=Sc9C
-----END PGP SIGNATURE-----

--1tgTX5C6IXNT9Bdp1zgEizQW8oE2AM4RL--

