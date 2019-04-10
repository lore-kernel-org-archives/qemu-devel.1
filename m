Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB34C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78A32077C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35588 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHsO-0000q0-My
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:23:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHrZ-0000Us-Gu
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHrX-00043u-Ni
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:22:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hEHrS-00041W-UL; Wed, 10 Apr 2019 14:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDE623019885;
	Wed, 10 Apr 2019 18:22:13 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1905D719;
	Wed, 10 Apr 2019 18:22:10 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190409210655.777-1-jsnow@redhat.com>
	<87y34i2zbt.fsf@dusky.pond.sub.org>
	<3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
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
Message-ID: <e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
Date: Wed, 10 Apr 2019 13:22:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 10 Apr 2019 18:22:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410182209.Axp02bCElcR_4zKhumxJRLxKb7UR2y0lCKizzwJhqYE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
References: <20190409210655.777-1-jsnow@redhat.com>
 <87y34i2zbt.fsf@dusky.pond.sub.org>
 <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
In-Reply-To: <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 12:37 PM, John Snow wrote:
>=20
>=20
> On 4/10/19 1:39 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> It turns out that having options listed in three places continues to =
be
>>> a bad idea. I'm still toying with the idea of an improved infrastruct=
ure
>>> here, but in the meantime, another bandaid.
>>>

>>
>> Nice to have in 4.0.
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>=20
> If it can go in for 4.0, who stages it? Kevin?

At this point, we've missed -rc3; the fix on its own is not a
release-blocker, but if something else comes up that requires -rc4 for
an actual release blocker, we can sort out someone sending a pull
request for this one at the same time. (I'm aware of a couple of iotest
fixups in the same boat... Guess it's time to start updating the wiki to
point to email threads where we document 'wish list' patches)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuNFEACgkQp6FrSiUn
Q2o5xwf9EtKJgQbBEnV7buNM89Z7a3lLWfW1GhWFEiNt61BGcMG2WqlsQGTbvbP9
hY1i4+KUDaAhJ11YeyZvIUS5jV6wzhFl+MoS2wlZ3v++g4aisUm9ll04JXpzpyrX
UDLpOTXLWUSpavX8z1UV+Rj3FU4csTfRQmA7iiDjnTAqYRZ2i+rvvHhr5lwCoj+b
mUO3Taavdhi6uONirYyHnvabBnT0Hzj5UgGXW8ybL1A5c9iC8PpcC5R6iYoIBZn/
gYj6HVIHQT5xiLxdQW7hMuTUnuNsyOFq3yiBsle8tWimQiES/AN2GaaksSGcrtyn
6Q28QFRgi9+4sR89zOPAiycHj6bDrA==
=hLYg
-----END PGP SIGNATURE-----

--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ--

