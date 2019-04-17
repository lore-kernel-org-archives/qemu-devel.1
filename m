Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD45C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32E8204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 15:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32E8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGmxg-0002o5-UB
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 11:59:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmwj-0002N7-FL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmwi-0006T3-9v
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGmwf-0006NX-L4; Wed, 17 Apr 2019 11:57:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 834DB3001764;
	Wed, 17 Apr 2019 15:57:56 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A20D85C224;
	Wed, 17 Apr 2019 15:57:55 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190417154850.29110-1-kwolf@redhat.com>
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
Message-ID: <9c4ec9ec-d76a-bcb1-4cc4-94480d88aec2@redhat.com>
Date: Wed, 17 Apr 2019 10:57:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 17 Apr 2019 15:57:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv
 == NULL
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417155754.Ix9HsXDF3OofVG3tw21XltB8r6w_Xru6q3-CmNt31n4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com
Message-ID: <9c4ec9ec-d76a-bcb1-4cc4-94480d88aec2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv ==
 NULL
References: <20190417154850.29110-1-kwolf@redhat.com>
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 10:48 AM, Kevin Wolf wrote:
> Even for block nodes with bs->drv =3D=3D NULL, we can't just ignore a
> bdrv_set_aio_context() call. Leaving the node in its old context can
> mean that it's still in an iothread context in bdrv_close_all() during
> shutdown, resulting in an attempted unlock of the AioContext lock which=

> we don't hold.
>=20

Seems like an "interesting" bug to diagnose. At any rate, getting rid of
the short-circuiting makes sense, and it's nice that you did manage to
come up with a reliable reproducer.

> The reproducer I used is a qcow2 image on gluster volume, where the
> virtual disk size (4 GB) is larger than the gluster volume size (64M),
> so we can easily trigger an ENOSPC. This backend is assigned to a
> virtio-blk device using an iothread, and then from the guest a
> 'dd if=3D/dev/zero of=3D/dev/vda bs=3D1G count=3D1' causes the VM to st=
op
> because of an I/O error. qemu_gluster_co_flush_to_disk() sets
> bs->drv =3D NULL on error, so when virtio-blk stops the dataplane, the
> block nodes stay in the iothread AioContext. A 'quit' monitor command
> issued from this paused state crashes the process.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1631227
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3TQIACgkQp6FrSiUn
Q2pLDwf7BXLzr7TU5s7mqWWDeJVr11uYE+OhSFQxGLdWinPUPk5m3Ftz3XQBS5AY
jH57IliIx+w4fyvam5/Ovao4VYtTeCXFWuMWrgnvtc7obHWnKEhH1xlIZfvWYDhV
y0KlNhFyGpssoLhP8ERvqCfk3Duuo4zQCUFnyEmaBdCysvwiSREz8nY6LVL7dvX9
sVIVP/lk1KUJ6scWL3t4ZVWH6BdaAsNnJKwsY1lbiW68YQH6/orH4UwLo/1+qZQX
mmLChjI0ulOVKUS3TbiMBZ85/2fJ7Jr9Q4SC+iiqW3+YBDwWIcddc+RX21H8+WDC
Z3YZd8xIYjU5UCORtpc1nt3OxjZG0Q==
=A9FM
-----END PGP SIGNATURE-----

--3Ze7XvoicqEnr3kvoMXHVlatssZdKQDiw--

