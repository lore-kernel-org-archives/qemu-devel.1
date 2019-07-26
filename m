Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4DEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8120222ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8120222ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzR2-0001wG-RH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqzQp-0001Ob-DO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqzQn-00058C-VK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:34:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqzQk-0004TN-Qd; Fri, 26 Jul 2019 08:34:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D0DE307D98A;
 Fri, 26 Jul 2019 12:34:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 787B960C18;
 Fri, 26 Jul 2019 12:34:35 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-5-kwolf@redhat.com>
 <6c00ea43-5b9f-5fb7-3e52-86bcf3933668@redhat.com>
 <20190726114930.GD6295@localhost.localdomain>
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
Message-ID: <3443822d-46f4-546f-65ba-70182425478e@redhat.com>
Date: Fri, 26 Jul 2019 14:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726114930.GD6295@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Md16mvzyZZlsd0wcJQM1wf9tMbN4XYXzL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 26 Jul 2019 12:34:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] block-backend: Queue requests while
 drained
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Md16mvzyZZlsd0wcJQM1wf9tMbN4XYXzL
Content-Type: multipart/mixed; boundary="G9b2jmdQC3bjRu98o1B8dXBEJgOtaEn4m";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, dplotnikov@virtuozzo.com,
 vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org
Message-ID: <3443822d-46f4-546f-65ba-70182425478e@redhat.com>
Subject: Re: [PATCH 4/4] block-backend: Queue requests while drained
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-5-kwolf@redhat.com>
 <6c00ea43-5b9f-5fb7-3e52-86bcf3933668@redhat.com>
 <20190726114930.GD6295@localhost.localdomain>
In-Reply-To: <20190726114930.GD6295@localhost.localdomain>

--G9b2jmdQC3bjRu98o1B8dXBEJgOtaEn4m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.19 13:49, Kevin Wolf wrote:
> Am 26.07.2019 um 12:50 hat Max Reitz geschrieben:
>> On 25.07.19 18:27, Kevin Wolf wrote:
>>> This fixes device like IDE that can still start new requests from I/O=

>>
>> *devices
>>
>>> handlers in the CPU thread while the block backend is drained.
>>>
>>> The basic assumption is that in a drain section, no new requests shou=
ld
>>> be allowed through a BlockBackend (blk_drained_begin/end don't exist,=

>>> we get drain sections only on the node level). However, there are two=

>>> special cases where requests should not be queued:
>>>
>>> 1. Block jobs: We already make sure that block jobs are paused in a
>>>    drain section, so they won't start new requests. However, if the
>>>    drain_begin is called on the job's BlockBackend first, it can happ=
en
>>>    that we deadlock because the job stays busy until it reaches a pau=
se
>>>    point - which it can't if it's requests aren't processed any more.=

>>>
>>>    The proper solution here would be to make all requests through the=

>>>    job's filter node instead of using a BlockBackend. For now, just
>>>    disabling request queuin on the job BlockBackend is simpler.
>>
>> Yep, seems reasonable.
>>
>> (We=E2=80=99d need a relationship that a BB is owned by some job, and =
then pause
>> the job when the BB is drained, I suppose.  But that=E2=80=99s exactly=

>> accomplished by not making the job use a BB, but its BdrvChild
>> references instead.)
>=20
> We actually had this before commit ad90feba, when we changed it to use
> the job's BdrvChild objects instead. All block jobs have both currently=
,
> they just don't use their BdrvChild objects much.
>=20
>>> 2. In test cases where making requests through bdrv_* would be
>>>    cumbersome because we'd need a BdrvChild. As we already got the
>>>    functionality to disable request queuing from 1., use it in tests,=

>>>    too, for convenience.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/sysemu/block-backend.h | 11 +++---
>>>  block/backup.c                 |  1 +
>>>  block/block-backend.c          | 69 +++++++++++++++++++++++++++++---=
--
>>>  block/commit.c                 |  2 +
>>>  block/mirror.c                 |  6 ++-
>>>  blockjob.c                     |  3 ++
>>>  tests/test-bdrv-drain.c        |  1 +
>>>  7 files changed, 76 insertions(+), 17 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/block-backend.c b/block/block-backend.c
>>> index fdd6b01ecf..603b281743 100644
>>> --- a/block/block-backend.c
>>> +++ b/block/block-backend.c
>>
>> [...]
>>
>>> @@ -1127,13 +1136,26 @@ static int blk_check_byte_request(BlockBacken=
d *blk, int64_t offset,
>>>      return 0;
>>>  }
>>> =20
>>> +static void blk_wait_while_drained(BlockBackend *blk)
>>
>> +coroutine_fn?  (Maybe even blk_co_wait...)
>>
>>> +{
>>> +    if (blk->quiesce_counter && !blk->disable_request_queuing) {
>>> +        qemu_co_queue_wait(&blk->queued_requests, NULL);
>>> +    }
>>> +}
>>> +
>>>  int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
>>>                                 unsigned int bytes, QEMUIOVector *qio=
v,
>>> -                               BdrvRequestFlags flags)
>>> +                               BdrvRequestFlags flags, bool wait_whi=
le_drained)
>>
>> What=E2=80=99s the purpose of this parameter?  How would it hurt to al=
ways
>> wait_while_drained?
>>
>> I see the following callers of blk_co_p{read,write}v() that call it wi=
th
>> wait_while_drained=3Dfalse:
>>
>> 1. blk_aio_{read,write}_entry(): They wait themselves, so they don=E2=80=
=99t
>>    need these functions to wait.  But OTOH, because they have waited, =
we
>>    know that the BB is not quiesced here, so we won=E2=80=99t wait her=
e anyway.
>>    (These functions should be coroutine_fn, too, by the way)
>=20
> I think I was worried that the coroutine might yield between the two
> places. Later I noticed that blk_wait_while_drained() must be the very
> first thing anyway, so maybe it doesn't matter any more now.
>=20
> If we did yield here for requests coming from blk_aio_prwv(), in_flight=

> would be increased and drain would deadlock.
>=20
> Would you prefer if I just unconditionally wait if we're drained?

I think I would, yes.

>> 2. mirror: It disables request queuing anyway, so wait_while_drained
>>    doesn=E2=80=99t have any effect.
>=20
> Yes, I wasn't sure what to use there. false seemed like it would be
> less likely to cause misunderstandings because it just repeats what
> would happen anyway.
>=20
>>>  {
>>>      int ret;
>>> -    BlockDriverState *bs =3D blk_bs(blk);
>>> +    BlockDriverState *bs;
>>> =20
>>> +    if (wait_while_drained) {
>>> +        blk_wait_while_drained(blk);
>>> +    }
>>
>> [...]
>>
>> What about blk_co_flush()?  Should that wait, too?
>=20
> Hm, probably, yes.
>=20
>>> @@ -2232,6 +2278,9 @@ static void blk_root_drained_end(BdrvChild *chi=
ld, int *drained_end_counter)
>>>          if (blk->dev_ops && blk->dev_ops->drained_end) {
>>>              blk->dev_ops->drained_end(blk->dev_opaque);
>>>          }
>>> +        while (qemu_co_enter_next(&blk->queued_requests, NULL)) {
>>> +            /* Resume all queued requests */
>>> +        }
>>
>> Wouldn=E2=80=99t qemu_co_queue_restart_all(&blk->queued_requests) achi=
eve the same?
>=20
> It would fail an assertion because we're not in coroutine context.
> (Guess what my first attempt was!)

:-)

Max


--G9b2jmdQC3bjRu98o1B8dXBEJgOtaEn4m--

--Md16mvzyZZlsd0wcJQM1wf9tMbN4XYXzL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0681kACgkQ9AfbAGHV
z0DLvQf9H8c696y3BoCSjyW34N6rYNUxxuCSdAx10XmbtuL/fZDXG0qQDQAqs42f
B9TmU1vIHaz4yQWc8ChkMLkuAvnF/YQb3etBzAYPvTSf1xjjqCcRpDI81kbQeXj1
+vjwVreOMiMH92lakvDNC2ceXlUmUtjZYZWJzJjDLIjE2yh46gqDfXdlPrdtHXaf
7zMXIvBKSboPUsiAaL6xZmq18JrzMhu3d343HEQKbYH1UmmEELIuBTjpCdByvGNO
ZF6g4RPbzEU6OjPNSTExFSzXoZGFlFyC7nvESr0P4GeM6nvWc47pIIw+o/gDj4Ae
ZbiDD3ZDSdRVLtonUPwncOm9TIPx+g==
=6QOW
-----END PGP SIGNATURE-----

--Md16mvzyZZlsd0wcJQM1wf9tMbN4XYXzL--

