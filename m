Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1643C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F902082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F902082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jMp-0004be-Fq
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i7j8Q-0005Rc-ES
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i7j8P-0002b4-7p
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i7j8O-0002ZM-V2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B711C0546D5;
 Tue, 10 Sep 2019 16:36:52 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9AA66012C;
 Tue, 10 Sep 2019 16:36:49 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-13-armbru@redhat.com>
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
Message-ID: <69429e4b-3218-bedf-177e-da5b2b05e2c7@redhat.com>
Date: Tue, 10 Sep 2019 11:36:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910063724.28470-13-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mTw7yPRqfTBO7R5PLVgunIa8T0ENGcNOb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 16:36:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/16] docs/devel/qapi-code-gen: Reorder
 sections for readability
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
--mTw7yPRqfTBO7R5PLVgunIa8T0ENGcNOb
Content-Type: multipart/mixed; boundary="erYcS4a6bupZ2zFzKLMNxeTREn0ehWl5L";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Message-ID: <69429e4b-3218-bedf-177e-da5b2b05e2c7@redhat.com>
Subject: Re: [PATCH v2 12/16] docs/devel/qapi-code-gen: Reorder sections for
 readability
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-13-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-13-armbru@redhat.com>

--erYcS4a6bupZ2zFzKLMNxeTREn0ehWl5L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/10/19 1:37 AM, Markus Armbruster wrote:
> Section "QMP/Guest agent schema" starts with a brief introduction,
> then subsection "Comments", then subsection "Schema overview" (more
> elaborate introduction), and only then talks about schema entities
> like types, commands, and so forth.
>=20
> Subsection "Comments" is long and tiring: almost 500 words, mostly
> about doc comments.  Move the doc comment part to its own subsection
> "Documentation comments" at the very end of "QMP/Guest agent schema".
>=20
> Subsection "Schema overview" explains naming rules at considerable
> length: 250 words.  Move this part to its own subsection "Naming rules
> and reserved names" right after the subsections on schema entities.
>=20
> Subsection "Enumeration types" is wedged between "Struct types" and
> "Union types".  Move it before "Struct types".
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt | 436 ++++++++++++++++++-----------------=

>  1 file changed, 221 insertions(+), 215 deletions(-)

Large patch, but mostly just shuffling sections.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--erYcS4a6bupZ2zFzKLMNxeTREn0ehWl5L--

--mTw7yPRqfTBO7R5PLVgunIa8T0ENGcNOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl130SAACgkQp6FrSiUn
Q2pceQf+K4YNBSJjgtNT6L7TXWCp7BtGmak1a8GyhtoeVRxshiqVKQuatDwPqRUe
0wWh25CmRhm+L5oAqjtPMwtpswz1UUbouXDB9pkq4ZaP6Ro4rOjXTIkeY5fK7nYG
JfBUd27RDVXsbbYLAIZZSh9eAf7MNtvY+tBDxU8HKXOogixCCOLUvCDPXhX7cHhE
ThH+YWciMZHtFGpHXWZy0a6fXcmcvqIKqWA7r7lJvHxq0S5ZnUZjkaXSxfE5186H
pyJsII7RYTQbEVbC2OZwMJktIVXveOZhWXWa4EWBYY7DOd4FzhVS1nZpQikLojLZ
92Dt2wbjebEF6JqN2g2prngGugyR6Q==
=KyhR
-----END PGP SIGNATURE-----

--mTw7yPRqfTBO7R5PLVgunIa8T0ENGcNOb--

