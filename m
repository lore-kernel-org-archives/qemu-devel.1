Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8903C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31D32054F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31D32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQ21-0005Jb-BI
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hnQ1p-0004pQ-Fw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hnQ1k-0005FM-K4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:10:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hnQ1h-0005CQ-Vw; Tue, 16 Jul 2019 12:10:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D7C437F46;
 Tue, 16 Jul 2019 16:09:58 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93EC919D7A;
 Tue, 16 Jul 2019 16:09:57 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-3-thuth@redhat.com>
 <1832e90b-0fd2-19ac-f90e-572147e51f53@redhat.com>
 <62ec1243-3bb9-c18d-0ff6-4c4ad193620c@redhat.com>
 <03b260f7-b108-f035-2974-17b5ef74e4e6@redhat.com>
 <99ee850e-d9e0-1079-7fb2-64a1901009e6@redhat.com>
 <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
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
Message-ID: <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
Date: Tue, 16 Jul 2019 11:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i8nQrOvbkRUiUGgy9TyKKVCjTCl7xPDIn"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 16:09:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tests/qemu-iotests/group: Remove
 some more tests from the "auto" group
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i8nQrOvbkRUiUGgy9TyKKVCjTCl7xPDIn
Content-Type: multipart/mixed; boundary="k8IPBfoNecjX6IpyL873TBIt7oNjZbCAO";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org
Message-ID: <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/qemu-iotests/group: Remove some more tests
 from the "auto" group
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-3-thuth@redhat.com>
 <1832e90b-0fd2-19ac-f90e-572147e51f53@redhat.com>
 <62ec1243-3bb9-c18d-0ff6-4c4ad193620c@redhat.com>
 <03b260f7-b108-f035-2974-17b5ef74e4e6@redhat.com>
 <99ee850e-d9e0-1079-7fb2-64a1901009e6@redhat.com>
 <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
In-Reply-To: <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>

--k8IPBfoNecjX6IpyL873TBIt7oNjZbCAO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/19 10:58 AM, Max Reitz wrote:

>>> Ah, OK.  So, uh, we effectively can=E2=80=99t run any Python tests on=
 macOS?
>>
>> Not when our CI is set up to use super-long file names:
>>
>> +  File
>> "/private/var/folders/sy/2x5qvs0n4lg18fry9jz4y21m0000gn/T/cirrus-ci-bu=
ild/tests/qemu-iotests/../../python/qemu/machine.py",
>> line 294, in launch
>=20
> That isn=E2=80=99t really long.

The MacOS limit is 104 (or 103 if you insist on using the trailing NUL
yourself), compared to Linux at 108 (107).  And:

$ printf
"/private/var/folders/sy/2x5qvs0n4lg18fry9jz4y21m0000gn/T/cirrus-ci-build=
/tests/qemu-iotests/scratch/name"
| wc -c
104

shows that we are right on the verge of overflowing the space allotted,
with any socket name worth using when the socket lives inside
qemu-iotests/scratch.

>=20
>> Is there any way to create our sockets somewhere under /tmp instead of=

>> inside tests/qemu-iotests, so that we have a shorter filename for
>> sockets no matter how deep in the file hierarchy the tests themselves =
live?
>>
>> Also, at one point, we tossed around the idea of
>> s/qemu-iotests/iotests/, to shave off 5 characters that don't really a=
dd
>> anything.
>=20
> I=E2=80=99d personally rather just skip the iotests if we detect such a=
 silly
> OS, but maybe that=E2=80=99s just me.

It's a rather unfortunate limit, but it's not all that silly (the limit
is based on the fact that struct sockaddr has to fit inside a nice
power-of-2 structure somewhere in the kernel, and enough else is used
that you really are left with just 104/108 bytes, or even 92 bytes if
you use HP-UX 11).  POSIX does not place a minimum length on sun_path,
but I know of no system that does not allow at least 92 bytes, if you
are aiming for a portably-small name.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--k8IPBfoNecjX6IpyL873TBIt7oNjZbCAO--

--i8nQrOvbkRUiUGgy9TyKKVCjTCl7xPDIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0t9tQACgkQp6FrSiUn
Q2q8Gwf/XDJXsB6gO8PqbI1MmGMJyavRs4TePXlB6tShCg5FzgzjATLjIxeVlepp
YcgiwRSmVyYvhey3Og1qxI5KLxcUBsMcvlErSshmdvR2i4KDsEh64gRbeXmgP81z
27cUO0/k+RqPRwJrWfI2EoAVZGLSHiG7TrpXG/5ah2aZYUgvS+vDUxfeU8Mo7S/3
l+H1A/bMkZx+lqyJ0lL0TS/lnivgf7Mo0jo5w7Sf8TvHq+ntIV9H6uJOSKatGpRo
ftCpR8Dwj9OaX/lVRqFxFeobJrNhh0qvYSeZAuq8QtJF1YWuM09swBnxWvNzdMK+
6FbnmF4KhSa7eTCXVQbMszJiE6TzuA==
=4FxX
-----END PGP SIGNATURE-----

--i8nQrOvbkRUiUGgy9TyKKVCjTCl7xPDIn--

