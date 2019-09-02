Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC253C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2AB2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2AB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4ouR-0000Fw-Qs
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 12:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4ota-0007ti-3L
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4otY-0005uG-QO
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4otU-0005q5-3B; Mon, 02 Sep 2019 12:09:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C175308FE8F;
 Mon,  2 Sep 2019 16:09:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71102196B2;
 Mon,  2 Sep 2019 16:09:18 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-4-vsementsov@virtuozzo.com>
 <9afc83df-5b6e-cf5c-91e4-19ab6c9eb137@redhat.com>
 <70de7df0-cbd6-ef3b-d03d-45c4d95a57dd@virtuozzo.com>
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
Message-ID: <7f124d98-b90f-1d89-15fc-43bbb806f83f@redhat.com>
Date: Mon, 2 Sep 2019 18:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70de7df0-cbd6-ef3b-d03d-45c4d95a57dd@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cosnjlh5QBTKkqfLGjzxPj7FiBFhBR4vN"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 02 Sep 2019 16:09:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/backup: introduce
 BlockCopyState
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cosnjlh5QBTKkqfLGjzxPj7FiBFhBR4vN
Content-Type: multipart/mixed; boundary="eLqaoVj9DEMBpU0HgbfofeOLTuE0796Cv";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <7f124d98-b90f-1d89-15fc-43bbb806f83f@redhat.com>
Subject: Re: [PATCH v9 03/13] block/backup: introduce BlockCopyState
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-4-vsementsov@virtuozzo.com>
 <9afc83df-5b6e-cf5c-91e4-19ab6c9eb137@redhat.com>
 <70de7df0-cbd6-ef3b-d03d-45c4d95a57dd@virtuozzo.com>
In-Reply-To: <70de7df0-cbd6-ef3b-d03d-45c4d95a57dd@virtuozzo.com>

--eLqaoVj9DEMBpU0HgbfofeOLTuE0796Cv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.08.19 12:52, Vladimir Sementsov-Ogievskiy wrote:
> Thanks for reviewing!
>=20
> 28.08.2019 18:59, Max Reitz wrote:
>> On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
>>> Split copying code part from backup to "block-copy", including separa=
te
>>> state structure and function renaming. This is needed to share it wit=
h
>>> backup-top filter driver in further commits.
>>>
>>> Notes:
>>>
>>> 1. As BlockCopyState keeps own BlockBackend objects, remaining
>>
>> I suppose these should be BdrvChild objects at some point, but doing i=
t
>> now would just mean effectively duplicating code from block-backend.c.=

>> (=E2=80=9Cnow=E2=80=9D =3D before we have a backup-top filter to attac=
h the children to.)
>=20
> How much is it bad to not do it, but leave them to be block-backends in=
 block-copy
> state? They'll connected anyway through the job, as they all are in job=
=2Enodes.
>=20
> We have block-backends in jobs currently, is it bad?

Yes.  First of all, it=E2=80=99s simply not how it should be.  It=E2=80=99=
s ugly.

Second, it does produce tangible problems.  One thing that comes to mind
is that we only need BB.disable_request_queuing because these
BlockBackends do not have a clear connection to the block job, which
means that the job may want to perform requests on drained BBs.

If source and target were children of the filter node, draining them
would first drain the job, and only then would they be marked as
quiesced, thus solving the problem (as far as I remember).

>>> job->common.blk users only use it to get bs by blk_bs() call, so clea=
r
>>> job->commen.blk permissions set in block_job_create.
>>>
>>> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit bett=
er
>>> as interface to BlockCopyState
>>>
>>> 3. Split is not very clean: there left some duplicated fields, backup=

>>
>> Are there any but cluster_size and len (and source, in a sense)?
>=20
> Seems no more

Good, I was just asking because duplicated fields may be difficult to
keep in sync and so on.

[...]

>>> @@ -99,9 +118,83 @@ static void cow_request_end(CowRequest *req)
>>>       qemu_co_queue_restart_all(&req->wait_queue);
>>>   }
>>>  =20
>>> +static void block_copy_state_free(BlockCopyState *s)
>>> +{
>>> +    if (!s) {
>>> +        return;
>>> +    }
>>> +
>>> +    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
>>> +    blk_unref(s->source);
>>> +    s->source =3D NULL;
>>> +    blk_unref(s->target);
>>> +    s->target =3D NULL;
>>
>> I=E2=80=99m not quite sure why you NULL these pointers when you free t=
he whole
>> object next anyway.
>=20
> it is for backup_drain, I'm afraid of some yield during blk_unref (and =
seems it's unsafe
> anyway, as I zero reference after calling blk_unref). Anyway,
> backup_drain will be dropped in "[PATCH v3] job: drop job_drain", I'll =
drop
> "=3D NULL" here now and workaround backup_drain in backup_clean with co=
rresponding
> comment.

OK.

[...]

>>> +
>>> +    blk_set_disable_request_queuing(s->source, true);
>>> +    blk_set_allow_aio_context_change(s->source, true);
>>> +    blk_set_disable_request_queuing(s->target, true);
>>> +    blk_set_allow_aio_context_change(s->target, true);
>>
>> Hm.  Doesn=E2=80=99t creating new BBs here mean that we have to deal w=
ith the
>> fallout of changing the AioContext on either of them somewhere?
>=20
> In backup context, backup job is responsible for keeping source and tar=
get bs
> in same context, so I think allowing blk to change aio context and asse=
rt in
> block_copy() that context is the same should be enough for now.

Hm, OK, and the backup job takes care of that through
child_job_set_aio_ctx() in blockjob.c.

But it should still be noted that on master, if you try to move e.g. the
source to a new context (by attaching a device to it), this happens:

qemu-system-x86_64: Cannot change iothread of active block backend

This comes from blk_root_can_set_aio_ctx(); but at the same time, it
will happily allow the context change if blk->allow_aio_context_change
is set =E2=80=93 which is precisely what you do here.

So with this patch, the change is allowed; but the target is moved to
the new context, too.

So it should be noted that this is a change in behavior.  (Well, at
least I wanted to note it here.)

> I'll add a comment on this here.

By the way, this is another problem that we wouldn=E2=80=99t have if sour=
ce and
target were BdrvChildren of backup-top.

(The problem being that the BBs=E2=80=99 contexts are kept in sync indire=
ctly
through the node list attached to the job.)

Max


--eLqaoVj9DEMBpU0HgbfofeOLTuE0796Cv--

--Cosnjlh5QBTKkqfLGjzxPj7FiBFhBR4vN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tPqwACgkQ9AfbAGHV
z0Bjuwf/dmlHSQkrNWFuTNxDs9O7V9Iza/sUYgKwYRygnPzNpFRdi58sWGukGthU
PDQfq33G8yEP6WvdpsqxgpT/JM2cy/F1TRR1qsQ81oLYJoRw/HmrqA4Ou8tvSDK1
LcKe9ekAuR0Cs89DqyqDURH8tgtbxt9nAWJd0qYsnROFPaj5zF5vRYftYBJZdy/2
moeii/8tJp/0waN1vItNx9/1IJLh5auoLJk9SB0HAdBairVaveHAiKAoFJKJaVtJ
q9j0WeYeP7x9thvk5Iym5xzzSOOd6L/kBevCgBgAAQW4kWPv9JisX8aoxg9g8K4+
oVRaWVvx/Pwv97EfWccS6HjCv+TDkQ==
=1xnm
-----END PGP SIGNATURE-----

--Cosnjlh5QBTKkqfLGjzxPj7FiBFhBR4vN--

