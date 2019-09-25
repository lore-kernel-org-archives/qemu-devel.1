Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11329C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB60621D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB60621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7Ko-0001T3-71
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iD76y-0003O8-Q5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iD76x-0003kC-Lm
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iD76x-0003hZ-CZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B4E92BFDC;
 Wed, 25 Sep 2019 13:13:38 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B850A5D9CC;
 Wed, 25 Sep 2019 13:13:35 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190910075943.12977-1-vsementsov@virtuozzo.com>
 <20190910080319.GA8215@redhat.com>
 <0e5b08c2-e823-799a-98e3-06174de8d333@redhat.com>
 <00357f96-367e-d003-c166-d43083ee60af@virtuozzo.com>
 <1296f8b0-b1db-3125-1989-47c4eed2b3e9@virtuozzo.com>
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
Message-ID: <8af559ca-3fd8-2786-4949-3b13a815fcdc@redhat.com>
Date: Wed, 25 Sep 2019 08:13:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1296f8b0-b1db-3125-1989-47c4eed2b3e9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="83Ma805ovARfgcPw114ERjl1dfusdWvt3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 25 Sep 2019 13:13:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--83Ma805ovARfgcPw114ERjl1dfusdWvt3
Content-Type: multipart/mixed; boundary="9DmFPqP7e7apXaJ31X8PnlSnm5J29xQhZ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Denis Lunev <den@virtuozzo.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <8af559ca-3fd8-2786-4949-3b13a815fcdc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
References: <20190910075943.12977-1-vsementsov@virtuozzo.com>
 <20190910080319.GA8215@redhat.com>
 <0e5b08c2-e823-799a-98e3-06174de8d333@redhat.com>
 <00357f96-367e-d003-c166-d43083ee60af@virtuozzo.com>
 <1296f8b0-b1db-3125-1989-47c4eed2b3e9@virtuozzo.com>
In-Reply-To: <1296f8b0-b1db-3125-1989-47c4eed2b3e9@virtuozzo.com>

--9DmFPqP7e7apXaJ31X8PnlSnm5J29xQhZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/25/19 6:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.09.2019 15:08, Vladimir Sementsov-Ogievskiy wrote:
>> 10.09.2019 16:59, Eric Blake wrote:
>>> On 9/10/19 3:03 AM, Daniel P. Berrang=C3=A9 wrote:
>>>> On Tue, Sep 10, 2019 at 10:59:43AM +0300, Vladimir Sementsov-Ogievsk=
iy wrote:
>>>>> In "if (saddr->keep_alive) {" we may already be on error path, with=

>>>>> invalid sock < 0. Fix it by returning error earlier.
>>>>>
>>>>> Reported-by: Coverity (CID 1405300)
>>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>> ---
>>>>> =C2=A0 util/qemu-sockets.c | 5 +++--
>>>>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>
>>> Thanks.=C2=A0 Will queue through my NBD tree, since that's where the =
original
>>> problem was introduced.
>>>
>>
>> Please add when queueing:
>>
>> Fixes: aec21d31756cbd
>>
>=20
> Hmm, don't you forget? Don't see it neither in pull request nor in your=
 branches.

Thanks for catching this.  Fixing now...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--9DmFPqP7e7apXaJ31X8PnlSnm5J29xQhZ--

--83Ma805ovARfgcPw114ERjl1dfusdWvt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2LZ/4ACgkQp6FrSiUn
Q2rqYgf/X7E89YvgqjQc+NCRYOIaJXPeXuIfE59zFzliLbP2MY9OGfkNuXBbXKOx
He2Y2QaoMTGYAIF64Ij4BzmE34lSWxG1CBtRTfpeJfSKlu8CEc6I1jvSCagF0idW
2MUbjLn0QEQ1kEt1KMrKzunveI9an3WmIE2ScB6zsFLgG7fS3GbIDtB6izFQHRXm
Xd8IjvKyhBbjyk95GHSRj63ZEgdsKULNjf4XVzrtO/svt7W5IhGiukcbOoZTI7Ci
elnXoZr0AL6P8+ciAJtaqszOo3dVguLJCh58ofCNV72w5cx08dvYr73SXW6lfYNt
Sp3iQWHH95u/ttY/08gPiVKg7hQo4A==
=vbmO
-----END PGP SIGNATURE-----

--83Ma805ovARfgcPw114ERjl1dfusdWvt3--

