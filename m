Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DCC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F9B2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F9B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxEB-0001c3-Em
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hcxCz-0000ml-BS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hcxCx-0003Vb-JE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hcxCx-0003U4-AJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:22:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEA085D674;
 Mon, 17 Jun 2019 19:22:15 +0000 (UTC)
Received: from [10.3.118.50] (ovpn-118-50.phx2.redhat.com [10.3.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8F72C16A;
 Mon, 17 Jun 2019 19:22:08 +0000 (UTC)
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
References: <20190617181631.30233-1-elena.ufimtseva@oracle.com>
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
Message-ID: <c8e6cb54-4b37-1452-c215-a9e071000635@redhat.com>
Date: Mon, 17 Jun 2019 14:22:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617181631.30233-1-elena.ufimtseva@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="il4TMiSFYngXZHfsYAjjayFCjR83qXQjv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 17 Jun 2019 19:22:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 24/35] multi-process: add
 qdev_proxy_add to create proxy devices
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
Cc: john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, imammedo@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--il4TMiSFYngXZHfsYAjjayFCjR83qXQjv
Content-Type: multipart/mixed; boundary="W9qJcaDOgaG2ovDfufARvayecnG2WJ0IY";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com,
 ross.lagerwall@citrix.com, imammedo@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, kanth.ghatraju@oracle.com
Message-ID: <c8e6cb54-4b37-1452-c215-a9e071000635@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 24/35] multi-process: add
 qdev_proxy_add to create proxy devices
References: <20190617181631.30233-1-elena.ufimtseva@oracle.com>
In-Reply-To: <20190617181631.30233-1-elena.ufimtseva@oracle.com>

--W9qJcaDOgaG2ovDfufARvayecnG2WJ0IY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/17/19 1:16 PM, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> This is handled while parsing the command line options.
> The parsed options are being sent to remote process
> as the messgaes containing JSON strings.

s/messgaes/messages/

>=20
> Changes in v2:
>  - parse socket and command suboptions of drive/device commands;

The changelog paragraph belongs...

>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---

=2E..here, after the --- divider. It is useful to reviewers, but gets
stripped by 'git am' when the maintainer applies the series. A year from
now, we won't care how many iterations the patches went through on list,
only the one version that got committed to git.

>  include/hw/proxy/qemu-proxy.h |   7 ++
>  include/monitor/qdev.h        |   5 +
>  qdev-monitor.c                | 166 ++++++++++++++++++++++++++++++++++=

>  3 files changed, 178 insertions(+)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--W9qJcaDOgaG2ovDfufARvayecnG2WJ0IY--

--il4TMiSFYngXZHfsYAjjayFCjR83qXQjv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0H6GAACgkQp6FrSiUn
Q2pWJQgAiyPiV21AG+nQ4ncj9xO5FXs8NiVkWF4xVGZFr2PP27kZ+V8YvBMH9YkK
XGj4ezSFMqTDejOhnhgrkxvSmEofyM9pHKmSgDY53wYlefih31nqYOlAtPbe7vg8
prcvED9IJxuxwawsN96I4o5EKhC1HGLPi7S3myY2rrfpDwllf/79Tq+JzhLaci1C
YdChg/Ls5xFBdEKD6p+x8QgdbsDjMA+bMjAM/lmOkqM752PIk/VaHCm3u7By/kcb
hIVuLKslPpzt/dqviu9VHRfQRwgIeE5u62VbTVhvwrXj96kjJo3kxEni4sPmc4Xu
n0IJApdzxw602SQdBSzpBRy2m2GOpg==
=T8dH
-----END PGP SIGNATURE-----

--il4TMiSFYngXZHfsYAjjayFCjR83qXQjv--

