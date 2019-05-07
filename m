Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834DC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A33020989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A33020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6EE-0005ap-AT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:58:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO67r-0000HR-Ac
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO67p-0007yF-Am
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO67h-0007pV-PG; Tue, 07 May 2019 15:51:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12AB23001C62;
	Tue,  7 May 2019 19:51:32 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F091001DCC;
	Tue,  7 May 2019 19:51:31 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
	<81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
	<f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
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
Message-ID: <e9280cc0-fd2d-0213-9883-f77138bd2831@redhat.com>
Date: Tue, 7 May 2019 14:51:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="edeK8Zb8mcZ8HTTJBBeF3LGIgC0Mk3QRN"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 07 May 2019 19:51:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--edeK8Zb8mcZ8HTTJBBeF3LGIgC0Mk3QRN
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <e9280cc0-fd2d-0213-9883-f77138bd2831@redhat.com>
Subject: Re: [PATCH 1/5] qemu-nbd: Add --pid-file option
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-2-mreitz@redhat.com>
 <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
 <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
In-Reply-To: <f34fb38c-22dd-1ed3-821d-7c8a9ea8943a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 2:39 PM, Max Reitz wrote:
> On 07.05.19 21:30, Eric Blake wrote:
>> On 5/7/19 1:36 PM, Max Reitz wrote:
>>> --fork is a bit boring if there is no way to get the child's PID.  Th=
is
>>> option helps.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
>>>  qemu-nbd.texi |  2 ++
>>>  2 files changed, 31 insertions(+)
>>>
>>
>>> @@ -111,6 +112,7 @@ static void usage(const char *name)
>>>  "                            specify tracing options\n"
>>>  "  --fork                    fork off the server process and exit th=
e parent\n"
>>>  "                            once the server is running\n"
>>> +"  --pid-file=3DPATH           store the server's process ID in the =
given file\n"
>>
>> Should --pid-file imply --fork, or be an error if --fork was not
>> supplied? As coded, it writes a pid file regardless of --fork, even
>> though it is less obvious that it is useful in that case. I don't have=
 a
>> strong preference (there doesn't seem to be a useful consensus on what=

>> forking daemons should do), but it would at least be worth documenting=

>> the intended action (even if that implies a tweak to the patch to matc=
h
>> the intent).
>=20
> I think the documentation is pretty clear.  It stores the server's PID,=

> whether it has been forked or not.
>=20
> I don't think we would gain anything from forbidding --pid-file without=

> --fork, would we?

I can't think of any reason to forbid it. So it sounds like we are
intentional, this writes the pid into --pid-file regardless of whether
that pid can be learned by other means as well.


>>> +    const char *pid_path =3D NULL;
>>
>> Bikeshedding: pid_name is nicer (path makes me think of $PATH and othe=
r
>> colon-separated lists, which this is not).
>=20
> I'd prefer pid_filename myself, then, because pid_name sounds like a
> weird way to say "process name". O:-)

Works for me, even if it is longer. Do you want to respin, or just have
me touch it up when folding it into my NBD tree?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--edeK8Zb8mcZ8HTTJBBeF3LGIgC0Mk3QRN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzR4cIACgkQp6FrSiUn
Q2pKTAf/S/lKnkyy4mJbrWeGKrBpgPSImfYYrraO+9EkjuhLyeXqdInmBydbOsJH
7OdfkP9D6TcHqIFTqTf8d0wpiTN/22T4R2vJOTtpT/SbinABsx7S0U7kgv/2vrXA
WKEqmK1IPP5+I7+PJsgM/sOPzsM4sgZzGdqWPSdy3Se4ConXuSX8kahBS8QDhD26
IyyT13Bi9bv7b4ptuRuJFnMNeGy6RwShtIdOeTio+Z4BvmN/hJQW7LvpyZ/jAYNb
3OQOKRkABAELV3opo/yxev+s5Y8GT8dx3+5LE6ZnYwZeU6lITQ8PZrFUz0QBEUxj
B+DPU6wGkRwKQXL3Xle3uYh4lQ47JA==
=t5Zv
-----END PGP SIGNATURE-----

--edeK8Zb8mcZ8HTTJBBeF3LGIgC0Mk3QRN--

