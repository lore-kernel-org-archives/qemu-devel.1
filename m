Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF13C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F51720838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F51720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htA5q-0008Ta-JI
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htA5B-0007yA-Pa
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htA59-0001En-Nh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htA53-0000yy-NB; Thu, 01 Aug 2019 08:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55799316D8C7;
 Thu,  1 Aug 2019 12:21:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-187.brq.redhat.com
 [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B88065D9CA;
 Thu,  1 Aug 2019 12:21:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
 <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
 <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
 <29be5652-33d3-216c-a377-ed7d76c23c1b@virtuozzo.com>
 <f83ed7fb-b9cd-4d28-d58e-92357f3acc73@redhat.com>
 <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>
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
Message-ID: <2225a89f-fe7e-e1be-c640-7281e8a20305@redhat.com>
Date: Thu, 1 Aug 2019 14:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bAnvkza8VnRLrTFtOjEyTePHzO6RsEMG2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 12:21:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bAnvkza8VnRLrTFtOjEyTePHzO6RsEMG2
Content-Type: multipart/mixed; boundary="3dXkEfiv6IdlNnYodx18yrkvpaDn45sHk";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <2225a89f-fe7e-e1be-c640-7281e8a20305@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
 <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
 <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
 <29be5652-33d3-216c-a377-ed7d76c23c1b@virtuozzo.com>
 <f83ed7fb-b9cd-4d28-d58e-92357f3acc73@redhat.com>
 <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>
In-Reply-To: <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>

--3dXkEfiv6IdlNnYodx18yrkvpaDn45sHk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.08.19 14:02, Vladimir Sementsov-Ogievskiy wrote:
> 01.08.2019 14:37, Max Reitz wrote:
>> On 01.08.19 13:32, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.08.2019 14:28, Max Reitz wrote:
>>>> On 31.07.19 18:01, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 30.07.2019 21:28, John Snow wrote:
>>>>>>
>>>>>>
>>>>>> On 7/30/19 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> write flags are constant, let's store it in BackupBlockJob instea=
d of
>>>>>>> recalculating. It also makes two boolean fields to be unused, so,=

>>>>>>> drop them.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
>>>>>>> ---
>>>>>>>     block/backup.c | 24 ++++++++++++------------
>>>>>>>     1 file changed, 12 insertions(+), 12 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/backup.c b/block/backup.c
>>>>>>> index c5f941101a..4651649e9d 100644
>>>>>>> --- a/block/backup.c
>>>>>>> +++ b/block/backup.c
>>>>>>> @@ -47,7 +47,6 @@ typedef struct BackupBlockJob {
>>>>>>>         uint64_t len;
>>>>>>>         uint64_t bytes_read;
>>>>>>>         int64_t cluster_size;
>>>>>>> -    bool compress;
>>>>>>>         NotifierWithReturn before_write;
>>>>>>>         QLIST_HEAD(, CowRequest) inflight_reqs;
>>>>>>>    =20
>>>>>>> @@ -55,7 +54,7 @@ typedef struct BackupBlockJob {
>>>>>>>         bool use_copy_range;
>>>>>>>         int64_t copy_range_size;
>>>>>>>    =20
>>>>>>> -    bool serialize_target_writes;
>>>>>>> +    BdrvRequestFlags write_flags;
>>>>>>>     } BackupBlockJob;
>>>>>>>    =20
>>>>>>>     static const BlockJobDriver backup_job_driver;
>>>>>>> @@ -110,10 +109,6 @@ static int coroutine_fn backup_cow_with_boun=
ce_buffer(BackupBlockJob *job,
>>>>>>>         BlockBackend *blk =3D job->common.blk;
>>>>>>>         int nbytes;
>>>>>>>         int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIAL=
ISING : 0;
>>>>>>> -    int write_flags =3D
>>>>>>> -            (job->serialize_target_writes ? BDRV_REQ_SERIALISING=
 : 0) |
>>>>>>> -            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
>>>>>>> -
>>>>>>>    =20
>>>>>>>         assert(QEMU_IS_ALIGNED(start, job->cluster_size));
>>>>>>>         hbitmap_reset(job->copy_bitmap, start, job->cluster_size)=
;
>>>>>>> @@ -132,7 +127,7 @@ static int coroutine_fn backup_cow_with_bounc=
e_buffer(BackupBlockJob *job,
>>>>>>>         }
>>>>>>>    =20
>>>>>>>         ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce=
_buffer,
>>>>>>> -                        write_flags);
>>>>>>> +                        job->write_flags);
>>>>>>>         if (ret < 0) {
>>>>>>>             trace_backup_do_cow_write_fail(job, start, ret);
>>>>>>>             if (error_is_read) {
>>>>>>> @@ -160,7 +155,6 @@ static int coroutine_fn backup_cow_with_offlo=
ad(BackupBlockJob *job,
>>>>>>>         BlockBackend *blk =3D job->common.blk;
>>>>>>>         int nbytes;
>>>>>>>         int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIAL=
ISING : 0;
>>>>>>> -    int write_flags =3D job->serialize_target_writes ? BDRV_REQ_=
SERIALISING : 0;
>>>>>>>    =20
>>>>>>>         assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster=
_size));
>>>>>>>         assert(QEMU_IS_ALIGNED(start, job->cluster_size));
>>>>>>> @@ -168,7 +162,7 @@ static int coroutine_fn backup_cow_with_offlo=
ad(BackupBlockJob *job,
>>>>>>>         nr_clusters =3D DIV_ROUND_UP(nbytes, job->cluster_size);
>>>>>>>         hbitmap_reset(job->copy_bitmap, start, job->cluster_size =
* nr_clusters);
>>>>>>>         ret =3D blk_co_copy_range(blk, start, job->target, start,=
 nbytes,
>>>>>>> -                            read_flags, write_flags);
>>>>>>> +                            read_flags, job->write_flags);
>>>>>>>         if (ret < 0) {
>>>>>>>             trace_backup_do_cow_copy_range_fail(job, start, ret);=

>>>>>>>             hbitmap_set(job->copy_bitmap, start, job->cluster_siz=
e * nr_clusters);
>>>>>>> @@ -638,10 +632,16 @@ BlockJob *backup_job_create(const char *job=
_id, BlockDriverState *bs,
>>>>>>>         job->sync_mode =3D sync_mode;
>>>>>>>         job->sync_bitmap =3D sync_mode =3D=3D MIRROR_SYNC_MODE_IN=
CREMENTAL ?
>>>>>>>                            sync_bitmap : NULL;
>>>>>>> -    job->compress =3D compress;
>>>>>>>    =20
>>>>>>> -    /* Detect image-fleecing (and similar) schemes */
>>>>>>> -    job->serialize_target_writes =3D bdrv_chain_contains(target,=
 bs);
>>>>>>> +    /*
>>>>>>> +     * Set write flags:
>>>>>>> +     *  1. Detect image-fleecing (and similar) schemes
>>>>>>> +     *  2. Handle compression
>>>>>>> +     */
>>>>>>> +    job->write_flags =3D
>>>>>>> +            (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALIS=
ING : 0) |
>>>>>>> +            (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
>>>>>>> +
>>>>>>>         job->cluster_size =3D cluster_size;
>>>>>>>         job->copy_bitmap =3D copy_bitmap;
>>>>>>>         copy_bitmap =3D NULL;
>>>>>>>
>>>>>>
>>>>>> What happens if you did pass BDRV_REQ_WRITE_COMPRESSED to
>>>>>> blk_co_copy_range? Is that rejected somewhere in the stack?
>>>>>
>>>>>
>>>>> Hmm, I'm afraid that it will be silently ignored.
>>>>>
>>>>> And I have one question related to copy offload too.
>>>>>
>>>>> Do we really need to handle max_transfer in backup code for copy of=
fload?
>>>>> Is max_transfer related to it really?
>>>>>
>>>>> Anyway, bl.max_transfer should be handled in generic copy_range cod=
e in block/io.c
>>>>> (if it should at all), I'm going to fix it, but may be, I can just =
drop this limitation
>>>>> from backup?
>>>>
>>>> On a quick glance, it doesn=E2=80=99t look like a limitation to me b=
ut actually
>>>> like the opposite.  backup_cow_with_bounce_buffer() only copies up t=
o
>>>> cluster_size, whereas backup_cow_with_offload() will copy up to the
>>>> maximum transfer size permitted by both source and target for copy
>>>> offloading.
>>>>
>>>
>>> I mean, why not to just copy the whole chunk comes in notifier and do=
n't care about
>>> max_transfer? Backup loop copies cluster by cluster anyway, so only n=
otifier may copy
>>> larger chunk.
>>
>> One thing that comes to mind is the hbitmap_get() check in
>> backup_do_cow().  You don=E2=80=99t want to copy everything just becau=
se the
>> first cluster needs to be copied.
>>
>=20
> Hmm, but seems that we do exactly this, and this is wrong. But this is =
separate thing..

You=E2=80=99re right.  It=E2=80=99s totally broken.  Nice.

The following gets me a nice content mismatch:

$ ./qemu-img create -f qcow2 src.qcow2 2M
$ ./qemu-io -c 'write -P 42 0 2M' src.qcow2
$ cp src.qcow2 ref.qcow2

{"execute":"qmp_capabilities"}
{"return": {}}
{"execute":"blockdev-add","arguments":
 {"node-name":"src","driver":"qcow2",
  "file":{"driver":"file","filename":"src.qcow2"}}}
{"return": {}}
{"execute":"drive-backup","arguments":
 {"device":"src","job-id":"backup","target":"tgt.qcow2",
  "format":"qcow2","sync":"full","speed":1048576}}
{"timestamp": {"seconds": 1564661742, "microseconds": 268384},
 "event": "JOB_STATUS_CHANGE",
  "data": {"status": "created", "id": "backup"}}
{"timestamp": {"seconds": 1564661742, "microseconds": 268436},
 "event": "JOB_STATUS_CHANGE",
  "data": {"status": "running", "id": "backup"}}
{"return": {}}
{"execute":"human-monitor-command",
 "arguments":{"command-line":
              "qemu-io src \"write -P 23 1114112 65536\""}}
{"return": ""}
{"execute":"human-monitor-command",
 "arguments":{"command-line":
              "qemu-io src \"write -P 66 1048576 1M\""}}
{"return": ""}
{"timestamp": {"seconds": 1564661744, "microseconds": 278362}.
 "event": "JOB_STATUS_CHANGE",
 "data": {"status": "waiting", "id": "backup"}}
{"timestamp": {"seconds": 1564661744, "microseconds": 278534},
 "event": "JOB_STATUS_CHANGE",
 "data": {"status": "pending", "id": "backup"}}
{"timestamp": {"seconds": 1564661744, "microseconds": 278778},
 "event": "BLOCK_JOB_COMPLETED",
 "data": {"device": "backup", "len": 2097152, "offset": 2162688,
          "speed": 1048576, "type": "backup"}}
{"execute":"quit"}
{"timestamp": {"seconds": 1564661744, "microseconds": 278884},
 "event": "JOB_STATUS_CHANGE",
 "data": {"status": "concluded", "id": "backup"}}
{"timestamp": {"seconds": 1564661744, "microseconds": 278946},
 "event": "JOB_STATUS_CHANGE",
 "data": {"status": "null", "id": "backup"}}
{"return": {}}

$ ./qemu-img compare src.qcow2
Content mismatch at offset 1114112!


Aww maaan.  Setting copy_range to false =E2=80=9Cfixes=E2=80=9D it.  I gu=
ess this=E2=80=99ll
need to be fixed for 4.1. :-/

> About copy_range, I just don't sure that max_transfer is a true restric=
tion for copy_range.
> For example, for file_posix max_transfer comes from some specific ioctl=
 or from sysfs.. Is
> it appropriate as limitation for copy_file_range?

Who knows, but it=E2=80=99s probably the best approximation we have.

> Also, Max, could you please take a look at "[PATCH v3] blockjob: drain =
all job nodes in block_job_drain"
> thread? Maybe, what John questions is obvious for you.

Perhaps after fixing backup. :-/

Max


--3dXkEfiv6IdlNnYodx18yrkvpaDn45sHk--

--bAnvkza8VnRLrTFtOjEyTePHzO6RsEMG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1C2TIACgkQ9AfbAGHV
z0AdFwf/Xo1J+UFfPkmCynGpISKJC7uXT648wC1gdXnMhiT7p7EgAXX3E1UGrMEY
m38gIuIQzPK58pz1uk3/x234dA6eicHmAa4dy66yPruZPoLeib3fJIXjMlyoVGNH
hpBAaYkrf1Gcm0urGcJfHFK4EMDKI/q9Xh86RiRtk4H6PyDSPDh/bNLMI6h96aka
Xb56xjdNqV9/pNaSzsXuQUQO4TvT7anI0KVTAhicEJ9tSg3QHhYjsGep+y2fzWXa
k7oTwRr8IhwY5cU2LUuSChSIbxVPFjWg0SIjA3CkTEDZvJRz/dld6GwQpkige7EH
fiWz0ELod23BWaPQtYSElR1VFf0AIg==
=k6Q/
-----END PGP SIGNATURE-----

--bAnvkza8VnRLrTFtOjEyTePHzO6RsEMG2--

