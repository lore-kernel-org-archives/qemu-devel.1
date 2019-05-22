Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2BC072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 01:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF882217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 01:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF882217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTFtk-0007OB-L6
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 21:18:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTFsJ-0006PR-Rq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 21:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTFdt-0007B8-U3
	for qemu-devel@nongnu.org; Tue, 21 May 2019 21:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hTFds-00079l-MY; Tue, 21 May 2019 21:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DC143082E23;
	Wed, 22 May 2019 01:02:03 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46655226F4;
	Wed, 22 May 2019 01:02:00 +0000 (UTC)
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-2-mehta.aaru20@gmail.com>
	<d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
	<1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
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
Message-ID: <b3cffe45-ffac-b010-189d-b852e632c8d9@redhat.com>
Date: Tue, 21 May 2019 20:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v8FVpQZ3H3f9vjh6lYdplqZllAq7MbfHg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 22 May 2019 01:02:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v8FVpQZ3H3f9vjh6lYdplqZllAq7MbfHg
From: Eric Blake <eblake@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b3cffe45-ffac-b010-189d-b852e632c8d9@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] qapi/block-core: add option for
 io_uring
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
 <20190521235215.31341-2-mehta.aaru20@gmail.com>
 <d932237b-03bc-5dbb-17dd-bcca5ce121c8@redhat.com>
 <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
In-Reply-To: <1c277edc76e47fbbaae0ecdd6774e24ac9a94ee5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/21/19 7:51 PM, Aarushi Mehta wrote:

>>> +# @io_uring:    Use linux io_uring
>>
>> Missing a '(since 4.1)' tag.
>>
>>>  #
>>>  # Since: 2.9
>>>  ##
>>>  { 'enum': 'BlockdevAioOptions',
>>> -  'data': [ 'threads', 'native' ] }
>>> +  'data': [ 'threads', 'native','io_uring' ] }
>>
>> Missing space after ',' (not essential, but matching style is nice).
>> Should the new element be defined conditionally, so that
>> introspection
>> only sees the new enum member when compiled for Linux?
>>
> I'm not sure what would be the benefits of that? We already check for
> Linux at configure, and this would reduce readability. We aren't doing
> this for native.

Look at BlockdevOptionsFile in qapi/block-core.qapi. Telling the QAPI
generator that something is only available on Linux means that it will
be obvious to introspection (the QMP command query-qmp-schema) whether
the feature is present in a particular binary.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--v8FVpQZ3H3f9vjh6lYdplqZllAq7MbfHg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzkn4cACgkQp6FrSiUn
Q2oYgAgAnFHzsi/NrlVhSdAVbl5Bzk2faJSupPqAHDM/KtHE8MD6KSDSBbVeDQQE
wdbzb+pXVoroMxEmJlnLrdB+1IV0jeY7QYLPjvvfPvYqAtuME/H98V7eWlzDinaa
JA9Yct8P0/49S0zqEVWCjd57S0N+OCIvj3YAt/WIjuPegtLVoOusO98Xcl3c1uCW
lUtrYm98BYTJ1Y2vlXRI+IfzXuEjp3JCO2ubfD4W7KoBsxiJtmG8MEfBTFTyoxhL
21OIBuMjuW7CCXw6eIE+zXazKVOjZs4nzNRx/nJDZDbaI5DM/lbuvG0NC2LltOPe
mEnN0kOf7Escrqh8bj58Qmq9tvS53Q==
=7BNf
-----END PGP SIGNATURE-----

--v8FVpQZ3H3f9vjh6lYdplqZllAq7MbfHg--

