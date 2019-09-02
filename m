Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84261C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4400B21744
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4400B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4pIQ-0008Sh-BU
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4pHk-0007vr-D5
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4pHi-0005fn-Pb
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4pHe-0005dF-Ta; Mon, 02 Sep 2019 12:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8537C058CB8;
 Mon,  2 Sep 2019 16:34:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F002196B2;
 Mon,  2 Sep 2019 16:34:17 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
 <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
 <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
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
Message-ID: <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
Date: Mon, 2 Sep 2019 18:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p6Y5ZTGTFDd1Cvxp718M5RnOLrWddT4nK"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 02 Sep 2019 16:34:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 13/13] block/backup: use backup-top
 instead of write notifiers
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
--p6Y5ZTGTFDd1Cvxp718M5RnOLrWddT4nK
Content-Type: multipart/mixed; boundary="Ly9tTdGOPkrs7usyAzafBzTbu7gaXkaY7";
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
Message-ID: <d0235117-87f7-2e8d-83e9-4678b5e4f1bb@redhat.com>
Subject: Re: [PATCH v9 13/13] block/backup: use backup-top instead of write
 notifiers
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
 <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
 <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>
In-Reply-To: <0a166308-7492-7489-be60-50e150beebc1@virtuozzo.com>

--Ly9tTdGOPkrs7usyAzafBzTbu7gaXkaY7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.08.19 16:55, Vladimir Sementsov-Ogievskiy wrote:
> 28.08.2019 22:50, Max Reitz wrote:
>> On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
>>> Drop write notifiers and use filter node instead.
>>>
>>> =3D Changes =3D
>>>
>>> 1. add filter-node-name argument for backup qmp api. We have to do it=

>>> in this commit, as 257 needs to be fixed.
>>
>> I feel a bit bad about it not being an implicit node.  But I know you
>> don=E2=80=99t like them, they=E2=80=99re probably just broken altogeth=
er and because
>> libvirt doesn=E2=80=99t use backup (yet), probably nobody cares.
>>
>>> 2. there no move write notifiers here, so is_write_notifier parameter=

>>
>> s/there/there are/, I suppose?
>>
>>> is dropped from block-copy paths.
>>>
>>> 3. Intersecting requests handling changed, now synchronization betwee=
n
>>> backup-top, backup and guest writes are all done in block/block-copy.=
c
>>> and works as follows:
>>>
>>> On copy operation, we work only with dirty areas. If bits are dirty i=
t
>>> means that there are no requests intersecting with this area. We clea=
r
>>> dirty bits and take bdrv range lock (bdrv_co_try_lock) on this area t=
o
>>> prevent further operations from interaction with guest (only with
>>> guest, as neither backup nor backup-top will touch non-dirty area). I=
f
>>> copy-operation failed we set dirty bits back together with releasing
>>> the lock.
>>>
>>> The actual difference with old scheme is that on guest writes we
>>> don't lock the whole region but only dirty-parts, and to be more
>>> precise: only dirty-part we are currently operate on. In old scheme
>>> guest write to non-dirty area (which may be safely ignored by backup)=

>>> may wait for intersecting request, touching some other area which is
>>> dirty.
>>>
>>> 4. To sync with in-flight requests at job finish we now have drained
>>> removing of the filter, we don't need rw-lock.
>>>
>>> =3D Notes =3D
>>>
>>> Note the consequence of three objects appearing: backup-top, backup j=
ob
>>> and block-copy-state:
>>>
>>> 1. We want to insert backup-top before job creation, to behave simila=
r
>>> with mirror and commit, where job is started upon filter.
>>>
>>> 2. We also have to create block-copy-state after filter injection, as=

>>> we don't want it's source child be replaced by fitler. Instead we wan=
t
>>
>> s/it's/its/, s/filter/filter/ (although =E2=80=9Cfitler=E2=80=9D does =
have an amusing
>> ring to it)
>>
>>> to keep BCS.source to be real source node, as we want to use
>>> bdrv_co_try_lock in CBW operations and it can't be used on filter, as=

>>> on filter we already have in-flight (write) request from upper layer.=

>>
>> Reasonable, even more so as I suppose BCS.source should eventually be =
a
>> BdrvChild of backup-top.
>>
>> What looks wrong is that the sync_bitmap is created on the source (=E2=
=80=9Cbs=E2=80=9D
>> in backup_job_create()), but backup_cleanup_sync_bitmap() still assume=
s
>> it is on blk_bs(job->common.blk) (which is no longer true).
>>
>>> So, we firstly create inject backup-top, then create job and BCS. BCS=

>>> is the latest just to not create extra variable for it. Finally we se=
t
>>> bcs for backup-top filter.
>>>
>>> =3D Iotest changes =3D
>>>
>>> 56: op-blocker doesn't shot now, as we set it on source, but then che=
ck
>>
>> s/shot/show/?
>>
>>> on filter, when trying to start second backup, so error caught in
>>> test_dismiss_collision is changed. It's OK anyway, as this test-case
>>> seems to test that after some collision we can dismiss first job and
>>> successfully start the second one. So, the change is that collision i=
s
>>> changed from op-blocker to file-posix locks.
>>
>> Well, but the op blocker belongs to the source, which should be covere=
d
>> by internal permissions.  The fact that it now shows up as a file-posi=
x
>> error thus shows that the conflict also moves from the source to the
>> target.  It=E2=80=99s OK because we actually don=E2=80=99t have a conf=
lict on the source.
>>
>> But I wonder whether it would be better for test_dismiss_collision() t=
o
>> do a blockdev-backup instead where we can see the collision on the tar=
get.
>>
>> Hm.  On second thought, why do we even get a conflict on the target?
>> block-copy does share the WRITE permission for it...
>=20
> Not sure, but assume that this is because in file-posix.c in raw_co_cre=
ate
> we do want RESIZE perm.
>=20
> I can instead move this test to use specified job-id, to move the colli=
sion
> to "job-id already exists" error. Is it better?

It=E2=80=99s probably the only thing that actually makes sense.

> I'm afraid that posix locks will not work if disable them in config.

Yes (or if the environment doesn=E2=80=99t support them); which is why I
suggested using blockdev-backup.  (But that would have the same problem
of =E2=80=9CWhere does the permission conflict even come from and is it
inevitable?=E2=80=9D)

[...]

>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 6828c46ba0..f3102ec3ff 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>> @@ -98,27 +98,32 @@ fail:
>>>    * error occurred, return a negative error number
>>>    */
>>>   static int coroutine_fn block_copy_with_bounce_buffer(
>>> -        BlockCopyState *s, int64_t start, int64_t end, bool is_write=
_notifier,
>>> +        BlockCopyState *s, int64_t start, int64_t end,
>>>           bool *error_is_read, void **bounce_buffer)
>>>   {
>>>       int ret;
>>> -    int nbytes;
>>> -    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING :=
 0;
>>> +    int nbytes =3D MIN(s->cluster_size, s->len - start);
>>> +    void *lock =3D bdrv_co_try_lock(blk_bs(s->source), start, nbytes=
);
>>> +
>>> +    /*
>>> +     * Function must be called only on full-dirty region, so nobody =
touching or
>>> +     * touched these bytes. Therefore, we must successfully get lock=
=2E
>>
>> Which is OK because backup-top does not share the WRITE permission.  B=
ut
>> it is organized a bit weirdly, because it=E2=80=99s actually block-cop=
y here
>> that relies on the WRITE permission not to be shared; which it itself
>> cannot do because backup-top needs it.
>>
>> This of course results from the fact that backup-top and block-copy
>> should really use the same object to access the source, namely the
>> backing BdrvChild of backup-top.
>>
>> Maybe there should be a comment somewhere that points this out?
>=20
> But I wanted block-copy not to be directly connected to backup-top.

But it doesn=E2=80=99t really work.  There=E2=80=99s an obscure contract =
that already
binds block-copy to backup-top.

> I think actually we rely on the fact that user of block-copy() guarante=
es that
> nobody is touching dirty areas (except block_copy). And with backup, th=
is is done by
> backup-top filter. I'll add a comment on this.

Yes, that=E2=80=99s the contract.  And it=E2=80=99s weird, because block-=
copy has its
own BB, so if it doesn=E2=80=99t want anyone to write to the source outsi=
de of
its control, it should just unshare the WRITE permission =E2=80=93 but it=
 cannot
do that, because its user needs WRITE access, and so it implicitly
relies on that user to then unshare WRITE.

If both used the same single BdrvChild, it would be clear

(1) why the BdrvChild belongs to block-copy=E2=80=99s user (because block=
-copy=E2=80=99s
user would need to own a node that then has this BdrvChild),

(2) why block-copy does not unshare the WRITE permission (it cannot,
because it doesn=E2=80=99t create the BdrvChild),

(3) how block-copy could explicitly ensure that WRITE is unshared (by
asserting !(child->shared_perm & WRITE)).


I=E2=80=99m not saying that we need to abandon having BBs right now, but =
I think
there are a couple of cases which show why I say it=E2=80=99s uglier than=
 using
BdrvChildren instead.

Max


--Ly9tTdGOPkrs7usyAzafBzTbu7gaXkaY7--

--p6Y5ZTGTFDd1Cvxp718M5RnOLrWddT4nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tRIcACgkQ9AfbAGHV
z0BpsQf/T2Mwb9BikhpwPOP6SHvGKLwCezbzFMxvndGGC4+saZgFrDN96IVN04dp
cFndgc6rQxCoBEoUyX+Z3EaZfi8lsrML6y9zKiyu9+YWQHHMmJ1b3LLe4q2OGjqO
PCHeizySt8xsPu8uikxB74nqUx3MkgKBCfmS22Ifz8Bl8nCuZmcGdS7RG99pkbwr
0gYZP8UMiR0PYwnMj0y8S/SVg6o/OR9DfZVFTgrMB5NJu6unNERor9saHrmomyWT
NuCHQY6MnguuKCMo2SDBz0RvbZbP06ku5YLceKGgFJ0tbt5rkajCPL3gCZGEXsMc
oU53WQCb6A0q9JoJVc5czvQNexE6lQ==
=sG1M
-----END PGP SIGNATURE-----

--p6Y5ZTGTFDd1Cvxp718M5RnOLrWddT4nK--

