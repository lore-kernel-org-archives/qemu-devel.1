Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD1AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4F5216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4F5216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VR9-0006Qs-3L
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i0UWE-0007bT-6p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i0UWC-0006UQ-7U
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:35:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i0UW8-0006ML-DI; Wed, 21 Aug 2019 13:35:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA66C307D90D;
 Wed, 21 Aug 2019 17:35:27 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E20C60F88;
 Wed, 21 Aug 2019 17:35:24 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-3-vsementsov@virtuozzo.com>
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
Message-ID: <4f7cce1f-d7a8-aa3f-01d0-15c28c97b6dd@redhat.com>
Date: Wed, 21 Aug 2019 12:35:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821165215.61406-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cX92qz9sBoGENbt8NtgSvkTH66m6wV0sI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 21 Aug 2019 17:35:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 2/3] block/nbd: nbd reconnect
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
--cX92qz9sBoGENbt8NtgSvkTH66m6wV0sI
Content-Type: multipart/mixed; boundary="ok6G0SI9tkw42d5zME29YOPthXlg0drQL";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, fam@euphon.net, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org
Message-ID: <4f7cce1f-d7a8-aa3f-01d0-15c28c97b6dd@redhat.com>
Subject: Re: [PATCH v8 2/3] block/nbd: nbd reconnect
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190821165215.61406-3-vsementsov@virtuozzo.com>

--ok6G0SI9tkw42d5zME29YOPthXlg0drQL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/21/19 11:52 AM, Vladimir Sementsov-Ogievskiy wrote:
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

> +static bool nbd_client_connecting(BDRVNBDState *s)
> +{
> +    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
> +            s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT;


Indentation looks unusual. I might have done:

    return (s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT ||
            s->state =3D=3D NBD_CLIENT_CONNECTING_NOWAIT);

Or even exploit the enum encoding:

    return s->state <=3D NBD_CLIENT_CONNECTING_NOWAIT

Is s->state updated atomically, or do we risk the case where we might
see two different values of s->state across the || sequence point?  Does
that matter?

> +}
> +
> +static bool nbd_client_connecting_wait(BDRVNBDState *s)
> +{
> +    return s->state =3D=3D NBD_CLIENT_CONNECTING_WAIT;
> +}
> +
> +static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (!nbd_client_connecting(s)) {
> +        return;
> +    }
> +    assert(nbd_client_connecting(s));

This assert adds nothing given the condition beforehand.

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
> +        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, timeout,
> +                         &s->connection_co_sleep_ns_state);
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
> +
> +        nbd_reconnect_attempt(s);
> +    }
>  }
> =20
>  static coroutine_fn void nbd_connection_entry(void *opaque)
>  {
> -    BDRVNBDState *s =3D opaque;
> +    BDRVNBDState *s =3D (BDRVNBDState *)opaque;

The cast is not necessary.

>      uint64_t i;
>      int ret =3D 0;
>      Error *local_err =3D NULL;
> @@ -177,16 +331,26 @@ static coroutine_fn void nbd_connection_entry(voi=
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
>          }
>          if (ret <=3D 0) {
>              nbd_channel_error(s, ret ? ret : -EIO);
> -            break;
> +            continue;
>          }
> =20
>          /*
> @@ -201,7 +365,7 @@ static coroutine_fn void nbd_connection_entry(void =
*opaque)
>              (nbd_reply_is_structured(&s->reply) && !s->info.structured=
_reply))
>          {
>              nbd_channel_error(s, -EINVAL);
> -            break;
> +            continue;
>          }
> =20

The commit message says you re-attempt the request after reconnection if
you have not yet timed out from the previous connection; but do you also
need to clear out any partial reply received to make sure the new
request isn't operating on stale assumptions left over if the server
died between two structured chunks?


> @@ -927,20 +1113,26 @@ static int nbd_co_request(BlockDriverState *bs, =
NBDRequest *request,
>      } else {
>          assert(request->type !=3D NBD_CMD_WRITE);
>      }
> -    ret =3D nbd_co_send_request(bs, request, write_qiov);
> -    if (ret < 0) {
> -        return ret;
> -    }
> =20
> -    ret =3D nbd_co_receive_return_code(s, request->handle,
> -                                     &request_ret, &local_err);
> -    if (local_err) {
> -        trace_nbd_co_request_fail(request->from, request->len, request=
->handle,
> -                                  request->flags, request->type,
> -                                  nbd_cmd_lookup(request->type),
> -                                  ret, error_get_pretty(local_err));
> -        error_free(local_err);
> -    }
> +    do {
> +        ret =3D nbd_co_send_request(bs, request, write_qiov);
> +        if (ret < 0) {
> +            continue;
> +        }
> +
> +        ret =3D nbd_co_receive_return_code(s, request->handle,
> +                                         &request_ret, &local_err);
> +        if (local_err) {
> +            trace_nbd_co_request_fail(request->from, request->len,
> +                                      request->handle, request->flags,=

> +                                      request->type,
> +                                      nbd_cmd_lookup(request->type),
> +                                      ret, error_get_pretty(local_err)=
);
> +            error_free(local_err);
> +            local_err =3D NULL;
> +        }
> +    } while (ret < 0 && nbd_client_connecting_wait(s));

I ask because nothing seems to reset request_ret here in the new loop.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ok6G0SI9tkw42d5zME29YOPthXlg0drQL--

--cX92qz9sBoGENbt8NtgSvkTH66m6wV0sI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1dgNsACgkQp6FrSiUn
Q2qSIQf8D6H/po6NEe90rpy6RH8ypkZKiq5jq24WkUDXbZgAknuNmmIFBO6yKTmF
ktvAW5065x2LkBQYD7CdWlY6mgoNHwR7W52K0aPNGrrkpHl1VKJ8+KH++eBnLmHv
k8BmICw78PMswwhdmmxTzLWB4exRptpDw+aSupWuj+TcHpUWeY5d7bvfwe/pwJ7G
xBCHUtW0zU8GdwyzAD1USudha8LF5lPhS7VAJvITJNynG6xf/dNG2fWJXA7vvFHo
eqyI2e/ZpPwBiJraf1lrP7ux2/e3kWGXumXZqzfh/zpV4/Uiq19VTws+EW/WEu/H
Gv7zECZfMQ/LXee6Ml6cdWeIhyVn1w==
=j38a
-----END PGP SIGNATURE-----

--cX92qz9sBoGENbt8NtgSvkTH66m6wV0sI--

