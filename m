Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D736C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7AE2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7AE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd0R-000806-3l
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYckg-0002FL-25
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYckb-0002lJ-NA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hYckP-0001mw-OJ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2308444BC6;
	Wed,  5 Jun 2019 20:42:48 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C43299C5;
	Wed,  5 Jun 2019 20:42:39 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org> <20190605155006.GI8956@redhat.com>
	<20190605201335.GD22416@habkost.net>
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
Message-ID: <c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
Date: Wed, 5 Jun 2019 15:42:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605201335.GD22416@habkost.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mB9H1ncxQMP1rx8zX0r0vFHFwn1Vius58"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 05 Jun 2019 20:42:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mB9H1ncxQMP1rx8zX0r0vFHFwn1Vius58
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
References: <20190531192429.GH22103@habkost.net>
 <93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
 <871s0asvli.fsf@dusky.pond.sub.org> <20190605155006.GI8956@redhat.com>
 <20190605201335.GD22416@habkost.net>
In-Reply-To: <20190605201335.GD22416@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/5/19 3:13 PM, Eduardo Habkost wrote:

>> IOW, I don't think RHEL-7 support as a build platform blocks us from
>> dropping py2. We merely need to tweak our build platforms doc to clari=
fy
>> our intent wrt add-on yum repos.
>=20
> If we clarify the docs in QEMU 4.1, is there anything that
> prevents us from removing Python 2 support in QEMU 4.1 too?

My take (but not definitive): if we have any CI setups that are testing
RHEL 7 without software collections and/or EPEL, then save Python 2
removal for 4.2 to give us time to update CI setups. But if all of our
CI setups are already fine, and we clarify the docs, then I'm all for
getting rid of Python 2 support in 4.1.

Similarly, if we are going to outlaw in-tree builds, let's get that done
in 4.1 instead of waiting yet another release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mB9H1ncxQMP1rx8zX0r0vFHFwn1Vius58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz4KT8ACgkQp6FrSiUn
Q2qczAf/WPTA+pNuXAS3DiWqc4ABl1YmUJgOid+2p5ACO7or9qhMHlmuDrE2n3mv
EqbcRhBfNKuNajFa/V3s69Jy+MhlkYAGP00twrhJrQByFarfTcgdmeoj+JXKSe8V
eDbfDi7xPRHPz9LJzfwXXPel6yMTyCBzRblDT3oWiBef+TBx18XD0jMaLuy4sdGw
xhslWofBlqmWUnAE3UKed79dZkah4RxN8K65c+YZOcRyqVz3QMkUKoH3FAv9/M2N
WONRUImrNMMi5GEC7I5CsY1+sypvXHYBWvsC59yXssscgcTUGALdrnyayMCn+kWX
o2XsVZ03LpZTKYYcy0Cfd6bbWdNdrA==
=HKAr
-----END PGP SIGNATURE-----

--mB9H1ncxQMP1rx8zX0r0vFHFwn1Vius58--

