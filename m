Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D288CC742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltzA-0004xj-1M
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hltyy-0004Wz-Gd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hltyw-0003Su-PL
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hltyr-0003QJ-Av; Fri, 12 Jul 2019 07:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9241AC057F3D;
 Fri, 12 Jul 2019 11:44:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21B7019C4F;
 Fri, 12 Jul 2019 11:44:45 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
 <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
 <20190712110110.GE4514@dhcp-200-226.str.redhat.com>
 <cd184838-6c1f-0d22-1d89-415dbd62955b@redhat.com>
 <20190712112318.GG4514@dhcp-200-226.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <a05bce45-d7f7-99c4-8126-e326a5f21340@redhat.com>
Date: Fri, 12 Jul 2019 13:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712112318.GG4514@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4tonmWEKxKw6zZSz3VxiNsqVvDakQyhwo"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 12 Jul 2019 11:44:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4tonmWEKxKw6zZSz3VxiNsqVvDakQyhwo
Content-Type: multipart/mixed; boundary="un0FrP8mtxWu6hE2SDycYdtYnuH07HJ8M";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a05bce45-d7f7-99c4-8126-e326a5f21340@redhat.com>
Subject: Re: [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
 <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
 <20190712110110.GE4514@dhcp-200-226.str.redhat.com>
 <cd184838-6c1f-0d22-1d89-415dbd62955b@redhat.com>
 <20190712112318.GG4514@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190712112318.GG4514@dhcp-200-226.str.redhat.com>

--un0FrP8mtxWu6hE2SDycYdtYnuH07HJ8M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.07.19 13:23, Kevin Wolf wrote:
> Am 12.07.2019 um 13:09 hat Max Reitz geschrieben:
>> On 12.07.19 13:01, Kevin Wolf wrote:
>>> Am 12.07.2019 um 12:47 hat Max Reitz geschrieben:
>>>> On 12.07.19 11:24, Kevin Wolf wrote:
>>>>> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
>>>>>> When nbd_close() is called from a coroutine, the connection_co nev=
er
>>>>>> gets to run, and thus nbd_teardown_connection() hangs.
>>>>>>
>>>>>> This is because aio_co_enter() only puts the connection_co into th=
e main
>>>>>> coroutine's wake-up queue, so this main coroutine needs to yield a=
nd
>>>>>> reschedule itself to let the connection_co run.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>  block/nbd.c | 12 +++++++++++-
>>>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/block/nbd.c b/block/nbd.c
>>>>>> index 81edabbf35..b83b6cd43e 100644
>>>>>> --- a/block/nbd.c
>>>>>> +++ b/block/nbd.c
>>>>>> @@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriv=
erState *bs)
>>>>>>      qio_channel_shutdown(s->ioc,
>>>>>>                           QIO_CHANNEL_SHUTDOWN_BOTH,
>>>>>>                           NULL);
>>>>>> -    BDRV_POLL_WHILE(bs, s->connection_co);
>>>>>> +
>>>>>> +    if (qemu_in_coroutine()) {
>>>>>> +        /* Let our caller poll and just yield until connection_co=
 is done */
>>>>>> +        while (s->connection_co) {
>>>>>> +            aio_co_schedule(qemu_get_current_aio_context(),
>>>>>> +                            qemu_coroutine_self());
>>>>>> +            qemu_coroutine_yield();
>>>>>> +        }
>>>>>
>>>>> Isn't this busy waiting? Why not let s->connection_co wake us up wh=
en
>>>>> it's about to terminate instead of immediately rescheduling ourselv=
es?
>>>>
>>>> Yes, it is busy waiting, but I didn=E2=80=99t find that bad.  The co=
nnection_co
>>>> will be invoked in basically every iteration, and once there is no
>>>> pending data, it will quit.
>>>>
>>>> The answer to =E2=80=9Cwhy not...=E2=80=9D of course is because it=E2=
=80=99d be more complicated.
>>>>
>>>> But anyway.
>>>>
>>>> Adding a new function qemu_coroutine_run_after(target) that adds
>>>> qemu_coroutine_self() to the given @target coroutine=E2=80=99s wake-=
up queue and
>>>> then using that instead of scheduling works, too, yes.
>>>>
>>>> I don=E2=80=99t really like being responsible for coroutine code, th=
ough...
>>>>
>>>> (And maybe it=E2=80=99d be better to make it qemu_coroutine_yield_fo=
r(target),
>>>> which does the above and then yields?)
>>>
>>> Or just do something like this, which is arguably not only a fix for =
the
>>> busy wait, but also a code simplification:
>>
>> 1. Is that guaranteed to work?  What if data sneaks in, the
>> connection_co handles that, and doesn=E2=80=99t wake up the teardown_c=
o?  Will
>> it be re-scheduled?
>=20
> Then connection_co is buggy because we clearly requested that it
> terminate.

Did we?  This would be done by setting s->quit to true, which isn=E2=80=99=
t
explicitly done here.

I thought it worked by just waking up the coroutine until it doesn=E2=80=99=
t
receive anything anymore, because the connection is closed.  Now I don=E2=
=80=99t
know whether QIO_CHANNEL_SHUTDOWN_BOTH discards data that has been
received before the channel is closed.  I don=E2=80=99t expect it to.

>            It is possible that it does so only after handling another
> request, but this wouldn't be a problem. teardown_co would then just
> sleep for a few cycles more until connection_co is done and reaches the=

> aio_co_wake() call.

I don=E2=80=99t quite understand, because the fact how connection_co woul=
d
proceed after handling another request was exactly my question.  If it
were to yield and not to wake up, it would never be done.

But I=E2=80=99ve followed nbd_receive_reply() now, and I suppose nbd_read=
_eof()
will simply never yield after we have invoked qio_channel_shutdown().

>> 2. I precisely didn=E2=80=99t want to do this because we have this fun=
ctionality
>> already in the form of Coroutine.co_queue_wakeup.  Why duplicate it he=
re?
>=20
> co_queue_wakeup contains coroutines to be run at the next yield point
> (or termination), which may be when connection_co is actually done, but=

> it might also be earlier.

Yes, if it handles another request, that would be the yield point at the
end of its main loop.

But that would be solved by simply putting the yield_for() in a loop,
like the one that already exists for the non-coroutine case with
BDRV_POLL_WHILE().

>                           My explicit aio_co_wake() at the end of
> connection_co is guaranteed to run only when connection_co is done.

I can=E2=80=99t explain it, it feels off to me to add this field to BDRVN=
BDState
and let connection_co handle it just for this special case.  It seems to
me that if we had a yield_for() function, we could simply use it instead
-- and I=E2=80=99d prefer a generic function over a special-case implemen=
tation.

I do understand that =E2=80=9Cit feels off=E2=80=9D is not a reasonable j=
ustification
for doing anything.

Max


--un0FrP8mtxWu6hE2SDycYdtYnuH07HJ8M--

--4tonmWEKxKw6zZSz3VxiNsqVvDakQyhwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0ocqsACgkQ9AfbAGHV
z0CtBAf/TrDi5m0z/C/5HnXyzHJZs7RFJuIPyhfJOBA8Hu31xUR2r4M9VP4XaZlV
bwnKjBOFQWTkF2cTP3mfex4mlqkH8KzQAXawOIung2/ps81dQAhL1ZRZXf1bcM/q
tg5loxsYlm34VVmlwbQSQT0wF5ZYYHzUMFgRK9VDfY4t+SvaNrkJIj4jDzSn8Vyb
mcMb/+3oZVcOy2dpJy6AWiiBxCKf8RGnLg/uRGyNCPrI2UbkWeXRmbYddafV9Sg9
q3YC+k9+ak7uZyDwBsIXxECarLuxImZQk2rIfm3wyq7SVh2BfvfNcABrgcCF4qVr
CZC83Q7x+bWxkKyNnIbp2vBPJLvLvA==
=q8Fj
-----END PGP SIGNATURE-----

--4tonmWEKxKw6zZSz3VxiNsqVvDakQyhwo--

