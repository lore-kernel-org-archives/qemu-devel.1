Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F94C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA47206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA47206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVLC-0006c2-Vl
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:33:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDVKK-0006FN-91
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDVKJ-0006j5-9h
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hDVKG-0006gw-JU; Mon, 08 Apr 2019 10:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 476E08AE47;
	Mon,  8 Apr 2019 14:32:42 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A40FD60FDF;
	Mon,  8 Apr 2019 14:32:39 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-3-eblake@redhat.com>
	<ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
	<d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
	<d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
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
Message-ID: <d14359d2-6178-eb32-c01a-b9d8e876e4ee@redhat.com>
Date: Mon, 8 Apr 2019 09:32:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 08 Apr 2019 14:32:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance
 on unaligned requests
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408143238.BBPvJNgSCiIsaF-BFHzwKX7SI1sxo8VvPiGbryoIKxY@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <d14359d2-6178-eb32-c01a-b9d8e876e4ee@redhat.com>
Subject: Re: [PATCH 2/7] nbd/server: Trace server noncompliance on unaligned
 requests
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-3-eblake@redhat.com>
 <ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
 <d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
 <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
In-Reply-To: <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 7:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.04.2019 23:04, Eric Blake wrote:
>> On 4/5/19 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.04.2019 6:05, Eric Blake wrote:
>>>> We've recently added traces for clients to flag server non-complianc=
e;
>>>> let's do the same for servers to flag client non-compliance. Accordi=
ng
>>
>> Thus, s/Trace server/Trace client/ in the subject line.
>>

>>> Patch seems correct anyway, so if you are in a hurry, it's OK as is:
>>>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>
>> Here's what I'll squash in; I think it is obvious enough to still keep=

>> your R-b, if I send the pull request before you reply back.
>>

>> @@ -2136,7 +2136,10 @@ static int nbd_co_receive_request(NBDRequestDat=
a
>> *req, NBDRequest *request,
>>            * The block layer gracefully handles unaligned requests, bu=
t
>>            * it's still worth tracing client non-compliance
>>            */
>> -
>> trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request->type));
>> +        trace_nbd_co_receive_align_compliance(nbd_cmd_lookup(request-=
>type,
>> +                                                             request-=
>from,
>> +                                                             request-=
>len,
>> +
>> client->check_align));
>=20
> something strange here with brackets.

Yeah, I grabbed the diff before compile-testing, but fixed it before
pushing to my branch.


>> +++ w/nbd/trace-events
>> @@ -71,5 +71,5 @@ nbd_co_send_extents(uint64_t handle, unsigned int
>> extents, uint32_t id, uint64_t
>>   nbd_co_send_structured_error(uint64_t handle, int err, const char
>> *errname, const char *msg) "Send structured error reply: handle =3D %"=

>> PRIu64 ", error =3D %d (%s), msg =3D '%s'"
>>   nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,
>> const char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %" =
PRIu16
>> " (%s)"
>>   nbd_co_receive_request_payload_received(uint64_t handle, uint32_t le=
n)
>> "Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
>> -nbd_co_receive_align_compliance(const char *op) "client sent
>> non-compliant unaligned %s request"
>> +nbd_co_receive_align_compliance(const char *op, uint64_t from, uint32=
_t
>> len, uint32_t align) "client sent non-compliant unaligned %s request:
>> from=3D0x%" PRIx64 ", len=3D0x%x, align=3D0x%x"
>=20
> %x or % PRIx32 - doesn't matter?

Will use PRIx32 for consistency.

>=20
>>   nbd_trip(void) "Reading request"
>>
>>
>>
>=20
> OK for me, thanks.

Thanks for a second look. Pull request will be out later today.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyrW4YACgkQp6FrSiUn
Q2rQfgf9G2Lz69PZGegesKt0WSdT1CDn9ZdrNT3X9IzjYYa0YSpI0CVAFoL/ZvQT
SmuHAPoNYgwj0+Iz9q1+cewcHmRVd0JZNerTHsaDiGCLLVYCpNCALJux2biTTB5c
syVxAQn6ZJfmYMybaDTh8YQo0cjtCGPVhdGEf03gbFA0mYQ1u7zgO7v6Ldo1rTrH
/JePakq1LzXTzm0BBDShOFBc37hJJDPZtQDDWePMNatR2PeF+aMoywbvECiSYFRX
XacsZTlt/8hTHLtU3aDUNGz//KygFl1UJOdHs3x7Y0NijrD0t7D3hnuS6Xm40HQu
DdWvltAWB6eek2NLseK6HzdQYUoCpA==
=iLCK
-----END PGP SIGNATURE-----

--d6ykUwgzIPGwnvnR9NLrYssKK7tzZ4Ntv--

