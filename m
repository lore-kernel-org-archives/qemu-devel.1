Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEC0C32750
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 00:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3274A206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 00:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3274A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxgr7-0001gy-EB
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 20:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hxgqb-0001Ci-6D
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 20:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxgqa-0006y1-32
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 20:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hxgqX-0006wJ-L7; Tue, 13 Aug 2019 20:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3F9D3003AFE;
 Wed, 14 Aug 2019 00:08:55 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0DCE18E35;
 Wed, 14 Aug 2019 00:08:52 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190813224446.14145-1-jsnow@redhat.com>
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
Message-ID: <8448b999-134c-edc0-ac29-1da08e3f4d50@redhat.com>
Date: Tue, 13 Aug 2019 19:08:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813224446.14145-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y78jY88Lj5ptB1tuONLGa92358CL0G8QB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 14 Aug 2019 00:08:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] dirty-bitmaps: add
 block-dirty-bitmap-persist command
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y78jY88Lj5ptB1tuONLGa92358CL0G8QB
Content-Type: multipart/mixed; boundary="hrQO3Uz4JS4BlGjjSasxR38ulejOXGVxV";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <8448b999-134c-edc0-ac29-1da08e3f4d50@redhat.com>
Subject: Re: [RFC] dirty-bitmaps: add block-dirty-bitmap-persist command
References: <20190813224446.14145-1-jsnow@redhat.com>
In-Reply-To: <20190813224446.14145-1-jsnow@redhat.com>

--hrQO3Uz4JS4BlGjjSasxR38ulejOXGVxV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/13/19 5:44 PM, John Snow wrote:
> This is for the purpose of toggling on/off persistence on a bitmap.
> This enables you to save a bitmap that was not persistent, but may
> have already accumulated valuable data.
>=20
> This is simply a QOL enhancement:
> - Allows user to "upgrade" an existing bitmap to persistent
> - Allows user to "downgrade" an existing bitmap to transient,
>   removing it from storage without deleting the bitmap.
>=20

In the meantime, a workaround is:

create tmp bitmap (non-persistent is fine)
merge existing bitmap into tmp bitmap
delete existing bitmap
recreate original bitmap with desired change in persistence
merge tmp bitmap into re-created original bitmap
delete tmp bitmap

(I'm not sure how much, if any of that, has to be done with a
transaction; ideally none, since merging two bitmaps that are both
enabled is not going to lose any bits.  And since one of the two ends of
the transaction has a non-persistent bitmap, qemu failing in the narrow
window where the original bitmap does not exist at all is not that much
different from failing while the bitmap is transient. If losing data due
to qemu failure was important, the bitmap should never have been
transient in the first place)

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>=20
> This is just an RFC because I'm not sure if I really want to pursue
> adding this, but it was raised in a discussion I had recently that it
> was a little annoying as an API design that persistence couldn't be
> changed after addition, so I wanted to see how much code it would take
> to address that.
>=20
> (So this patch isn't really tested; just: "Hey, look!")
>=20
> I don't like this patch because it exacerbates my perceived problems
> with the "check if I can make it persistent, then toggle the flag"
> model, where I prefer the "Just try to set it persistent and let it fai=
l
> if it cannot" model, but there were some issues with that patchset that=

> I want to revisit.

The idea itself makes sense. I don't know if libvirt would ever use it,
but it does seem like it could make hand-management of bitmaps easier to
reason about.

> +++ b/qapi/block-core.json
> @@ -2001,6 +2001,19 @@
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
>              '*persistent': 'bool', '*autoload': 'bool', '*disabled': '=
bool' } }
> =20
> +##
> +# @BlockDirtyBitmapPersist:

The QAPI additions look fine to me, regardless of whether you respin the
code based on review there.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hrQO3Uz4JS4BlGjjSasxR38ulejOXGVxV--

--Y78jY88Lj5ptB1tuONLGa92358CL0G8QB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1TURMACgkQp6FrSiUn
Q2o1awf/QlLvEO2Esk75ZgTWWJGD11DBX12uWNfB3Zvii4HotXdSU9O7CfEFSNjj
odgepLpfu8bmpxpAL6TezpSjrSMO8vVhrBdAH4nLQIUbnpDN2JcEEqsO8nMn0LPM
OPjQMRgz/kAjXKpoUCq+/rhxdmroc5vGfpgQIaaBsfdsx9/5GnWVE4IC7hBS5wVS
CNBHpnzDmbpbl5gJvDqx8PoxOlvQECGYYlu0iyQ441rcQmP06LA3qjrbz6MmY9MB
ZRcj2Fuv+hUumvCJqJ0KyVWMxxO4m16r+3t0KxLTwICw6VM6Ov1ATS4FnhU1l7DX
tm9+gJmMOqqYdpP1+ngoJlCnFfPibw==
=A6l2
-----END PGP SIGNATURE-----

--Y78jY88Lj5ptB1tuONLGa92358CL0G8QB--

