Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E1FC433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C84B20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 07:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C84B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7EJX-0007Yy-6Z
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 03:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7EIW-0006ss-NZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7EIV-0007DV-H0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 03:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7EIS-0007BB-Ot; Mon, 09 Sep 2019 03:41:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9265AA909;
 Mon,  9 Sep 2019 07:41:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E030A1D9;
 Mon,  9 Sep 2019 07:41:09 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
 <a9ca977d-d8d5-662f-748a-b1e53f95969f@virtuozzo.com>
 <bf35dca0-c965-6a28-49fc-3943d05b2909@redhat.com>
 <f3a78c1a-b396-d82e-7fcf-04669a9eb2c7@virtuozzo.com>
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
Message-ID: <eeb204f4-6143-3f13-9a46-72ce3c86f65a@redhat.com>
Date: Mon, 9 Sep 2019 09:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f3a78c1a-b396-d82e-7fcf-04669a9eb2c7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RRBe8atERUD8C6YzReZUSSYgRXMgk8A2G"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 09 Sep 2019 07:41:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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
--RRBe8atERUD8C6YzReZUSSYgRXMgk8A2G
Content-Type: multipart/mixed; boundary="GWU2e6RtBgCrSUUal2j1hcV6M0YyzlIzZ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <eeb204f4-6143-3f13-9a46-72ce3c86f65a@redhat.com>
Subject: Re: [PATCH v6 25/42] mirror: Deal with filters
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
 <a9ca977d-d8d5-662f-748a-b1e53f95969f@virtuozzo.com>
 <bf35dca0-c965-6a28-49fc-3943d05b2909@redhat.com>
 <f3a78c1a-b396-d82e-7fcf-04669a9eb2c7@virtuozzo.com>
In-Reply-To: <f3a78c1a-b396-d82e-7fcf-04669a9eb2c7@virtuozzo.com>

--GWU2e6RtBgCrSUUal2j1hcV6M0YyzlIzZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.09.19 10:32, Vladimir Sementsov-Ogievskiy wrote:
> 02.09.2019 17:35, Max Reitz wrote:
>> On 31.08.19 11:57, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.08.2019 19:13, Max Reitz wrote:
>>>> This includes some permission limiting (for example, we only need to=

>>>> take the RESIZE permission for active commits where the base is smal=
ler
>>>> than the top).
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    block/mirror.c | 117 ++++++++++++++++++++++++++++++++++++++------=
-----
>>>>    blockdev.c     |  47 +++++++++++++++++---
>>>>    2 files changed, 131 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>> index 54bafdf176..6ddbfb9708 100644
>>>> --- a/block/mirror.c
>>>> +++ b/block/mirror.c
>>>> @@ -42,6 +42,7 @@ typedef struct MirrorBlockJob {
>>>>        BlockBackend *target;
>>>>        BlockDriverState *mirror_top_bs;
>>>>        BlockDriverState *base;
>>>> +    BlockDriverState *base_overlay;
>>>>   =20
>>>>        /* The name of the graph node to replace */
>>>>        char *replaces;
>>>> @@ -665,8 +666,10 @@ static int mirror_exit_common(Job *job)
>>>>                                 &error_abort);
>>>>        if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CH=
AIN) {
>>>>            BlockDriverState *backing =3D s->is_none_mode ? src : s->=
base;
>>>> -        if (backing_bs(target_bs) !=3D backing) {
>>>> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
>>>> +        BlockDriverState *unfiltered_target =3D bdrv_skip_rw_filter=
s(target_bs);
>>>> +
>>>> +        if (bdrv_filtered_cow_bs(unfiltered_target) !=3D backing) {=

>>>> +            bdrv_set_backing_hd(unfiltered_target, backing, &local_=
err);
>>>>                if (local_err) {
>>>>                    error_report_err(local_err);
>>>>                    ret =3D -EPERM;
>>>> @@ -715,7 +718,7 @@ static int mirror_exit_common(Job *job)
>>>>         * valid.
>>>>         */
>>>>        block_job_remove_all_bdrv(bjob);
>>>> -    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &er=
ror_abort);
>>>> +    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &e=
rror_abort);
>>>>   =20
>>>>        /* We just changed the BDS the job BB refers to (with either =
or both of the
>>>>         * bdrv_replace_node() calls), so switch the BB back so the c=
leanup does
>>>> @@ -812,7 +815,8 @@ static int coroutine_fn mirror_dirty_init(Mirror=
BlockJob *s)
>>>>                return 0;
>>>>            }
>>>>   =20
>>>> -        ret =3D bdrv_is_allocated_above(bs, base, false, offset, by=
tes, &count);
>>>> +        ret =3D bdrv_is_allocated_above(bs, s->base_overlay, true, =
offset, bytes,
>>>> +                                      &count);
>>>>            if (ret < 0) {
>>>>                return ret;
>>>>            }
>>>> @@ -908,7 +912,7 @@ static int coroutine_fn mirror_run(Job *job, Err=
or **errp)
>>>>        } else {
>>>>            s->target_cluster_size =3D BDRV_SECTOR_SIZE;
>>>>        }
>>>> -    if (backing_filename[0] && !target_bs->backing &&
>>>> +    if (backing_filename[0] && !bdrv_backing_chain_next(target_bs) =
&&
>>>>            s->granularity < s->target_cluster_size) {
>>>>            s->buf_size =3D MAX(s->buf_size, s->target_cluster_size);=

>>>>            s->cow_bitmap =3D bitmap_new(length);
>>>> @@ -1088,8 +1092,9 @@ static void mirror_complete(Job *job, Error **=
errp)
>>>>        if (s->backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN) {
>>>>            int ret;
>>>>   =20
>>>> -        assert(!target->backing);
>>>> -        ret =3D bdrv_open_backing_file(target, NULL, "backing", err=
p);
>>>> +        assert(!bdrv_backing_chain_next(target));
>>>
>>> Preexisting, but seems we may crash here, I don't see where it is che=
cked before, to
>>> return error if there is some backing. And even if we do so, we don't=
 prevent appearing
>>> of target backing during mirror operation.
>>
>> The idea is that MIRROR_OPEN_BACKING_CHAIN is set only when using
>> drive-mirror with mode=3Dexisting.  In this case, we also set
>> BDRV_O_NO_BACKING for the target.
>>
>> You=E2=80=99re right that a user could add a backing chain to the targ=
et during
>> the operation.  They really have to make an effort to shoot themselves=

>> in the foot for this because the target must have an auto-generated no=
de
>> name.
>>
>> I suppose the best would be not to open the backing chain if the targe=
t
>> node already has a backing child?
>=20
> Hmm, but we still should generate an error, as we can't do what was req=
uested.

But the user didn=E2=80=99t request anything.  They just specified an exi=
sting
file as the target with mode=3Dexisting, then (for whatever reason) made =
a
real effort to add a backing node to it (i.e. they had to look up the
target=E2=80=99s auto-generated node name), and then the job finishes.

The user didn=E2=80=99t request us to open the backing chain of the targe=
t.
They just requested to mirror to an existing file.  If they manually
override that existing file=E2=80=99s backing chain, I think it makes sen=
se to
keep it that way.

Max

>>>> +        ret =3D bdrv_open_backing_file(bdrv_skip_rw_filters(target)=
, NULL,
>>>> +                                     "backing", errp);
>>>>            if (ret < 0) {
>>>>                return;
>>>>            }


--GWU2e6RtBgCrSUUal2j1hcV6M0YyzlIzZ--

--RRBe8atERUD8C6YzReZUSSYgRXMgk8A2G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12AhMACgkQ9AfbAGHV
z0DuMwf/c8fvFmQ07U66amKDDx3tv5PxFaO63pN3Ktjd/kuEGQQ0lzt+bDRDl4Qt
wAglmUwJZmxs/LPWScQSo6IaM/UZ6AhmaWhJGRE5qLK/kUg2IsuxjdKcV9FjYRmz
Daq/aeSj2oO2KF7zvu0ciVjn1wv/Ukv9gvC51n1zxTj804HJJrVAJdxJulCuXshJ
Zfi4dDk5/npow0rScDhHibBHOtbeqHwswotMwrQAzQ4bvATphfQD0Rbm8Gr4tQru
KtCIGqeiegUA66vidDgY76XmB8K1/pntW2M7zBkPcJMTuEORfZCSOGyPgTX+VoBD
03JmmExtR+LtlPyM/u8xzpG/RTrjWQ==
=nmn6
-----END PGP SIGNATURE-----

--RRBe8atERUD8C6YzReZUSSYgRXMgk8A2G--

