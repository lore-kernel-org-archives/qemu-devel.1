Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B403C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2920720693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2920720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOEW-0000jB-28
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hnOEJ-0000G3-L1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hnOEH-0005b2-Ix
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hnOEF-0005ZN-Bd; Tue, 16 Jul 2019 10:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A97481F1B;
 Tue, 16 Jul 2019 14:14:50 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34FA7608A6;
 Tue, 16 Jul 2019 14:14:42 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716100731.29843-1-marcandre.lureau@redhat.com>
 <c3e74283-5050-ec15-6f19-84b5e013e5bf@redhat.com>
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
Message-ID: <56aff8eb-d94f-eb98-e8cd-8f5c962330ed@redhat.com>
Date: Tue, 16 Jul 2019 09:14:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c3e74283-5050-ec15-6f19-84b5e013e5bf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XxJfObK7pY5c6oJtficR17YgT8PYTiMA3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 16 Jul 2019 14:14:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] nbd: fix uninitialized variable warning
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XxJfObK7pY5c6oJtficR17YgT8PYTiMA3
Content-Type: multipart/mixed; boundary="YH5rNSYMxBqOwh8a9AXTT7dSClANOtYLT";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <56aff8eb-d94f-eb98-e8cd-8f5c962330ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] nbd: fix uninitialized variable warning
References: <20190716100731.29843-1-marcandre.lureau@redhat.com>
 <c3e74283-5050-ec15-6f19-84b5e013e5bf@redhat.com>
In-Reply-To: <c3e74283-5050-ec15-6f19-84b5e013e5bf@redhat.com>

--YH5rNSYMxBqOwh8a9AXTT7dSClANOtYLT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/19 5:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> I was writing on your v1 "it might be worth commenting this is when
> building with -O3"
>=20
> This might be as easy as having the subject modified (by maintainer
> taking this patch?) as:
>=20
> "fix uninitialized variable warning [when building with -O3]"
>=20

I can do a touchup (probably to the commit body, rather than the subject)=
=2E


>> cc1: all warnings being treated as errors
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks; will queue through my NBD tree.

>> ---
>>  block/nbd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 81edabbf35..0f74c1e455 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -707,7 +707,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDSt=
ate *s,
>>                                           void **payload)
>>  {
>>      int ret, request_ret;
>> -    NBDReply local_reply;
>> +    NBDReply local_reply =3D {};

Relies on the gcc extension rather than the idiomatic C spelling of {0}
(but we rely on it elsewhere, in part because some versions of clang are
buggy on incorrectly warning about the idiomatic spelling, so nothing new=
)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YH5rNSYMxBqOwh8a9AXTT7dSClANOtYLT--

--XxJfObK7pY5c6oJtficR17YgT8PYTiMA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0t28wACgkQp6FrSiUn
Q2qsPAf/eyiZulgFD0r7xSL98ACEDlSpgrCZqCuQ+vh6MvHOiU08NHQyDIZyZzI1
IHoCmF5y344IhJh55S/u/HQeglzkxxYwD3Ii556TwOOYEHT23Of+/dsAp8taglbP
Qz/Fv4kUO6Rhz4f2B8rqIlS7d76kOydIihXe+zUe6yvE1ju9Y+bZ71IC4KG3mzVc
BehyczO1URDhgA9g80GX5gKoFhHh+sXFV12BCD54XFXaLMSESAT0fkAGROVMYtKj
3jgtDiaMSSWAxfynu02KLMfIUtBg3OsnQ3H1HrCk/BUU8bz+dyEJAD0NRw0bowMr
VA8fXs0hYrbD9/hKWW/UgiHWfWH8ng==
=mKgn
-----END PGP SIGNATURE-----

--XxJfObK7pY5c6oJtficR17YgT8PYTiMA3--

