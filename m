Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EF62064A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EF62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yaY-0005pp-G6
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2yZZ-0005FD-Hi
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2yZX-0005Mh-32
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i2yZW-0005LZ-QW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:05:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA59181129;
 Wed, 28 Aug 2019 14:05:12 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5F15D6B0;
 Wed, 28 Aug 2019 14:05:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <9d2ee7ad-a575-dc33-a7c7-dcaceea63792@virtuozzo.com>
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
Message-ID: <e0dd8b33-8711-8591-25f3-60ff626989b3@redhat.com>
Date: Wed, 28 Aug 2019 09:05:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9d2ee7ad-a575-dc33-a7c7-dcaceea63792@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I9Jaf7Cxo1Cy6si1BfRsSYHzYBBmerqeM"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 28 Aug 2019 14:05:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/5] Add NBD fast zero support to qemu
 client and server
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
Cc: "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9Jaf7Cxo1Cy6si1BfRsSYHzYBBmerqeM
Content-Type: multipart/mixed; boundary="sxdxhjp3YoqaiqLPWDoosiMeTVtq8x53N";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "libguestfs@redhat.com" <libguestfs@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>
Message-ID: <e0dd8b33-8711-8591-25f3-60ff626989b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Add NBD fast zero support to qemu client
 and server
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <9d2ee7ad-a575-dc33-a7c7-dcaceea63792@virtuozzo.com>
In-Reply-To: <9d2ee7ad-a575-dc33-a7c7-dcaceea63792@virtuozzo.com>

--sxdxhjp3YoqaiqLPWDoosiMeTVtq8x53N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/28/19 8:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.08.2019 17:37, Eric Blake wrote:
>> See the cross-post cover letter for more details:
>> https://www.redhat.com/archives/libguestfs/2019-August/msg00322.html
>>
>> Based-on: https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg048=
05.html
>> [Andrey Shinkevich block: workaround for unaligned byte range in fallo=
cate()]
>=20
> I assume, I can look at git://repo.or.cz/qemu/ericb.git fast-zero branc=
h?

Yes, I posted a fast-zero branch for all four projects that I touched
(with the obvious similar URLs). They might have non-fast-forward
changes as I rebase things (for example, the nbdkit stuff needs to
s/1.13.9/1.15.0/ in docs about which version introduced things), but
should be sufficient to reproduce experiments with the feature supported.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sxdxhjp3YoqaiqLPWDoosiMeTVtq8x53N--

--I9Jaf7Cxo1Cy6si1BfRsSYHzYBBmerqeM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1mihIACgkQp6FrSiUn
Q2pzigf/dCScJNRFxs3jJbSAeoqaKWwyGFKKiMtuIZ2slOJRkXM7scMQWUyDdLFf
OLJ36NjX51aTo5pChRf72URUQSUiinffjmvn6aemJhBYx/tqWRGp03pQoXQpQ0LZ
W8307KWwvvWo3llD08BRLgtlbtthXCMkB3QVAB3LpGKkLKzhVki7kHCwgu/HioDa
RbjjgeejVltcRG478gH5zyVQYEWBcYF5hpq3xtrWZObdTG4TRNvnIKB7ONNqCr1k
thrfoQvOUOMeDaOGT9fe4yDWsAxiUao2WF8L7oEIuLiLZYn7gO5xr5LfvjUoG6sc
FY/jrk60hSudvKYZlOi1qWB0NMFXwA==
=JzmC
-----END PGP SIGNATURE-----

--I9Jaf7Cxo1Cy6si1BfRsSYHzYBBmerqeM--

