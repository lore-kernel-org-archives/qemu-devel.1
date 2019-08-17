Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB1C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 14:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6CB21744
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6CB21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz02d-0002Vx-4I
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hz01a-0001gd-Ke
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 10:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hz01Z-000471-KS
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 10:49:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hz01X-00045F-Bt; Sat, 17 Aug 2019 10:49:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F72D7FD45;
 Sat, 17 Aug 2019 14:49:42 +0000 (UTC)
Received: from [10.3.116.18] (ovpn-116-18.phx2.redhat.com [10.3.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10DC561B65;
 Sat, 17 Aug 2019 14:49:38 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
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
Message-ID: <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
Date: Sat, 17 Aug 2019 09:49:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UkV0YVBySgvTF2n5duz7HT8LIo58OyRqq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sat, 17 Aug 2019 14:49:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UkV0YVBySgvTF2n5duz7HT8LIo58OyRqq
Content-Type: multipart/mixed; boundary="TcsTaR8AhlWk7W2qUS1eQsWMmlQEcXeXz";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Message-ID: <fa4f4405-5a51-c7ec-f712-95e40ef6dd41@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>
In-Reply-To: <1677e835-39a1-4af3-8f4f-e1600021a2ee@redhat.com>

--TcsTaR8AhlWk7W2qUS1eQsWMmlQEcXeXz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/17/19 9:42 AM, Eric Blake wrote:
> On 4/5/19 9:24 AM, Andrey Shinkevich wrote:
>> On a file system used by the customer, fallocate() returns an error
>=20
> Which error?

Okay, I read the rest of the thread; EINVAL.  But the commit message was
not amended before becoming commit 118f9944.


>> =20
>> -        if (ret =3D=3D -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {=

>> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
>=20
> This change is a regression of sorts.  Now, you are unconditionally
> attempting the fallback for ALL failures (such as EIO) and for all
> drivers, even when that was not previously attempted and increases the
> traffic.  I think we should revert this patch and instead fix the
> fallocate() path to convert whatever ACTUAL errno you got from unaligne=
d
> fallocate failure into ENOTSUP (that is, just the file-posix.c location=

> that failed), while leaving all other errors as immediately fatal.

And the rest of the thread worried about that exact scenario.

Here's how I encountered it. I was trying to debug the nbdkit sh plugin,
with:

$ cat >script  <<\EOF
case $1 in
get_size) echo 1m;;
pread) false;;
can_write|can_zero) ;;
pwrite) ;;
zero) echo ENOTSUP; exit 1 ;;
*) exit 2;;
esac
EOF

(the script has a subtle bug; zero) should be using 'echo ENOTSUP >&2',
but because it didn't, nbdkit treats the failure as EIO rather than the
intended ENOTSUP)

coupled with:

$ qemu-io -f raw nbd://localhost:10810 -c 'w -z 0 1'

but when the script fails with EIO and qemu-io reported that the write
was still successful, I was confused (I was debugging a server-side
fallback to write, not a client-side one), until I discovered that we
changed the semantics in qemu 4.1 that EIO is no longer fatal and
attempts the write fallback.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TcsTaR8AhlWk7W2qUS1eQsWMmlQEcXeXz--

--UkV0YVBySgvTF2n5duz7HT8LIo58OyRqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1YFAIACgkQp6FrSiUn
Q2rC/Af/eaHq0d65KTtJdfGyXQTaeeC9M3Aytl1RCraTxCIh1oUPfu+q4noScSOB
EB6ckVpHIDJawYJeRNBBFYhMDv8uVATxElqUnNWw9nwfMqbgTaPB2IvsX7HIVDxL
UYlbZF0IYxagcfKoe1Dq8QTm9aFgBBmL03u9mt57c4rhvpHO4vJBl4L/yWmplGYK
7tXfoEpkT/xFw/KTzuUotYaK1Q0+seMclkvBRaerN0TmhOftmSKQLeUCXotiLntQ
HCK6nPfKuGAn1fvv9UATdFLXOeBzq6AUZmfDKkwjr0Scq9cE3wOmwqMsS2h1pW95
Gw8CeJ83gJPIOUtPN2ySHU1knoOEQw==
=/sUZ
-----END PGP SIGNATURE-----

--UkV0YVBySgvTF2n5duz7HT8LIo58OyRqq--

