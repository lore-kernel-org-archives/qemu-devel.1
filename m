Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13ADC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9611D218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9611D218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KM4-0007HS-Q2
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7KLO-0006le-Jh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7KLN-0005ut-97
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7KLG-0005qz-OU; Mon, 09 Sep 2019 10:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E9DEC0546FC;
 Mon,  9 Sep 2019 14:08:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7F060BF7;
 Mon,  9 Sep 2019 14:08:26 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-15-mreitz@redhat.com>
 <20190905140547.GC4911@localhost.localdomain>
 <c8ef1957-e656-80bf-7e53-a8a417861d26@redhat.com>
 <20190909095547.GB17606@localhost.localdomain>
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
Message-ID: <30c5d55f-b3ef-4a52-883d-93059a76b383@redhat.com>
Date: Mon, 9 Sep 2019 16:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909095547.GB17606@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="soSF6sG3VGuA5awFVzPlmyt3tdM6TLfFL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 09 Sep 2019 14:08:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 14/42] block: Use CAFs when working with
 backing chains
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--soSF6sG3VGuA5awFVzPlmyt3tdM6TLfFL
Content-Type: multipart/mixed; boundary="mxF51ywizOJnWMJIvrg1wZPVObRwW379K";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <30c5d55f-b3ef-4a52-883d-93059a76b383@redhat.com>
Subject: Re: [PATCH v6 14/42] block: Use CAFs when working with backing chains
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-15-mreitz@redhat.com>
 <20190905140547.GC4911@localhost.localdomain>
 <c8ef1957-e656-80bf-7e53-a8a417861d26@redhat.com>
 <20190909095547.GB17606@localhost.localdomain>
In-Reply-To: <20190909095547.GB17606@localhost.localdomain>

--mxF51ywizOJnWMJIvrg1wZPVObRwW379K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 11:55, Kevin Wolf wrote:
> Am 09.09.2019 um 10:25 hat Max Reitz geschrieben:
>> On 05.09.19 16:05, Kevin Wolf wrote:
>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>> Use child access functions when iterating through backing chains so
>>>> filters do not break the chain.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block.c | 40 ++++++++++++++++++++++++++++------------
>>>>  1 file changed, 28 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 86b84bea21..42abbaf0ba 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -4376,7 +4376,8 @@ int bdrv_change_backing_file(BlockDriverState =
*bs,
>>>>  }
>>>> =20
>>>>  /*
>>>> - * Finds the image layer in the chain that has 'bs' as its backing =
file.
>>>> + * Finds the image layer in the chain that has 'bs' (or a filter on=

>>>> + * top of it) as its backing file.
>>>>   *
>>>>   * active is the current topmost image.
>>>>   *
>>>> @@ -4388,11 +4389,18 @@ int bdrv_change_backing_file(BlockDriverStat=
e *bs,
>>>>  BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>>>                                      BlockDriverState *bs)
>>>>  {
>>>> -    while (active && bs !=3D backing_bs(active)) {
>>>> -        active =3D backing_bs(active);
>>>> +    bs =3D bdrv_skip_rw_filters(bs);
>>>> +    active =3D bdrv_skip_rw_filters(active);
>>>
>>> This does more than the commit message says. In addition to iterating=

>>> through filters instead of stopping, it also changes the semantics of=

>>> the function to return the next non-filter on top of bs instead of th=
e
>>> next node.
>>
>> Which is to say the overlay.
>>
>> (I think we only ever use =E2=80=9Coverlay=E2=80=9D in the COW sense.)=

>=20
> I think we do, but so far also only ever for immediate COW childs, not
> for skipping through intermediate node.

Yes, because it=E2=80=99s broken so far.

>>> The block jobs seem to use it only for bdrv_is_allocated_above(), whi=
ch
>>> should return the same thing in both cases, so the behaviour stays th=
e
>>> same. qmp_block_commit() will check op blockers on a different node n=
ow,
>>> which could be a fix or a bug, I can't tell offhand. Probably the
>>> blocking doesn't really work anyway.
>>
>> You mean that the op blocker could have been on a block job filter nod=
e
>> before?  I think that=E2=80=98s pretty much the point of this fix; tha=
t that
>> doesn=E2=80=99t make sense.  (We didn=E2=80=99t have mirror_top_bs and=
 the like at
>> 058223a6e3b.)
>=20
> On the off chance that the op blocker actually works, it can't be a job=

> filter. I was thinking more of throttling, blkdebug etc.

Well, that=E2=80=99s just broken altogether right now.

>>> All of this should be mentioned in the commit message at least. Maybe=

>>> it's also worth splitting in two patches.
>>
>> I don=E2=80=99t know.  The function was written when there were no fil=
ters.
>=20
> I doubt it. blkdebug is a really old filter.
>=20
>> This change would have been a no-op then.  The fact that it isn=E2=80=99=
t to me
>> just means that introducing filters broke it.
>>
>> So I don=E2=80=99t know what I would write.  Maybe =E2=80=9Cbdrv_find_=
overlay() now
>> actually finds the overlay, that is, it will not return a filter node.=

>> This is the behavior that all callers expect (because they work on COW=

>> backing chains).=E2=80=9D
>=20
> Maybe just something like "In addition, filter nodes are not returned a=
s
> overlays any more. Instead, the first non-filter node on top of bs is
> considered the overlay now."?

Isn=E2=80=99t that basically the same? :-)

Max


--mxF51ywizOJnWMJIvrg1wZPVObRwW379K--

--soSF6sG3VGuA5awFVzPlmyt3tdM6TLfFL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12XNcACgkQ9AfbAGHV
z0DMMwf+PAlpzmBOrPKi/WL9m5kIT2Qo9zr0isTmt21IyagrZmmS6tyTr8GrwVYP
vfkLJMIuPrtbVe12bCeeXdcVZz5lXHfIZtovi9VwtIBzvXUCK63RfVGvXqhQf74c
eC86uFOZkHUwujVG4r6R1oTGRQiKBJI/0qrF3hHvQ5t9G4isqRV2+JVqUnynMLUq
oMF/xrSB7U7xa2b2Znw7FAlkcwdFIjvZYVnwKARwqG7rgIdXU2qq5YZmKcIVouWq
gfx8FXP2dR1LVKN0gA2sf8ANA38E9dJCkTf6xWYbHf8Yx5id86jpBejIuZtATvSg
7gDiMIin0GN4dX7UiBcWWf0ZCR3xlg==
=thB6
-----END PGP SIGNATURE-----

--soSF6sG3VGuA5awFVzPlmyt3tdM6TLfFL--

