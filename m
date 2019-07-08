Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FCC606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBB22086D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBB22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTan-0005UM-JZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hkTZh-0004kR-Cx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hkTZg-0002s7-Dd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hkTZg-0002ij-4a
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:20:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45BFD307D846;
 Mon,  8 Jul 2019 13:20:35 +0000 (UTC)
Received: from [10.3.116.78] (ovpn-116-78.phx2.redhat.com [10.3.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5EEC5D9C8;
 Mon,  8 Jul 2019 13:20:28 +0000 (UTC)
To: Tao Xu <tao3.xu@intel.com>, imammedo@redhat.com, ehabkost@redhat.com
References: <20190707142958.31316-1-tao3.xu@intel.com>
 <20190707142958.31316-6-tao3.xu@intel.com>
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
Message-ID: <69280ef3-ed37-6ed0-3e95-17084c2e1d48@redhat.com>
Date: Mon, 8 Jul 2019 08:20:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190707142958.31316-6-tao3.xu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wOizWNk4TlWIVtavGczDF7j1GPZeCuVw5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 08 Jul 2019 13:20:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 05/14] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: jingqi.liu@intel.com, dan.j.williams@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wOizWNk4TlWIVtavGczDF7j1GPZeCuVw5
Content-Type: multipart/mixed; boundary="hMidNGWg3WyfYEgnvW9Gx8ubRgTIeG1u3";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Tao Xu <tao3.xu@intel.com>, imammedo@redhat.com, ehabkost@redhat.com
Cc: jingqi.liu@intel.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, fan.du@intel.com, qemu-devel@nongnu.org
Message-ID: <69280ef3-ed37-6ed0-3e95-17084c2e1d48@redhat.com>
Subject: Re: [PATCH v6 05/14] numa: Extend CLI to provide initiator
 information for numa nodes
References: <20190707142958.31316-1-tao3.xu@intel.com>
 <20190707142958.31316-6-tao3.xu@intel.com>
In-Reply-To: <20190707142958.31316-6-tao3.xu@intel.com>

--hMidNGWg3WyfYEgnvW9Gx8ubRgTIeG1u3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/7/19 9:29 AM, Tao Xu wrote:
> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),=

> The initiator represents processor which access to memory. And in 5.2.2=
7.3
> Memory Proximity Domain Attributes Structure, the attached initiator is=

> defined as where the memory controller responsible for a memory proximi=
ty
> domain. With attached initiator information, the topology of heterogene=
ous
> memory can be described.
>=20
> Extend CLI of "-numa node" option to indicate the initiator numa
> node-id.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---

> +++ b/qapi/misc.json
> @@ -2572,6 +2572,9 @@
>  # @memdev: memory backend object.  If specified for one node,
>  #          it must be specified for all nodes.
>  #
> +# @initiator: the initiator numa nodeid that is closest (as in directl=
y
> +#             attached) to this numa node.

Missing a '(since 4.2)' designator. We've already missed softfreeze for
4.1, and this is a new feature, so probably does have to slip into 4.2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hMidNGWg3WyfYEgnvW9Gx8ubRgTIeG1u3--

--wOizWNk4TlWIVtavGczDF7j1GPZeCuVw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0jQxsACgkQp6FrSiUn
Q2qPUAf/SHLb5gd0Lm1K4H+eF1tYZJVOk+O+s2vaTeyxt6UuJBeK3Y3UThTaWpDn
+Ksh2ht3l/qXahqMygH7x/atBL8gME3lyXuqjhzkktQSdZFDeLHvWPlnCFp84ixl
7tvy/oae3vbZTM8eA57tAZ7MuKCnnqe+KR20iwbPdzaggqCK2cTifycsgQjkBeC9
i+cYKxJsOyE6+gc+pspCQrNpHD/gqSCcQpnJ6t/Liv8/YGKCpC0+4oyIetNO04/z
UqtLCGKGpfHbW+Kbeld4EQYT4s9vBTkN3b7gxbwTEqJMqmMVBgYWlfeJAmSnkkGN
7d2+tb0xu/24ayUzaf/XpHJ0IuxpEQ==
=Nrex
-----END PGP SIGNATURE-----

--wOizWNk4TlWIVtavGczDF7j1GPZeCuVw5--

