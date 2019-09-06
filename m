Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F282C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C46207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C46207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JV5-0004rM-3F
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i6JT4-00040C-3w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i6JT2-0005zM-3l
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:00:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i6JSx-0005Yv-2j; Fri, 06 Sep 2019 15:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8E9718CB8E3;
 Fri,  6 Sep 2019 19:00:12 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB2DE60BF7;
 Fri,  6 Sep 2019 19:00:11 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
 <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
 <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>
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
Message-ID: <19dabeca-b99d-822e-84ad-0cc2be90d6c9@redhat.com>
Date: Fri, 6 Sep 2019 14:00:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lT13HVBIDexdyTyExDYHMDxJvE7A9mhqj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 06 Sep 2019 19:00:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
 encryption code
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lT13HVBIDexdyTyExDYHMDxJvE7A9mhqj
Content-Type: multipart/mixed; boundary="4esRjMsOY7P9eys5fKBWtD3ycWP9xSmTG";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <19dabeca-b99d-822e-84ad-0cc2be90d6c9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block/qcow2: refactoring of threaded
 encryption code
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-2-mlevitsk@redhat.com>
 <e7f3febc-63cb-ea09-0761-45ecae74ad14@redhat.com>
 <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>
In-Reply-To: <4dacc6bde5bc87d48f5d3b255a7a44bbded782ef.camel@redhat.com>

--4esRjMsOY7P9eys5fKBWtD3ycWP9xSmTG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/6/19 1:55 PM, Maxim Levitsky wrote:

>>> +/*
>>> + * qcow2_co_encrypt()
>>> + *
>>> + * Encrypts a sector size aligned contiguous area
>>> + *
>>> + * @host_cluster_offset - on disk offset of the cluster in which
>>> + *                        the buffer resides
>>> + *
>>> + * @guest_offset - guest (virtual) offset of the buffer
>>> + * @buf - buffer with the data to encrypt
>>> + * @len - length of the buffer
>>> + *
>>> + * Note that the area is not cluster aligned and might cross a clust=
er
>>> + * boundary
>>
>> Umm, how is it possible for a sector to cross a cluster boundary?  All=

>> clusters are sector-aligned, and encryption only works on aligned
>> sectors.  Oh, I see - if @len is a multiple larger than sector size,
>> then we have multiple sectors, and then indeed we may cross clusters.
>> But then the docs about being 'a sector size aligned contiguous area' =
is
>> not quite right.
>=20
> Why? the written area is always both aligned on _sector_ boundary
> and multiple of the sector size. At least that what I see from
> the existing asserts.

I'm thinking it should read something like:

Encrypts one or more contiguous aligned sectors

to make it obvious that because there can be multiple sectors, there may
indeed be a cluster boundary mid-length.  My complaint was that the
original text made it sound like there was exactly one sector (at which
point @len is redundant, unless sectors are variably-sized)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4esRjMsOY7P9eys5fKBWtD3ycWP9xSmTG--

--lT13HVBIDexdyTyExDYHMDxJvE7A9mhqj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1yrLoACgkQp6FrSiUn
Q2pI2Af/amu+KIx4omLNJ5EW6NvPg4WbqExmVJLkGmnWxNbzXAyYgCvawL0ZM7ah
JrE5phdIoYkgdFpTYW3yWQTW2lZ6BPH7svY2yL7agM4FrqnIPDDJ04l0zDvByhvq
O/sr8uO3cSr+iCpRrC+gxfHRefZuI+387Yv1mwv4ej52c6Sam49eg41wI7UFTHUL
W8ICHHSOCX8dk1qH+H7UKco6oQ9bJpVIkoiQhfREUsNXgknZq5rPrGEMcruOXBPr
0ebdQUw7escIlN/syxKN17CfVGLHU+4bI1AnRbwbxJNh29QtBgmKt5g3Lw0JgKCA
n8UDGGbB3NIQjwVap/lQ4UKW95yRWw==
=OriL
-----END PGP SIGNATURE-----

--lT13HVBIDexdyTyExDYHMDxJvE7A9mhqj--

