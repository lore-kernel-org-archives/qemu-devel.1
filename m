Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676F2C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1F3207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNzP-0002eD-Gy
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCNwt-00025x-GK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCNwr-0002xz-E8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iCNwo-0002vw-Ce
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:00:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29988305FC56;
 Mon, 23 Sep 2019 13:00:09 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C96986012D;
 Mon, 23 Sep 2019 13:00:04 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
To: Markus Armbruster <armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
 <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
 <87tv9g8cf4.fsf@dusky.pond.sub.org>
 <f71d6dd3-c9f5-7b89-a536-cf7e9baaff51@redhat.com>
 <87impjp77y.fsf@dusky.pond.sub.org>
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
Message-ID: <84f90c22-4983-dc9c-bf0e-5297b9ea7658@redhat.com>
Date: Mon, 23 Sep 2019 08:00:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87impjp77y.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SPTnie9j44n3UFRDCTvfwE7UjA3rXvyym"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 23 Sep 2019 13:00:09 +0000 (UTC)
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SPTnie9j44n3UFRDCTvfwE7UjA3rXvyym
Content-Type: multipart/mixed; boundary="2N2zf51N3NQJ47PrrEkQPnoCloPZa0MDQ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Message-ID: <84f90c22-4983-dc9c-bf0e-5297b9ea7658@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
 <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
 <87tv9g8cf4.fsf@dusky.pond.sub.org>
 <f71d6dd3-c9f5-7b89-a536-cf7e9baaff51@redhat.com>
 <87impjp77y.fsf@dusky.pond.sub.org>
In-Reply-To: <87impjp77y.fsf@dusky.pond.sub.org>

--2N2zf51N3NQJ47PrrEkQPnoCloPZa0MDQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/23/19 6:44 AM, Markus Armbruster wrote:

>>>> Worth mentioning that type names themselves are NOT part of the
>>>> interface, and may be freely renamed?
>>>
>>> Care to suggest a suitable sentence?
>>
>> Although member names within a type cannot be changed without affectin=
g
>> compatibility,
>=20
> This part seems redundant with the previous paragraph.
>=20
>>                changes to type names themselves do not affect the
>> protocol.  As such, complex types may be freely renamed or refactored,=

>=20
> All types (enums, structs, simple & flat unions, alternates) actually,
> not just complex ones (structs, unions).
>=20
>> such as splitting members from one type into a common base type, as lo=
ng
>> as the resulting set of members remain compatible.
>=20
> What does it mean for a set of members to be compatible?  We don't
> actually define that...
>=20
> What about:
>=20
>   Since type names are not visible in the Client JSON Protocol, types
>   may be freely renamed.  Even certain refactorings are invisible, such=

>   as splitting members from one type into a common base type.

Seems reasonable to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2N2zf51N3NQJ47PrrEkQPnoCloPZa0MDQ--

--SPTnie9j44n3UFRDCTvfwE7UjA3rXvyym
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2IwdQACgkQp6FrSiUn
Q2q09wf+OAF+HmkWrt8cq7IuR8289jKFIuZkGZTjQob1b5SMFLMu6HYOdUfTr6c7
1z1eQSWQI2ubmkzfMWQaBpDnARGeM38z5yyRQuk3X40EDVTf0Il8jMX3UEBi5yMF
xj1Zp2MzRmIoKcUk/imCU38dvh8sh3uz/rFhpDCd0PKAasQgSPvsreHzuffJpJ0u
NNX6NC9qeQcRthed7z37mlZhyfTWNx/IuabFjNTZI5JsgghN0ObAXsyGt/VkmKOD
zpUQNnwfKBAqIJg0at8Xs+ghBvxe8fhv8U+FL33oxYEomM4TjH1nxhVtsOaaWyHf
/pmh/lC6gj6zdQ2RxhrSDPysCacEtA==
=+qj3
-----END PGP SIGNATURE-----

--SPTnie9j44n3UFRDCTvfwE7UjA3rXvyym--

