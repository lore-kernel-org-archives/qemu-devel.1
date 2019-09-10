Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB97C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C212082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C212082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jRK-0002Bn-9U
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7jLl-0003fi-DN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7jLk-00010S-0f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7jLj-00010C-OZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 206D0302C066;
 Tue, 10 Sep 2019 16:50:39 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0380360166;
 Tue, 10 Sep 2019 16:50:33 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-15-armbru@redhat.com>
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
Message-ID: <608a5ab7-eed6-6f09-95e2-5c28bdeec158@redhat.com>
Date: Tue, 10 Sep 2019 11:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-15-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJeViVfEOCXTApUhLjqP6GvoCtQmCNJte"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 10 Sep 2019 16:50:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 14/16] docs/devel/qapi-code-gen: Rewrite
 introduction to schema
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJeViVfEOCXTApUhLjqP6GvoCtQmCNJte
Content-Type: multipart/mixed; boundary="XZTLqiaxflhEeXM5rwieTxNKmrrrAdyLH";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <608a5ab7-eed6-6f09-95e2-5c28bdeec158@redhat.com>
Subject: Re: [PATCH v2 14/16] docs/devel/qapi-code-gen: Rewrite introduction
 to schema
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-15-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-15-armbru@redhat.com>

--XZTLqiaxflhEeXM5rwieTxNKmrrrAdyLH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> The introduction to the QAPI schema is somewhat rambling.  Rewrite for
> clarity.

The curse of additions over time.  Thanks for tackling this.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 106 ++++++++++++++++-------------------=

>  1 file changed, 47 insertions(+), 59 deletions(-)
>=20

> +=3D=3D=3D Schema syntax =3D=3D=3D
> +
> +Syntax is loosely based on JSON (http://www.ietf.org/rfc/rfc8259.txt).=

> +Differences:
> +
> +* Comments: start with a hash character (#) that is not part of a
> +  string, and extend to the end of the line.
> +
> +* Strings are enclosed in 'single quotes', not "double quotes".
> +
> +* Strings are restricted to ASCII.  All control characters must be
> +  escaped, even DEL.

Or rather, control characters are not permitted.  (May affect the
earlier 7/16...)

> +
> +* Numbers are not supported.

Yet. But if we allow default values, it won't be much longer before we
get there.  (Doesn't affect this patch)

> +
> +A QAPI schema consists of a series of top-level expressions (JSON
> +objects).  Their order does not matter.

Does the order of 'include' and/or 'pragma' matter?

Touchups seem minor enough that I trust you, so you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XZTLqiaxflhEeXM5rwieTxNKmrrrAdyLH--

--lJeViVfEOCXTApUhLjqP6GvoCtQmCNJte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl131FgACgkQp6FrSiUn
Q2rF4wf/SwSWTbsZKwuZhR5pFTz/1tA0pL5t9ReTMPpa7KaQIt4R3m+oxUS+Sbhk
FG0yB/I/YnJ8QM118bvMlB9H9WK8PvOBsB4QFEduBEu9RoTXjk2CZVfHb521AQtP
701wUjFU56J1e9yrFfF7lCowFjPuEvTy8+stiRhPaFrWg417d5alqBbM+nHS0wVX
EA9rX4biESsKU8r+kSxGGMYnlr2hb3C13An8fAYhmseovRoSt2KLGHQmA5zr2Hiz
GF/NUoHnDNdhQKjHZ6klHWXcp/fCbzeHKdey+c9KiYQd9Ze4An+gdFzFcjRWKSuw
XsA+FWs6KDoERhVMxDwO/n3dGOGm7w==
=BVBY
-----END PGP SIGNATURE-----

--lJeViVfEOCXTApUhLjqP6GvoCtQmCNJte--

