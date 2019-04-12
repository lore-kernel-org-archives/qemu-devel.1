Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84198C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A792077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A792077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzlF-0000dI-4y
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:14:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEzkT-0000MM-FM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEzkS-0000b9-DV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hEzkR-0000aX-Vl
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B25B3082E25;
	Fri, 12 Apr 2019 17:13:54 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D15E85D9CD;
	Fri, 12 Apr 2019 17:13:52 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
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
Message-ID: <fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
Date: Fri, 12 Apr 2019 12:13:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 12 Apr 2019 17:13:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
	yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412171351.gujkzirL4yLtjX2udJNU-mFPKMITTM25P0S1eJ0Gjf0@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Message-ID: <fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/12/19 7:20 AM, Yury Kotov wrote:
> Hi,
>=20
> I've added 'inline-fd:' proto to simplify migration to/from fd.
> I thought about modifying the existing 'fd:' proto but I'm not sure it'=
s a
> good idea to change it's contract.
>=20
> Existing 'fd:' proto works with previously added fd by getfd or add-fd =
commands.
> If client doesn't want to work with this fd before or after migration t=
hen it's
> easier to send an fd with the migrate-* command. Also, client shouldn't=
 maintain
> this fd.

While the sentiment of making it easier by having fewer QMP commands
might be worthwhile, I'm worried about whether this scales. Having just
a limited set of commands that take an fd over SCM rights, and every
other command wired to automagically work with existing named fds,
scales a lot easier than having to teach individual commands how to take
an fd inline.

At the very least, if we DO decide we like this, then I'd at least hope
that you made this addition introspectible (how can management learn
whether the 'inline-fd:' protocol is supported, and even more
importantly, which commands require an inline fd via SCM rights to be a
valid command based, especially if accepting or rejecting an inline fd
is conditional on other arguments to the command).

>=20
> Usage:
> { 'execute': 'migrate', 'arguments': { 'uri': 'inline-fd:' } }
> { 'execute': 'migrate-incoming', 'arguments': { 'uri': 'inline-fd:' } }=

>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlywx08ACgkQp6FrSiUn
Q2odIAf/WcKPhy1fIDf2yroe9aBtCw6P0OVX96MqPlSbT+uJdoODnE+aSv7SajVY
4N5BjAf9gvHkThK9odFssaLNgipDevtM96oHk1MavoCDz3z3ItiWWVuiKFf3fVDn
Oq7Py/Nmk06RKc3s9fUxcjaMBTRK8HJLD4IpbqbHq5bpRIvIQN3t1/V9ZtwZui3D
8ozH6h1ycRsZBfSl3qZ45hKZPbnfMFW3TJv/3I+30MbMGqfhggTpTm/jDqcFkBf4
Qzzb3ROmNDJBww9yVnJTWop/a9OkG+G2eLTuALfUkUjYlWQ6f0U9ngN0jk9ijc7O
aQdBjVkOEVQLtXLI7fBYFrpr59lQlQ==
=A25u
-----END PGP SIGNATURE-----

--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD--

