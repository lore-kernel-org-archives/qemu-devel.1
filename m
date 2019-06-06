Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB27C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A0C20866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A0C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsOC-0002UL-86
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:25:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYsNF-00022w-Kn
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYsN8-0004N9-6E
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hYsN3-0003oU-Ff
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:23:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A53497EBC4;
	Thu,  6 Jun 2019 13:23:55 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7684C7D66D;
	Thu,  6 Jun 2019 13:23:48 +0000 (UTC)
To: Tao Xu <tao3.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-9-tao3.xu@intel.com>
	<20190605164045.12bf194c@redhat.com>
	<58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
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
Message-ID: <c802e812-dabb-0ec6-4458-71f0379856c7@redhat.com>
Date: Thu, 6 Jun 2019 08:23:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PnMcIa7PCeox47ZPSFfQSl9IfhNRgeygE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 06 Jun 2019 13:23:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 08/11] numa: Extend the command-line to
 provide memory latency and bandwidth information
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com,
	Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PnMcIa7PCeox47ZPSFfQSl9IfhNRgeygE
From: Eric Blake <eblake@redhat.com>
To: Tao Xu <tao3.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, ehabkost@redhat.com, xiaoguangrong.eric@gmail.com,
 rth@twiddle.net, pbonzini@redhat.com, jingqi.liu@intel.com,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <c802e812-dabb-0ec6-4458-71f0379856c7@redhat.com>
Subject: Re: [PATCH v4 08/11] numa: Extend the command-line to provide memory
 latency and bandwidth information
References: <20190508061726.27631-1-tao3.xu@intel.com>
 <20190508061726.27631-9-tao3.xu@intel.com>
 <20190605164045.12bf194c@redhat.com>
 <58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
In-Reply-To: <58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/6/19 2:47 AM, Tao Xu wrote:
> On 6/5/2019 10:40 PM, Igor Mammedov wrote:
>> On Wed,=C2=A0 8 May 2019 14:17:23 +0800
>> Tao Xu <tao3.xu@intel.com> wrote:
>>
>>> From: Liu Jingqi <jingqi.liu@intel.com>
>>>
>>> Add -numa hmat-lb option to provide System Locality Latency and
>>> Bandwidth Information. These memory attributes help to build
>>> System Locality Latency and Bandwidth Information Structure(s)
>>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>>
>>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>> ---
> ...
>>> +##
>>> +{ 'struct': 'NumaHmatLBOptions',
>>> +=C2=A0 'data': {
>>> +=C2=A0=C2=A0 'initiator': 'uint16',
>>> +=C2=A0=C2=A0 'target': 'uint16',
>>> +=C2=A0=C2=A0 'hierarchy': 'HmatLBMemoryHierarchy',
>>> +=C2=A0=C2=A0 'data-type': 'HmatLBDataType',
>> I think union will be better here with data-type used as discriminator=
,
>> on top of that you'll be able to drop a bit of error checking above si=
nce
>> QAPI's union will not allow user to mix latency and bandwidth.
>>
> Hi Igor,
>=20
> I have quesion here, the 'hmat-lb' is a member of a union 'NumaOptions'=
,
> it seems can' use a union as a member of union.

It should be technically possible to expand the QAPI generators to allow
one union as a branch within another union, so long as there are no
collisions in identifiers, if that makes for the smartest on-the-wire
representation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--PnMcIa7PCeox47ZPSFfQSl9IfhNRgeygE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz5E+MACgkQp6FrSiUn
Q2qwNwgAqCoque8RfiGAW0K9TzhdjGVV16/qIv3zEizPou8uIY+OieEVDv2rPxqH
DUrpZM01W20hOZ/ctpVVGg9jN2gF103FX/pF/Tfh2M/SgQpcWFWiERuqb/7YrbAe
u8ME4+/2QzUYvOt/abpeYS1vXMd8mv3Ehn+x34rHcnDsuCHFX88bA1NuR6yma9ja
NqluIjym06hMkw2VwpzuXtCBGoMF60Ri8H6qvCoNpw35JrgSX9z3lHRTTXNgouz0
Hrq5ygiTnv8V6CwDku/on0HZXa81M20ZamM1epYupu0sAU2tVh/tvsv6t8Akvfnv
vLwno0YgL0vGlaeC0/2AZJiBsO5Oyw==
=EKLP
-----END PGP SIGNATURE-----

--PnMcIa7PCeox47ZPSFfQSl9IfhNRgeygE--

