Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF80C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782AF21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782AF21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyVo-0002YO-VJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAyUc-00022Y-ON
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAyUa-0008K4-8H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:37:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAyUZ-0008Jo-VO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CFD6308FBA0;
 Thu, 19 Sep 2019 15:37:11 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A24995D9CC;
 Thu, 19 Sep 2019 15:37:10 +0000 (UTC)
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
 <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
 <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
 <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
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
Message-ID: <e5956649-c691-c7f1-de33-afa2bb272a20@redhat.com>
Date: Thu, 19 Sep 2019 10:37:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q8LDkoWp3Cw39hGSwBpfgqxIEZXPEqSYD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 19 Sep 2019 15:37:11 +0000 (UTC)
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8LDkoWp3Cw39hGSwBpfgqxIEZXPEqSYD
Content-Type: multipart/mixed; boundary="WgfWRQ7gkfaoYwtUG3TL6rTLynBWxVtl0";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <e5956649-c691-c7f1-de33-afa2bb272a20@redhat.com>
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
 <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
 <CAFEAcA_P8H4=-tnKLrm+YTqH_p7x2oVjHq1Sg03m6ssrWnKsjw@mail.gmail.com>
 <07b8a4b8-79d2-a2f6-721d-e4a14917c808@redhat.com>
 <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>
In-Reply-To: <CAFEAcA9notWQ9JjZ87v3e19dEYeUpGhoZEGLUmf80XFEAcsegw@mail.gmail.com>

--WgfWRQ7gkfaoYwtUG3TL6rTLynBWxVtl0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/19/19 10:22 AM, Peter Maydell wrote:

> Alex looked at this and suggests the problem is probably because
> you're doing an in-tree build.

Bingo.  I thought we wanted to get rid of that, though.  What's the
status on forcing out-of-tree builds?  (I'll adapt, but only once
patches are in that force me to).

> Sphinx insists that it can't build
> output files into the source tree, so we have a thing where we
> set MANUAL_BUILDDIR to docs/built if we're doing an in-tree build.
> But the filename we add to DOCS is just "docs/interop/qemu-ga.8"
> so for an in-tree build the sphinx rule won't match it, and
> the install rune won't find it either.
>=20
> If that's the cause I think this untested fix should help:
>=20
> diff --git a/Makefile b/Makefile
> index 111082ce545..8d9dcb3aa4a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -325,7 +325,7 @@ endif
>  endif
>=20

[1]

>  ifdef BUILD_DOCS
> -DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
> docs/interop/qemu-ga.8
> +DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8
> $(MANUAL_BUILDDIR)/interop/qemu-ga.8

Not quite. This occurs prior to the line defining MANUAL_BUILDDIR,
resulting in:

  GEN     /interop/qemu-ga.8
opening "/interop": No such file or directory

But hoisting the following text up to point [1] makes the build complete
with sphinx installed.  Progress!

> # Sphinx does not allow building manuals into the same directory as
> # the source files, so if we're doing an in-tree QEMU build we must
> # build the manuals into a subdirectory (and then install them from
> # there for 'make install'). For an out-of-tree build we can just
> # use the docs/ subdirectory in the build tree as normal.
> ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> MANUAL_BUILDDIR :=3D docs/built
> else
> MANUAL_BUILDDIR :=3D docs
> endif
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--WgfWRQ7gkfaoYwtUG3TL6rTLynBWxVtl0--

--Q8LDkoWp3Cw39hGSwBpfgqxIEZXPEqSYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2DoKUACgkQp6FrSiUn
Q2pZjgf/ZcojC+11g88tz7OBTfJKSjRvlbbul3Hx5ABfbpg7olB+HSPo2fUbEaoS
vxpVcGQvu5Qd/N2XXAIk1RR1tRWeQWBgFahPc1KnrPJHeyVgsOnrH2sfujU9gqrD
D+DMJZgPH166bRePmERNBI3Df3zG4PEu6Qh84kjB94y8KeJlH8/MxZtIB+po+hu7
C6fEorzzmbuaHFtpcTMiIgb7Nv6vkFdG3NFTzygb/onGTq1I1D4+GVeMQtaekr0A
Wka5m0RrDXlN31vWBepIIrPlgWY7lHQycpUJjBOhoeYIRlIFdupG9EXLK91LEfww
uQ3EMT97jZw8BjutlxWsclX2ozFGbQ==
=MPkR
-----END PGP SIGNATURE-----

--Q8LDkoWp3Cw39hGSwBpfgqxIEZXPEqSYD--

