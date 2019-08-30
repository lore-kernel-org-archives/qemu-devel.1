Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FD3C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2F921721
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2F921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hL2-00086c-0y
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i3hHH-00057N-72
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i3hHF-0001yk-Ni
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i3hHF-0001v5-Bt
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11B6B8796BC;
 Fri, 30 Aug 2019 13:49:20 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A294526;
 Fri, 30 Aug 2019 13:49:16 +0000 (UTC)
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
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
Message-ID: <18aef1bc-247c-1119-db02-7ebfece30591@redhat.com>
Date: Fri, 30 Aug 2019 08:49:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IGAsvbQ6vXZH2eocVUTJ9RCNPakAlwiyr"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 13:49:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi/qmp-dispatch: Fix error class for
 reporting disabled commands
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGAsvbQ6vXZH2eocVUTJ9RCNPakAlwiyr
Content-Type: multipart/mixed; boundary="daiaeNJaKaDrENmbcEMIG30B5XesdE2Rt";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, lcapitulino@redhat.com, armbru@redhat.com
Message-ID: <18aef1bc-247c-1119-db02-7ebfece30591@redhat.com>
Subject: Re: [PATCH v2] qapi/qmp-dispatch: Fix error class for reporting
 disabled commands
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
In-Reply-To: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>

--daiaeNJaKaDrENmbcEMIG30B5XesdE2Rt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/30/19 8:29 AM, Michal Privoznik wrote:
> If a command is disabled an error is reported. But due to usage
> of error_setg() the class of the error is GenericError which does
> not help callers in distinguishing this case from a case where a
> qmp command fails regularly due to other reasons. Use
> CommandNotFound error class which is much closer to the actual
> root cause.
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>=20
> This is a v2 of:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg06327.html
>=20
> diff to v1:
> - Don't introduce new error class (CommandDisabled)
> - Use CommandNotFound error class
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--daiaeNJaKaDrENmbcEMIG30B5XesdE2Rt--

--IGAsvbQ6vXZH2eocVUTJ9RCNPakAlwiyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1pKVwACgkQp6FrSiUn
Q2pHkgf/e11jtgJuvjfWOWRDxrEUvVbaqNNWvzMP/sJKe3kYVryG1gvAHgI+Xfix
AbkD0SWzT7vkpwFv00fTSpub1Ws6mPc3Tps1MDE4cKcl25daeDWojyJzfXxTv81S
ILMp5/CdGJFHknvWmH+8nQiEZuw35X1orqDHz4xrajvnBwo/P30usDajco5zu/9b
KLYOi6q33sVLvnVc7APOx1HBZFGnBnbmhhxa3u7aLyCrKg5Enxg6demTiwZygPN+
z2TYBTvDQAzH+LL8q5Kn1Hu69qKoT+A575edzSqO9CNlEl015eO4T8YcVC66fwjJ
pbtnZ4VEhd4bXp+j8a8YCQaw4QJ7LA==
=4/OQ
-----END PGP SIGNATURE-----

--IGAsvbQ6vXZH2eocVUTJ9RCNPakAlwiyr--

