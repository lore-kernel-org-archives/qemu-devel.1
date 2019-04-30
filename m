Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA7C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057B321734
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057B321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLUwJ-0000Zf-WC
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUuF-0007OG-3n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUsd-0000ac-Ss
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLUsa-0000Y3-6x; Tue, 30 Apr 2019 11:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 104CC308621B;
	Tue, 30 Apr 2019 15:41:09 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A811217146;
	Tue, 30 Apr 2019 15:41:03 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
	<20190430110918.GF5607@linux.fritz.box>
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
Message-ID: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
Date: Tue, 30 Apr 2019 10:41:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430110918.GF5607@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 30 Apr 2019 15:41:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430154102.qkk4AAKoTy5QnQGwOFDtodnElMXvXIxOWruVRHsKCU4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <2c8b3197-316d-7215-9284-6f1e986a0803@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
 <20190423125706.26989-3-vsementsov@virtuozzo.com>
 <20190430092437.jbecehdkqa4zdavd@steredhat>
 <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
 <20190430110918.GF5607@linux.fritz.box>
In-Reply-To: <20190430110918.GF5607@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 6:09 AM, Kevin Wolf wrote:
> Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 30.04.2019 12:24, Stefano Garzarella wrote:
>>> On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
>>>> This fixes at least one overflow in qcow2_process_discards, which
>>>> passes 64bit region length to bdrv_pdiscard where bytes (or sectors =
in
>>>> the past) parameter is int since its introduction in 0b919fae.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>

>>>> -    if (!bs || !bs->drv) {
>>>> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
>>>
>>> Should we describe this change in the commit message?
>>
>> Honestly, don't want to resend the series for this.
>=20
> I haven't reviewed the patches yet, but if this remains the only thing
> to change, it can be updated while applying the series if we have a
> specific proposal for a new commit message.

How about:

This fixes at least one overflow in qcow2_process_discards, which was
inadvertently truncating a 64-bit region length to the bdrv_pdiscard
'int bytes' parameter (previously bdrv_discard's 'int sectors') since
its introduction in 0b919fae.

By inlining the remaining portions of bdrv_check_byte_request() that are
still independent from the code previously validating a 32-bit request,
we can drop the call to that function. A request larger than 31 bits (or
the driver's max discard limit, if specified) is still split into
smaller chunks by the block layer before reaching the driver.


At any rate, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIbI4ACgkQp6FrSiUn
Q2r6sQf/XXjTsk75VmfCuh6wISaLexIoCpqItTSPix5QnEOWUFtPpv8leJh/tGit
jgNDeiJBisePVvR1UK5MFP8nSy2Chrqe/IuvQfaRBpeLC7YLpEtS9YiHc5FuyIXa
ka2u9cTtPhd3e2/t+LUQlCU7qhawVHzBXXJFfCDTX40xCJC8OUAUqRArAG/8bwaw
cxADZs/pGmEf4KcxbcblYEs+3n7MwABk3hEuQrA/pwffnB/fueV+nkfffgoc60he
XhvKAYU/wVlAM7dJkvmL2C4fepxc0hond0u+rEyhqhrBZtVuwj/WKontgnPd58N8
J6Kx4vrTj96eF3W5egY1IG1Y39667A==
=MmpC
-----END PGP SIGNATURE-----

--JuRnLRaEtvMUin9Yb1nXuzMmsqDlRSMmV--

