Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DBC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B992086D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B992086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAF5-0005SK-1D
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hgADn-0004kT-58
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hgADm-0002Ic-3I
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hgADl-0002HJ-Pz; Wed, 26 Jun 2019 11:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C97D308FBAC;
 Wed, 26 Jun 2019 15:52:23 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D20A60C80;
 Wed, 26 Jun 2019 15:52:22 +0000 (UTC)
To: Antonio Ospite <antonio.ospite@collabora.com>, Antonio Ospite
 <ao2@ao2.it>, qemu-devel@nongnu.org
References: <20190526144747.30019-1-ao2@ao2.it>
 <adce6062-9289-afe8-b26a-949144700656@collabora.com>
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
Message-ID: <974086f5-459f-5e8d-d206-735010445b12@redhat.com>
Date: Wed, 26 Jun 2019 10:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <adce6062-9289-afe8-b26a-949144700656@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w6793FgKvl4g0Ryu18PChqsQBFXyIynMa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 26 Jun 2019 15:52:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/2] configure: disallow spaces and
 colons in source path and build path
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w6793FgKvl4g0Ryu18PChqsQBFXyIynMa
Content-Type: multipart/mixed; boundary="1xE4CMDIHno0ylVkc4XIq6S7OWPZvj7ks";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Antonio Ospite <antonio.ospite@collabora.com>, Antonio Ospite
 <ao2@ao2.it>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Message-ID: <974086f5-459f-5e8d-d206-735010445b12@redhat.com>
Subject: Re: [PATCH v3 0/2] configure: disallow spaces and colons in source
 path and build path
References: <20190526144747.30019-1-ao2@ao2.it>
 <adce6062-9289-afe8-b26a-949144700656@collabora.com>
In-Reply-To: <adce6062-9289-afe8-b26a-949144700656@collabora.com>

--1xE4CMDIHno0ylVkc4XIq6S7OWPZvj7ks
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/26/19 10:16 AM, Antonio Ospite wrote:
> On 26/05/19 16:47, Antonio Ospite wrote:
>> Hi,
>>
>> Here is a v3 set to address
>> https://bugs.launchpad.net/qemu/+bug/1817345
>>
>> CCing Laurent Vivier as the patch is going through the trivial-patches=

>> branch.
>>
>=20
> Ping.
>=20
> I cannot see this in the trivial-patches repository nor in mainline qem=
u.
>=20

Explicitly adding qemu-trivial in cc may help (done now).

>> Antonio Ospite (2):
>> =C2=A0=C2=A0 configure: set source_path only once and make its definit=
ion more
>> =C2=A0=C2=A0=C2=A0=C2=A0 robust
>> =C2=A0=C2=A0 configure: disallow spaces and colons in source path and =
build path
>>
>> =C2=A0 Makefile=C2=A0 |=C2=A0 4 ++++
>> =C2=A0 configure | 11 ++++++++---
>> =C2=A0 2 files changed, 12 insertions(+), 3 deletions(-)
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1xE4CMDIHno0ylVkc4XIq6S7OWPZvj7ks--

--w6793FgKvl4g0Ryu18PChqsQBFXyIynMa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0TlLQACgkQp6FrSiUn
Q2rAdggAksZM/CmyWFFE4eaiVmOmynokvRyzTZKj861BeAleP+/cSb4TqCaV4aQW
1UpQGNAgHw4lSPftCsJZkk2TusqSvONoG22ATfEswAFyTv5a2zAxIk0Z9iGPty2v
3LN9Jx0G9ETcdPVPRglm5uisc06TPIOUxMWP+VMJgauCYuQr8j9BUVUPCAjnO4to
79/qRREFibMh0aMgCzcia1NORS3ubfomi4/9w9gJk+fXBo79xDdjpx25TPTHV//z
4XBu4d9dKW58U3MJIaDH+JLjGH+WlITLbc2cXqwC/WUnKgKDYotoTrmtztMVcwnu
V1AKc7DethHL0nAwaGSYidbfL9lKGg==
=sp4B
-----END PGP SIGNATURE-----

--w6793FgKvl4g0Ryu18PChqsQBFXyIynMa--

