Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA84E205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA84E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBRHF-0002Uk-4E
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iBR9u-0003kM-EG
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iBR9t-00075R-8u
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iBR9q-000752-Q7; Fri, 20 Sep 2019 18:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4DB010C0928;
 Fri, 20 Sep 2019 22:03:37 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4068260BE2;
 Fri, 20 Sep 2019 22:03:32 +0000 (UTC)
Subject: Re: [Qemu-block] [PATCH v2] nbd/server: attach client channel to the
 export's AioContext
To: John Snow <jsnow@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org
References: <20190912110032.26395-1-slp@redhat.com>
 <4e84115f-5317-7e84-a30f-3ed94b170f06@redhat.com>
 <d2911bb2-8fad-cb55-0f60-073345282186@redhat.com>
 <598fd2ca-14e6-12fd-c3fc-7b9c8e198952@redhat.com>
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
Message-ID: <9839e070-d59d-78fb-b47e-521ac8dc9c72@redhat.com>
Date: Fri, 20 Sep 2019 17:03:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <598fd2ca-14e6-12fd-c3fc-7b9c8e198952@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N0PR8KxstS5ZEk05TWdtEJgAXZut30f5e"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 20 Sep 2019 22:03:37 +0000 (UTC)
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N0PR8KxstS5ZEk05TWdtEJgAXZut30f5e
Content-Type: multipart/mixed; boundary="OBG5AFVOf06MEk1FDh3TfBSCNgTrW7BSD";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <9839e070-d59d-78fb-b47e-521ac8dc9c72@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2] nbd/server: attach client channel to the
 export's AioContext
References: <20190912110032.26395-1-slp@redhat.com>
 <4e84115f-5317-7e84-a30f-3ed94b170f06@redhat.com>
 <d2911bb2-8fad-cb55-0f60-073345282186@redhat.com>
 <598fd2ca-14e6-12fd-c3fc-7b9c8e198952@redhat.com>
In-Reply-To: <598fd2ca-14e6-12fd-c3fc-7b9c8e198952@redhat.com>

--OBG5AFVOf06MEk1FDh3TfBSCNgTrW7BSD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/20/19 2:11 PM, Eric Blake wrote:
> On 9/20/19 1:49 PM, John Snow wrote:
>>
>=20
>>>> To fix this, as soon we have the export corresponding to the client,=

>>>> we call qio_channel_attach_aio_context() to attach the QIOChannel
>>>> context to the export's AioContext. This matches with the logic at
>>>> blk_aio_attached().
>>>>
>=20
>>>
>>> I assume this patch has been superseded by Eric's later patches?
>>
>> Nevermind -- my filtering got messed up slightly and I missed the
>> followup. I see that Eric staged this.
>=20
> I actually think both patches are needed: this one covers transactions,=

> while my later patch was on top of this to protect shutdown.  But now
> you've made me curious; I'll see if my patch hoisted in front still
> solves everything, or if we really do need both.
>=20

Nope, both patches are still needed.  Sergio's fixes the assertion:
    (qemu) qemu-kvm: io/channel.c:411: qio_channel_restart_read:
Assertion `qemu_get_current_aio_context() =3D=3D
qemu_coroutine_get_aio_context(co)' failed.

while mine fixes:
+qemu: qemu_mutex_unlock_impl: Operation not permitted


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--OBG5AFVOf06MEk1FDh3TfBSCNgTrW7BSD--

--N0PR8KxstS5ZEk05TWdtEJgAXZut30f5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2FTLMACgkQp6FrSiUn
Q2oawQf/fck9NDdrt1lRVeOooml3M961Uh4s5EjkFHBe1KU7U9+9pVjYrx7rqZ1x
tAqEcZqMnFrRqLobntJHCchTJC1PdWly9OeAb6NVIIwUsn+3JtKktF7KUkudi2hF
PnkPzCgvyOqDJKnm0B+LIehqLPh6FrWeafRkvniGT25CkZaucZCAKAU9fOnsIhFx
MGIDNrW+SJizuucpVa/pWNJNYN6snwl6xNoZLiiS7wHU7VNGifM5w7GqAqFKX5kO
gr/AtU0n8tne3Vj6L0Ib0+rco8WRWHGk1f7lHzU5w3CwgJ/FOiPx7Dk+ZxgNnBzO
gaKHB4IjCAASVDrg3PVoVJjcNvjZNw==
=WbXY
-----END PGP SIGNATURE-----

--N0PR8KxstS5ZEk05TWdtEJgAXZut30f5e--

