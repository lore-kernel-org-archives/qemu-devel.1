Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE8C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADD3214AE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 17:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADD3214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57517 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzbl-0007vq-4g
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 13:53:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIzan-0007XT-5h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIzal-0005rF-Lu
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hIzal-0005hx-Bc; Tue, 23 Apr 2019 13:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECBB930ADBA2;
	Tue, 23 Apr 2019 17:52:20 +0000 (UTC)
Received: from [10.3.116.149] (ovpn-116-149.phx2.redhat.com [10.3.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB0B1001E71;
	Tue, 23 Apr 2019 17:52:19 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
References: <20190423160608.7519-1-thuth@redhat.com>
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
Message-ID: <f1db3bb5-6028-e8a4-f56b-fdd22215688f@redhat.com>
Date: Tue, 23 Apr 2019 12:52:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 23 Apr 2019 17:52:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic,
 model=help" to stdout instead of stderr
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423175218.B4Obj2RW0YnPMaO2OgnUnrlN3ITLkCyVUzPRzHpI-JE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <f1db3bb5-6028-e8a4-f56b-fdd22215688f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: Print output of "-net nic, model=help"
 to stdout instead of stderr
References: <20190423160608.7519-1-thuth@redhat.com>
In-Reply-To: <20190423160608.7519-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Markus, as he send a recent batch of similar patches]

On 4/23/19 11:06 AM, Thomas Huth wrote:
> We are printing all other help output to stdout already (e.g. "-help",
> "-cpu help" and "-machine help" output). So the "-net nic,model=3Dhelp"=

> output should go to stdout instead of stderr, too. And while we're at
> it, also print the NICs line by line, like we do it e.g. with the
> "-cpu help" or "-M help" output, too.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/net/net.c b/net/net.c
> index f3a3c5444c..2cf5e76469 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const ch=
ar *const *models)
>          return 0;
>      }
> =20
> -    fprintf(stderr, "qemu: Supported NIC models: ");
> -    for (i =3D 0 ; models[i]; i++)
> -        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
> +    printf("Supported NIC models:\n");
> +    for (i =3D 0 ; models[i]; i++) {
> +        printf("%s\n", models[i]);
> +    }
>      return 1;
>  }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly/UNIACgkQp6FrSiUn
Q2pLsggAoZ110sQJBNhz05OBWHy7JQ9Fa1S7rcjEfhDM7BA68oj3X3VzxcPVVsv0
jo+mBKTVryVMqKpv1RCziPWbo/tHJvMnERHHqX+24zXeztLaxD0H/JjxvrA/I2EA
nPqARjEFpTtwKLBx5+j/+A6W5z66GZy3goqWor17Bs9nyVPa811N9LhsCGNVT//M
1IMASrN1dE0k8R4d+0xwbJdt7COZHP8UJv41zG+TRFEyZcIO8EbgoE4QVoxQYSIy
Ounyiz5t9gXKSHWdTxuc0U7LTNTxMf49920wIdunddj/7ZqIG4NTZTlDSt7MPnbg
1yzTX7IZRVYg4KLiquREl86qyo/uzA==
=/CYd
-----END PGP SIGNATURE-----

--oG3L6d2PSVZYkVCaZcW6WzX09EPqdzahr--

