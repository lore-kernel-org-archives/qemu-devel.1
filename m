Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D734C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D876621019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D876621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZU5-0007jf-Hu
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hlZTT-0006wO-OU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hlZTS-0001sg-Al
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hlZTP-0001oQ-OY; Thu, 11 Jul 2019 09:50:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6896D368FF;
 Thu, 11 Jul 2019 13:50:58 +0000 (UTC)
Received: from [10.3.116.78] (ovpn-116-78.phx2.redhat.com [10.3.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6F860BFB;
 Thu, 11 Jul 2019 13:50:57 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
 <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>
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
Message-ID: <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
Date: Thu, 11 Jul 2019 08:50:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YG7Re7bz7QQWNmjegLVITwLPtu45hUS5t"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 11 Jul 2019 13:50:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YG7Re7bz7QQWNmjegLVITwLPtu45hUS5t
Content-Type: multipart/mixed; boundary="3KTbQYNyDCXoGy3JVSElILF3RGN8vtSSJ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
Subject: Re: [PATCH] LUKS: support preallocation in qemu-img
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
 <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>
In-Reply-To: <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>

--3KTbQYNyDCXoGy3JVSElILF3RGN8vtSSJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/11/19 7:24 AM, Max Reitz wrote:

>>> So it isn=E2=80=99t just me who expects these to pre-initialize the i=
mage to 0.
>>>  Hm, although...  I suppose @falloc technically does not specify whet=
her
>>> the data reads as zeroes.  I kind of find it to be implied, but, well=
=2E..
>>
>> I personally don't really think that zeros are important, but rather t=
he level of allocation.
>> posix_fallocate probably won't write the data blocks but rather only t=
he inode metadata / used block bitmap/etc.
>>
>> On the other hand writing zeros (or anything else) will force the bloc=
k layer to actually write to the underlying
>> storage which could trigger lower layer allocation if the underlying s=
torage is thin-provisioned.
>>
>> In fact IMHO, instead of writing zeros, it would be better to write ra=
ndom garbage instead (or have that as an even 'fuller'
>> preallocation mode), since underlying storage might 'compress' the zer=
os.=20
>=20
> Which is actually an argument why you should just write zeroes on the
> LUKS layer, because this will then turn into quasi-random data on the
> protocol layer.

We want preallocation to be fast (insofar as possible). Writing zeroes
in LUKS is not fast, because it forces random data on the protocol
layer; while writing zeroes on the protocol layer can be fast, even if
it reads back as random on the LUKS layer. If you WANT to guarantee
reading zeroes, that's image scrubbing, not preallocation.  I think this
patch is taking the right approach, of letting the underlying layer
allocate data efficiently (but the burden is then on the underlying
layer to actually allocate data, and not optimize by compressing zeroes
into non-allocated storage).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3KTbQYNyDCXoGy3JVSElILF3RGN8vtSSJ--

--YG7Re7bz7QQWNmjegLVITwLPtu45hUS5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0nPsAACgkQp6FrSiUn
Q2q4FQf+LWYFahD6J08jQ8fVIXDp0AYABFR1ffiWvQGXUSldU1hjnrH2oMPTZBFs
KN1hvRNwTJSkWrsp2ymRvIfjvQ8Xr013XSRRxuar6FQYWOpSzF8g0HzB3OAnJ+nJ
IOgncyXiUgQn/MTUxMy6Ad9401YpAZhb+2Pv49bwzenNPUpNPViXhHu9kbg92n0K
ifuw16xXe+2o89rfctzrBljjfAzM+6CIrpTCzOe8/jR3Iauh001kKsCncYypnIv2
A1J7SZxcOp3Md2stq4fy9U6PO/1aSZTi12pHrHBWd9JcusRE4VtnrsvqAi0YfmSf
NsrAzaZomhIohuMhnHyKGMUwkd/R8Q==
=rbxA
-----END PGP SIGNATURE-----

--YG7Re7bz7QQWNmjegLVITwLPtu45hUS5t--

