Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B59C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799B320B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799B320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTxb-0002IF-JD
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCTwJ-0001h4-QB
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCTwH-0004cX-Q2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCTwD-0004Zi-6i; Mon, 23 Sep 2019 15:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E03110F2E82;
 Mon, 23 Sep 2019 19:23:56 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9DE819C77;
 Mon, 23 Sep 2019 19:23:51 +0000 (UTC)
Subject: Re: [PATCH v9 2/3] block/nbd: nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-3-vsementsov@virtuozzo.com>
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
Message-ID: <b4532b07-71a9-1890-949d-a017ede348ee@redhat.com>
Date: Mon, 23 Sep 2019 14:23:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917171322.4127-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fiCEFb92qSSibtZYOmyCD1GnVHjl6QNC4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 23 Sep 2019 19:23:56 +0000 (UTC)
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fiCEFb92qSSibtZYOmyCD1GnVHjl6QNC4
Content-Type: multipart/mixed; boundary="PgnNXkGifqfeoPIcC9mVlkSghjAe7wEo2";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <b4532b07-71a9-1890-949d-a017ede348ee@redhat.com>
Subject: Re: [PATCH v9 2/3] block/nbd: nbd reconnect
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190917171322.4127-3-vsementsov@virtuozzo.com>

--PgnNXkGifqfeoPIcC9mVlkSghjAe7wEo2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/17/19 12:13 PM, Vladimir Sementsov-Ogievskiy wrote:
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
>  block/nbd.c | 332 ++++++++++++++++++++++++++++++++++++++++++----------=

>  1 file changed, 269 insertions(+), 63 deletions(-)
>=20

> +
> +static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (!nbd_client_connecting(s)) {
> +        return;
> +    }
> +
> +    /* Wait for completion of all in-flight requests */
> +
> +    qemu_co_mutex_lock(&s->send_mutex);
> +
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
> +     * Now we are sure that nobody is accessing the channel, and no on=
e will
> +     * try until we set the state to CONNECTED.
> +     */
> +
> +    /* Finalize previous connection if any */
> +    if (s->ioc) {
> +        nbd_client_detach_aio_context(s->bs);
> +        object_unref(OBJECT(s->sioc));
> +        s->sioc =3D NULL;
> +        object_unref(OBJECT(s->ioc));
> +        s->ioc =3D NULL;
> +    }
> +
> +    s->connect_status =3D nbd_client_connect(s->bs, &local_err);
> +    error_free(s->connect_err);
> +    s->connect_err =3D NULL;
> +    error_propagate(&s->connect_err, local_err);
> +    local_err =3D NULL;
> +

Looks like a dead assignment to local_err.  But I see elsewhere you add
it, because you convert straight-line code into loops where it matters.

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
> +static coroutine_fn void nbd_reconnect_loop(BDRVNBDState *s)

Coroutine functions should generally have '_co_' in their name.  I'd
prefer nbd_co_reconnect_loop.

> +{
> +    uint64_t start_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);=

> +    uint64_t delay_ns =3D s->reconnect_delay * NANOSECONDS_PER_SECOND;=

> +    uint64_t timeout =3D 1 * NANOSECONDS_PER_SECOND;
> +    uint64_t max_timeout =3D 16 * NANOSECONDS_PER_SECOND;
> +
> +    nbd_reconnect_attempt(s);
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
> +        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
> +                                  &s->connection_co_sleep_ns_state);
> +        if (s->drained) {
> +            bdrv_dec_in_flight(s->bs);
> +            s->wait_drained_end =3D true;
> +            while (s->drained) {
> +                /*
> +                 * We may be entered once from nbd_client_attach_aio_c=
ontext_bh
> +                 * and then from nbd_client_co_drain_end. So here is a=
 loop.
> +                 */
> +                qemu_coroutine_yield();
> +            }
> +            bdrv_inc_in_flight(s->bs);
> +        }
> +        if (timeout < max_timeout) {
> +            timeout *=3D 2;
> +        }

Exponential backup, ok.  If I read the loop correctly, you've hardcoded
the max_timeout at 16s, which means the overall timeout is about 30s
when adding in the time of the earlier iterations.  Does that need to be
tunable?  But for now I can live with it.

> +
> +        nbd_reconnect_attempt(s);
> +    }
>  }
> =20
>  static coroutine_fn void nbd_connection_entry(void *opaque)
> @@ -177,16 +330,26 @@ static coroutine_fn void nbd_connection_entry(voi=
d *opaque)
>           * Therefore we keep an additional in_flight reference all the=
 time and
>           * only drop it temporarily here.
>           */
> +
> +        if (nbd_client_connecting(s)) {
> +            nbd_reconnect_loop(s);
> +        }
> +
> +        if (s->state !=3D NBD_CLIENT_CONNECTED) {
> +            continue;
> +        }

Is 'continue' right, even if s->state =3D=3D QUIT?

> +
>          assert(s->reply.handle =3D=3D 0);
>          ret =3D nbd_receive_reply(s->bs, s->ioc, &s->reply, &local_err=
);
> =20
>          if (local_err) {
>              trace_nbd_read_reply_entry_fail(ret, error_get_pretty(loca=
l_err));
>              error_free(local_err);
> +            local_err =3D NULL;

Could be fun in concert with your proposal to get rid of local_err ;)
But here, we aren't using error_propagate().

>          }
>          if (ret <=3D 0) {
>              nbd_channel_error(s, ret ? ret : -EIO);
> -            break;
> +            continue;
>          }
> =20
>          /*

We're getting really close.  If you can answer my questions above, and
the only thing left is adding _co_ in the function name, I could tweak
that locally to spare you a v10.  At any rate, I'm tentatively queuing
this on my NBD tree; I'll probably do a pull request today without it,
and save it for next week's PR after I've had a week to hammer on it in
local tests.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--PgnNXkGifqfeoPIcC9mVlkSghjAe7wEo2--

--fiCEFb92qSSibtZYOmyCD1GnVHjl6QNC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2JG8cACgkQp6FrSiUn
Q2oGkwgAidoldnPbJ+ttdq3v1wawfY7fjtZu0ktw8fdIyJMfA9HL/a74E5Pd6bZ1
ByQOMxn8HGOsKPbkB5SNIkjwk2NQz1kzlQUTNB6Ige0FV8WT2Z/XTWyGgp1Iyckm
+kK1u6XrJMPWFNgUUVdpK9ccqPYvsQ8HV4KNGTFUQgdc5kWXv3m1ZDqAZvs6SF1r
gumHEgvyp3pmW2DM2NagrU0yM/qi39RZ14ig2dSHVvj8TFCmhIh3FqWqecGwvb+U
nIPuWpxqNXd9pMNvuYaGVS1wnJ1V9wAQ0GLY16U2rLHvwaXARXbOMMs5N7IqBfSo
F4WS4L9uZYLDdLYrSrRxAt9EuhjuZg==
=laKC
-----END PGP SIGNATURE-----

--fiCEFb92qSSibtZYOmyCD1GnVHjl6QNC4--

