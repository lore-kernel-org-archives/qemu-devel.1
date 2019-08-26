Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3400BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098692053B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098692053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2F7D-0000NN-8v
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2F6F-0008CB-PU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2F6E-0003j7-O5
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i2F6A-0003gk-Lx; Mon, 26 Aug 2019 09:31:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1056E8980EB;
 Mon, 26 Aug 2019 13:31:53 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB2775D9E2;
 Mon, 26 Aug 2019 13:31:49 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-7-mlevitsk@redhat.com>
 <20190822110448.GK3267@redhat.com>
 <ba3ddc4c3c6dd18b7a7c913e55e52ddc8c9efeb0.camel@redhat.com>
 <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
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
Message-ID: <0cd8b90e-db47-676d-bb5a-25c70a1c1598@redhat.com>
Date: Mon, 26 Aug 2019 08:31:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j6dbvEKOYIEM2KqdSht76ZJcmcHLpvlPI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 26 Aug 2019 13:31:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more
 rigorous header checking
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j6dbvEKOYIEM2KqdSht76ZJcmcHLpvlPI
Content-Type: multipart/mixed; boundary="vc40jumCzOMvLZDcKoMh8LVRVIxzUExm3";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <0cd8b90e-db47-676d-bb5a-25c70a1c1598@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more rigorous
 header checking
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-7-mlevitsk@redhat.com>
 <20190822110448.GK3267@redhat.com>
 <ba3ddc4c3c6dd18b7a7c913e55e52ddc8c9efeb0.camel@redhat.com>
 <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
In-Reply-To: <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>

--vc40jumCzOMvLZDcKoMh8LVRVIxzUExm3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/25/19 11:08 AM, Maxim Levitsky wrote:

>>> I'd do a separate check for stripes and active fields, and then give =
a
>>> specific error message for each. That way if this does ever trigger
>>> in practice will immediately understand which check failed.
>>>
>>> Also using '%d' rather than '%i' is more common convention
>>
>> Done.
>=20
> Note that I switched i,j to be size_t since you said that you prefer th=
is,
> and to print this I apparently need %lu.

Actually, for size_t, you need %zu. %lu/size_t will cause warnings on
32-bit platforms.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vc40jumCzOMvLZDcKoMh8LVRVIxzUExm3--

--j6dbvEKOYIEM2KqdSht76ZJcmcHLpvlPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1j30QACgkQp6FrSiUn
Q2oP/wgAqh1zfh8g3axhcqUWUUe8PjNwydXGvh7c++RvHKgT50ktncL5aTZdQLCX
FXof8Aa2DWxKwiggtkBdi4OGhaP8cJUcBTh+cDHAGOUZeAxg4qXmko+9PsbUC3Ui
RDibqRRLqaPP+2fp6tiQNczxMvK3tnNJpw77/ccxAzUYm1dHJ74kMVvRa7y9zgC/
k7ek0WLIF0FXw5fqhCHL+HMjtG5IY+6q98DQf3lOcQwjx+dqTpHmjZDHeTKQNjgI
2Yt9aVh5t3urZrVvPSN0SteFB0A/QdXnfqi7Q6VKPCO/yWNZ1b9S/uW3PZwZCm/y
C3ba8zbXkg3Pj96ixsUedQZUUQi4xQ==
=FNVT
-----END PGP SIGNATURE-----

--j6dbvEKOYIEM2KqdSht76ZJcmcHLpvlPI--

