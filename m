Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04133C31E5E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D478920873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D478920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGBm-00047O-2K
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdFPI-0001bl-N7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdFPE-0001fU-Tu
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdFOe-0001CH-6J; Tue, 18 Jun 2019 10:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14BBDA9DB5;
 Tue, 18 Jun 2019 14:47:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B2D8186D;
 Tue, 18 Jun 2019 14:47:32 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-26-mreitz@redhat.com>
 <ffaaf50e-ea9c-a75e-5868-7322d06b4062@virtuozzo.com>
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
Message-ID: <f21fb0b0-3cee-dc4d-355c-ae197f071802@redhat.com>
Date: Tue, 18 Jun 2019 16:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ffaaf50e-ea9c-a75e-5868-7322d06b4062@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vb9Gkra91hgJZ21V800TJ2RZ1NYvqmnFI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 18 Jun 2019 14:47:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 25/42] mirror: Deal with filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vb9Gkra91hgJZ21V800TJ2RZ1NYvqmnFI
Content-Type: multipart/mixed; boundary="XzghRMaNcupdk1KlJl8JvpwG2aqDMevyW";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <f21fb0b0-3cee-dc4d-355c-ae197f071802@redhat.com>
Subject: Re: [PATCH v5 25/42] mirror: Deal with filters
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-26-mreitz@redhat.com>
 <ffaaf50e-ea9c-a75e-5868-7322d06b4062@virtuozzo.com>
In-Reply-To: <ffaaf50e-ea9c-a75e-5868-7322d06b4062@virtuozzo.com>

--XzghRMaNcupdk1KlJl8JvpwG2aqDMevyW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.06.19 15:12, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission for active commits where the base is smalle=
r
>> than the top).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> ohm, unfortunately I'm far from knowing block/mirror mechanics and inte=
rfaces :(.
>=20
> still some comments below.
>=20
>> ---
>>   block/mirror.c | 110 +++++++++++++++++++++++++++++++++++++----------=
--
>>   blockdev.c     |  47 +++++++++++++++++----
>>   2 files changed, 124 insertions(+), 33 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 4fa8f57c80..3d767e3030 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -660,8 +660,10 @@ static int mirror_exit_common(Job *job)
>>                               &error_abort);
>>       if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN=
) {
>>           BlockDriverState *backing =3D s->is_none_mode ? src : s->bas=
e;
>> -        if (backing_bs(target_bs) !=3D backing) {
>> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
>> +        BlockDriverState *unfiltered_target =3D bdrv_skip_rw_filters(=
target_bs);
>> +
>> +        if (bdrv_filtered_cow_bs(unfiltered_target) !=3D backing) {
>> +            bdrv_set_backing_hd(unfiltered_target, backing, &local_er=
r);
>>               if (local_err) {
>>                   error_report_err(local_err);
>>                   ret =3D -EPERM;
>> @@ -711,7 +713,7 @@ static int mirror_exit_common(Job *job)
>>       block_job_remove_all_bdrv(bjob);
>>       bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,=

>>                               &error_abort);
>> -    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &erro=
r_abort);
>> +    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &err=
or_abort);
>>  =20
>>       /* We just changed the BDS the job BB refers to (with either or =
both of the
>>        * bdrv_replace_node() calls), so switch the BB back so the clea=
nup does
>> @@ -757,6 +759,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBl=
ockJob *s)
>>   {
>>       int64_t offset;
>>       BlockDriverState *base =3D s->base;
>> +    BlockDriverState *filtered_base;
>>       BlockDriverState *bs =3D s->mirror_top_bs->backing->bs;
>>       BlockDriverState *target_bs =3D blk_bs(s->target);
>>       int ret;
>> @@ -795,6 +798,9 @@ static int coroutine_fn mirror_dirty_init(MirrorBl=
ockJob *s)
>>           s->initial_zeroing_ongoing =3D false;
>>       }
>>  =20
>> +    /* Will be NULL if @base is not in @bs's chain */
>=20
> Should we assert that not NULL?

Well, but it can be NULL.  It is only non-NULL for active commit.

> Hmm, so this is the way to "skip filters reverse from the base", yes? W=
orth add a comment?

We need this because bdrv_is_allocated() will report everything as
allocated in a filter if it is allocated in its filtered child.  So if
we use @base in bdrv_is_allocated_above() and there is a filter on top
of it, bdrv_is_allocated_above() will report everything as allocated
that is allocated in @base (which we do not want).

Therefor, we need to go to the topmost R/W filter on top of @base, so
that bdrv_is_allocated_above() actually starts at the first COW chain
element above @base.

As for the comment, I thought the name =E2=80=9Cfiltered base=E2=80=9D wo=
uld suffice,
but sure.

(=E2=80=9C@filtered_base is the topmost node in the @bs-@base chain that =
is
connected to @base only through filters=E2=80=9D or something; plus the
explanation why we need it.)

>> +    filtered_base =3D bdrv_filtered_cow_bs(bdrv_find_overlay(bs, base=
));
>> +
>>       /* First part, loop on the sectors and initialize the dirty bitm=
ap.  */
>>       for (offset =3D 0; offset < s->bdev_length; ) {
>>           /* Just to make sure we are not exceeding int limit. */

[...]

>> @@ -1583,15 +1590,42 @@ static void mirror_start_job(const char *job_i=
d, BlockDriverState *bs,
>>        * In the case of active commit, things look a bit different, th=
ough,
>>        * because the target is an already populated backing file in ac=
tive use.
>>        * We can allow anything except resize there.*/
>> +
>> +    target_perms =3D BLK_PERM_WRITE;
>> +    target_shared_perms =3D BLK_PERM_WRITE_UNCHANGED;
>> +
>>       target_is_backing =3D bdrv_chain_contains(bs, target);
>=20
> don't you want skip filters here? actual target node may be in backing =
chain, but has separate
> filters above it

I don=E2=80=99t quite understand.  bdrv_chain_contains() iterates over th=
e
filter chain, so it shouldn=E2=80=99t matter whether there are filters ab=
ove
target or not.

[...]

>> @@ -1641,15 +1675,39 @@ static void mirror_start_job(const char *job_i=
d, BlockDriverState *bs,
>>       /* In commit_active_start() all intermediate nodes disappear, so=

>>        * any jobs in them must be blocked */
>=20
> hmm, preexisting, it s/jobs/nodes/

I think the idea was that no other jobs may be run on intermediate
nodes.  (But by now it=E2=80=99s no longer just about jobs, so yes, shoul=
d be
s/jobs/nodes/.  I don=E2=80=99t know whether I should squeeze that in her=
e, though.)

Max


--XzghRMaNcupdk1KlJl8JvpwG2aqDMevyW--

--Vb9Gkra91hgJZ21V800TJ2RZ1NYvqmnFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0I+YMACgkQ9AfbAGHV
z0AfMQf/VkkxJPr6ywBBmRDIy0d+AX5xczpG9jW3kqMSlJoXqsZJDS9Y/Y8QW+Sa
5qNDNiH9cD1Yeer+q+zv8t33R9Xwr7Nay9kH8vXoTGyA+G83gimZnnNcgbVDPzey
F/y0BQNBnLD3cLefoimvdoylP8uUSP7f46UvEwXAfm/okfBhMBrlI9cJ8YrC8old
i61asEBDX7Ktwtf3Ge8gnFVEPcSbhg7ddC+jdKultByIBYQpg9Jd/e8yLI8XvT2t
5/ho/T75uPkOPklj2HfGaYpLcKYLphCbiulugCYrfP2QRsDG/S5R3s/wnHVye47y
QYQF5yxRs0gbDJ32eDFrGlu7GSj0mQ==
=IefT
-----END PGP SIGNATURE-----

--Vb9Gkra91hgJZ21V800TJ2RZ1NYvqmnFI--

