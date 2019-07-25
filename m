Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83215C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB5922C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB5922C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqghQ-0002qz-7R
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44950)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqghC-0002Ca-RE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqghB-0003xG-CZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:34:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqgh8-0003qk-60; Thu, 25 Jul 2019 12:34:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9A5A30A884C;
 Thu, 25 Jul 2019 16:34:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFE8917B0E;
 Thu, 25 Jul 2019 16:34:14 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
 <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
 <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
 <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>
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
Message-ID: <6ab14c4a-5460-12f4-da65-ef55511a2e44@redhat.com>
Date: Thu, 25 Jul 2019 18:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Rx0Cl8KuScvW4b2WgoghhwFMcEw2xkN6J"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 25 Jul 2019 16:34:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 30/42] qemu-img: Use child access
 functions
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
--Rx0Cl8KuScvW4b2WgoghhwFMcEw2xkN6J
Content-Type: multipart/mixed; boundary="jFKmQZew5IfcmMqopK9IGD5Gkx9kjIQBT";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <6ab14c4a-5460-12f4-da65-ef55511a2e44@redhat.com>
Subject: Re: [PATCH v5 30/42] qemu-img: Use child access functions
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
 <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
 <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
 <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>
In-Reply-To: <650837b5-1fb8-3995-348c-77ab55020585@virtuozzo.com>

--jFKmQZew5IfcmMqopK9IGD5Gkx9kjIQBT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.07.19 11:54, Vladimir Sementsov-Ogievskiy wrote:
> 21.06.2019 16:15, Vladimir Sementsov-Ogievskiy wrote:
>> 19.06.2019 18:49, Max Reitz wrote:
>>> On 19.06.19 11:18, Vladimir Sementsov-Ogievskiy wrote:
>>>> 13.06.2019 1:09, Max Reitz wrote:
>>>>> This changes iotest 204's output, because blkdebug on top of a COW =
node
>>>>> used to make qemu-img map disregard the rest of the backing chain (=
the
>>>>> backing chain was broken by the filter).=C2=A0 With this patch, the=

>>>>> allocation in the base image is reported correctly.
>>>>>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 ++++++++++++++++=
++++----------------
>>>>> =C2=A0=C2=A0 tests/qemu-iotests/204.out |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 2 files changed, 21 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/qemu-img.c b/qemu-img.c
>>>>> index 07b6e2a808..7bfa6e5d40 100644
>>>>> --- a/qemu-img.c
>>>>> +++ b/qemu-img.c
>>>>> @@ -992,7 +992,7 @@ static int img_commit(int argc, char **argv)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!blk) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 bs =3D blk_bs(blk);
>>>>> +=C2=A0=C2=A0=C2=A0 bs =3D bdrv_skip_implicit_filters(blk_bs(blk));=

>>>>
>>>> if filename is json, describing explicit filter over normal node, bs=
 will be
>>>> explicit filter ...
>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_progress_init(progress, 1=
=2Ef);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_progress_print(0.f, 100);=

>>>>> @@ -1009,7 +1009,7 @@ static int img_commit(int argc, char **argv)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Thi=
s is different from QMP, which by default uses the deepest file in
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* the backing chain (i.e., the very base); however, the traditional
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* behavior of qemu-img commit is using the immediate backing file. */
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_bs =3D backing_bs(=
bs);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_bs =3D bdrv_filter=
ed_cow_bs(bs);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!b=
ase_bs) {
>>>>
>>>> and here we'll fail.
>>>
>>> Right, will change to bdrv_backing_chain_next().
>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 error_setg(&local_err, "Image does not have a backing fil=
e");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto done;
>>>>> @@ -1626,19 +1626,18 @@ static int convert_iteration_sectors(ImgCon=
vertState *s, int64_t sector_num)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->sector_next_status <=3D=
 sector_num) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_=
t count =3D n * BDRV_SECTOR_SIZE;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *src_b=
s =3D blk_bs(s->src[src_cur]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *base;=

>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-=
>target_has_backing) {
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D bdrv_block_status(blk_bs(s->src[src_cur]),
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (se=
ctor_num - src_cur_offset) *
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDR=
V_SECTOR_SIZE,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cou=
nt, &count, NULL, NULL);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 base =3D bdrv_backing_chain_next(src_bs);
>>>>
>>>> As you described in another patch, will not we here get allocated in=
 base as allocated, because of
>>>> counting filters above base?
>>>
>>> Damn, yes.=C2=A0 So
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 base =3D bdrv_filtered_cow_bs(bdrv_skip_rw_f=
ilters(src_bs));
>>>
>>> I suppose.
>>>
>>>> Hmm. I now think, why filters don't report everything as unallocated=
, would not it be more correct
>>>> than fallthrough to child?
>>>
>>> I don=E2=80=99t know, actually.=C2=A0 Maybe, maybe not.
>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else=
 {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (sector_num - src_cur_offset) *
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_SECTOR_SIZE,
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count, &count, NULL, NULL);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 base =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_block_stat=
us_above(src_bs, base,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (sector_num - src_cur_offset) *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BDRV_SECTOR_SIZE,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 count, &count, NULL, NULL);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (re=
t < 0) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 error_report("error while reading block status of sector =
%" PRId64
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ": %s", sector_num, strerror(-ret));
>>>
>>> [...]
>>>
>>>>> @@ -2949,7 +2950,7 @@ static int img_map(int argc, char **argv)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!blk) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 1;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0 bs =3D blk_bs(blk);
>>>>> +=C2=A0=C2=A0=C2=A0 bs =3D bdrv_skip_implicit_filters(blk_bs(blk));=

>>>>
>>>> Hmm, another thought about implicit filters, how they could be here =
in qemu-img?
>>>
>>> Hm, I don=E2=80=99t think they can.
>>>
>>>> If implicit are only
>>>> job filters. Do you prepared it for implicit COR? But we discussed w=
ith Kevin that we'd better deprecate
>>>> copy-on-read option..
>>>>
>>>> So, if implicit filters are for compatibility, we'll have them only =
in block-jobs. So, seems no reason to support
>>>> them in qemu-img.
>>>
>>> Seems reasonable, yes.
>>>
>>>> Also, in block-jobs, we can abandon creating implicit filters above =
any filter nodes, as well as abandon creating any
>>>> filter nodes above implicit filters. This will still support old sce=
narios, but gives very simple and well defined scope
>>>> of using implicit filters and how to work with them. What do you thi=
nk?
>>>
>>> Hm, in what way would that make things simpler?
>>>
>>
>> This question was in my mind while I've finishing this paragraph) At l=
east such restriction answer the question, where
>> should new filters be added: below or under implicit filters.. With su=
ch restriction we always can have only one implicit filter
>> over non-filter node, and above it should be explicit filter or non-fi=
lter node. But this need huge work to be done with small
>> benefit, so, forget it)

OK.  I should have read the last part first, then I could have replied
sooner. :-)

> Strange, I have this mail automatically returned back. Did you receive =
it?

No, I didn=E2=80=99t.  (Nor any of the other mails you resent.)  Weird.

Also, welcome back, congratulations, and all the best to your family! :-)=


Max


--jFKmQZew5IfcmMqopK9IGD5Gkx9kjIQBT--

--Rx0Cl8KuScvW4b2WgoghhwFMcEw2xkN6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl052gQACgkQ9AfbAGHV
z0BTpQf+NDwHq2HZMjxRU9siTiLtf/QvJbmHl1RKJwgStgYbTzOc+cGEb9+uhzKe
B7uoZQGom7XzdvEgazmQVD0dsI4Urz1kaAU8Pr8jq8YT6qhuWV3mfGQIzex2JmPf
VipVGoMSJXLwBHKVhouFqyrDbOIX0aFChdgOYdZuChsBRLpyjDckjcueIWRgLPzD
FLzfZriHrxA7elv1rtCn4uVw8wyWUzJYq3BuUbyaXx3X1rKW4rooYUtmSBj3VpWS
4MGmbvzm/KMZa9vs7lPJkl6ndP+x7/M1qXgs40UDCf8K6lR/ZSOQ87fb24YRT5kS
yXweNdHg5R0Mwu04Nbgxq+5+8ke6SQ==
=jCjt
-----END PGP SIGNATURE-----

--Rx0Cl8KuScvW4b2WgoghhwFMcEw2xkN6J--

