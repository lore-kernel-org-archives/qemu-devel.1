Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E6CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D106C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D106C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKSC-0003Ms-Vy
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iBKQL-0001Sj-7H
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iBKQI-0000N5-5j
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iBKQH-0000LL-SW
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:02:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9DC04E925;
 Fri, 20 Sep 2019 15:02:12 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFEAA5C1B5;
 Fri, 20 Sep 2019 15:01:53 +0000 (UTC)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
 <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
 <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
 <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>
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
Message-ID: <e6169704-2af8-95e7-d64d-9de8b5768cdc@redhat.com>
Date: Fri, 20 Sep 2019 10:01:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sGKWqnqkTQ2gLs3TrGLglGdZsVMW1Tpby"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 20 Sep 2019 15:02:12 +0000 (UTC)
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sGKWqnqkTQ2gLs3TrGLglGdZsVMW1Tpby
Content-Type: multipart/mixed; boundary="YDpetHQyQVOpNMBXEzzQKCNBsvSJ0fugU";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>
Message-ID: <e6169704-2af8-95e7-d64d-9de8b5768cdc@redhat.com>
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
References: <20190920141248.12887-1-philmd@redhat.com>
 <CAFEAcA981SOP7UqgXYcTt1s29TfiUwxWc9GoJd+m+BO4WHrz_g@mail.gmail.com>
 <f817b9a4-272e-c4c0-a4c4-5b5ebd7fd917@redhat.com>
 <CAFEAcA9KAc4viUy1X6f=f9Xm=_+H_JDJh1+USOHyPG76v5f_jw@mail.gmail.com>
 <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>
In-Reply-To: <a4c4f869-710d-930d-54f3-d43882cbb869@redhat.com>

--YDpetHQyQVOpNMBXEzzQKCNBsvSJ0fugU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/20/19 9:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>> I thought I read a comment about it between Eric/Stefan but I can't f=
ind
>>> it, maybe I dreamed it. (Cc'ed Eric).

Not from me.  But looking at scripts/tracetool/format/log_stap.py, I
suspect the dtrace via stap backend cannot support it.

Researching further,

https://sourceware.org/systemtap/langref.pdf

section 9.2 printf, states:

"The printf formatting directives are similar to those of C, except that
they are fully checked for type by the translator."

and does NOT list handling for '*' under precision or width.


>>
>> If my grep is correct we currently use the syntax already in
>> gt64120_read, gt64120_write, pflash_io_read, pflash_io_write,
>> pflash_data_read and pflash_data_write trace events.
>=20
> If you use 'git blame' you'll notice I added all of them, so better
> let's get a proper confirmation from Stefan :)
>=20
> I plan to use them more, I find them helpful to directly see the access=

> size looking at the value width.

You'll probably have to revert that, or else teach the various backend
generators how to dumb-down a format string containing it when coupled
with a backend that doesn't support it natively.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YDpetHQyQVOpNMBXEzzQKCNBsvSJ0fugU--

--sGKWqnqkTQ2gLs3TrGLglGdZsVMW1Tpby
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2E6eEACgkQp6FrSiUn
Q2pLAwf9FnNwDwOrCyHScwElB9EUEhNcpToaGKdTVVqDXyL1c65Ed+f8+zU5Zd0D
mrKi9cbcIpsn7scBcKElWpxoiHEw/kYo7wxeFXpnT9MnPhRr5GmBHRtnroAGTNB+
uRRDELKYFvSXdcZIOpTV/MyXNpIWtjeB/jLzt6CVFmU9biwYx3JTXIDlEvTbQVh5
gS/H5DwHUduZA2KsufUq/tpqcgEhBWnDx6cVTo0B0BrJYPno2V4LpDxiloiLrFw1
9ifXoP1kop3nRGQfDRxq5ifJCpK0JOVcbwaswlAHos1Ijmk//rrDmkDZR+DWwR3b
J3/HK5CFAr1DUoVXLh7seKOf0pxSMg==
=sY3H
-----END PGP SIGNATURE-----

--sGKWqnqkTQ2gLs3TrGLglGdZsVMW1Tpby--

