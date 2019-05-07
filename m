Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A99C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD61205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD61205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1jv-0003GS-64
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:10:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1fe-0000LL-Ov
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1fb-0005VE-87
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hO1fa-0005Tl-Ve
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D5AE308FC4D;
	Tue,  7 May 2019 15:06:14 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 513C460BEC;
	Tue,  7 May 2019 15:06:12 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Tao Xu <tao3.xu@intel.com>
References: <20190507124853.9015-1-tao3.xu@intel.com>
	<20190507130722.GQ27205@redhat.com>
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
Message-ID: <69089c48-629c-1297-84cf-63877f803802@redhat.com>
Date: Tue, 7 May 2019 10:06:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507130722.GQ27205@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NxMxlAnYnuFjGFkKLo6lQ8fHAwSnTDrFc"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 07 May 2019 15:06:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
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
Cc: ehabkost@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, robert.hu@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NxMxlAnYnuFjGFkKLo6lQ8fHAwSnTDrFc
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Tao Xu <tao3.xu@intel.com>
Cc: ehabkost@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 robert.hu@intel.com, pbonzini@redhat.com, rth@twiddle.net
Message-ID: <69089c48-629c-1297-84cf-63877f803802@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
References: <20190507124853.9015-1-tao3.xu@intel.com>
 <20190507130722.GQ27205@redhat.com>
In-Reply-To: <20190507130722.GQ27205@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 8:07 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 07, 2019 at 08:48:53PM +0800, Tao Xu wrote:
>> As noted in
>> http://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02212.html
>=20
> Rather than pointing to the mailing list post, please just refer
> to the git commit hash that patch was merged under, which IIUC
> is c7a88b52f62b30c04158eeb07f73e3f72221b6a8.
>=20
>> Because MSR based feature has been supported by QEMU,
>> we add CPUID_7_0_EDX_ARCH_CAPABILITIES on Cascadelake-Server CPU
>> model, and add IA32_ARCH_CAPABILITIES MSR based features (RDCL_NO,
>> IBRS_ALL and SKIP_L1DFL_VMENTRY).
>>
>> And "014018e19b i386: Make arch_capabilities migratable" has been
>> in QEMU upstream, the CPUID_7_0_EDX_ARCH_CAPABILITIES can be
>> safely added into CPU Model.

Also, this paragraph:

>>
>> Changes in v2:
>>     - rebased patch to latest qemu base

is useful to the list reader but not to the permanent git history, so it
belongs better...

>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---

=2E..here, after the --- marker, so that 'git am' will strip it on the
maintainer's behalf when they prepare the patch for a pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NxMxlAnYnuFjGFkKLo6lQ8fHAwSnTDrFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzRnuIACgkQp6FrSiUn
Q2qtcQf+MP+pUSAtkD6LifsrLdmtSO/ZZQmedqtwFe0wsHwhEiuYRxo+J125AkML
YO6fsk34N/uaUgVd5Nl+Tv6KTC5gQFq5IqgTEHIOw/8dHe1jyGZDAvjSL1l5hzHS
WMGfn52mHDsc4ATezHBsb4swCkA1PEwPE58+yUK4APQ4YB/8gEnwJvnDW2MgKzUn
P/k62hrmXwyisTPwB4yqxytTCbb5gkATJMhpNj9t/dQHhUw7mRsCNy+5WhZm9XIn
ASwWFN6SOD2GIFJtNTrPFzhzEvXiloc/MkCAujDwYQQzqm59seT5HjOOBsnFNSRF
X3Hj/IwjYfZhgvJ1xKEcRJbINrxuXA==
=aIvr
-----END PGP SIGNATURE-----

--NxMxlAnYnuFjGFkKLo6lQ8fHAwSnTDrFc--

