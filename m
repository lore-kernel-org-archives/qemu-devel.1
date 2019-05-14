Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA3EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC39C20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC39C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfGm-0002ty-VD
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:47:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfD1-0000c5-DO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfD0-0007ur-0E
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hQfCy-0007qe-Sm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D691307D910;
	Tue, 14 May 2019 21:43:35 +0000 (UTC)
Received: from [10.3.116.43] (ovpn-116-43.phx2.redhat.com [10.3.116.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA0B65D6A6;
	Tue, 14 May 2019 21:43:34 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<877eatdq3w.fsf@dusky.pond.sub.org> <20190514152331.GJ25916@redhat.com>
	<d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
	<20190514165036.GA7680@redhat.com>
	<f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
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
Message-ID: <dfed572d-6104-8ada-3bd8-1231dc6d6392@redhat.com>
Date: Tue, 14 May 2019 16:43:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YfrUyl5bOcMKTyAn9h7EDSbuyEqdNFc74"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 14 May 2019 21:43:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YfrUyl5bOcMKTyAn9h7EDSbuyEqdNFc74
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <dfed572d-6104-8ada-3bd8-1231dc6d6392@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and ARMv8.5-RNG
 etc
References: <20190510173049.28171-1-richard.henderson@linaro.org>
 <877eatdq3w.fsf@dusky.pond.sub.org> <20190514152331.GJ25916@redhat.com>
 <d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
 <20190514165036.GA7680@redhat.com>
 <f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
In-Reply-To: <f0da55b5-e14d-e718-0608-fa37d1cb6c2b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 12:46 PM, Richard Henderson wrote:
> On 5/14/19 9:50 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, May 14, 2019 at 09:14:57AM -0700, Richard Henderson wrote:
>>> Yes, that would do it.  We would need something in the test that forc=
es the
>>> objects into the link.  Without having yet looked at the test cases, =
any ideas?
>>
>> I don't think this is only the test suite. I think it will affect all =
the
>> binaries we build
>=20
> You're right, it does.
>=20
> $ nm aarch64-softmmu/qemu-system-aarch64  \
>   | grep qcrypto_tls_creds_x509_register_types
>=20
> comes up empty.
>=20
> It didn't occur to me that there was nothing in the object files for th=
e
> reference.  I'll have to drop the crypto-obj-y patch and come up with a=

> different solution.

Isn't there a gcc annotation for marking a simple as mandatorily
included during link?

/me goes looking...

__attribute__((externally_visible)) sounds promising (it nullifies the
effects of -fwhole-program, so that a function remains visible even if
the linker would have otherwise suppressed it)

__attribute__((used)) also sounds useful (the function must be emitted
even if it does not appear to be referenced, which may be enough for the
linker to infer that it is used)

There may be other tricks, although I didn't go searching very hard.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YfrUyl5bOcMKTyAn9h7EDSbuyEqdNFc74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzbNoUACgkQp6FrSiUn
Q2r4/wgAjaSc1QCHYQvuMoAL6zHXl+Vbacs0JZnYTvvY+Kf3ttJ1TX9qdGRr8jCi
h7gSEZCSweA+D28jduW/wVg581yK6OJkXmT5x9iEv25e99MZSwBwiyhm/l8sFfP7
BeWkuJUErg6qVd02F9ro6H8vCGwCdZfIeQCY6NHCnm+Kbjo7VaHOc0Ha30+TK0Vf
2g6Kzurmg9B7SAkXwGmv0TmBTxk1nZr/gPEuPkDFexof+lfM5VpmT+Zx+SKrQLZp
2mnAU/vDTysqxTIgGVuQ9Z++C5PQ0WpaGEBd95BGCtmQxMeFH6ZqNdwf36sCj7Mg
/IRpJ8RUeC+bCkWuj4dhSB4Q/1T3Eg==
=SmN1
-----END PGP SIGNATURE-----

--YfrUyl5bOcMKTyAn9h7EDSbuyEqdNFc74--

