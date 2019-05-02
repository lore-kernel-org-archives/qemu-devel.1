Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E74C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E922087F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E922087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMJX2-0001VB-6s
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 17:46:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJV6-0008Dm-5E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJV3-0005KO-JD
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hMJUx-0005AM-SR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A1F683F4C;
	Thu,  2 May 2019 21:44:06 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CE54183AA;
	Thu,  2 May 2019 21:44:05 +0000 (UTC)
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20190430181343.1362-1-driver1998@foxmail.com>
	<141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
	<tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
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
Message-ID: <153ed8ff-73b1-b120-9f83-a143c6bdac64@redhat.com>
Date: Thu, 2 May 2019 16:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 02 May 2019 21:44:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502214405.Nj3vtmzPQsl9ZYttGP8eybP0HWMZnpXbrBCmzv2gjos@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU
From: Eric Blake <eblake@redhat.com>
To: driver1998 <driver1998@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <153ed8ff-73b1-b120-9f83-a143c6bdac64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
References: <20190430181343.1362-1-driver1998@foxmail.com>
 <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
 <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
In-Reply-To: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 4:05 PM, driver1998 wrote:
> On 5/1/19 2:30 AM, Eric Blake wrote:
>> Your entire series is missing 'In-Reply-To:' and 'References:' headers=
,
>> making each message show up as individual new threads rather than
>> properly threaded to a 0/4 cover letter. You'll want to fix your sendi=
ng
>> habits to avoid that problem in future submissions.
>=20
> I am terribly sorry about that, this is the first time I summit patches=
, and I am still getting used to the tooling.

That's okay, we were all first-timers once; and most human maintainers
try to be more forgiving than automated tools when it comes to working
around first-timer learning curves. There may be other useful hints you
can use at https://wiki.qemu.org/Contribute/SubmitAPatch

> Thank you for pointing out the issue though.
>=20
>> It's unusual to use a trailing '.' in the subject line. Also, your
>> subject is very long; commit message summaries should typically be
>> around 60-70 characters because 'git log' shows them with further
>> indentation, where an 80-column terminal window makes it hard to see t=
he
>> tail at a glance.  Better might be a short subject line explaining the=

>> "what", and then a non-empty commit message explaining the "why"
>=20
> Thank you for pointing out, I'll update that in the upcoming v3 set.
>=20
>> Question - does it hurt to make the define of __USE_MINGW_ANSI_STDIO
>> unconditional?  In other words, we're unlikely to break any non-mingw
>> platform if we drop the #ifdef __MINGW32__ line.
>=20
> I personally have no idea, so I'll keep it as is.

Fair enough for your patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZKUACgkQp6FrSiUn
Q2pdvQgAql9L8zApXNRLq5WkHnALApNsOTysaJjf/Raow/VeU2yZihhIdafKDpLJ
MmfhrDlWbIp3kTaqiaOCRpoBvuEt7ipoDTdjjNdDFZybOJuf6AKr6rSJv29O5MUc
Uz5ddl4urw/IR8lBQWL69tDnOUZC88BUVWlgRBorI6EqKCvcx4Q1JU4oaS9lRA2h
mQkx5NF1697DEic03w3pIbBuiPemDD6eS+8Ofz8N8oFuRXQ9C9BdaQIU0Y+gjtl0
1K4MkVePwJZIokAa9L3ZqByxwt5QoCqRQOIlQRCYZXZEsjOx1pskDnICU8vw7URU
Hdts6bO5xCMsypncfvr0V+IG0F1Ryg==
=Oo0Z
-----END PGP SIGNATURE-----

--oFhh7Xu7cvW0S1qfReAuLeHb6vmaxh9vU--

