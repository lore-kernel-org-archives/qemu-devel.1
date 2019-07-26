Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E025C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245E821951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245E821951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1oE-00029H-CT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hr1o3-0001iW-Ep
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hr1o2-0005Co-7u
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hr1ny-00056D-NU; Fri, 26 Jul 2019 11:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5B6C882F2;
 Fri, 26 Jul 2019 15:06:45 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5B3C1C2;
 Fri, 26 Jul 2019 15:06:44 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726142710.GY3888@redhat.com>
 <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>
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
Message-ID: <94a702f6-10a3-4705-4ec4-496a1b5b0515@redhat.com>
Date: Fri, 26 Jul 2019 10:06:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4kiuKz8qSGf1130gW0vOBXTCrs9em0mZa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 26 Jul 2019 15:06:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] ssh: add password and privkey auth
 methods
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4kiuKz8qSGf1130gW0vOBXTCrs9em0mZa
Content-Type: multipart/mixed; boundary="9veo0Lpm7rD7ZRS6ayaYIFpo8OQR3aCDW";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>, "Richard W.M. Jones"
 <rjones@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <94a702f6-10a3-4705-4ec4-496a1b5b0515@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] ssh: add password and privkey auth
 methods
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726142710.GY3888@redhat.com>
 <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>
In-Reply-To: <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>

--9veo0Lpm7rD7ZRS6ayaYIFpo8OQR3aCDW
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/26/19 9:45 AM, Pino Toscano wrote:
> On Friday, 26 July 2019 16:27:11 CEST Richard W.M. Jones wrote:
>> On Fri, Jul 26, 2019 at 04:09:52PM +0200, Pino Toscano wrote:
>>> These two patches add the password and private key authentication
>>> methods to the ssh block driver, using secure objects for
>>> passwords/passphrases.
>>
>> I was attempting to test this but couldn't work out the full command
>> line to use it (with qemu-img).  I got as far as:
>>
>> $ ./qemu-img convert -p 'json:{ "file.driver": "ssh", "file.host": "de=
vr7", "file.path": "/var/tmp/root", "file.password-secret": "..." }' /var=
/tmp/root
>>
>> I guess the secret should be specified using --object, but at that
>> point I gave up.
>=20
> Almost there :) add e.g.
>   --object 'secret,id=3Dsec0,file=3Dpasswd'
> as parameter for the convert command (so after it, not before), and the=
n
> set 'sec0' as value for file.password-secret.  Of course 'sec0' is
> arbitrary, any other QEMU id will do.
>=20
> A long helpful comment in include/crypto/secret.h explains the basics
> of the crypto objects.

That is useful information, but even more useful if you amend the commit
message to include a working example command line rather than making
readers chase down the docs :)

Untested, but piecing together what I know from my work on qemu-nbd
encryption, it seems like this should be a starting point for such a
command:

qemu-img convert -p --imageopts --object secret,id=3Dsec0,file=3Dpasswd \=

  driver=3Dssh,host=3Ddevr7,path=3D/var/tmp/root,password-secret=3Dsec0 \=

  /var/tmp/copy

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--9veo0Lpm7rD7ZRS6ayaYIFpo8OQR3aCDW--

--4kiuKz8qSGf1130gW0vOBXTCrs9em0mZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl07FwMACgkQp6FrSiUn
Q2od5Af+J3HTYQ6PTasE31mbHwKqZCeSEWaLEjtO+kZhpD8VnNfOX2YmB+rYYXkE
bEX29IhfG4VWd/di+zhiPxmHScRJoc2Jy/zqYJ8tMuTEd17rgWFO6cmR+UmzCeXn
gMh2vku2Tg4mRQp2gKKkjN7VYnamCxAC5ghvtw0BUk+uIJRZvbapx77HtZK3znuU
vXJpRTTDjK/nBPMQEVnlFg8r6h6iAAcpSp1lLrkqSitFjfkrnVvEaPw7vq7PeRsh
UHidzoGz7h94JLiY2ZjWOv7RVUARfCScoVV5455IiAo39+h40v1Vr987lzOHH1lr
NNFFEwp2oInzN/RhnG+3Fzn3dXGupA==
=bNc8
-----END PGP SIGNATURE-----

--4kiuKz8qSGf1130gW0vOBXTCrs9em0mZa--

