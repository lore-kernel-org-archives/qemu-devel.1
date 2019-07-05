Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08FDC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CBA21670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CBA21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQjV-0004Ua-W7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hjQYh-0004bA-Uy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hjQYg-0000m7-SQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:55:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hjQYM-0007f9-VP; Fri, 05 Jul 2019 11:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAE87C04958C;
 Fri,  5 Jul 2019 15:55:11 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470794C7;
 Fri,  5 Jul 2019 15:55:08 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190705152812.26438-1-eblake@redhat.com>
 <7c01df31-e606-6524-db02-8cbbdef93a3b@redhat.com>
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
Message-ID: <1887bd36-b343-26ed-ac9f-4abd13f4b0ca@redhat.com>
Date: Fri, 5 Jul 2019 10:55:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7c01df31-e606-6524-db02-8cbbdef93a3b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kBNxtzENiHicM0DEYLGuJDFpbtmTWBx14"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 15:55:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] qcow2: Allow -o compat=v3 during
 qemu-img amend
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kBNxtzENiHicM0DEYLGuJDFpbtmTWBx14
Content-Type: multipart/mixed; boundary="HJfxtkzemix7WKV2SYc5XF4rWxFCj2FPF";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <1887bd36-b343-26ed-ac9f-4abd13f4b0ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] qcow2: Allow -o compat=v3 during
 qemu-img amend
References: <20190705152812.26438-1-eblake@redhat.com>
 <7c01df31-e606-6524-db02-8cbbdef93a3b@redhat.com>
In-Reply-To: <7c01df31-e606-6524-db02-8cbbdef93a3b@redhat.com>

--HJfxtkzemix7WKV2SYc5XF4rWxFCj2FPF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/5/19 10:53 AM, Eric Blake wrote:
> On 7/5/19 10:28 AM, Eric Blake wrote:
>> Commit b76b4f60 allowed '-o compat=3Dv3' as an alias for the
>> less-appealing '-o compat=3D1.1' for 'qemu-img create' since we want t=
o
>> use the QMP form as much as possible, but forgot to do likewise for
>> qemu-img amend.  Also, it doesn't help that '-o help' doesn't list our=

>> new preferred spellings.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I'm arguing that the lack of consistency is a bug, even though the bug=

>> has been present since 2.12.
>=20
> I found this bug while chasing down another one: trying to see if we ca=
n
> now lift our restriction against 'qemu-img resize' on an image with
> internal snapshots.  For v3 images, the limitation is artificial (the
> spec says every snapshot is required to have an associated size, so you=

> know what size to change back to when reverting to that snapshot); but
> for v2 the limitation is real (the spec did not require tracking image
> size, and therefore changing the size meant that you might not be able
> to safely revert).  Except that we ALSO have a bug in qemu-img amend:
>=20
> 1. Create a v2 file with internal snapshot. On CentOS 6:
> $ qemu-img create -f qcow2 file 1m
> $ qemu-img snapshot -c s1 file
> 2. Check that the internal snapshot header uses the smaller size:
> $ od -Ax -j64 -N8 -tx1 file  # Learn the offset for the next command
> $ offset=3D$((0x50000+36))
> $ od -Ax -j$offset -N 4 -tx1 file
>  =3D> extra field is 0
> 3. Upgrade it to v3. Using qemu.git master:
> $ qemu-img amend -o compat=3D1.1 file
> 4. Check the internal snapshot header size:
> $ od -Ax -j64 -N8 -tx1 file  # Learn the offset for the next command
> $ offset=3D$((0x50000+36))
> $ od -Ax -j$offset -N 4 -tx1 file
>  =3D> oops - extra field is still 0, but should now be at least 16.
>=20


Oh, and 'qemu-img check file' fails to diagnose the v3 image as
violating the qcow2 spec.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HJfxtkzemix7WKV2SYc5XF4rWxFCj2FPF--

--kBNxtzENiHicM0DEYLGuJDFpbtmTWBx14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0fctsACgkQp6FrSiUn
Q2rhZAf/S7NUKLV+39RWO64ET1ZFnVHZT03AQK2kN3uBlsKISCHf1/Ywl82cQ+Yn
Z7RcKdovj6Rb2IgIMGZN3k7/BZmrtBKaUSPShMPZnnnYFyOP3RumIgwhaOWXZhAs
PvpgmxpcaRsbva05DEN+u+u8eO3lvWq9gesfjnnfNHWt5zaPim5+e6QJxeqpcUys
KVo8VMLxXmLyQgrxjghWhr4+SY2hNZWsRDyoj2oVuqVUD21gBc5t91opflgznxpT
Uvug2w7WbBtlTx7y622G9eIcz7mwmQmJZXQU6H8qgkaDoUenZAstnib3PohIHcz2
YSvAwycGDvesjWMjNV8rXOeGztEJvg==
=h13J
-----END PGP SIGNATURE-----

--kBNxtzENiHicM0DEYLGuJDFpbtmTWBx14--

