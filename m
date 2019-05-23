Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED5620863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED5620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTntp-0005fz-5S
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTnfF-0000nk-Gu
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTnfE-0004oL-DF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hTnfE-0004nx-6R
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 939B29FFC9;
	Thu, 23 May 2019 13:21:42 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72B621001E63;
	Thu, 23 May 2019 13:21:30 +0000 (UTC)
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
References: <20190523102449.2642-1-pagupta@redhat.com>
	<20190523102449.2642-2-pagupta@redhat.com>
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
Message-ID: <cf892fc7-37f8-5819-eba7-dd007ed4f2c5@redhat.com>
Date: Thu, 23 May 2019 08:21:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102449.2642-2-pagupta@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xwUJTxDGNncjdz9XJnty5Stunhs88gmLR"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 13:21:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/7] virtio-pmem: add virtio device
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
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
	xiaoguangrong.eric@gmail.com, mst@redhat.com, riel@surriel.com,
	david@redhat.com, armbru@redhat.com, ehabkost@redhat.com,
	lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
	imammedo@redhat.com, dan.j.williams@intel.com, nilal@redhat.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xwUJTxDGNncjdz9XJnty5Stunhs88gmLR
From: Eric Blake <eblake@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, lcapitulino@redhat.com, dan.j.williams@intel.com,
 kwolf@redhat.com, imammedo@redhat.com, nilal@redhat.com, riel@surriel.com,
 stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
 cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
 armbru@redhat.com, dgilbert@redhat.com, marcel.apfelbaum@gmail.com,
 rth@twiddle.net, ehabkost@redhat.com
Message-ID: <cf892fc7-37f8-5819-eba7-dd007ed4f2c5@redhat.com>
Subject: Re: [PATCH 1/7] virtio-pmem: add virtio device
References: <20190523102449.2642-1-pagupta@redhat.com>
 <20190523102449.2642-2-pagupta@redhat.com>
In-Reply-To: <20190523102449.2642-2-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/23/19 5:24 AM, Pankaj Gupta wrote:
> This is the implementation of virtio-pmem device. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled. It can be unlocked with VIRTIO_PMEM_SUPPORTED per
> machine and disabled globally via VIRTIO_PMEM.
>=20
> We cannot use the "addr" property as that is already used e.g. for
> virtio-pci/pci devices. And we will have e.g. virtio-pmem-pci as a prox=
y.
> So we have to choose a different one (unfortunately). "memaddr" it is.
> That name should ideally be used by all other virtio-* based memory
> devices in the future.
>     -device virtio-pmem-pci,id=3Dp0,bus=3Dbux0,addr=3D0x01,memaddr=3D0x=
1000000...
>=20
> Acked-by: Markus Armbruster <armbru@redhat.com>
> [ QAPI bits ]
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",=

>   split up patches, unplug handler ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

> +++ b/qapi/misc.json
> @@ -2742,16 +2742,42 @@
>            }
>  }
> =20
> +##
> +# @VirtioPMEMDeviceInfo:
> +#
> +# VirtioPMEM state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 4.0

You've missed 4.0; this should be 4.1.

> +##
> +{ 'struct': 'VirtioPMEMDeviceInfo',
> +  'data': { '*id': 'str',

Why is id optional? Does it make sense to have a device without an id?

> +            'memaddr': 'size',
> +            'size': 'size',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
>  # Union containing information about a memory device
>  #
> +# nvdimm is included since 2.12. virtio-pmem is included since 4.0.

4.1

> +#
>  # Since: 2.1
>  ##
>  { 'union': 'MemoryDeviceInfo',
>    'data': { 'dimm': 'PCDIMMDeviceInfo',
> -            'nvdimm': 'PCDIMMDeviceInfo'
> +            'nvdimm': 'PCDIMMDeviceInfo',
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
>            }
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xwUJTxDGNncjdz9XJnty5Stunhs88gmLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzmnlkACgkQp6FrSiUn
Q2q5SQgAq+8wsDxPivw9sd+Lf65lKx2LmgRhmgW2kNMmyaMxbUuoKJ1jOiesv5XR
riP2zLwfHUD54/vnf02JV3x/fqVn1OeDN4Na5DQIG8fA1+SXBWxOqAusI/Q5e9E7
S9rS2DfuwE6wOCnjTg21/M6nYQWoV5FttFkXtbNC0pqWw68Gu73vRNJOtvA9l+HL
Q+in+NnMJyiuOYJFES+ic9nGlM/9zlyIK21wngdAgjzznBEtxuHq6+f8gjkawIpK
/BbIZVeBt6mLkVzTm4MbQMKfxbeRyo719k1WSieCfZ/f1Xgdusgk3dl6MQtHpmLf
0ogojh97Omgt7Q5g6uAfX6Hko+7Nbw==
=GgyT
-----END PGP SIGNATURE-----

--xwUJTxDGNncjdz9XJnty5Stunhs88gmLR--

