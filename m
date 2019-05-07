Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD1C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C423205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C423205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2QO-0008Ug-RM
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:54:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO2Ox-0007by-Bm
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO2Ow-0003R7-7n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hO2Ov-0003Qq-Uu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 361B85D688
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 15:53:05 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D4A1646CA;
	Tue,  7 May 2019 15:53:01 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Nikos Mavrogiannopoulos <nmav@redhat.com>
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
	<CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
	<20190507152211.GU27205@redhat.com>
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
Message-ID: <4e9ff44c-fa61-71c5-f835-24047403ba67@redhat.com>
Date: Tue, 7 May 2019 10:53:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507152211.GU27205@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3fUHHFILuANk5945bcOtt2yaruHD6grpm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 07 May 2019 15:53:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
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
Cc: Markus Armbruster <armbru@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	"Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3fUHHFILuANk5945bcOtt2yaruHD6grpm
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Nikos Mavrogiannopoulos <nmav@redhat.com>
Cc: qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <4e9ff44c-fa61-71c5-f835-24047403ba67@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
 <CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
 <20190507152211.GU27205@redhat.com>
In-Reply-To: <20190507152211.GU27205@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 10:22 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 07, 2019 at 11:59:05AM +0200, Nikos Mavrogiannopoulos wrote=
:
>> In terms of RHEL what is preferred is (1) use a crypto lib, and (2) if=

>> that's not possible use getrandom(). That is summarized in this
>> article:
>>
>> https://www.redhat.com/en/blog/understanding-red-hat-enterprise-linux-=
random-number-generator-interface
>=20
> For QEMU this would mean re-writing the code to use qcrypto_random_byte=
s
> instead. This internal API is backed by a crypto lib if available,
> falling back to /dev/urandom or /dev/random on UNIX, or CryptGenRandom
> on Windows. We could add getrandom() support there too.
>=20
> The main question is whether to implement a new backends/rng-builtin.c
> or modify backends/rng-random.c so that it has a NULL filename by
> default, which would be taken as meaning use the qcrypto_random_bytes
> API.  The latter benefits that all existing VMs which don't have a
> filename set would get the new behaviour. The latter has downside
> that it is not discoverable from mgmt apps, so they won't know if
> they can rely on it or not.

Alas, our example in misc.json is:

# -> { "execute": "object-add",
#      "arguments": { "qom-type": "rng-random", "id": "rng1",
#                     "props": { "filename": "/dev/hwrng" } } }
# <- { "return": {} }

which is indeed one of the interfaces that evades introspection at the
present, so even if we made filename a StrOrNull, which would normally
show up in introspection when done on any other command, it is invisible
here. :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3fUHHFILuANk5945bcOtt2yaruHD6grpm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzRqdwACgkQp6FrSiUn
Q2oRugf/R32HaK1QHI9yqcOBPwCshq+8tMXwuKvyb4Ble45+H2Vd3qqeoCOeWEsB
UHmQugzGjEKZbVg4HYYFi45d6E4xv03xvxupcTvx2U9YfMB3QxQRnewRDXoPc5eF
50AirPvtn/psRoVyeg6XWbFnV9e9MmYaMqFlIPb+qLPvFus3jcUSMg6P3EEU1fcB
HQnsJ40Td4PE8776UBKCrvSzoiC3S5ZnpJDt171slgqDhnufXAobJuQOMmLb6Rc3
w9OcQCrDuV5sRtgWJsr3uACoapNWwrLmNkAzY7bUEzL8y9vEWGtCadJmPKIRFhGC
dY/175TUKVRgcpGgsAMUi7QmyPCh5A==
=N27V
-----END PGP SIGNATURE-----

--3fUHHFILuANk5945bcOtt2yaruHD6grpm--

