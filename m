Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D103C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E989F21D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E989F21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44435 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAws3-0000UH-T4
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAwSg-0004eX-N1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAwSf-00007d-JD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iAwSf-000071-B1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B4DB3018ED0;
 Thu, 19 Sep 2019 13:27:04 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 545E45C1B5;
 Thu, 19 Sep 2019 13:27:04 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
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
Message-ID: <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
Date: Thu, 19 Sep 2019 08:27:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XzBCsKNlmbEjzugQAOJxyUphqmPNr9oKi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 19 Sep 2019 13:27:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XzBCsKNlmbEjzugQAOJxyUphqmPNr9oKi
Content-Type: multipart/mixed; boundary="mVKMKN6i9DE0IwLIrFTG2lFeX6qrydXVe";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <4324a9d9-6070-d014-27c9-77187cea1dfa@redhat.com>
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
 <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8nj27YwR3F0NA8JiV2yqqLcBzZ6T42Ue5FV2cUcmRoaQ@mail.gmail.com>

--mVKMKN6i9DE0IwLIrFTG2lFeX6qrydXVe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/19/19 7:00 AM, Peter Maydell wrote:

>> In an incremental build on Fedora 30, I'm now seeing:
>>
>>         CHK version_gen.h
>>   GEN     docs/interop/qemu-ga.8
>> No filename or title
>> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
>> Error 255
>>
>> and suspect this patch introduced it.  It may be that I just need to
>> nuke intermediate artifacts rather than an actual problem with the
>> patch, but I'd welcome help in identifying the problem.
>=20
> If you build with V=3D1 what does it say it's doing?

make[1]: Leaving directory '/home/eblake/qemu/dtc'
perl -Ww -- /home/eblake/qemu/scripts/texi2pod.pl -I docs -I scripts -I
docs/interop -DVERSION=3D"4.1.50" -DCONFDIR=3D"/usr/local/etc/qemu"
scripts/texi2pod.pl docs/interop/qemu-ga.8.pod && pod2man --utf8
--section=3D8 --center=3D" " --release=3D" " docs/interop/qemu-ga.8.pod >=

docs/interop/qemu-ga.8
No filename or title
make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
Error 255

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mVKMKN6i9DE0IwLIrFTG2lFeX6qrydXVe--

--XzBCsKNlmbEjzugQAOJxyUphqmPNr9oKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2DgicACgkQp6FrSiUn
Q2ovHgf/dB61SFVzTcEEHCibtuwkdAvnmIcLAsypdofwy+vt2O0+NVSXmRHas8ij
rv/ulc5L8GmzGUemEWYljEoFy9/1Eyx+Oxv+wvMCTE5rPpGZ1FTBTCLjTVwcFZGF
JVsO1uEzkHVLaqwPU9LNn8m5tf/hicighdffJyVa5CwFv1YXRrKOae83zK/hrZj0
4m5r5HusOWEU7YZq4WTRXsEfgBCuKIXZOtZPgmVBMccNlQszS2M912vvY0+huveP
svf2sKe5BMg8CQvWBHPW04ZC7rLbB/6FaDDVChtL0e0q97Oc8N5ArK2+iVUoO00a
vUz8lKoVJyjes6fE81Yls5YlEK3abg==
=SnLz
-----END PGP SIGNATURE-----

--XzBCsKNlmbEjzugQAOJxyUphqmPNr9oKi--

