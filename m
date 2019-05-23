Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32597C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F261620879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F261620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqh3-0004RB-6h
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:35:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTqfL-0003AC-R3
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hTqfK-0000ob-SB
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hTqfK-0000nx-Hp
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 158E688311
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 16:33:58 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7167617F23;
	Thu, 23 May 2019 16:33:55 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
	laine@redhat.com
References: <20190523145840.11774-1-dgilbert@redhat.com>
	<20190523145840.11774-2-dgilbert@redhat.com>
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
Message-ID: <3fe6b079-94ed-a379-78b8-396dee1665b9@redhat.com>
Date: Thu, 23 May 2019 11:33:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523145840.11774-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dEOfPWZNwwJGvboywaHMtziOI20xninTW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 23 May 2019 16:34:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] net/announce: Allow optional list of
 interfaces
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dEOfPWZNwwJGvboywaHMtziOI20xninTW
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
 laine@redhat.com
Message-ID: <3fe6b079-94ed-a379-78b8-396dee1665b9@redhat.com>
Subject: Re: [PATCH 1/2] net/announce: Allow optional list of interfaces
References: <20190523145840.11774-1-dgilbert@redhat.com>
 <20190523145840.11774-2-dgilbert@redhat.com>
In-Reply-To: <20190523145840.11774-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/23/19 9:58 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Allow the caller to restrict the set of interfaces that announces are
> sent on.  The default is still to send on all interfaces.
>=20
> e.g.
>=20
>   { "execute": "announce-self", "arguments": { "initial": 50, "max": 55=
0, "rounds": 5, "step": 50, "ifaces": ["vn2","vn1"] } }
>=20
> Note: There's still only one timer for the qmp command, so that
> performing an 'announce-self' on one list of interfaces followed
> by another 'announce-self' on another list will stop the announces
> on the existing set.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -706,7 +706,8 @@
>    'data': { 'initial': 'int',
>              'max': 'int',
>              'rounds': 'int',
> -            'step': 'int' } }
> +            'step': 'int',
> +            '*ifaces': ['str'] } }

Missing documentation for the addition, including a '(since 4.1)' tag.

> =20
>  ##
>  # @announce-self:
> @@ -718,9 +719,10 @@
>  #
>  # Example:
>  #
> -# -> { "execute": "announce-self"
> +# -> { "execute": "announce-self",
>  #      "arguments": {
> -#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> +#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> +#          "ifaces": ["vn2","vn3"] } }
>  # <- { "return": {} }
>  #
>  # Since: 4.0
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--dEOfPWZNwwJGvboywaHMtziOI20xninTW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzmy3IACgkQp6FrSiUn
Q2o+IAf9EgQcgAD9dnEHi14fP17Q8W2iQ+S6/ekD5v98JK5IGfBPxmc7C8/n14Mc
HzSencm0lF19qGnCyLRta1EImKXZHhYfjAOEFE/spBEOa0k5LNHALKgVlJa7E3d7
ZK6xRgte7TAIjjhdDL9INeA2pTQoGQgGdeGTMHP0F7IzXodBvrU52vsnflAqGVOw
+Nd4nVLsfWMPjtg6DGlXtTN3RdmyfbpDOXFyNadrxO9xfpU4geT0BKdTax+n06S6
0mBb7p+aueitdssBj7h3IRyp7On3XFZ+1O2suGESM5rMAogttCfLMvOVkeBNGaX5
sLgPENo/mQwgm6cqYWJrUmXiLlfxig==
=XueO
-----END PGP SIGNATURE-----

--dEOfPWZNwwJGvboywaHMtziOI20xninTW--

