Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD17AC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 20:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D93208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 20:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D93208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVjBs-0004Uq-Pj
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 16:59:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hVjB4-00046P-P5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hVjB3-00088O-Qf
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hVjB3-00085H-I8
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D0923179172;
	Tue, 28 May 2019 20:58:31 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 107FF5D6A9;
	Tue, 28 May 2019 20:58:25 +0000 (UTC)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190528204838.21568-1-kraxel@redhat.com>
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
Message-ID: <96d581a7-ce85-2347-cee1-bc4043eaed47@redhat.com>
Date: Tue, 28 May 2019 15:58:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528204838.21568-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jBymMN9k0iEPcg6JuvvBjd0jnXsb8pcor"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 28 May 2019 20:58:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] q35: split memory at 2G
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jBymMN9k0iEPcg6JuvvBjd0jnXsb8pcor
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <96d581a7-ce85-2347-cee1-bc4043eaed47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] q35: split memory at 2G
References: <20190528204838.21568-1-kraxel@redhat.com>
In-Reply-To: <20190528204838.21568-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/28/19 3:48 PM, Gerd Hoffmann wrote:
> Original q35 behavior was to split memory 2.75 GB, leaving space for th=
e

s/memory/memory at/

> mmconfig bar at 0xb000000 and pci I/O window starting at 0xc0000000.
>=20
> Note: Those machine types have been removed from the qemu codebase
> meanwhile because they could not be live-migrated so there was little
> value in keeping them around.
>=20
> With the effort to allow for gigabyte-alignment of guest memory that
> behavior was changed:  The split was moved to 2G, but only in case the
> memory didn't fit below 2.75 GB.
>=20
> So today the address space between 2G and 2,75G is not used for guest
> memory in typical use cases, where the guest memory sized at a power of=


s/memory/memory is/

> two or a gigabyte number.  But if you configure your guest with some od=
d
> amout of memory (such as 2.5G) the address space is used.

s/amout/amount/

>=20
> This patch removes that oddity for 4.1+ machine types.  The memory is
> splitted at 2G no matter what.

s/splitted/split/

>=20
> Cc: L=C3=A1szl=C3=B3 =C3=89rsek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/pc.h | 1 +
>  hw/i386/pc.c         | 1 +
>  hw/i386/pc_q35.c     | 7 ++++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jBymMN9k0iEPcg6JuvvBjd0jnXsb8pcor
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlztoPEACgkQp6FrSiUn
Q2o1nggApWnZj0bYFp+TfGqDJt/qfxbRvAd/Maf7XIgqWodV6LUTM6tdprXynI+7
zrILQP+OLpEsn5bVMWumaI93cxwL7koG+m8S6UgMShkklV/Q//NAMXnQsWxHilOy
gfjMn+asGnsVh0H5QdtyWB4Tr9rn04JF+DKAw+FDySVWaAPx4H1oqb3f0tLusawB
q2zeYxG8KSblXFSrSfM80zXR8ByPHr22yFqISsWjfvZrVuoj5CIF5z3Jf3ko3Pd5
7NEX9/fmHFH3mv2C5YySKziDfFrzhaiDnzTAb20jmNzH+p3QHpf+rfxh0pLkB5ze
J9omikv8rs08hlRoAE7yip2r+mmBfg==
=QCh6
-----END PGP SIGNATURE-----

--jBymMN9k0iEPcg6JuvvBjd0jnXsb8pcor--

