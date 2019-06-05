Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B83C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EA52083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EA52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYbAg-0007sy-6h
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:02:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYb9m-0007Vy-0S
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYb9k-0007WH-1N
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hYb9c-0007L1-DO; Wed, 05 Jun 2019 15:00:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C2013086202;
	Wed,  5 Jun 2019 19:00:50 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 591905D9D6;
	Wed,  5 Jun 2019 19:00:47 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
	<87mun8jddk.fsf@dusky.pond.sub.org>
	<4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
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
Message-ID: <325f9894-89d2-c267-9d8c-90df62a28b20@redhat.com>
Date: Wed, 5 Jun 2019 14:00:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pnLpJJxUogGeZP16Cbs4FYF96n7cQqeZq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 05 Jun 2019 19:00:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pnLpJJxUogGeZP16Cbs4FYF96n7cQqeZq
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <325f9894-89d2-c267-9d8c-90df62a28b20@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-2-mreitz@redhat.com>
 <87mun8jddk.fsf@dusky.pond.sub.org>
 <4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
In-Reply-To: <4f75a6e9-5f5b-9161-cbb0-91c8034a7abc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 12:21 PM, Max Reitz wrote:
> On 07.02.19 07:56, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>>
>>> This patch allows specifying a discriminator that is an optional memb=
er
>>> of the base struct.  In such a case, a default value must be provided=

>>> that is used when no value is given.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---

>>> +++ b/qapi/introspect.json
>>> @@ -168,6 +168,13 @@
>>>  # @tag: the name of the member serving as type tag.
>>>  #       An element of @members with this name must exist.
>>>  #
>>> +# @default-variant: if the @tag element of @members is optional, thi=
s
>>> +#                   is the default value for choosing a variant.  It=
s
>>> +#                   value will be a valid value for @tag.
>>> +#                   Present exactly when @tag is present and the
>>> +#                   associated element of @members is optional.
>>> +#                   (Since: 4.0)
>>> +#
>>>  # @variants: variant members, i.e. additional members that
>>>  #            depend on the type tag's value.  Present exactly when
>>>  #            @tag is present.  The variants are in no particular ord=
er,
>>> @@ -181,6 +188,7 @@
>>>  { 'struct': 'SchemaInfoObject',
>>>    'data': { 'members': [ 'SchemaInfoObjectMember' ],
>>>              '*tag': 'str',
>>> +            '*default-variant': 'str',
>>>              '*variants': [ 'SchemaInfoObjectVariant' ] } }
>>> =20
>>>  ##
>>
>> I'm afraid this could become awkward later on.  Let me explain.
>>
>> In many programming languages, absent optional arguments / members
>> default to a default value specified in the declaration.  Simple.
>>
>> In others, 'absent' is effectively an additional value.  The code
>> consuming the argument / member can interpret 'absent' however it want=
s.
>> It may eliminate the additional value by mapping it to a default value=
,
>> but it can also interpret 'absent' unlike any value.  If there's more
>> than one consumer, their interpretations need not be consistent.  The
>> declaration provides no clue on semantics of 'absent'.
>>
>> QAPI is in the latter camp.  I trust you can already sense how much I
>> like that.
>>
>> Now you want to permit optional variant discriminators.  As per genera=
l
>> rule, their interpretation is left to the code consuming it.  One
>> instance of such code is the generated union visitor, which needs to
>> decide which variant to visit.  Your default-variant tells it which
>> variant to visit.  Other code interpreting the discriminator better be=

>> consistent with that, but that's the other code's problem.  Hmm.
>>
>> If I could go back in time, I'd flip QAPI to "'absent' defaults to a
>> default value".  Lacking a time machine, we're stuck with cases of
>> "'absent' means something you can't express with a value" and "'absent=
'
>> means different things in different contexts" that have been enshrined=

>> in external interfaces.  Is there anything we could do to improve
>> matters for saner cases?
>>
>> I think there is: we could provide for an *optional* default value.  I=
f
>> the schema specifies it, that's what 'absent' means.  If it doesn't, a=
ll
>> bets are off, just like they are now.
>>
>> Say we do that (for what it's worth, introspect.json is already prepar=
ed
>> for it).
>=20
> If somebody(tm) does that, great. :-)
>=20
>> How would it play with your default-variant?
>>
>> If an optional discriminator specifies a default value, then that's th=
e
>> default variant.  But wait, if there's also a default-variant, *that's=
*
>> the default variant!  Awkward clash.  To resolve it, we could either
>> forbid combining the two, or rule default-variant overrides the defaul=
t.
>> Feels needlessly complicated.
>=20
> I agree on the needless, not so sure about the complicated.  (Other tha=
n
> it being double the work, but, well, the default-variant work is alread=
y
> right here.)
>=20
>> Could we get away with "if you want a default variant, the discriminat=
or
>> must specify a default"?
>=20
> I think so, yes.  I agree that it'd be the better solution.  But to be
> honest I'd really rather not delve any deeper into the QAPI dungeon tha=
n
> I've done in this series so far...

I've now hit a case where I'd like a default-variant (namely, improving
nbd-server-add to avoid SocketAddressLegacy); maybe I'll find time to
revive at least this part of the series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pnLpJJxUogGeZP16Cbs4FYF96n7cQqeZq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz4EV4ACgkQp6FrSiUn
Q2qObwf+OaGMnFOKz0osri9lh+GSEyDpWP+ShGoyvDwkkwJQvJBsozwqvAcvBqN4
qAvefV07wS9LqwC+qYYU0aVaXsrh3C9EfofzvGsJIxudbnYw9hQp14P6ilO+/lLC
TvN2D+ZTn7KddxxXIqFSokWygEQgPRbcoCcWoDDWpoPqGFlyBqnTOwB6lP8JqRW3
zXPqrsis3ZLiuJ6UIcedSR4P2nij0Khknsx5sY5v1FgLC1a7zqLLscowJxFONY9Q
Fa5jZEtt8QxQ7bnGy+y94M2537auRzw8qN5HHF0pAaKhvLKJkwb0JNZ8Jfzkjdto
Aqm6U6CUCcLuqevxP4aDcyAb3MFsbw==
=byFu
-----END PGP SIGNATURE-----

--pnLpJJxUogGeZP16Cbs4FYF96n7cQqeZq--

