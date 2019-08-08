Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74180C32751
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45268217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45268217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvW0d-00081b-H1
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 20:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvW0D-0007Xk-15
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvW0B-00071J-QA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:09:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hvW09-0006yU-7S; Wed, 07 Aug 2019 20:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD328C05AA67;
 Thu,  8 Aug 2019 00:09:51 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E61441001925;
 Thu,  8 Aug 2019 00:09:50 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, kwolf@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
 <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
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
Message-ID: <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>
Date: Wed, 7 Aug 2019 19:09:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="75qPwd86LLsCdoPROigiwGZCK0WQTdWtm"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 08 Aug 2019 00:09:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qcow2: introduce compression type
 feature
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75qPwd86LLsCdoPROigiwGZCK0WQTdWtm
Content-Type: multipart/mixed; boundary="E0CQQAovJY1VGc88GCeDj89CPbBENzG0P";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>, kwolf@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <8f43b3ab-7c90-0965-4707-9aae1be787a0@redhat.com>
Subject: Re: [PATCH v2 1/3] qcow2: introduce compression type feature
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
 <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>
In-Reply-To: <f7f3b12c-2c04-87bc-a88f-f89a2e50bc4e@redhat.com>

--E0CQQAovJY1VGc88GCeDj89CPbBENzG0P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/7/19 6:12 PM, Max Reitz wrote:

>> =20
>> +static int check_compression_type(BDRVQcow2State *s, Error **errp)
>> +{
>> +    switch (s->compression_type) {
>> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +        break;
>> +
>> +    default:
>> +        error_setg(errp, "qcow2: unknown compression type: %u",
>> +                   s->compression_type);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    /*
>> +     * if the compression type differs from QCOW2_COMPRESSION_TYPE_ZL=
IB
>> +     * the incompatible feature flag must be set
>> +     */
>> +
>> +    if (s->compression_type !=3D QCOW2_COMPRESSION_TYPE_ZLIB &&
>> +        !(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)=
) {
>> +            error_setg(errp, "qcow2: Invalid compression type setting=
");
>> +            return -EINVAL;
>=20
> (1) Why is this block indented twice?
>=20
> (2) Do we need this at all?  Sure, it=E2=80=99s a corruption, but do we=
 need to
> reject the image because of it?

Yes, because otherwise there is a high risk of some application
misinterpreting the contents (whether an older qemu that silently
ignores unrecognized headers, and so assumes it can decode compressed
clusters with zlib even though the decode will only succeed with zstd,
or can write a compressed cluster with zlib which then causes corruption
when the newer qemu tries to read it with zstd).  The whole point of an
incompatible bit is to reject opening an image that can't be interpreted
correctly, and where writing may break later readers.

>=20
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>=20
> Overall, I don=E2=80=99t see the purpose of this function.  I don=E2=80=
=99t see any need
> to call it in qcow2_update_header().  And without =E2=80=9Cdoes non-zli=
b
> compression imply the respective incompatible flag?=E2=80=9D check, you=
 can just
> inline the rest (checking that we recognize the compression type) into
> qcow2_do_open().
>=20

Inlining may indeed be possible; the real question is whether the
function expands later in the series to the point that inlining no
longer makes sense.

>>  /* Called with s->lock held.  */
>>  static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *op=
tions,
>>                                        int flags, Error **errp)
>> @@ -1318,6 +1344,35 @@ static int coroutine_fn qcow2_do_open(BlockDriv=
erState *bs, QDict *options,
>>      s->compatible_features      =3D header.compatible_features;
>>      s->autoclear_features       =3D header.autoclear_features;
>> =20
>> +    /*
>> +     * Handle compression type
>> +     * Older qcow2 images don't contain the compression type header.
>> +     * Distinguish them by the header length and use
>> +     * the only valid (default) compression type in that case
>> +     */
>> +    if (header.header_length > offsetof(QCowHeader, compression_type)=
) {
>> +        /* sanity check that we can read a compression type */
>> +        size_t min_len =3D offsetof(QCowHeader, compression_type) +
>> +                         sizeof(header.compression_type);
>> +        if (header.header_length < min_len) {
>> +            error_setg(errp,
>> +                       "Could not read compression type."
>> +                       "qcow2 header is too short");
>=20
> This will read as =E2=80=9CCould not read compression type.qcow2 header=
 is too
> short=E2=80=9D.  There should be a space after the full stop (and the f=
ull stop
> should maybe be a comma instead).

Indeed, error_setg() should generally not contain '.'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--E0CQQAovJY1VGc88GCeDj89CPbBENzG0P--

--75qPwd86LLsCdoPROigiwGZCK0WQTdWtm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1LaE0ACgkQp6FrSiUn
Q2ouXAgAhvSf1/maWwm0ogliDr/PI5OiJAREIzk++U55vw2OQ5ImUJqTfbSKQhHL
ltw4RUV/ejXyP6SIM7FkPG9LqHDREqgP2gsvPS+780rf4rT/srpvfYmCX/ELGqgO
BPaidjCOzoGizmmDfPryDRFv2qfEYjGeK0iRwpA+0bp33Oi3jwQc4hi1+n0VPxUZ
gvXHEqtOUWlZC1DHIQ+hANtSEzQ3PdiHywyaIAsmH3bFktAvcLm0tLAjy5dK6UNf
kvZnxQQwu1iH/VH+13PaUdnVQxm3X3zExPxGnfH11raLy1RROVCTur+O0xu02CgE
GFgbx98nz/SW5c/EELC/h7oKap8ttQ==
=zx0E
-----END PGP SIGNATURE-----

--75qPwd86LLsCdoPROigiwGZCK0WQTdWtm--

