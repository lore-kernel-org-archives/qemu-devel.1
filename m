Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A371C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC55206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC55206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2c3d-0006b6-Eu
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i2c2S-00068t-1V
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i2c2Q-0004qy-Q8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1i2c2Q-0004qi-Fd
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 309C520ABB;
 Tue, 27 Aug 2019 14:01:33 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D918D5D6B0;
 Tue, 27 Aug 2019 14:01:21 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
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
Message-ID: <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
Date: Tue, 27 Aug 2019 09:01:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827120221.15725-2-yury-kotov@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t4u5CBug3Z9tdyIOtMmrQHdsbrKW8K9Df"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 27 Aug 2019 14:01:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Add x-validate-uuid
 capability
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t4u5CBug3Z9tdyIOtMmrQHdsbrKW8K9Df
Content-Type: multipart/mixed; boundary="g8mo5Zp2iemZreYNhFgEik9FZTqYukKYF";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Message-ID: <fb324ab9-b7a2-d56e-a0d1-9f4ae86791ce@redhat.com>
Subject: Re: [PATCH 1/3] migration: Add x-validate-uuid capability
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-2-yury-kotov@yandex-team.ru>
In-Reply-To: <20190827120221.15725-2-yury-kotov@yandex-team.ru>

--g8mo5Zp2iemZreYNhFgEik9FZTqYukKYF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 7:02 AM, Yury Kotov wrote:
> This capability realizes simple source validation by UUID.
> It's useful for live migration between hosts.
>=20
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  migration/migration.c |  9 +++++++++
>  migration/migration.h |  1 +
>  migration/savevm.c    | 45 +++++++++++++++++++++++++++++++++++++++++++=

>  qapi/migration.json   |  5 ++++-
>  4 files changed, 59 insertions(+), 1 deletion(-)

Any reason why this is marked experimental?  It seems useful enough that
we could probably just add it as a fully-supported feature (dropping the
x- prefix) - but I'll leave that up to the migration maintainers.

In fact, do we even need this to be a tunable feature?  Why not just
always enable it?  As long as the UUID is sent in a way that new->old
doesn't break the old qemu from receiving the migration stream, and that
old->new copes with UUID being absent, then new->new will always benefit
from the additional safety check.

> +++ b/qapi/migration.json
> @@ -415,6 +415,9 @@
>  #
>  # @x-ignore-shared: If enabled, QEMU will not migrate shared memory (s=
ince 4.0)
>  #
> +# @x-validate-uuid: Check whether the UUID is the same on both sides o=
r not.
> +#                   (since 4.2)

Maybe:

@x-validate-uuid: Send the UUID of the source to allow the destination
to ensure it is the same.

if we even need a tunable capability.

> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
> @@ -422,7 +425,7 @@
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
>             'block', 'return-path', 'pause-before-switchover', 'multifd=
',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate=
',
> -           'x-ignore-shared' ] }
> +           'x-ignore-shared', 'x-validate-uuid' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--g8mo5Zp2iemZreYNhFgEik9FZTqYukKYF--

--t4u5CBug3Z9tdyIOtMmrQHdsbrKW8K9Df
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1lN7AACgkQp6FrSiUn
Q2r3RggAgbDhGjnCkVYd1X/W2vBNqpRHCrTtZsCUF23n3BUXsyRQiDF/MgrbBLAc
2VH13DeumdX3e11/AA2QCj6ycDLQ0R42Vs73gqkgeMSE0JSHP3NxmJxcybRyg1hP
8IHK4G8Np4Z9YDg8sa8luVjsjUVd511bh6v/JAwyuw/nf1Zvz2aRzVKbn2GiFbSo
NaPIftUrNclwbrrThduMwI6rWkZIaxKG7IVAghxDPHx3WF8Q+CQ779ugJ1vuS4zl
FA/uzyjAsINO7ILZOPAmlENQq15sWgTRshpw77L9LVhad1W+jHssYnjZ/JXG69yh
efTYOkqnS+iENtkTUM86a+1OzsnGuw==
=8/jv
-----END PGP SIGNATURE-----

--t4u5CBug3Z9tdyIOtMmrQHdsbrKW8K9Df--

