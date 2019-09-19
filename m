Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2506C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18DA20665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18DA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyMz-0006Yh-Ld
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAyLu-0005gA-Js
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAyLt-0003G7-6L
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAyLs-0003Fz-UC
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 405333B77;
 Thu, 19 Sep 2019 15:28:12 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 868B15D6B0;
 Thu, 19 Sep 2019 15:28:09 +0000 (UTC)
Subject: Re: [Qemu-devel] [PULL 00/26] Audio 20190919 patches
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
 <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>
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
Message-ID: <6691e81f-3122-a13c-d3bf-7f1762b2d69e@redhat.com>
Date: Thu, 19 Sep 2019 10:28:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kZlalgDGlQnJ9FOETFRu3AzzF2TExC2g3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 19 Sep 2019 15:28:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kZlalgDGlQnJ9FOETFRu3AzzF2TExC2g3
Content-Type: multipart/mixed; boundary="beZdl7GUS7EA8LZzSOPGfpEstS1u0euwG";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <6691e81f-3122-a13c-d3bf-7f1762b2d69e@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/26] Audio 20190919 patches
References: <20190919083629.29998-1-kraxel@redhat.com>
 <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>
In-Reply-To: <CAFEAcA96outvEdRasZM-LdTSs7QCRZracTvWUZ3gG5x23kh+1w@mail.gmail.com>

--beZdl7GUS7EA8LZzSOPGfpEstS1u0euwG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/19/19 10:15 AM, Peter Maydell wrote:
> On Thu, 19 Sep 2019 at 09:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7=
c6194:
>>
>>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:=
01:00 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.kraxel.org/qemu tags/audio-20190919-pull-request
>>
>> for you to fetch changes up to cf0c1c2aa32db5d658c3c797ad995a6d571bad9=
6:
>>
>>   audio: fix ALSA period-length typo in documentation (2019-09-19 10:3=
2:48 +0200)
>>
>> ----------------------------------------------------------------
>> audio: make mixeng optional.
>> audio: add surround sound support.
>> audio: documentation fixes.
>>
>=20
> Hi; I'm afraid this fails to build on OSX/FreeBSD/OpenBSD/Windows,
> with format string issues:
>=20
> /Users/pm215/src/qemu-for-merges/audio/wavaudio.c:50:15: error: format
> specifies type 'size_t' (aka 'unsigned long') but the argument has
> type 'int64_t' (aka 'long long') [-Werror,-Wformat]
>               bytes, strerror(errno));
>               ^~~~~

As long as you spin a v2, it's also worth fixing a typo I found in 15/26.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--beZdl7GUS7EA8LZzSOPGfpEstS1u0euwG--

--kZlalgDGlQnJ9FOETFRu3AzzF2TExC2g3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2DnogACgkQp6FrSiUn
Q2otPgf/SUUkJdEah/484ZJ1oFIk2x4HvBl66YYkXdnHyUES3irMQCTE8NTy+4VZ
A4ZuU8cTANwNxieQuxWd5UCmPP8kNKt5vHlBIJPKeMQ3M3MDkq+7diPbsvB0/rde
gvclsYcqcAojKrYhPzgkbUudVTW6moCcxNKGV5x6bCPwXKNsjZxSs5EBuINj+jP1
f32zggsfl1pjJDqfCXYI/1pW4n70Wkm8ZQe4XjbH0UuheVbckHSH35mLO62s1hAa
RYLlKdtBYLMhun83JroWsvHSBGJCq4fk2DN2jtxEe5SCLG0zOqEuFvpUJYR4UVPH
ZCqzOwF4605Mxn7gDZL8ij1cmHlmlA==
=hE78
-----END PGP SIGNATURE-----

--kZlalgDGlQnJ9FOETFRu3AzzF2TExC2g3--

