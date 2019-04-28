Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB10C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 02:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9822077B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 02:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9822077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKZpd-0002L4-An
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 22:46:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZoF-0001OF-6L
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZmH-0003gq-HY
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hKZmG-0003gM-6h; Sat, 27 Apr 2019 22:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8F59307D914;
	Sun, 28 Apr 2019 02:42:50 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C96BA1001E71;
	Sun, 28 Apr 2019 02:42:44 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
	<e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
	<6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
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
Message-ID: <3e826289-53f0-2086-3142-dd738039f9af@redhat.com>
Date: Sat, 27 Apr 2019 21:42:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Sun, 28 Apr 2019 02:42:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428024243.8Poro9xK_TmFE4sfg-pNn-DI3ixk6LZV_PRi9oEoR68@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christophe Fergeau <cfergeau@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <3e826289-53f0-2086-3142-dd738039f9af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-6-thuth@redhat.com>
 <6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
 <e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
 <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
In-Reply-To: <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/25/19 5:24 AM, Thomas Huth wrote:

>> Ok, thanks for the info. Looks like many tests are failing because qem=
u-io suddenly prints its program name in front of the error messages? E.g=
=2E:
>>
>> --- /tmp/qemu-test/src/tests/qemu-iotests/069.out	2019-04-24 16:52:31.=
000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/069.out.bad	2019-04-24 16:=
59:13.310226424 +0000
>> @@ -4,5 +4,5 @@
>> =20
>>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
>> -can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Cou=
ld not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>> +qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing =
file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>>
>> Does anybody from the block folks has a clue what might be going wrong=
 here?
>=20
> It's a regression in the current master branch, not caused by my series=
=2E
> The iotests also fail with vanilla master, e.g. reproducible with:
>=20
>  cd tests/qemu-iotests
>  ./check -qcow2 069
>=20
> It's caused by Christophe's commit here:
>=20
>  99e98d7c9fc1a1639fad2c638733b02f4b43aebe
>  qemu-io: Use error_[gs]et_progname()
>=20
> Christophe, could you please have a look?

The change in output is desirable, but yes, it does mean that iotests
need to have .out files updated to match.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzFEyMACgkQp6FrSiUn
Q2qtKQf9HD60A+WOtM0n1WIyvojMztKciJvE8ATW4C08oTZ90wDfcMnnafpcSePB
UQRKNwb+7F3+Rk9LzEnLZCwLQefJYztKJDBLy4E5axXqkz0CrilMbLGDvtKotiWm
jary26x3kmmlyPSeQbkx6TnSa971iItlBP25iGL7jpnbnY1f4fR7C47e2DceRBq/
aqS7G6KZU86573P/R53uYrXN8kZWD0sXyYm0PPtGTRdDf6SzotwvCuBmf/q4PgE+
+RbiuprX971k1Rylrk7ck6ZOjBw1qEuxoLm0M1IZ30o8DYiooruFdmcBPhI0H2Ci
o1AENbEf+O7pfmEkxRnvjyH/ZdvEag==
=kCXV
-----END PGP SIGNATURE-----

--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx--

