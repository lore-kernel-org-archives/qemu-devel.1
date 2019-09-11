Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10C5C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A230F2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A230F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Aky-0001RI-R1
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 18:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i8Aia-0007yd-6h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i8AiZ-0002Hr-37
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i8AiT-0002Dg-TM; Wed, 11 Sep 2019 18:03:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D4F218C426C;
 Wed, 11 Sep 2019 22:03:56 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E73467630;
 Wed, 11 Sep 2019 22:03:53 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
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
Message-ID: <5c1488f6-00ed-9d28-f544-a198f2fada94@redhat.com>
Date: Wed, 11 Sep 2019 17:03:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="97qlybAIkBaT7TdCl8bzEXq0oFQLPn4gv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 11 Sep 2019 22:03:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--97qlybAIkBaT7TdCl8bzEXq0oFQLPn4gv
Content-Type: multipart/mixed; boundary="w21t4e7s8AhhjqpxUAPx7NMhyL1aDBGFC";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <5c1488f6-00ed-9d28-f544-a198f2fada94@redhat.com>
Subject: Re: [PATCH] nbd/server: attach client channel to the export's
 AioContext
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>
In-Reply-To: <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com>

--w21t4e7s8AhhjqpxUAPx7NMhyL1aDBGFC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/11/19 4:33 PM, Eric Blake wrote:

> I tried to test this patch, but even with it applied, I still got an
> aio-context crasher by attempting an nbd-server-start, nbd-server-add,
> nbd-server-stop (intentionally skipping the nbd-server-remove step) on =
a
> domain using iothreads, with a backtrace of:

The crash also reproduces with nbd-server-remove instead of
nbd-server-stop.  Both QMP commands eventually call into the
blk_remove_bs() that calls the fatal blk_drain().  So libvirt can't work
around the bug merely by adding an nbd-server-remove step.

>=20
> #0  0x00007ff09d070e35 in raise () from target:/lib64/libc.so.6
> #1  0x00007ff09d05b895 in abort () from target:/lib64/libc.so.6
> #2  0x000055dd03b9ab86 in error_exit (err=3D1, msg=3D0x55dd03d59fb0
> <__func__.15769> "qemu_mutex_unlock_impl")
>     at util/qemu-thread-posix.c:36
> #3  0x000055dd03b9adcf in qemu_mutex_unlock_impl (mutex=3D0x55dd062d509=
0,
> file=3D0x55dd03d59041 "util/async.c",
>     line=3D523) at util/qemu-thread-posix.c:96
> #4  0x000055dd03b93433 in aio_context_release (ctx=3D0x55dd062d5030) at=

> util/async.c:523
> #5  0x000055dd03ac421b in bdrv_do_drained_begin (bs=3D0x55dd0673a2d0,
> recursive=3Dfalse, parent=3D0x0,
>     ignore_bds_parents=3Dfalse, poll=3Dtrue) at block/io.c:428
> #6  0x000055dd03ac4299 in bdrv_drained_begin (bs=3D0x55dd0673a2d0) at
> block/io.c:434
> #7  0x000055dd03aafb54 in blk_drain (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:1605
> #8  0x000055dd03aae054 in blk_remove_bs (blk=3D0x55dd06a3ec40) at
> block/block-backend.c:800


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--w21t4e7s8AhhjqpxUAPx7NMhyL1aDBGFC--

--97qlybAIkBaT7TdCl8bzEXq0oFQLPn4gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl15b0gACgkQp6FrSiUn
Q2piYwf/UtTIo4QAUkecq0CoSL6CnE3ISc393I+aKoRKKL/SQ2PzhCS9qylMr6Vk
oeA+E7nuzL3STLDmkRYBOSqjC0BkG0O/10P+QlM6g9yM5mtq1pSvY4/5IUDLJKUE
ZVprx53F5ZstlPHOC9/w0GEF/zB2HyzIkMrvaqjosZrBZSn4OEndzYDIn/AXo7DC
uu2hdk/hvUMTG9HTQl8Mr5DJx+fMV8YZU6wzC807bAw5tbS3ahNZmkYpanWEqwb4
QGoPVkv0FIWu8bGZ/ULDBoxJhFe4Jb3+j5zoudmQl/arzWZaJjMEmA+1zqAkquSE
aWmuJUHsySc4dITiQ/nThf9d7xCW3Q==
=+NP4
-----END PGP SIGNATURE-----

--97qlybAIkBaT7TdCl8bzEXq0oFQLPn4gv--

