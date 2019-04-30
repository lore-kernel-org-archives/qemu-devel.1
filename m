Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CB720835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CB720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXSO-0006Qe-Rs
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:26:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXRa-00065D-MN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXRZ-0007Vk-LY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLXRZ-0007UP-D9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8FD5309703F;
	Tue, 30 Apr 2019 18:25:27 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 35026D1C4;
	Tue, 30 Apr 2019 18:25:27 +0000 (UTC)
To: Cao Jiaxi <driver1998@foxmail.com>, mdroth@linux.vnet.ibm.com
References: <20190430181257.1265-1-driver1998@foxmail.com>
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
Message-ID: <b2f0fc78-f9ca-ae2c-d800-9b25d220b7dd@redhat.com>
Date: Tue, 30 Apr 2019 13:25:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430181257.1265-1-driver1998@foxmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 30 Apr 2019 18:25:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warning
 in commands-win32.c, hit by clang.
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430182526.M2GhVMckdPyjtzQ7FIkb-y-xJQ0GCoqxXKkUO2D3JRM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv
From: Eric Blake <eblake@redhat.com>
To: Cao Jiaxi <driver1998@foxmail.com>, mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org
Message-ID: <b2f0fc78-f9ca-ae2c-d800-9b25d220b7dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion warning
 in commands-win32.c, hit by clang.
References: <20190430181257.1265-1-driver1998@foxmail.com>
In-Reply-To: <20190430181257.1265-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 1:12 PM, Cao Jiaxi wrote:
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  qga/commands-win32.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

Can you paste the actual warning message you were getting?

>=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d40d61f605..4cdd2950bf 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -458,23 +458,24 @@ void qmp_guest_file_flush(int64_t handle, Error *=
*errp)
>  #ifdef CONFIG_QGA_NTDDSCSI
> =20
>  static STORAGE_BUS_TYPE win2qemu[] =3D {
> -    [BusTypeUnknown] =3D GUEST_DISK_BUS_TYPE_UNKNOWN,

> +    [BusTypeUnknown] =3D (STORAGE_BUS_TYPE)GUEST_DISK_BUS_TYPE_UNKNOWN=
,

This adds lots of explicit casts. Are they actually necessary? Without
seeing the actual warning, it seems fishy to have to be this explicit.


> @@ -483,7 +484,7 @@ static GuestDiskBusType find_bus_type(STORAGE_BUS_T=
YPE bus)
>      if (bus >=3D ARRAY_SIZE(win2qemu) || (int)bus < 0) {
>          return GUEST_DISK_BUS_TYPE_UNKNOWN;
>      }
> -    return win2qemu[(int)bus];
> +    return (GuestDiskBusType)win2qemu[(int)bus];

Or is it complaining that GuestDiskBusType and STORAGE_BUS_TYPE are
distinct types, and that we are indeed cross-assigning between the two
enums because we intentionally want them to share values?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIkxYACgkQp6FrSiUn
Q2qvSQf/c0U5e7lgfwgoomKqIePk/5fdFoELN2yvvCIe5TWnwJCp7X1oqlPwxNUg
WAmgVNaPFL84K7tM7kqSFszfKoc/nLPbzLu/2WD/+5cGdBorP3Sgz140j9fxAlEI
CpSo8sIilCy1sw710fGheBs0evc3t4bfNNgvL5VeUj8D1Ji94fxQuhC0MpKO4agT
VGjqM2qMIX3bhnXoZ4cOn2jzQ3IHDqjo0hUYntTjZc65Qo0MESmEAOqS7cfhclfm
KP2cRf8Ss3wDct6H2DFyuWLQP1UV/LGqB6FfVJi82jjZibeQ1wghzlcIKElUt/cl
EtuF33767f4goDBl5wdQFRSFPE0x1g==
=IgVz
-----END PGP SIGNATURE-----

--4YPsYRHHENTZMhR1MGcFHMat1EonXw0Qv--

