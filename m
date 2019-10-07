Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57DC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508E1206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508E1206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV23-0006jB-Bo
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHUqk-0005ke-RJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHUqi-0002vp-QX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHUqe-0002tj-JM; Mon, 07 Oct 2019 11:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC4E6301A3B6;
 Mon,  7 Oct 2019 15:22:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC1AF1001E75;
 Mon,  7 Oct 2019 15:22:51 +0000 (UTC)
Subject: Re: [PATCH 4/6] util: introduce co-shared-amount
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-5-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <1efcbe22-6f71-3123-ca78-886153da11b3@redhat.com>
Date: Mon, 7 Oct 2019 17:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003171539.12327-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jP2oCD5I9ArhFmWOujHMNAcUbwER51dV7"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 07 Oct 2019 15:22:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jP2oCD5I9ArhFmWOujHMNAcUbwER51dV7
Content-Type: multipart/mixed; boundary="z4REexWBJZNBE49ld8xmSvSWesDvJX9Ad"

--z4REexWBJZNBE49ld8xmSvSWesDvJX9Ad
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 19:15, Vladimir Sementsov-Ogievskiy wrote:
> Introduce an API for some shared splitable resource, like memory.

*splittable, I suppose

> It's going to be used by backup. Backup uses both read/write io and
> copy_range. copy_range may consume memory implictly, so new API is

*the new API

> abstract: it don't allocate any real memory but only handling out

*It doesn=E2=80=99t allocate any real memory but only hands out

> tickets.

Note that allocation doesn=E2=80=99t necessarily mean you get a handle to=
 the
allocated object.  It just means that some resource (or part of a
resource) is now under your exclusive control.  At least that=E2=80=99s h=
ow I
understand the term.

So this is indeed some form of allocation.

> The idea is that we have some total amount of something and callers
> should wait in coroutine queue if there is not enough of the resource
> at the moment.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/co-shared-amount.h | 66 ++++++++++++++++++++++++++++
>  util/qemu-co-shared-amount.c    | 77 +++++++++++++++++++++++++++++++++=

>  util/Makefile.objs              |  1 +
>  3 files changed, 144 insertions(+)
>  create mode 100644 include/qemu/co-shared-amount.h
>  create mode 100644 util/qemu-co-shared-amount.c
>=20
> diff --git a/include/qemu/co-shared-amount.h b/include/qemu/co-shared-a=
mount.h
> new file mode 100644
> index 0000000000..e2dbc43dfd
> --- /dev/null
> +++ b/include/qemu/co-shared-amount.h
> @@ -0,0 +1,66 @@
> +/*
> + * Generic shared amount for coroutines

=E2=80=9Camount=E2=80=9D always begs the question =E2=80=9Camount of what=
=E2=80=9D.  So maybe something
more verbose like =E2=80=9CHelper functionality for distributing a fixed =
total
amount of an abstract resource among multiple coroutines=E2=80=9D would a=
nswer
that question.

(I can=E2=80=99t come up with a better short name than shared-amount, tho=
ugh.
It does get the point across once the concept=E2=80=99s clear.)

> + *
> + * Copyright (c) 2019 Virtuozzo International GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef QEMU_CO_SHARED_AMOUNT_H
> +#define QEMU_CO_SHARED_AMOUNT_H
> +
> +
> +typedef struct QemuCoSharedAmount QemuCoSharedAmount;
> +
> +/*
> + * Create QemuCoSharedAmount structure
> + *
> + * @total: total amount to be shared between clients
> + *
> + * Note: this API is not thread-safe as it originally designed to be u=
sed in
> + * backup block-job and called from one aio context. If multiple threa=
ds support
> + * is needed it should be implemented (for ex., protect QemuCoSharedAm=
ount by
> + * mutex).

I think the simple note =E2=80=9CThis API is not thread-safe=E2=80=9D wil=
l suffice.  The
rest seems more confusing to me than that it really helps.

> + */
> +QemuCoSharedAmount *qemu_co_shared_amount_new(uint64_t total);
> +
> +/*
> + * Release QemuCoSharedAmount structure

I=E2=80=99d add the note from qemu_co_put_amount():

=E2=80=9CThis function may only be called once everything allocated by al=
l
clients has been deallocated/released.=E2=80=9D

> + */
> +void qemu_co_shared_amount_free(QemuCoSharedAmount *s);
> +
> +/*
> + * Try to get n peaces. If not enough free peaces returns false, other=
wise true.

*pieces

But I=E2=80=99d prefer =E2=80=9CTry to allocate an amount of @n.  Return =
true on
success, and false if there is too little left of the collective
resource to fulfill the request.=E2=80=9D

> + */
> +bool qemu_co_try_get_amount(QemuCoSharedAmount *s, uint64_t n);
> +
> +/*
> + * Get n peaces. If not enough yields. Return on success.

I=E2=80=99d prefer =E2=80=9CAllocate an amount of $n, and, if necessary, =
yield until
that becomes possible.=E2=80=9D

> + */
> +void coroutine_fn qemu_co_get_amount(QemuCoSharedAmount *s, uint64_t n=
);
> +
> +/*
> + * Put n peaces. Client must not put more than it gets, still it may p=
ut in
> + * split: for example, get(5) and then put(3), put(2). All peaces must=
 be put
> + * back before qemu_co_shared_amount_free call.

I=E2=80=99d prefer =E2=80=9CDeallocate/Release an amount of @n.  The tota=
l amount
allocated by a caller does not need to be deallocated/released with a
single call, but may be split over several calls.  For example, get(4),
get(3), and then put(5), put(2).=E2=80=9D

(And drop the qemu_co_shared_amount_free() reference, because it should
so say there.)

> + */
> +void coroutine_fn qemu_co_put_amount(QemuCoSharedAmount *s, uint64_t n=
);
> +
> +
> +#endif /* QEMU_CO_SHARED_AMOUNT_H */
> diff --git a/util/qemu-co-shared-amount.c b/util/qemu-co-shared-amount.=
c
> new file mode 100644
> index 0000000000..8855ce5705
> --- /dev/null
> +++ b/util/qemu-co-shared-amount.c
> @@ -0,0 +1,77 @@
> +/*
> + * Generic shared amount for coroutines
> + *
> + * Copyright (c) 2019 Virtuozzo International GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/coroutine.h"
> +#include "qemu/co-shared-amount.h"
> +
> +struct QemuCoSharedAmount {
> +    uint64_t total;
> +    uint64_t taken;

I=E2=80=99d reverse the =E2=80=9Ctaken=E2=80=9D to be =E2=80=9Cavailable=E2=
=80=9D.  Then the only purpose of
=E2=80=9Ctotal=E2=80=9D would be as part of assertions.

> +
> +    CoQueue queue;
> +};
> +
> +QemuCoSharedAmount *qemu_co_shared_amount_new(uint64_t total)
> +{
> +    QemuCoSharedAmount *s =3D g_new0(QemuCoSharedAmount, 1);
> +
> +    s->total =3D total;
> +    qemu_co_queue_init(&s->queue);
> +
> +    return s;
> +}
> +
> +void qemu_co_shared_amount_free(QemuCoSharedAmount *s)
> +{
> +    assert(s->taken =3D=3D 0);
> +    g_free(s);
> +}
> +
> +bool qemu_co_try_get_amount(QemuCoSharedAmount *s, uint64_t n)
> +{
> +    if (n < s->total && s->total - n >=3D s->taken) {

(This=E2=80=99d become simply =E2=80=9Cs->available >=3D n=E2=80=9D)

(And to be honest I have a hard time parsing that second condition.  To
me, the natural order would appear to be =E2=80=9Cs->total - s->taken >=3D=
 n=E2=80=9D.  I
mean, I can see that it matches by rearranging the inequation, but...
And in this order you could drop the =E2=80=9Cn < s->total=E2=80=9D part =
because it=E2=80=99s
guaranteed that s->taken <=3D s->total.)

> +        s->taken +=3D n;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +void coroutine_fn qemu_co_get_amount(QemuCoSharedAmount *s, uint64_t n=
)
> +{
> +    assert(n < s->total);
> +    while (s->total - n < s->taken) {
> +        qemu_co_queue_wait(&s->queue, NULL);
> +    }
> +
> +    assert(qemu_co_try_get_amount(s, n));

I=E2=80=99d refrain from putting things that should do something in asser=
tions
because assert() is not guaranteed to be compiled.

It is in practice in qemu, but I still don=E2=80=99t like it too much.

Furthermore, it appears to me that the following would be simpler:

while (!qemu_co_try_get_amount(s, n)) {
    qemu_co_queue_wait(&s->queue, NULL);
}

> +}
> +
> +void coroutine_fn qemu_co_put_amount(QemuCoSharedAmount *s, uint64_t n=
)
> +{
> +    assert(n <=3D s->taken);
> +    s->taken -=3D n;
> +    qemu_co_queue_restart_all(&s->queue);

It itches me to ask for a better allocation strategy (like maybe
smallest-allocation-first), but I suppose I should just scratch myself.

Max

> +}
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 41bf59d127..65ae18993a 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -37,6 +37,7 @@ util-obj-y +=3D rcu.o
>  util-obj-$(CONFIG_MEMBARRIER) +=3D sys_membarrier.o
>  util-obj-y +=3D qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-=
io.o
>  util-obj-y +=3D qemu-coroutine-sleep.o
> +util-obj-y +=3D qemu-co-shared-amount.o
>  util-obj-y +=3D coroutine-$(CONFIG_COROUTINE_BACKEND).o
>  util-obj-y +=3D buffer.o
>  util-obj-y +=3D timed-average.o
>=20



--z4REexWBJZNBE49ld8xmSvSWesDvJX9Ad--

--jP2oCD5I9ArhFmWOujHMNAcUbwER51dV7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bWEoACgkQ9AfbAGHV
z0B52Af9Etbbdl7QH6/Iml2q3em9qNgkcItDKpLvFxGMYh97FJfU3EHYiy/Ars3/
syOhPkq8d2ivhXb5kFWOYE1XIAqvv3ryqUxvlokNJRNGgxP+y99Nel8S38Ol2KO8
4az0t2OxvomdZgmgIXlU8FBVHwG91AADKnm8povCOswX2Sp7X/YdNNeVkIEupM2M
3N06i0b8OBwqs2xfOnlqI5E3hNz/NmvOsvKprLTQea8OAEB1EUHMW2z681gnmwBT
nylSG5HBPCLyJnRoIuhcPw2IZFL4Rdst6PUyRs/kJkGdyLjMTSL6ySb3b5vgsmex
WsIB6xwhicbMWgBzJ2bqVPkbjVC5ZQ==
=ajTe
-----END PGP SIGNATURE-----

--jP2oCD5I9ArhFmWOujHMNAcUbwER51dV7--

