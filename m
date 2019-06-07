Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690FC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 03:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B35208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 03:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B35208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ5PD-0007VJ-MU
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 23:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hZ5O5-00070l-GZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 23:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hZ5O3-0002Oq-PB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 23:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hZ5Nw-0002DY-V0; Thu, 06 Jun 2019 23:17:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A38DAC04959F;
 Fri,  7 Jun 2019 03:17:43 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A2F77C867;
 Fri,  7 Jun 2019 03:17:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
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
Message-ID: <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
Date: Thu, 6 Jun 2019 22:17:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411172709.205032-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RjhRo0EKlrmbOVE7deXCXZl6U9nkCQrez"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 03:17:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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
--RjhRo0EKlrmbOVE7deXCXZl6U9nkCQrez
Content-Type: multipart/mixed; boundary="0LA3ZzChEWk7OQzmfAG8ZxgUTSuSUTMmI";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
Subject: Re: [PATCH v6 6/7] block/nbd-client: nbd reconnect
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-7-vsementsov@virtuozzo.com>

--0LA3ZzChEWk7OQzmfAG8ZxgUTSuSUTMmI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/11/19 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Implement reconnect. To achieve this:
>=20
> 1. add new modes:
>    connecting-wait: means, that reconnecting is in progress, and there
>      were small number of reconnect attempts, so all requests are
>      waiting for the connection.
>    connecting-nowait: reconnecting is in progress, there were a lot of
>      attempts of reconnect, all requests will return errors.
>=20
>    two old modes are used too:
>    connected: normal state
>    quit: exiting after fatal error or on close
>=20
> Possible transitions are:
>=20
>    * -> quit
>    connecting-* -> connected
>    connecting-wait -> connecting-nowait (transition is done after
>                       reconnect-delay seconds in connecting-wait mode)
>    connected -> connecting-wait
>=20
> 2. Implement reconnect in connection_co. So, in connecting-* mode,
>     connection_co, tries to reconnect unlimited times.
>=20
> 3. Retry nbd queries on channel error, if we are in connecting-wait
>     state.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Does this also mean that we can start queuing up guest I/O even before
the first time connected is reached?

>  block/nbd-client.h |   7 +
>  block/nbd-client.c | 336 +++++++++++++++++++++++++++++++++++----------=

>  2 files changed, 273 insertions(+), 70 deletions(-)
>=20

> +++ b/block/nbd-client.c
> @@ -1,6 +1,7 @@
>  /*
>   * QEMU Block driver for  NBD
>   *
> + * Copyright (c) 2019 Virtuozzo International GmbH. All rights reserve=
d.

Adding copyright is fine - you are indeed adding a non-trivial amount of
code to this file. Adding "All rights reserved" is questionable, in part
because it no longer has legal status (see this recent nbdkit patch
https://github.com/libguestfs/nbdkit/commit/952ffe0fc7 for example).

Furthermore, I really cringe when I see it mixed with GPL, because the
GPL works by explicitly stating that you are NOT reserving all rights,
but are rather granting specific permissions to recipients. However, as
this file is BSD licensed, and the various family tree of BSD licenses
have (often due to copy-and-paste) used this phrase in the past, I'm not
going to reject the patch because of the phrase, even though I can
definitely ask if you can remove it.

> @@ -59,24 +77,133 @@ static void nbd_teardown_connection(BlockDriverSta=
te *bs)
>  {
>      NBDClientSession *client =3D nbd_get_client_session(bs);
> =20
> -    assert(client->ioc);
> -
> -    /* finish any pending coroutines */
> -    qio_channel_shutdown(client->ioc,
> -                         QIO_CHANNEL_SHUTDOWN_BOTH,
> -                         NULL);
> +    if (client->state =3D=3D NBD_CLIENT_CONNECTED) {
> +        /* finish any pending coroutines */
> +        assert(client->ioc);
> +        qio_channel_shutdown(client->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, N=
ULL);
> +    }
> +    client->state =3D NBD_CLIENT_QUIT;
> +    if (client->connection_co) {
> +        qemu_co_sleep_wake(client->connection_co);
> +    }
>      BDRV_POLL_WHILE(bs, client->connection_co);

So you are using the qemu_co_sleep_wake code as a way to in effect
cancel any ongoing sleep. I'm still not sure if there is already another
way to achieve the same effect, perhaps by re-entering the coroutine?

> +typedef struct NBDConnection {
> +    BlockDriverState *bs;
> +    SocketAddress *saddr;
> +    const char *export;
> +    QCryptoTLSCreds *tlscreds;
> +    const char *hostname;
> +    const char *x_dirty_bitmap;
> +} NBDConnection;

Can we put this type in a header, and use it instead of passing lots of
individual parameters to nbd_client_connect()?  Probably as a separate
pre-requisite cleanup patch.

> +
> +static bool nbd_client_connecting(NBDClientSession *client)
> +{
> +    return client->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
> +           client->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;
> +}

I don't know what style we prefer to use here. If my returns split
across lines, I tend to go with either 4-space indent instead of 7, or
to use () so that the second line is indented to the column after (; but
this is aesthetics and so I'm not going to change what you have.

> +
> +static bool nbd_client_connecting_wait(NBDClientSession *client)
> +{
> +    return client->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
> +}
> +
> +static coroutine_fn void nbd_reconnect_attempt(NBDConnection *con)
> +{
> +    NBDClientSession *s =3D nbd_get_client_session(con->bs);
> +    Error *local_err =3D NULL;
> +
> +    if (!nbd_client_connecting(s)) {
> +        return;
> +    }
> +    assert(nbd_client_connecting(s));
> +
> +    /* Wait completion of all in-flight requests */

Wait for completion

> +
> +    qemu_co_mutex_lock(&s->send_mutex);
> =20
> -    nbd_client_detach_aio_context(bs);
> -    object_unref(OBJECT(client->sioc));
> -    client->sioc =3D NULL;
> -    object_unref(OBJECT(client->ioc));
> -    client->ioc =3D NULL;
> +    while (s->in_flight > 0) {
> +        qemu_co_mutex_unlock(&s->send_mutex);
> +        nbd_recv_coroutines_wake_all(s);
> +        s->wait_in_flight =3D true;
> +        qemu_coroutine_yield();
> +        s->wait_in_flight =3D false;
> +        qemu_co_mutex_lock(&s->send_mutex);
> +    }
> +
> +    qemu_co_mutex_unlock(&s->send_mutex);
> +
> +    if (!nbd_client_connecting(s)) {
> +        return;
> +    }
> +
> +    /*
> +     * Now we are sure, that nobody accessing the channel now and nobo=
dy
> +     * will try to access the channel, until we set state to CONNECTED=


Now we are sure that nobody is accessing the channel, and no one will
try until we set the state to CONNECTED

> +     */
> +
> +    /* Finalize previous connection if any */
> +    if (s->ioc) {
> +        nbd_client_detach_aio_context(con->bs);
> +        object_unref(OBJECT(s->sioc));
> +        s->sioc =3D NULL;
> +        object_unref(OBJECT(s->ioc));
> +        s->ioc =3D NULL;
> +    }
> +
> +    s->connect_status =3D nbd_client_connect(con->bs, con->saddr,
> +                                           con->export, con->tlscreds,=

> +                                           con->hostname, con->x_dirty=
_bitmap,
> +                                           &local_err);
> +    error_free(s->connect_err);
> +    s->connect_err =3D NULL;
> +    error_propagate(&s->connect_err, local_err);
> +    local_err =3D NULL;
> +
> +    if (s->connect_status < 0) {
> +        /* failed attempt */
> +        return;
> +    }
> +
> +    /* successfully connected */
> +    s->state =3D NBD_CLIENT_CONNECTED;
> +    qemu_co_queue_restart_all(&s->free_sema);
> +}
> +
> +static coroutine_fn void nbd_reconnect_loop(NBDConnection *con)
> +{
> +    NBDClientSession *s =3D nbd_get_client_session(con->bs);
> +    uint64_t start_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);=

> +    uint64_t delay_ns =3D s->reconnect_delay * 1000000000UL;

Do we have a #define constant for nanoseconds in a second to make this
more legible than counting '0's?

> +    uint64_t timeout =3D 1000000000UL; /* 1 sec */
> +    uint64_t max_timeout =3D 16000000000UL; /* 16 sec */

1 * constant, 16 * constant

> +
> +    nbd_reconnect_attempt(con);
> +
> +    while (nbd_client_connecting(s)) {
> +        if (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT &&
> +            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > d=
elay_ns)
> +        {
> +            s->state =3D NBD_CLIENT_CONNECTING_NOWAIT;
> +            qemu_co_queue_restart_all(&s->free_sema);
> +        }
> +
> +        bdrv_dec_in_flight(con->bs);
> +        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout);

Another place where I'd like someone more familiar with coroutines to
also have a look.

> +        bdrv_inc_in_flight(con->bs);
> +        if (timeout < max_timeout) {
> +            timeout *=3D 2;
> +        }
> +
> +        nbd_reconnect_attempt(con);
> +    }
>  }
> =20
>  static coroutine_fn void nbd_connection_entry(void *opaque)
>  {
> -    NBDClientSession *s =3D opaque;
> +    NBDConnection *con =3D opaque;
> +    NBDClientSession *s =3D nbd_get_client_session(con->bs);
>      uint64_t i;
>      int ret =3D 0;
>      Error *local_err =3D NULL;
> @@ -91,16 +218,25 @@ static coroutine_fn void nbd_connection_entry(void=
 *opaque)
>           * Therefore we keep an additional in_flight reference all the=
 time and
>           * only drop it temporarily here.
>           */
> +
> +        if (nbd_client_connecting(s)) {
> +            nbd_reconnect_loop(con);
> +        }
> +
> +        if (s->state !=3D NBD_CLIENT_CONNECTED) {
> +            continue;
> +        }
> +

If I understand, this is not a busy loop because nbd_reconnect_loop()
will pause the coroutine until something interesting happens. Correct?

It's late enough at night for me that I don't trust this to be a full
review; I'll try and look again soon in more details, as well as play
with this against iotests.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--0LA3ZzChEWk7OQzmfAG8ZxgUTSuSUTMmI--

--RjhRo0EKlrmbOVE7deXCXZl6U9nkCQrez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz511MACgkQp6FrSiUn
Q2pvdggAlA+ODENokHMT1SPg5m+dVHmrXQ0nDq3HO1BqfqWlJQdqb7StNQgppHxl
6X40roXPoLkeksoDJBm9+UVFGdfsvLm948Yk16xpJHRZOT6/LEKZ1KDizavEy22V
AdFOYLmA2k7kBBIuIExUJcAysHorze69lq5zf0qYPgYwpwsRQ2VBrnyCmBQSIIwB
NaD6LdgeaLxZNE+pP3y6jMCW6ZaX4IHS3B6UcisFjO/orCtwZAowJ2Vk1Enah20C
KteNIFqTfz3Xstq5p8krBUOmquqTdBq/o31ymlG0IG7LP6+uN+ZJTPWmdthn5sDf
DN03S2qpnONcSCy6BmVXzunhzzN8rQ==
=XSt0
-----END PGP SIGNATURE-----

--RjhRo0EKlrmbOVE7deXCXZl6U9nkCQrez--

