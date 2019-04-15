Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2FDC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07AF206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07AF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4G9-0002sE-7x
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:15:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4FL-0002Uk-HU
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4FK-0008Ss-Ii
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hG4FI-0008LA-3B; Mon, 15 Apr 2019 12:14:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6862146233;
	Mon, 15 Apr 2019 16:14:10 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E7BD660C05;
	Mon, 15 Apr 2019 16:14:09 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190415155452.5115-1-kwolf@redhat.com>
	<20190415155452.5115-2-kwolf@redhat.com>
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
Message-ID: <e8cbce5a-6407-ed72-5344-230733caf7e8@redhat.com>
Date: Mon, 15 Apr 2019 11:14:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415155452.5115-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 15 Apr 2019 16:14:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Avoid COW during metadata
 preallocation
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415161408.2ktySYq2ZHC2WIZpsm4IMgKIDzjf8GdISWXNKM6H-cg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <e8cbce5a-6407-ed72-5344-230733caf7e8@redhat.com>
Subject: Re: [PATCH 1/4] qcow2: Avoid COW during metadata preallocation
References: <20190415155452.5115-1-kwolf@redhat.com>
 <20190415155452.5115-2-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:54 AM, Kevin Wolf wrote:
> Limiting the allocation to INT_MAX bytes isn't particularly clever
> because it means that the final cluster will be a partial cluster which=

> will be completed through a COW operation. This results in unnecessary
> data read and write requests which lead to an unwanted non-sparse
> filesystem block for metadata preallocation.
>=20
> Align the maximum allocation size down to the cluster size to avoid thi=
s
> situation.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0rdAACgkQp6FrSiUn
Q2oMvgf/fwGvs9cOvxAO/oUkGphldiegQoBeVyAxuU6TjcbH4IcOzGo5B85PWCsj
APZRpu1lIoxzWpF75LyIiXlCEbPr0mm+fvxmzqSTv3T6AUoEbZFbaD524r2Kaf6T
bIkWk86xHMQTlUOXNBp2hP5e4KvVCk98mxfJaSic+KfAALoIZzWWEFlydWh4Olnr
Ym2D1DnXtuX6oyFwo19eYyw8mUjiHx/3AGwTaD/mxCi/Is061+PKCMDV8zM9n4pr
CzACPDT1sLK9U+itaraNS6I6dTcSHfDb9EFZ8fOG48bMZ/dSKXI4ZBxhh49B9eLg
JFCugBSM0tehkZZYiU74rwyiVtE9og==
=3son
-----END PGP SIGNATURE-----

--D5qkspzTOEM88CTDnAUTWuweSQKUB39RZ--

