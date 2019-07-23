Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1C2C7618E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E94223BE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E94223BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprvE-0008Vv-5w
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hprv1-00082Z-Qb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hprv0-0002cn-Lk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:21:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hprux-0002a2-Su; Tue, 23 Jul 2019 06:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1568307D844;
 Tue, 23 Jul 2019 10:21:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A17D65C230;
 Tue, 23 Jul 2019 10:21:09 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190722133054.21781-1-mreitz@redhat.com>
 <20190722133054.21781-3-mreitz@redhat.com>
 <20190723085236.GA5296@localhost.localdomain>
 <91179292-29aa-4d00-78ac-a8861fd5f308@redhat.com>
 <20190723100243.GA11008@localhost.localdomain>
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
Message-ID: <083850e7-81ab-a9df-9fbd-1bb49adf1712@redhat.com>
Date: Tue, 23 Jul 2019 12:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723100243.GA11008@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UxbUjkn1G74qajStHXwRZ7EoFUlHPNs4Z"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 23 Jul 2019 10:21:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] block: Only the main loop can
 change AioContexts
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UxbUjkn1G74qajStHXwRZ7EoFUlHPNs4Z
Content-Type: multipart/mixed; boundary="6kjBipt3HJh7fvPrKz6hqq9JUU7RPrALJ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <083850e7-81ab-a9df-9fbd-1bb49adf1712@redhat.com>
Subject: Re: [PATCH for-4.1 2/2] block: Only the main loop can change
 AioContexts
References: <20190722133054.21781-1-mreitz@redhat.com>
 <20190722133054.21781-3-mreitz@redhat.com>
 <20190723085236.GA5296@localhost.localdomain>
 <91179292-29aa-4d00-78ac-a8861fd5f308@redhat.com>
 <20190723100243.GA11008@localhost.localdomain>
In-Reply-To: <20190723100243.GA11008@localhost.localdomain>

--6kjBipt3HJh7fvPrKz6hqq9JUU7RPrALJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.07.19 12:02, Kevin Wolf wrote:
> Am 23.07.2019 um 11:41 hat Max Reitz geschrieben:
>> On 23.07.19 10:52, Kevin Wolf wrote:
>>> Am 22.07.2019 um 15:30 hat Max Reitz geschrieben:
>>>> bdrv_set_aio_context_ignore() can only work in the main loop:
>>>> bdrv_drained_begin() only works in the main loop and the node's (old=
)
>>>> AioContext; and bdrv_drained_end() really only works in the main loo=
p
>>>> and the node's (new) AioContext (contrary to its current comment, wh=
ich
>>>> is just wrong).
>>>>
>>>> Consequentially, bdrv_set_aio_context_ignore() must be called from t=
he
>>>> main loop.  Luckily, assuming that we can make block graph changes o=
nly
>>>> from the main loop as well, all its callers do that already.
>>>>
>>>> Note that changing a node's context in a sense is an operation that
>>>> changes the block graph, so it actually makes sense to require this
>>>> function to be called from the main loop.
>>>>
>>>> Also, fix bdrv_drained_end()'s description.  You can only use it fro=
m
>>>> the main loop or the node's AioContext, and in the latter case, the
>>>> whole subtree must be in the same context.
>>>>
>>>> Fixes: e037c09c78520cbdb6da7cfc6ad0256d5870b814
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  include/block/block.h |  8 +++-----
>>>>  block.c               | 13 ++++++++-----
>>>>  2 files changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index 60f00479e0..50a07c1c33 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -667,11 +667,9 @@ void bdrv_subtree_drained_begin(BlockDriverStat=
e *bs);
>>>>   *
>>>>   * This polls @bs's AioContext until all scheduled sub-drained_ends=

>>>>   * have settled.  On one hand, that may result in graph changes.  O=
n
>>>> - * the other, this requires that all involved nodes (@bs and all of=

>>>> - * its parents) are in the same AioContext, and that the caller has=

>>>> - * acquired it.
>>>> - * If there are any nodes that are in different contexts from @bs,
>>>> - * these contexts must not be acquired.
>>>> + * the other, this requires that the caller either runs in the main=

>>>> + * loop; or that all involved nodes (@bs and all of its parents) ar=
e
>>>> + * in the caller's AioContext.
>>>>   */
>>>>  void bdrv_drained_end(BlockDriverState *bs);
>>>
>>> I think you are right about the requirement that bdrv_drained_end() i=
s
>>> only called from the main or the BDS AioContext, which is a requireme=
nt
>>> that directly comes from AIO_WAIT_WHILE().
>>>
>>> However, I don't see why we have requirements on the AioContext of th=
e
>>> parent nodes (or any other nodes), except possibly not holding their
>>> lock.  We don't poll their context, so it shouldn't matter in which
>>> context they are?
>>
>> Hm.  I don=E2=80=99t know how I got confused there, you=E2=80=99re rig=
ht.
>>
>> I don=E2=80=99t think the (falsely given) restriction hurts, though, b=
ecause a
>> subtree should be within a single context anyway (unless you=E2=80=99r=
e in
>> bdrv_set_aio_context_ignore(), which needs to be in the main context).=

>>
>> So, hm, yes, I messed up this comment a bit now.  But now it=E2=80=99s=
 just more
>> restrictive than it needs to be and I don=E2=80=99t think callers are =
going to
>> care, so...
>=20
> Nothing that should hold up your pull request, but I'd prefer to fix th=
e
> comment in a follow-up.

On second thought, does aio_wait_kick() wake up any context but the main
context?  I was under the impression that it doesn=E2=80=99t.  If it does=
n=E2=80=99t, I
don=E2=80=99t know how bdrv_drained_end()=E2=80=99s AIO_WAIT_WHILE() will=
 be woken up if
it doesn=E2=80=99t run in the main context and it has to wait for yet ano=
ther
thread.

Max

> One thing where I could imagine it becoming relevant in the future is
> cross-context block jobs. At the moment, we automatically pull the
> target node into the AioContext of the source and fail if this isn't
> possible, but that's really overly restrictive.
>=20
> Kevin


--6kjBipt3HJh7fvPrKz6hqq9JUU7RPrALJ--

--UxbUjkn1G74qajStHXwRZ7EoFUlHPNs4Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0235MACgkQ9AfbAGHV
z0CEEQgAj4+TCnmc/YPvlkTXoIaqDkqHW0OQS/qOGIg5xJ0vYfzA+TlvVSvoXZe1
NvwVT+mT/yayAI8ZArMLqSDLKBTjvg3wtHYpqI+vu9WXIMtZATEsvDBjqLOmsTjL
9FbbJPk8psbf7S6khtDI93yy3nFpjiVJTc3VOnHs5r0Ax/OwE1ybtDclU/dtDEZ6
KECltbEeuSTOcWuA1WuFExTnK4prSYhWeQsNXzbKkYX0belS2dei6Fept+xUBrU6
NBeOvANDb8yvZEDgwwgTTL2y3VjoZCgjtzzDjv1QZbyx1Mr6BS0wxeZz74CJfsky
iA7/UbuFXvOOtrZg8/mpRGJFHHEtJg==
=03WF
-----END PGP SIGNATURE-----

--UxbUjkn1G74qajStHXwRZ7EoFUlHPNs4Z--

