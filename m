Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB3C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D562146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D562146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCsCg-0001Ps-E4
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCryl-0005Ez-Ee
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCryi-0005B9-RB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:04:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCryf-00059J-Ga; Tue, 24 Sep 2019 17:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0FF420FF;
 Tue, 24 Sep 2019 21:04:04 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86E58608C0;
 Tue, 24 Sep 2019 21:04:00 +0000 (UTC)
Subject: Re: [PATCH v3 18/25] block: Fix error_append_hint usage
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-19-vsementsov@virtuozzo.com>
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
Message-ID: <94edc340-5cc0-d6ed-67c0-e8030a3bc38a@redhat.com>
Date: Tue, 24 Sep 2019 16:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924200902.4703-19-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5pRWrNbAXgTTzL09u36fPA27zGLyVo8Oe"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 24 Sep 2019 21:04:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 integration@gluster.org, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5pRWrNbAXgTTzL09u36fPA27zGLyVo8Oe
Content-Type: multipart/mixed; boundary="ktkysQrLLXPoRIp4hbPyzHt0b3U4GPcb6";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Jeff Cody <codyprime@gmail.com>,
 Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
 integration@gluster.org, John Snow <jsnow@redhat.com>
Message-ID: <94edc340-5cc0-d6ed-67c0-e8030a3bc38a@redhat.com>
Subject: Re: [PATCH v3 18/25] block: Fix error_append_hint usage
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-19-vsementsov@virtuozzo.com>
In-Reply-To: <20190924200902.4703-19-vsementsov@virtuozzo.com>

--ktkysQrLLXPoRIp4hbPyzHt0b3U4GPcb6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 3:08 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want append hint to errp, we must use ERRP_FUNCTION_BEGIN macro.
> Otherwise hint will not be appended in case of errp =3D=3D &fatal_err
> (program will exit before error_append_hint() call). Fix such cases.
>=20
> This commit (together with its neighbors) was generated by
>=20
> git grep -l 'error_append_hint(errp' | while read f; do \
> spatch --sp-file scripts/coccinelle/fix-error_append_hint-usage.cocci \=

> --in-place $f; done
>=20
> and then
>=20
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20

Your automation is cool!

> Still, for backporting it may be more comfortable to use only the first=

> command and then do one huge commit.
>=20
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c       | 1 +
>  block/dirty-bitmap.c | 1 +
>  block/file-posix.c   | 3 +++
>  block/gluster.c      | 2 ++
>  block/qcow.c         | 1 +
>  block/qcow2.c        | 1 +
>  block/vhdx-log.c     | 1 +
>  block/vpc.c          | 1 +
>  8 files changed, 11 insertions(+)

$ git grep -p 'error_append_hint(errp' block/ | grep '\.c=3D' | wc -l

produces 11 hits, very nicely matching up with your patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ktkysQrLLXPoRIp4hbPyzHt0b3U4GPcb6--

--5pRWrNbAXgTTzL09u36fPA27zGLyVo8Oe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KhL8ACgkQp6FrSiUn
Q2oYiQf8Cb85Lqc+efoQLGZtoEJiCGKs+3TyrkS2VDD3gUoKkccM/iCbz98trc8S
Hzvqc12Ia7rm/Ik0Kp9sPrda1yP2zhcJfon3n9OqFV62GlYm878uTzgZtYDbjZEv
Xrd4GDaEEp7GdXpNAbr9Q+lHZf4/86jJRQtIPujS3BxNqqF9SZ4LJS3w6aBhr/Zw
Ljbb642ai5XM5NdM8EMwPSRyqgOuV/wOAFG+bkE3KiC63FYN2n0St+o+AzW+og2s
OOe6hBgi2GlQOEHnhrVUSHiu6M3Wpr+NOUG1vDHi93Elqy3sqT+PtDG9oAomuiYV
gpqcsjzJElmSeUpFtJiheNniisetfw==
=ORAG
-----END PGP SIGNATURE-----

--5pRWrNbAXgTTzL09u36fPA27zGLyVo8Oe--

