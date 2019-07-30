Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B499C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5DD20679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5DD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXHk-000899-Ku
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 14:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hsXGe-0006oM-F0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hsXGd-0001I0-Hp
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hsXGb-0001Et-DC; Tue, 30 Jul 2019 14:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B65FE8F01F;
 Tue, 30 Jul 2019 18:54:32 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B4DE19C67;
 Tue, 30 Jul 2019 18:54:32 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-8-mreitz@redhat.com>
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
Message-ID: <dc71a5c0-bc5f-fd94-cbdb-e537ea714e5b@redhat.com>
Date: Tue, 30 Jul 2019 13:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190730172508.19911-8-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o9970V6sUUIIZA4Fec0K7PSQ6qtedfmNO"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 30 Jul 2019 18:54:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 07/13] qcow2: Add
 qcow2_check_fix_snapshot_table()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o9970V6sUUIIZA4Fec0K7PSQ6qtedfmNO
Content-Type: multipart/mixed; boundary="rOMOUKaGWd381RdC1zgTnvRKdAQdQTsRJ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <dc71a5c0-bc5f-fd94-cbdb-e537ea714e5b@redhat.com>
Subject: Re: [PATCH for-4.2 07/13] qcow2: Add qcow2_check_fix_snapshot_table()
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-8-mreitz@redhat.com>
In-Reply-To: <20190730172508.19911-8-mreitz@redhat.com>

--rOMOUKaGWd381RdC1zgTnvRKdAQdQTsRJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/19 12:25 PM, Max Reitz wrote:
> qcow2_check_read_snapshot_table() can perform consistency checks, but i=
t
> cannot fix everything.  Specifically, it cannot allocate new clusters,
> because that should wait until the refcount structures are known to be
> consistent (i.e., after qcow2_check_refcounts()).  Thus, it cannot call=

> qcow2_write_snapshots().
>=20
> Do that in qcow2_check_fix_snapshot_table(), which is called after
> qcow2_check_refcounts().
>=20
> Currently, there is nothing that would set result->corruptions, so this=

> is a no-op.  A follow-up patch will change that.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rOMOUKaGWd381RdC1zgTnvRKdAQdQTsRJ--

--o9970V6sUUIIZA4Fec0K7PSQ6qtedfmNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1AkmcACgkQp6FrSiUn
Q2qmOggAgncyseqbfvRPI78/uczkWMZ0JJ6M+U9iFOuUs2hBeNY+hdpM9WBKFn3V
UcLFTn8Aqo0LFfzQ7k7uhPauT2+Lc1SR2bIHoJeZhyiN+VNdYmHWowlvVXt7iX49
oXARIWUDoE/kpSzebQzVd+Te5fznpRE6dbM7qyOKrBFgXtTfmw7q6wuu7wWyXs8W
kLNrAlwS0weStiLiJelAaDIayMeypo5EKljFUTatbtrowiZixe0FU4uamtwFDZy9
8g3WBlCWI5x+30JmNmwUcQvEi/A8oWZsxqv3ZFFx1X34GfIFNaTx17z2nIkEJWdm
gveSINs25mY1j8AXInjCWSyDeJ6new==
=oq3i
-----END PGP SIGNATURE-----

--o9970V6sUUIIZA4Fec0K7PSQ6qtedfmNO--

