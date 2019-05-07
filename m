Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452A0205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452A0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2Oo-0006u6-F8
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:52:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO2Mc-00054e-9m
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO2Mb-0001Bq-9n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO2MV-00016f-40; Tue, 07 May 2019 11:50:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 013AD19D058;
	Tue,  7 May 2019 15:50:34 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E84B7799D;
	Tue,  7 May 2019 15:50:23 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-7-thuth@redhat.com>
	<87ef5acsce.fsf@dusky.pond.sub.org>
	<b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
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
Message-ID: <3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
Date: Tue, 7 May 2019 10:50:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aSQZlKVTuz56dr3fTsY7PhvdEgwfmKQqC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 07 May 2019 15:50:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 6/7] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
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
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aSQZlKVTuz56dr3fTsY7PhvdEgwfmKQqC
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] tests/qemu-iotests/group: Re-use the
 "auto" group for tests that can always run
References: <20190502084506.8009-1-thuth@redhat.com>
 <20190502084506.8009-7-thuth@redhat.com> <87ef5acsce.fsf@dusky.pond.sub.org>
 <b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
In-Reply-To: <b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 10:22 AM, Thomas Huth wrote:
> On 07/05/2019 15.22, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Currently, all tests are in the "auto" group. This is a little bit po=
intless.
>>> OTOH, we need a group for the tests that we can automatically run dur=
ing
>>> "make check" each time, too. Tests in this new group are supposed to =
run
>>> with every possible QEMU configuration, for example they must run wit=
h every
>>> QEMU binary (also non-x86), without failing when an optional features=
 is
>>> missing (but reporting "skip" is ok), and be able to run on all kind =
of host
>>> filesystems and users (i.e. also as "nobody" or "root").
>>> So let's use the "auto" group for this class of tests now. The initia=
l
>>> list has been determined by running the iotests with non-x86 QEMU tar=
gets
>>> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. inclu=
ding
>>> macOS and FreeBSD).
>>
>> I wonder whether we should additionally limit "make check" to "quick"
>> tests.  How slow are the non-quick auto tests for you?
>=20
> I already sorted out some of the tests that run veeeery long, since the=

> run time on gitlab, cirrus-ci and travis is limited. "make check-block"=

> currently takes 3 minutes on my laptop, I think that's still ok?
>=20
> When I run the tests from the auto group that are not in the quick
> group, I currently get:
>=20

My personal threshold is about 5 seconds for quick, so:

> 003 1s ...
> 007 2s ...

Should these be moved to quick?

> 013 5s ...

this one is borderline

> 014 15s ...
> 015 9s ...

Definitely not quick, but if you think they are still okay for auto, I
can live with that.

> 022 1s ...

Another candidate for quick?

> 023 18s ...

Even longer than 14. Okay for auto?

etc.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aSQZlKVTuz56dr3fTsY7PhvdEgwfmKQqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzRqT8ACgkQp6FrSiUn
Q2qf9gf/URHgozVJ5oEZXyaK/gQEZkb1+kczVCjiosGHxH5MwFn1gCJpnOgJ1Or+
iCbZvjwp000yzDs91ld+6kwaDoHMHwt9IeJ0qVkwBBk6isiLKp/uJOf/syq/R5kK
wzHoONy+bqitcYT0K1R8g3wigEhbCPADQdWQ5hZIcsGM2/lWBYd/WQWS6261r+33
v4Cekh8MuBkkywHNTc1+loDDLSsRmWsOJFyDkm9Xe6icJClOd/CeAXmVVK9jJhTF
7/YMbedUaufIHcMPMIw0S6RJanJd9tefNqQwwNSsoOPuG87G6tB7Gx6KvvTQ3hpH
Xtn97BTDi+o+/zqFi5ke51/VC0W8TA==
=8HDF
-----END PGP SIGNATURE-----

--aSQZlKVTuz56dr3fTsY7PhvdEgwfmKQqC--

