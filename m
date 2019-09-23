Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07765C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE38220835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE38220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCO6q-0000jF-QK
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCO4n-0007a1-Iv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCO4m-0005NC-GQ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCO4j-0005MZ-Nm; Mon, 23 Sep 2019 09:08:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE6823C92D;
 Mon, 23 Sep 2019 13:08:20 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE5CA10013D9;
 Mon, 23 Sep 2019 13:08:15 +0000 (UTC)
Subject: Re: [PATCH v2 01/11] qcrypto: add suport for amend options
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-2-mlevitsk@redhat.com>
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
Message-ID: <29336f49-c364-1263-664b-61a4a02be0be@redhat.com>
Date: Mon, 23 Sep 2019 08:08:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912223028.18496-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iUGTTnk9YFpSxZimChNkXrsm3DSJJP3QJ"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 23 Sep 2019 13:08:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iUGTTnk9YFpSxZimChNkXrsm3DSJJP3QJ
Content-Type: multipart/mixed; boundary="JVCtDtOddfrqefqA7fIrsgCuFie8APiZi";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <29336f49-c364-1263-664b-61a4a02be0be@redhat.com>
Subject: Re: [PATCH v2 01/11] qcrypto: add suport for amend options
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-2-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-2-mlevitsk@redhat.com>

--JVCtDtOddfrqefqA7fIrsgCuFie8APiZi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 5:30 PM, Maxim Levitsky wrote:
> This adds the qcrypto_amend_options and corresponding
> crypto driver callbacks for the  for encrypted

grammar is off, did you miss a word where that double space is?

> key managedment

management

>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/block.c         | 31 +++++++++++++++++++++++++++++++
>  crypto/blockpriv.h     |  8 ++++++++
>  include/crypto/block.h | 22 ++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>=20
> diff --git a/crypto/block.c b/crypto/block.c
> index 325752871c..14b684de7f 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -115,6 +115,37 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCre=
ateOptions *options,
>  }
> =20
> =20
> +int qcrypto_block_amend_options(QCryptoBlock *block,
> +                                QCryptoBlockReadFunc readfunc,
> +                                QCryptoBlockWriteFunc writefunc,
> +                                void *opaque,
> +                                QCryptoBlockCreateOptions *options,
> +                                bool force,
> +                                Error **errp)
> +{
> +    if (options->format !=3D block->format) {
> +        error_setg(errp,
> +                   "Its not possible to change encryption format with =
amend interface");
> +        return -1;

"It's" (here, you want the form meaning "It is")

Or reword the entire error to something shorter:

error_setg(errp, "cannot amend encryption format")

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--JVCtDtOddfrqefqA7fIrsgCuFie8APiZi--

--iUGTTnk9YFpSxZimChNkXrsm3DSJJP3QJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2Iw7wACgkQp6FrSiUn
Q2ryCwf+MmXWH19E1HgzE+x+BfNK6rJwKfsKSM8L6LlQmedqAO8Se9ipuAlpnJP4
dwwXD70d0//LHdIF5dGmGUKYr1XrIOfpYxvn+azQFkGoDn0WnYR6W9Di2YkXT0Oq
Ygr31yjZsKgLcnLboQlP6jRRIqoZPKzFFDOXgfWwF3FwJ+xwTc58TpilLfQwsAkO
zm128bv6nNdxouyTJHNy43/5gPu/2QyUBWqiBGoBW2n6nR3ptoWYCsr/FN6Ty2uK
zeqAG7wE4jHDbb46DSygMwBR/GxU+0GaiOgCB/LkYLvuyQMMOp5L4/3oJk+xG3nD
OvR0fC1GO3cmU+hdvs6IVVuChb2IdQ==
=NAdF
-----END PGP SIGNATURE-----

--iUGTTnk9YFpSxZimChNkXrsm3DSJJP3QJ--

