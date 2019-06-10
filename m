Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457BC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FBE20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FBE20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQOl-0005Ep-Dp
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haQMl-0004Au-An
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haQMi-0006IM-J4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1haQMi-0006Hb-6E
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CD3C30F1BBC
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 19:53:51 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227B66061B;
 Mon, 10 Jun 2019 19:53:44 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
 laine@redhat.com
References: <20190610184402.7090-1-dgilbert@redhat.com>
 <20190610184402.7090-4-dgilbert@redhat.com>
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
Message-ID: <e602e259-f5db-c73a-7a4e-f63a2d48e85c@redhat.com>
Date: Mon, 10 Jun 2019 14:53:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610184402.7090-4-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C9lN3n1GaluiAPfUqTz9imI6kqae3ebka"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 10 Jun 2019 19:53:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/4] net/announce: Add optional ID
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
--C9lN3n1GaluiAPfUqTz9imI6kqae3ebka
Content-Type: multipart/mixed; boundary="aenxVI1hmaVw3cFWvkuRa5yggszDm9Ia8";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, armbru@redhat.com,
 laine@redhat.com
Message-ID: <e602e259-f5db-c73a-7a4e-f63a2d48e85c@redhat.com>
Subject: Re: [PATCH v3 3/4] net/announce: Add optional ID
References: <20190610184402.7090-1-dgilbert@redhat.com>
 <20190610184402.7090-4-dgilbert@redhat.com>
In-Reply-To: <20190610184402.7090-4-dgilbert@redhat.com>

--aenxVI1hmaVw3cFWvkuRa5yggszDm9Ia8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 1:44 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Previously there was a single instance of the timer used by
> monitor triggered announces, that's OK, but when combined with the
> previous change that lets you have announces for subsets of interfaces
> it's a bit restrictive if you want to do different things to different
> interfaces.
>=20
> Add an 'id' field to the announce, and maintain a list of the
> timers based on id.
>=20
> This allows you to for example:
>     a) Start an announce going on interface eth0 for a long time
>     b) Start an announce going on interface eth1 for a long time
>     c) Kill the announce on eth0 while leaving eth1 going.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

> +++ b/include/net/announce.h
> @@ -23,8 +23,12 @@ struct AnnounceTimer {
>  /* Returns: update the timer to the next time point */
>  int64_t qemu_announce_timer_step(AnnounceTimer *timer);
> =20
> -/* Delete the underlying timer and other data */
> -void qemu_announce_timer_del(AnnounceTimer *timer);
> +/*
> + * Delete the underlying timer and other datas

'data' is already plural, 'datas' is not a word.

> + * If 'free_named' true and the timer is a named timer, then remove
> + * it from the list of named timers and free the AnnounceTimer itself.=

> + */
> +void qemu_announce_timer_del(AnnounceTimer *timer, bool free_named);
> =20

> +++ b/qapi/net.json
> @@ -702,6 +702,10 @@
>  # @interfaces: An optional list of interface names, which restrict the=

>  #        announcment to the listed interfaces. (Since 4.1)
>  #
> +# @id: A name to be used to identify an instance of announce-timers
> +#        and to allow it to modified later.  Not for use as
> +#        part of the migration paramters. (Since 4.1)

parameters

> +#
>  # Since: 4.0
>  ##
> =20
> @@ -710,7 +714,8 @@
>              'max': 'int',
>              'rounds': 'int',
>              'step': 'int',
> -            '*interfaces': ['str'] } }
> +            '*interfaces': ['str'],
> +            '*id' : 'str' } }
> =20
>  ##
>  # @announce-self:
> @@ -725,7 +730,7 @@
>  # -> { "execute": "announce-self",
>  #      "arguments": {
>  #          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> -#          "interfaces": ["vn2","vn3"] } }
> +#          "interfaces": ["vn2","vn3"], "id": "bob" } }
>  # <- { "return": {} }
>  #

Worth an example of deleting a timer by id?

>  # Since: 4.0
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 163126cf07..7184e2bff4 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -186,7 +186,7 @@ static void announce_self(void *obj, void *data, QG=
uestAllocator *t_alloc)
>      rsp =3D qmp("{ 'execute' : 'announce-self', "
>                    " 'arguments': {"
>                        " 'initial': 50, 'max': 550,"
> -                      " 'rounds': 10, 'step': 50 } }");
> +                      " 'rounds': 10, 'step': 50, 'id': 'bob' } }");

And here, is it worth testing that you can delete by id, rather than
just create with an id?

>      assert(!qdict_haskey(rsp, "error"));
>      qobject_unref(rsp);
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aenxVI1hmaVw3cFWvkuRa5yggszDm9Ia8--

--C9lN3n1GaluiAPfUqTz9imI6kqae3ebka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+tUcACgkQp6FrSiUn
Q2rkbgf/ddNO4FEJUH/groXSmmPJZSu8INwoYjBQtT8Lgh34UXMWBOlkZRv4gJ8Z
dnhCvbS2UtgA1fzEU29QBjnLBKy4T9etGa3bVt7TjPX0gxOtGV8qNZ/yionKr7Jj
3ta434GDgvyfZRq8J8bUrmA02Hbf2qP9bOrjZp3IWMKy4AMhRR+pAf2RTrk41qDB
ira2nhNrYsGdVhsFSShJguweBdzvGvmoZVZnYMsSH5a+EHAVI5y5L4wAWO21JGhT
UnJQv0yZrB3CuvZeQj51vKKVFlyUZKA23Q71eB/WALHGHtjuIEWZnBNnUFrs0/0V
dXMCuZq2hlNK6PqnHYXfBjFuLBV3Pg==
=7B/R
-----END PGP SIGNATURE-----

--C9lN3n1GaluiAPfUqTz9imI6kqae3ebka--

