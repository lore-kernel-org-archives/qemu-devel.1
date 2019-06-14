Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD83208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD83208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbloM-0001dd-NT
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hblmU-00015p-Jq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hblmT-0004mg-13
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:58:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hblmP-00049a-FW; Fri, 14 Jun 2019 08:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4F0B30821C1;
 Fri, 14 Jun 2019 12:57:47 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C1FA61987;
 Fri, 14 Jun 2019 12:57:41 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
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
Message-ID: <825995ac-488e-b25c-c551-526812046caf@redhat.com>
Date: Fri, 14 Jun 2019 14:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p0TFcz2mcVlkoux3LS1TDmeVAp0agcS2M"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 14 Jun 2019 12:57:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
 Denis Lunev <den@virtuozzo.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p0TFcz2mcVlkoux3LS1TDmeVAp0agcS2M
Content-Type: multipart/mixed; boundary="6YzhKQ7eOx4uiWbZkf7TjvS5GaFK5npwn";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>
Message-ID: <825995ac-488e-b25c-c551-526812046caf@redhat.com>
Subject: Re: [PATCH v8 4/7] block: introduce backup-top filter driver
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
In-Reply-To: <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>

--6YzhKQ7eOx4uiWbZkf7TjvS5GaFK5npwn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 11:04, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 18:57, Max Reitz wrote:
>> On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
>>> Backup-top filter does copy-before-write operation. It should be
>>> inserted above active disk and has a target node for CBW, like the
>>> following:
>>>
>>>      +-------+
>>>      | Guest |
>>>      +-------+
>>>          |r,w
>>>          v
>>>      +------------+  target   +---------------+
>>>      | backup_top |---------->| target(qcow2) |
>>>      +------------+   CBW     +---------------+
>>>          |
>>> backing |r,w
>>>          v
>>>      +-------------+
>>>      | Active disk |
>>>      +-------------+
>>>
>>> The driver will be used in backup instead of write-notifiers.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup-top.h  |  64 +++++++++
>>>   block/backup-top.c  | 322 +++++++++++++++++++++++++++++++++++++++++=
+++
>>>   block/Makefile.objs |   2 +
>>>   3 files changed, 388 insertions(+)
>>>   create mode 100644 block/backup-top.h
>>>   create mode 100644 block/backup-top.c
>>>
>>> diff --git a/block/backup-top.h b/block/backup-top.h
>>> new file mode 100644
>>> index 0000000000..788e18c358
>>> --- /dev/null
>>> +++ b/block/backup-top.h

[...]

>>> +/*
>>> + * bdrv_backup_top_append
>>> + *
>>> + * Append backup_top filter node above @source node. @target node wi=
ll receive
>>> + * the data backed up during CBE operations. New filter together wit=
h @target
>>> + * node are attached to @source aio context.
>>> + *
>>> + * The resulting filter node is implicit.
>>
>> Why?  It=E2=80=99s just as easy for the caller to just make it implici=
t if it
>> should be.  (And usually the caller should decide that.)
>=20
> Personally, I don't know what are the reasons for filters to bi implici=
t or not,
> I just made it like other job-filters.. I can move making-implicit to t=
he caller
> or drop it at all (if it will work).

Nodes are implicit if they haven=E2=80=99t been added consciously by the =
user.
A node added by a block job can be non-implicit, too, as mirror shows;
If the user specifies the filter-node-name option, they will know about
the node, thus it is no longer implicit.

If the user doesn=E2=80=99t know about the node (they didn=E2=80=99t give=
 the
filter-node-name option), the node is implicit.

[...]

>>> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
>>> +{
>>> +    if (!bs->backing) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    return bdrv_co_flush(bs->backing->bs);
>>
>> Should we flush the target, too?
>=20
> Hm, you've asked it already, on previous version :)

I wasn=E2=80=99t sure...

> Backup don't do it,
> so I just keep old behavior. And what is the reason to flush backup tar=
get
> on any guest flush?

Hm, well, what=E2=80=99s the reason not to do it?
Also, there are not only guest flushes.  bdrv_flush_all() exists, which
is called when the guest is stopped.  So who is going to flush the
target if not its parent?

[...]

>>> +
>>> +    if (role =3D=3D &child_file) {
>>> +        /*
>>> +         * Target child
>>> +         *
>>> +         * Share write to target (child_file), to not interfere
>>> +         * with guest writes to its disk which may be in target back=
ing chain.
>>> +         */
>>> +        if (perm & BLK_PERM_WRITE) {
>>> +            *nshared =3D *nshared | BLK_PERM_WRITE;
>>
>> Why not always share WRITE on the target?
>=20
> Hmm, it's a bad thing to share writes on target, so I'm trying to reduc=
e number of
> cases when we have share it.

Is it?  First of all, this filter doesn=E2=80=99t care.  It doesn=E2=80=99=
t even read
from the target (related note: we probably don=E2=80=99t need CONSISTENT_=
READ on
the target).

Second, there is generally going to be a parent on backup-top that has
the WRITE permission taken.  So this does not really effectively reduce
that number of cases.

>>> +        }
>>> +    } else {
>>> +        /* Source child */
>>> +        if (perm & BLK_PERM_WRITE) {
>>
>> Or WRITE_UNCHANGED, no?
>=20
> Why? We don't need doing CBW for unchanged write.

But we will do it still, won=E2=80=99t we?

(If an unchanging write comes in, this driver will handle it just like a
normal write, will it not?)

[...]

>>> +
>>> +BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>>> +                                         BlockDriverState *target,
>>> +                                         HBitmap *copy_bitmap,
>>> +                                         Error **errp)
>>> +{

[...]

>>> +}
>>
>> I guess it would be nice if it users could blockdev-add a backup-top
>> node to basically get a backup with sync=3Dnone.
>>
>> (The bdrv_open implementation should then create a new bitmap and
>> initialize it to be fully set.)
>>
>> But maybe it wouldn=E2=80=99t be so nice and I just have feverish drea=
ms.
>=20
> When series begun, I was trying to make exactly this - user-available f=
ilter,
> which may be used in separate, but you was against)

Past me is stupid.

> Maybe, not totally against, but I decided not to argue long, and instea=
d make
> filter implicit and drop public api (like mirror and commit filters), b=
ut place it
> in a separate file (no one will argue against putting large enough and =
complete
> new feature, represented by object into a separate file :). And this ac=
tually
> makes it easy to publish this filter at some moment. And now I think it=
 was
> good decision anyway, as we postponed arguing around API and around sha=
red dirty
> bitmaps.
>=20
> So publishing the filter is future step.

OK, sure.

>>> +void bdrv_backup_top_set_progress_callback(
>>> +        BlockDriverState *bs, BackupTopProgressCallback progress_cb,=

>>> +        void *progress_opaque)
>>> +{
>>> +    BDRVBackupTopState *s =3D bs->opaque;
>>> +
>>> +    s->progress_cb =3D progress_cb;
>>> +    s->progress_opaque =3D progress_opaque;
>>> +}
>>> +
>>> +void bdrv_backup_top_drop(BlockDriverState *bs)
>>> +{
>>> +    BDRVBackupTopState *s =3D bs->opaque;
>>> +    AioContext *aio_context =3D bdrv_get_aio_context(bs);
>>> +
>>> +    aio_context_acquire(aio_context);
>>> +
>>> +    bdrv_drained_begin(bs);
>>> +
>>> +    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abo=
rt);
>>
>> Pre-existing in other jobs, but I think calling this function is
>> dangerous.  (Which is why I remove it in my =E2=80=9Cblock: Ignore loo=
sening
>> perm restrictions failures=E2=80=9D series.)
>=20
> Hmm, good thing.. Should I rebase on it?

It would help me at least.

>>> +    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
>>> +    bdrv_set_backing_hd(bs, NULL, &error_abort);
>>
>> I think some of this function should be in a .bdrv_close()
>> implementation, for example this bdrv_set_backing_hd() call.
>=20
> Why? We don't have .bdrv_open, so why to have .bdrv_close? I think, whe=
n
> we publish this filter most of _add() and _drop() will be refactored to=

> open() and close(). Is there a real reason to implement .close() now?

Not really if it isn=E2=80=99t a usable block driver yet, no.

Max


--6YzhKQ7eOx4uiWbZkf7TjvS5GaFK5npwn--

--p0TFcz2mcVlkoux3LS1TDmeVAp0agcS2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DmcMACgkQ9AfbAGHV
z0CO7wgAmdbLvl0p47veut+L1N2gdzolKlOI/zekW7k34AUnWYW/dEhyYAPOVeyd
Odtiop0GuRUWsb5HY2pv4laLOGteLNLsBxOkBvmaGJS8PRKce4foFTOjaUjHPMGy
5njZf3Gw56xy1hLqqZ5kTUi3JoEEFHCzJFUZZm3VoL5/CU61fKjSyl/URtpq2KRg
GsIvAbFVS2aq6WleVgd/h2W+OHbZO9Sws4uSKUTZ48cusN60ZPyu1CgEY9WkdI4u
FGAl2mNzPkpGGq7a5Amrfj7fr9BBYnnTpyUjz0jkiYdTAZuLoq0MqIKvc2D+tjwf
q3LbF/Osy7iFY5W5UUL0rJy1xzQ9EA==
=1Hhu
-----END PGP SIGNATURE-----

--p0TFcz2mcVlkoux3LS1TDmeVAp0agcS2M--

