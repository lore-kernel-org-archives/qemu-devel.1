Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17067C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EF42171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EF42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvguo-0006Uc-2C
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvguL-00064m-Oz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvguK-00040g-ON
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hvguK-000409-GD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64EB53008955;
 Thu,  8 Aug 2019 11:48:35 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDB45C21A;
 Thu,  8 Aug 2019 11:48:30 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
 <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
 <87pnlgl1sr.fsf@dusky.pond.sub.org>
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
Message-ID: <b0c67e68-2926-f8c4-b872-a57f54ca775f@redhat.com>
Date: Thu, 8 Aug 2019 06:48:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87pnlgl1sr.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kga6VXRbi5umuNjNUXOeTiwFy2buBXPye"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 11:48:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kga6VXRbi5umuNjNUXOeTiwFy2buBXPye
Content-Type: multipart/mixed; boundary="2BzRh6gtlUSxlEu1NrGurEJCD6pxv2121";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Message-ID: <b0c67e68-2926-f8c4-b872-a57f54ca775f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
 <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
 <87pnlgl1sr.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnlgl1sr.fsf@dusky.pond.sub.org>

--2BzRh6gtlUSxlEu1NrGurEJCD6pxv2121
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/7/19 11:27 PM, Markus Armbruster wrote:

>>>>  /*
>>>>   * Function types
>>>>   */
>>>>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>>>>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version=
_id);
>>>> +typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>>
>> Should we prefer a consistent form for function pointer typedefs?  Her=
e,
>> we've mixed 'rettype Name(params)' with 'rettype (*name)(params)'.
>=20
> Which of the two difference I can see do you mean?

Both :)

>=20
> CamelCase vs. lower_case_with_underscore?

Indeed, choosing a consistent naming convention to make it obvious we
are referring to a typedef naming a function signature may be useful.

>=20
> Parenthesis around the type name?  I wouldn't call that inconsistent, w=
e
> simply use parenthesis only when needed.

And the question of whether the * is implied by the typedef itself
(which we tend to avoid for typedefs to structures) or must be supplied
at the point of use.  It gets odd since C permits both 'FuncType f =3D
myfunc' and 'FuncType f =3D &myfunc', and since invoking through a
function pointer can be done as both 'f(args)' and '(*f)(args)'.
However, since we only have 3 uses total that declare a use of
SaveStateHandler and LoadStateHandler, compared to a LOT of use of
qemu_irq_handler, moving the '*' out of the declarations and into the
typedef of the former is a lot easier than moving the '*' out of the
typedef and into the declarations of the latter.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2BzRh6gtlUSxlEu1NrGurEJCD6pxv2121--

--Kga6VXRbi5umuNjNUXOeTiwFy2buBXPye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1MDA0ACgkQp6FrSiUn
Q2odTAf/d7cZBbhGJGl+UX7+Y8F+Ntgg2f6qne9yQHYgjF87IPkS4QIlMni4l7CD
ri/dNNw5qhftGS44iL8zVHDkRwZ6zWk8tx5+VPcFbaMAZCLA74HpB9m7PAMRbizt
q8yrZPcRvSS/pgycpG08GFKRCcZxaSxgJYltDulJxWU+u6eY5de1CbGKAyPUWWJu
kgdIlNU8rNkTd7i3QAp5BB8xqQXm2v6NnHnH5WLIVPazZHha5jo1VbyfgI71Qwry
5FbVlkrA5ZN/6RI26IwKSKml02mtYQOrz72XIsM1gZ9Asw+7Z5KSHxL81t2V4qHd
klDaJGAT1kTx9xL7XIYuWQeTQFSUQA==
=yrxs
-----END PGP SIGNATURE-----

--Kga6VXRbi5umuNjNUXOeTiwFy2buBXPye--

