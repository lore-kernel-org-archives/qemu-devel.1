Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427ADC606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176DC204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176DC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTk7-0004zz-92
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hkThx-0003h9-DX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hkThv-0005Su-Dg
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hkThn-00059Z-Um
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:29:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE61430860B3;
 Mon,  8 Jul 2019 13:29:11 +0000 (UTC)
Received: from [10.3.116.78] (ovpn-116-78.phx2.redhat.com [10.3.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9078D608A4;
 Mon,  8 Jul 2019 13:29:09 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
 <20190705221504.25166-30-ehabkost@redhat.com>
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
Message-ID: <e0329cb8-a5a6-6497-975b-71546f5eb921@redhat.com>
Date: Mon, 8 Jul 2019 08:29:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705221504.25166-30-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2BCQuAfVWvfNldOgTDt55f3DUaHyw7ujB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 08 Jul 2019 13:29:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v6 29/42] qmp: Add deprecation information
 to query-machines
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
--2BCQuAfVWvfNldOgTDt55f3DUaHyw7ujB
Content-Type: multipart/mixed; boundary="wyExcWFhYZm7gGZvI6GzXq8nPgpRSfNPz";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>
Message-ID: <e0329cb8-a5a6-6497-975b-71546f5eb921@redhat.com>
Subject: Re: [Qemu-devel] [PULL v6 29/42] qmp: Add deprecation information to
 query-machines
References: <20190705221504.25166-1-ehabkost@redhat.com>
 <20190705221504.25166-30-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-30-ehabkost@redhat.com>

--wyExcWFhYZm7gGZvI6GzXq8nPgpRSfNPz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/5/19 5:14 PM, Eduardo Habkost wrote:
> Export machine type deprecation status through the query-machines
> QMP command.  With this, libvirt and management software will be
> able to show this information to users and/or suggest changes to
> VM configuration to avoid deprecated machines.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20190608233447.27970-2-ehabkost@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/machine.json          | 7 ++++++-
>  hw/core/machine-qmp-cmds.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 78d34ef717..6db8a7e2ec 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -321,12 +321,17 @@
>  # @numa-mem-supported: true if '-numa node,mem' option is supported by=

>  #                      the machine type and false otherwise (since 4.1=
)
>  #
> +# @deprecated: if true, the machine type is deprecated and may be remo=
ved
> +#              in future versions of QEMU according to the QEMU deprec=
ation
> +#              policy (since 4.1.0)

Here, you used 'since 4.1.0'; in patch 31, you used merely 'since 4.1'.
It's not the first time we are inconsistent, but if someone wants a
trivial cleanup job, scrubbing the docs for all 3-element versions and
converting them to 2-element may be an interesting beginner's task.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wyExcWFhYZm7gGZvI6GzXq8nPgpRSfNPz--

--2BCQuAfVWvfNldOgTDt55f3DUaHyw7ujB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0jRSQACgkQp6FrSiUn
Q2qkqgf/VrcRbkumOErFWDbGDnBpfBHnkwTaGPC/GL9dVrrPfLFenjTOLrhvbffM
NqSlweE3fusqjCHeDi3X07OJ2q7wwR/8nl4Qgh0und9v53Eczr7z9rbHCsEbr3nB
bmxpmTM72MgFPFiL8g3iVqNtlxvcqwLGcpGrp075niHzChjp/rV0yenW82dswnOo
IIXhNMPZij6D4CqXkboiqNUpJnKktI1BwoJMezjNjpUAToOKiLaknv9u2HiwUl+G
elcwQqNAAQZahp3ldHTM4cU10pf8vbuSUSve2cOSh+jkFwJWP5PRbY1dEP1WLYiy
OR2npifMcEQ0OmifjQNADJaZKgemCg==
=fpx5
-----END PGP SIGNATURE-----

--2BCQuAfVWvfNldOgTDt55f3DUaHyw7ujB--

