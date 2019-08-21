Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A926C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F03922CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03922CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UEM-0003sT-BP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0UDK-0002Gg-LQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0UDI-0003aa-SZ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i0UDF-0003US-6Y; Wed, 21 Aug 2019 13:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18D731801580;
 Wed, 21 Aug 2019 17:15:56 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D99660605;
 Wed, 21 Aug 2019 17:15:52 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-2-vsementsov@virtuozzo.com>
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
Message-ID: <b406fc91-b2ea-37b0-fe91-82bfa4f0a85d@redhat.com>
Date: Wed, 21 Aug 2019 12:15:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821165215.61406-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uhtgOWqDuVhpTgf8zDTm2tN8P81mZMLdI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 21 Aug 2019 17:15:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 1/3] qemu-coroutine-sleep: introduce
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
Cc: fam@euphon.net, kwolf@redhat.com, sheepdog@lists.wpkg.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 namei.unix@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uhtgOWqDuVhpTgf8zDTm2tN8P81mZMLdI
Content-Type: multipart/mixed; boundary="gVSgwQQ2QBmMCSb404QwVfnUvxHH7NIpe";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, fam@euphon.net, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org
Message-ID: <b406fc91-b2ea-37b0-fe91-82bfa4f0a85d@redhat.com>
Subject: Re: [PATCH v8 1/3] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190821165215.61406-2-vsementsov@virtuozzo.com>

--gVSgwQQ2QBmMCSb404QwVfnUvxHH7NIpe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/21/19 11:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce a function to gracefully wake a coroutine sleeping in
> qemu_co_sleep_ns().
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

I'd like a second reviewer on this, but I'll at least give it a spin.

>  include/qemu/coroutine.h    | 17 ++++++++++++--
>  block/null.c                |  2 +-
>  block/sheepdog.c            |  2 +-
>  tests/test-bdrv-drain.c     |  6 ++---
>  tests/test-block-iothread.c |  2 +-
>  util/qemu-coroutine-sleep.c | 47 +++++++++++++++++++++++++++----------=

>  6 files changed, 55 insertions(+), 21 deletions(-)

This merely updates existing callers to pass in NULL for the new
argument.  I'd feel a lot better if one of the two tests/ changes also
added a test passing a non-NULL sleep_state, and demonstrated its use.

>=20
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a4..96780a4902 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -274,9 +274,22 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
>  void qemu_co_rwlock_unlock(CoRwlock *lock);
> =20
>  /**
> - * Yield the coroutine for a given duration
> + * Yield the coroutine for a given duration. During this yield @sleep_=
state (if

s/yield/yield,/

> + * not NULL) is set to opaque pointer, which may be used for

s/to/to an/

> + * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero w=
hen timer
> + * shoots. Don't save obtained value to other variables and don't call=


s/when timer shoots/when the timer fires/

s/save/save/the/

> + * qemu_co_sleep_wake from another aio context.
>   */
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
> +void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns,
> +                                   void **sleep_state);
> +
> +/**
> + * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will =
be

s/by/in/
s/Timer/The timer/

> + * deleted. @sleep_state must be the variable which address was given =
to

s/which/whose/

> + * qemu_co_sleep_ns() and should be checked to be non-NULL before call=
ing
> + * qemu_co_sleep_wake().
> + */
> +void qemu_co_sleep_wake(void *sleep_state);
> =20

> +++ b/util/qemu-coroutine-sleep.c
> @@ -17,31 +17,52 @@
>  #include "qemu/timer.h"
>  #include "block/aio.h"
> =20
> -static void co_sleep_cb(void *opaque)
> -{
> -    Coroutine *co =3D opaque;
> +const char *qemu_co_sleep_ns__scheduled =3D "qemu_co_sleep_ns";

Why is this not marked static?

> +
> +typedef struct QemuCoSleepState {
> +    Coroutine *co;
> +    QEMUTimer *ts;
> +    void **user_state_pointer;
> +} QemuCoSleepState;
> =20
> +void qemu_co_sleep_wake(void *sleep_state)
> +{
> +    QemuCoSleepState *s =3D (QemuCoSleepState *)sleep_state;

This is C; the cast is not necessary.

>      /* Write of schedule protected by barrier write in aio_co_schedule=
 */
> -    atomic_set(&co->scheduled, NULL);
> -    aio_co_wake(co);
> +    const char *scheduled =3D atomic_cmpxchg(&s->co->scheduled,
> +                                           qemu_co_sleep_ns__scheduled=
, NULL);
> +
> +    assert(scheduled =3D=3D qemu_co_sleep_ns__scheduled);
> +    if (s->user_state_pointer) {
> +        *s->user_state_pointer =3D NULL;
> +    }
> +    timer_del(s->ts);
> +    aio_co_wake(s->co);
>  }
> =20
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
> +void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns,
> +                                   void **sleep_state)
>  {
>      AioContext *ctx =3D qemu_get_current_aio_context();
> -    QEMUTimer *ts;
> -    Coroutine *co =3D qemu_coroutine_self();
> +    QemuCoSleepState state =3D {
> +        .co =3D qemu_coroutine_self(),
> +        .ts =3D aio_timer_new(ctx, type, SCALE_NS, qemu_co_sleep_wake,=
 &state),
> +        .user_state_pointer =3D sleep_state,
> +    };
> =20
> -    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL, __f=
unc__);
> +    const char *scheduled =3D atomic_cmpxchg(&state.co->scheduled, NUL=
L,
> +                                           qemu_co_sleep_ns__scheduled=
);
>      if (scheduled) {
>          fprintf(stderr,
>                  "%s: Co-routine was already scheduled in '%s'\n",
>                  __func__, scheduled);
>          abort();
>      }
> -    ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
> -    timer_mod(ts, qemu_clock_get_ns(type) + ns);
> +
> +    if (sleep_state) {
> +        *sleep_state =3D &state;
> +    }
> +    timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
>      qemu_coroutine_yield();
> -    timer_del(ts);
> -    timer_free(ts);
> +    timer_free(state.ts);
>  }

Grammar changes are trivial; and while it is not the most trivial of
patches, I at least follow what it is doing.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--gVSgwQQ2QBmMCSb404QwVfnUvxHH7NIpe--

--uhtgOWqDuVhpTgf8zDTm2tN8P81mZMLdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1dfEcACgkQp6FrSiUn
Q2rNqQf/UA81pEdqrw/r/Ow8UpBvYdpqV+IQsewushTvORYQ1tPOH/CxmGdoz4lz
bXvq1QtoCJVpU36zfZFgErQSDQAN2kKGOQVvY0Cvg2yjTKbCxXpx+J42g2nPWGWi
QXwFsbSnTj9hIp0rE7M/jdUHUuIhCLGYL8G4jgcDDABxI7wzBqRVjOfY8xInuzh4
fBEp0aUAqpk2+M1zgDNdeliR8EsUfQ8zgfeDZPmdXLQiy0rEbQ2cghaETyOVZlAO
FEraCZt8yyUz30QS4mLz845NtIcj7gHO9rAfaP6MkJ1N1C7B4qWcebqnsBOzefMI
3g4lXwP7dl1xQt1OfcQBHFMT/aF0bQ==
=EjEE
-----END PGP SIGNATURE-----

--uhtgOWqDuVhpTgf8zDTm2tN8P81mZMLdI--

