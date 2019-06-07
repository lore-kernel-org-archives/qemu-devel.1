Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E9C28EBD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581CE206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 02:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581CE206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ525-0005I8-HD
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 22:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50963)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZ514-0004aJ-FP
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZ513-0006Cb-CA
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 22:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hZ4w5-0007yF-6V; Thu, 06 Jun 2019 22:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 882A33082200;
 Fri,  7 Jun 2019 02:48:54 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5448BE58;
 Fri,  7 Jun 2019 02:48:48 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
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
Message-ID: <834d25f9-23c9-287c-0599-905a7669a6c5@redhat.com>
Date: Thu, 6 Jun 2019 21:48:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411172709.205032-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2U6CC7xS62OVCcNoU9QxIrucDq4bDmSOK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 07 Jun 2019 02:48:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2U6CC7xS62OVCcNoU9QxIrucDq4bDmSOK
Content-Type: multipart/mixed; boundary="u3DzIyC2y4l9f20KSbx9jdWvT8BfqVwUw";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <834d25f9-23c9-287c-0599-905a7669a6c5@redhat.com>
Subject: Re: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-6-vsementsov@virtuozzo.com>

--u3DzIyC2y4l9f20KSbx9jdWvT8BfqVwUw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce a function to gracefully wake-up a coroutine, sleeping in
> qemu_co_sleep_ns() sleep.

Maybe:

Introduce a function to gracefully short-circuit the remainder of the
delay for a coroutine sleeping in qemu_co_sleep_ns().

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/coroutine.h    |  6 ++++++
>  util/qemu-coroutine-sleep.c | 20 ++++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a4..ec765c26f0 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -278,6 +278,12 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
>   */
>  void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
> =20
> +/*
> + * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will =
be
> + * deleted.

Maybe:

Wake a coroutine if it is sleeping in qemu_co_sleep_ns, and delete the
timer.

> +++ b/util/qemu-coroutine-sleep.c
> @@ -17,13 +17,24 @@
>  #include "qemu/timer.h"
>  #include "block/aio.h"
> =20
> +const char *qemu_co_sleep_ns__scheduled =3D "qemu_co_sleep_ns";
> +
> +void qemu_co_sleep_wake(Coroutine *co)
> +{
> +    /* Write of schedule protected by barrier write in aio_co_schedule=
 */
> +    const char *scheduled =3D atomic_cmpxchg(&co->scheduled,
> +                                           qemu_co_sleep_ns__scheduled=
, NULL);
> +
> +    if (scheduled =3D=3D qemu_co_sleep_ns__scheduled) {
> +        aio_co_wake(co);
> +    }
> +}
> +
>  static void co_sleep_cb(void *opaque)
>  {
>      Coroutine *co =3D opaque;
> =20
> -    /* Write of schedule protected by barrier write in aio_co_schedule=
 */
> -    atomic_set(&co->scheduled, NULL);
> -    aio_co_wake(co);
> +    qemu_co_sleep_wake(co);
>  }
> =20
>  void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
> @@ -32,7 +43,8 @@ void coroutine_fn qemu_co_sleep_ns(QEMUClockType type=
, int64_t ns)
>      QEMUTimer *ts;
>      Coroutine *co =3D qemu_coroutine_self();
> =20
> -    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL, __f=
unc__);
> +    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL,
> +                                           qemu_co_sleep_ns__scheduled=
);
>      if (scheduled) {
>          fprintf(stderr,
>                  "%s: Co-routine was already scheduled in '%s'\n",
>=20

Here, I'd rather get an additional review from anyone more familiar with
coroutine sleeps.  I'm guessing that your intent is to request a maximum
timeout for a given operation to complete in, but to leave the sleep
loop early if the operation completes earlier.  I don't know if any
existing coroutine code can be used to express that same idea.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--u3DzIyC2y4l9f20KSbx9jdWvT8BfqVwUw--

--2U6CC7xS62OVCcNoU9QxIrucDq4bDmSOK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz50I8ACgkQp6FrSiUn
Q2pN3Qf9E7uyYyZ7VYk4ilCQe+eZYdw6z0Fuz4960MtrMOJWF35QDH6603l0gU0r
E9MOyINp1rO4TkP3+amMh73zC6o6SQjWMMfYK0Wzji0yBylfT1tDsD+f/+bNOm0c
V6z1oY8LLUqwA2mopxX++IHWkV061nCZU2vgxx0Stxq5WLY5nHAsbcyaC/ITR2rz
3r/qNqNBh6m8yunoa5iVcmHYBN1Z4SsGlMIYTqtVouSPhDN9HLOBwTa/cGlqDn30
UXKqPaX31YbGI85FsKqFdRLi6G1aOUps5at9AjetowhiRaXRxldACFzxwbgrpmpG
Q3FRMgveTor0H8Qv9VJbXcIsQxGKHA==
=R2sV
-----END PGP SIGNATURE-----

--2U6CC7xS62OVCcNoU9QxIrucDq4bDmSOK--

