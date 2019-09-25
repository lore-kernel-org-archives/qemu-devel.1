Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81874C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341472146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341472146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7Qv-0007Hd-4B
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iD7BM-0007MQ-LH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iD7BL-0006RP-Ex
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iD7BL-0006RA-6d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5542089AC6;
 Wed, 25 Sep 2019 13:18:10 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DBF060BF1;
 Wed, 25 Sep 2019 13:18:09 +0000 (UTC)
Subject: Re: [PULL 0/4] NBD patches for 2019-09-24
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190924123933.10607-1-eblake@redhat.com>
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
Message-ID: <09a35255-8384-4606-3273-6b4daf3661a7@redhat.com>
Date: Wed, 25 Sep 2019 08:18:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924123933.10607-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xPGv0EFCKpEXkOO460gGt80wOda18rPdj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 25 Sep 2019 13:18:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xPGv0EFCKpEXkOO460gGt80wOda18rPdj
Content-Type: multipart/mixed; boundary="CkXYlAL50AbvdkNoketB7iv3GEMADFKy9";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <09a35255-8384-4606-3273-6b4daf3661a7@redhat.com>
Subject: Re: [PULL 0/4] NBD patches for 2019-09-24
References: <20190924123933.10607-1-eblake@redhat.com>
In-Reply-To: <20190924123933.10607-1-eblake@redhat.com>

--CkXYlAL50AbvdkNoketB7iv3GEMADFKy9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 7:39 AM, Eric Blake wrote:
> The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd98=
563a:
>=20
>   Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg=
-2019-09-23' into staging (2019-09-23 15:44:52 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-09-24
>=20
> for you to fetch changes up to 506902c6fa80210b002e30ff33794bfc718b15c6=
:
>=20
>   tests: Use iothreads during iotest 223 (2019-09-24 07:30:19 -0500)
>=20
> ----------------------------------------------------------------
> nbd patches for 2019-09-05
>=20
> - Improved error message for plaintext client of encrypted server
> - Fix various assertions when -object iothread is in use
>=20

As this has not been merged yet, I'll post a v2 series adding one more
patch fixing a Coverity error, since Vladimir pointed out I missed that.

> ----------------------------------------------------------------
> Eric Blake (3):
>       nbd/client: Add hint when TLS is missing
>       nbd: Grab aio context lock in more places
>       tests: Use iothreads during iotest 223
>=20
> Sergio Lopez (1):
>       nbd/server: attach client channel to the export's AioContext
>=20
>  include/block/nbd.h        |  1 +
>  blockdev-nbd.c             | 14 ++++++++++++--
>  nbd/client.c               |  1 +
>  nbd/server.c               | 27 +++++++++++++++++++++++----
>  tests/qemu-iotests/223     |  6 ++++--
>  tests/qemu-iotests/223.out |  1 +
>  tests/qemu-iotests/233.out |  2 ++
>  7 files changed, 44 insertions(+), 8 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CkXYlAL50AbvdkNoketB7iv3GEMADFKy9--

--xPGv0EFCKpEXkOO460gGt80wOda18rPdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2LaREACgkQp6FrSiUn
Q2o/Ogf/WmLBVgIWk0x06P0h7jbiY8aEsF52kRfoWC068nVnkY4goyQJpFeJaN7i
Ybd8v64eUwQ47BokvNaexnpcqTqPHrR/md4ADwp2KbX5KKE/4Sn4XGnnmH7hPyX0
sLaXKwDGcZGqaWpY1ylLJFEVVHlCp+WO6C3cSWNWnplNTLtEqvmII6nSyvsx4uBj
/L0nQc7GZD8DZlHj8uxKQSNeYsX7riNJ3+qV/W4EnO3iFj+PVIxx/eIEz2AHVo3G
xnUuyUEcdhIvwrIpO9V3oo3XecENiB+yL7mwcCvjIfMHosE8bs5P4gZNHZSlDlUl
IrScjA+QtX7zocRmgryIQIhcYrFrKQ==
=3brC
-----END PGP SIGNATURE-----

--xPGv0EFCKpEXkOO460gGt80wOda18rPdj--

