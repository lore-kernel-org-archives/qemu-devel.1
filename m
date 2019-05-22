Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599BC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDA72081C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDA72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWzA-0007Df-Tl
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:33:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTWxe-0006KZ-Nl
	for qemu-devel@nongnu.org; Wed, 22 May 2019 15:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTWxW-00058M-Fd
	for qemu-devel@nongnu.org; Wed, 22 May 2019 15:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hTWxP-000523-DO; Wed, 22 May 2019 15:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5099F3083045;
	Wed, 22 May 2019 19:31:14 +0000 (UTC)
Received: from [10.3.116.19] (ovpn-116-19.phx2.redhat.com [10.3.116.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82431607B7;
	Wed, 22 May 2019 19:31:13 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190522170352.12020-1-mreitz@redhat.com>
	<6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
	<9f198134-8739-057a-47b3-52483a428080@redhat.com>
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
Message-ID: <3e169e5a-a88b-e6a6-63df-d589a37a3b7f@redhat.com>
Date: Wed, 22 May 2019 14:31:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f198134-8739-057a-47b3-52483a428080@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T2J2j7hJVKazxwJHMKYrYxEP2fjNr9aIx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 22 May 2019 19:31:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T2J2j7hJVKazxwJHMKYrYxEP2fjNr9aIx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3e169e5a-a88b-e6a6-63df-d589a37a3b7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
References: <20190522170352.12020-1-mreitz@redhat.com>
 <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
 <9f198134-8739-057a-47b3-52483a428080@redhat.com>
In-Reply-To: <9f198134-8739-057a-47b3-52483a428080@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/22/19 1:37 PM, Max Reitz wrote:

>> I don't know if there is an easy way to warn for normal users, but
>> silence the warnings if run under test setups to keep 'make check'
>> output unchanged (I know we've silenced warnings in the past when we
>> detect we are running qtest, but this isn't necessarily the same setup=
).
>>  So not a show-stopper for me.
>=20
> Hm.  That doesn=E2=80=99t sound too bad.  I don=E2=80=99t think there i=
s an easy way to
> silence the warning in qemu, but we might be able to just modify the te=
st.
>=20
> But I don=E2=80=99t even know whether the warnings are even useful or w=
hether
> they would just confuse users more than anything.  So far, every case I=

> know where loosening restrictions failed was because the file is just
> gone completely.  The only purpose of a warning is to show the user tha=
t
> qemu might have locks on the file that it doesn=E2=80=99t need, so they=
 will
> know what=E2=80=99s up if they try to open the file in another qemu ins=
tance in
> a way that should normally work but suddenly doesn=E2=80=99t.  But if t=
he file=E2=80=99s
> just gone, you can=E2=80=99t open it in another qemu, so I don=E2=80=99=
t even know
> whether there=E2=80=99s actually any point in warning.

Good point - if we unlink()ed the file, we can't loosen permissions, but
neither can anyone else open() it to collide with us :)

A network connection going down is a bit harder to justify (it might
come back up), but I think it still fits the bill (if we can't loosen
permissions, who else can interfere with us?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--T2J2j7hJVKazxwJHMKYrYxEP2fjNr9aIx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzlo4AACgkQp6FrSiUn
Q2qcIwf+N5fbnkAYDJno40DZCXtqgavlwgsgEKVEu+f/vJfE8oD+pzZg8prbBHhL
CuFjvLPzHSaawWJ05soWiHRf/T/XKGyu9lZYC0pVSNrfHgkTnC4p/4WaEA2qd6Xs
gPXJr6jfnVBhenRcu1W4ojppmDsenYGjZSDNxj1kosMAZAEKaChaYpIxW4UpBZF+
1yc4pDaM9jVhSLgJBkyRw96cqZbvM2h7937H7k4r5srlwjV625zwfNYeJgt8GJzP
AVzzMyA2vswpDcd27Y/Ufd9mVGr+wH7IyRNMOR88rYiRPFSqPAg9s3rerRZ8TkrX
Df4J8Rus9bUNl6GAJpdX8RHzlQ8O9A==
=PmCI
-----END PGP SIGNATURE-----

--T2J2j7hJVKazxwJHMKYrYxEP2fjNr9aIx--

