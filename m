Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1978C43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD23206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD23206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQJe-0000EB-Be
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haQGq-0007CT-Tc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haQGn-00026S-AQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:47:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1haQGf-0001sw-03
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12C9859449
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 19:47:33 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3187A60565;
 Mon, 10 Jun 2019 19:47:28 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
 laine@redhat.com
References: <20190610184402.7090-1-dgilbert@redhat.com>
 <20190610184402.7090-2-dgilbert@redhat.com>
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
Message-ID: <272867fd-1a3a-3cc2-9774-0feb694cd773@redhat.com>
Date: Mon, 10 Jun 2019 14:47:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610184402.7090-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SwgAIJfa1OCmz9ut5qktkTcn0sv8IgHEy"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 10 Jun 2019 19:47:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/4] net/announce: Allow optional list
 of interfaces
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
--SwgAIJfa1OCmz9ut5qktkTcn0sv8IgHEy
Content-Type: multipart/mixed; boundary="mJ3WZvC0zZ3yupoQcAT3Ph7eZCigTU1nE";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
 laine@redhat.com
Message-ID: <272867fd-1a3a-3cc2-9774-0feb694cd773@redhat.com>
Subject: Re: [PATCH v3 1/4] net/announce: Allow optional list of interfaces
References: <20190610184402.7090-1-dgilbert@redhat.com>
 <20190610184402.7090-2-dgilbert@redhat.com>
In-Reply-To: <20190610184402.7090-2-dgilbert@redhat.com>

--mJ3WZvC0zZ3yupoQcAT3Ph7eZCigTU1nE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 1:43 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Allow the caller to restrict the set of interfaces that announces are
> sent on.  The default is still to send on all interfaces.
>=20
> e.g.
>=20
>   { "execute": "announce-self", "arguments": { "initial": 50, "max": 55=
0, "rounds": 5, "step": 50, "interfaces": ["vn2","vn1"] } }
>=20
> This doesn't affect the behaviour of migraiton announcments.
>=20
> Note: There's still only one timer for the qmp command, so that
> performing an 'announce-self' on one list of interfaces followed
> by another 'announce-self' on another list will stop the announces
> on the existing set.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/qapi/net.json
> @@ -699,6 +699,9 @@
>  #
>  # @step: Delay increase (in ms) after each self-announcement attempt
>  #
> +# @interfaces: An optional list of interface names, which restrict the=


restricts

> +#        announcment to the listed interfaces. (Since 4.1)

announcement

> +#
>  # Since: 4.0
>  ##
> =20
> @@ -706,7 +709,8 @@
>    'data': { 'initial': 'int',
>              'max': 'int',
>              'rounds': 'int',
> -            'step': 'int' } }
> +            'step': 'int',
> +            '*interfaces': ['str'] } }
> =20
>  ##
>  # @announce-self:
> @@ -718,9 +722,10 @@
>  #
>  # Example:
>  #
> -# -> { "execute": "announce-self"
> +# -> { "execute": "announce-self",

Embarrassing that we didn't notice that one earlier.

>  #      "arguments": {
> -#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> +#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> +#          "interfaces": ["vn2","vn3"] } }

Worth a space after the comma? Not required, but I think it looks nicer.

As I only focused on doc issues, I'll leave the full review to others.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mJ3WZvC0zZ3yupoQcAT3Ph7eZCigTU1nE--

--SwgAIJfa1OCmz9ut5qktkTcn0sv8IgHEy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+s88ACgkQp6FrSiUn
Q2rj9wf+JD+BZgz1WUzPyf/OwDUsYLIVtX/K1xsxJWV5mhRDGDb2UeFNgnpg3Grl
TFBkAk2kDpez3LvKcrM7IhZtDg/vA4LjHxUEKjB2VvD499iBgB6+mI+Mi/aRWljW
M2qp8Ds4/MeQebjc1umUKzACKdqOdjXtY96fn4RgccFt0NK9jciKtTRD5J92f7Jv
7g/c/MWrQMpBJyDPqTqM7Xb5+Dl8RtXxg8rvd8YXFoSoxZWL3odJ4o8kdlqmxzFE
1NUkn4UOcJMqj+tvpgVqudpqpq7ZLcgyrLtmFXYeyLlQdLB6rizSOQ3smZgWdybJ
1yHW3VS92ZZwpJs6lvYR9AddowdGnw==
=qyH3
-----END PGP SIGNATURE-----

--SwgAIJfa1OCmz9ut5qktkTcn0sv8IgHEy--

