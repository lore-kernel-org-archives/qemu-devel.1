Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD66C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F8921670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 04:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F8921670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjcOY-0006RO-RE
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 00:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hjcNX-0005sp-W7
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hjcNW-0005mb-Ql
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:32:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hjcNW-0005ly-I4
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 00:32:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4595230821C2
 for <qemu-devel@nongnu.org>; Sat,  6 Jul 2019 04:32:49 +0000 (UTC)
Received: from [10.3.116.152] (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D29772B4;
 Sat,  6 Jul 2019 04:32:48 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
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
Message-ID: <420745c6-4709-d32a-b4f0-f0ffc066bd2b@redhat.com>
Date: Fri, 5 Jul 2019 23:32:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="haD9zpZI7fpfOzkU9quzSRRI8mCvCwLDp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Sat, 06 Jul 2019 04:32:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
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
--haD9zpZI7fpfOzkU9quzSRRI8mCvCwLDp
Content-Type: multipart/mixed; boundary="Nr51JaPVDegnOvpYRXZLI5D8Pd1V4Koit";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <420745c6-4709-d32a-b4f0-f0ffc066bd2b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>

--Nr51JaPVDegnOvpYRXZLI5D8Pd1V4Koit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/5/19 2:50 PM, Paolo Bonzini wrote:
> The following changes since commit 68d7ff0cff0c4905802104843cf0100543b4=
7314:
>=20
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into=
 staging (2019-06-21 13:32:10 +0100)
>=20
> are available in the git repository at:
>=20
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 2994e7e66a8902d0e42c5e528489ca6484c66d2d=
:
>=20
>   ioapic: use irq number instead of vector in ioapic_eoi_broadcast (201=
9-07-05 18:35:43 +0200)

Missing v2 in the subject line to distinguish this from the failed v1
pull request. And per the comments on 11/12, it may need a v3 pull
request to fix an issue with a missing S-o-b.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Nr51JaPVDegnOvpYRXZLI5D8Pd1V4Koit--

--haD9zpZI7fpfOzkU9quzSRRI8mCvCwLDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0gJHAACgkQp6FrSiUn
Q2r31Qf+JOJ3nPDRtB8TopXS3+oPHTKZtLcMbnJPvUm0ip2IUP+1ayQyAGzFF1wS
XHzMXmS8alN+en/aZt1B+zyOpyBN0/YJItb18rFHilP08g7Br5AB7YyzjmiNt5G5
/U99h4+5GvjEkPEFUg12f9SudLqUdPaawTDAsuDfKYkX26qLPgwDtp7GkHWQtU6I
WepNnzV1ndouxxJI1oqryoDg0F58xvtxa7UcVD0tSTkf9bJtM+QiM4XNV2pTSECX
5S/OOZxzrJB4ywj/b9toczqI0MSzSoWcusNk5LMyY7iNB8EzpwjtBB66HcT2Ahkm
/53UJwE0V89+Ayrha9VP8VRbObaFeA==
=HWvf
-----END PGP SIGNATURE-----

--haD9zpZI7fpfOzkU9quzSRRI8mCvCwLDp--

