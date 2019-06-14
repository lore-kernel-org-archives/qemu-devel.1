Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564CBC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CD921841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CD921841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbp7c-0008SV-CS
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbofK-0002QW-Rq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbofI-0001aH-Fw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hboes-000163-SG; Fri, 14 Jun 2019 12:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8C1F307D863;
 Fri, 14 Jun 2019 16:02:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74873605CA;
 Fri, 14 Jun 2019 16:02:21 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
 <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
 <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>
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
Message-ID: <bc9cd825-3cd9-239b-0980-950e6489be6a@redhat.com>
Date: Fri, 14 Jun 2019 18:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m2DOqb10zjGW1N3kHJaLWfIySfUCykX0c"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 14 Jun 2019 16:02:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 14/42] block: Use CAFs when working with
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2DOqb10zjGW1N3kHJaLWfIySfUCykX0c
Content-Type: multipart/mixed; boundary="kzgfAfa8hrRlGSmW6bnqX4uljFledJH56";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <bc9cd825-3cd9-239b-0980-950e6489be6a@redhat.com>
Subject: Re: [PATCH v5 14/42] block: Use CAFs when working with backing chains
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
 <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
 <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>
In-Reply-To: <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>

--kzgfAfa8hrRlGSmW6bnqX4uljFledJH56
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 16:31, Vladimir Sementsov-Ogievskiy wrote:
> 14.06.2019 16:50, Max Reitz wrote:
>> On 14.06.19 15:26, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.06.2019 1:09, Max Reitz wrote:
>>>> Use child access functions when iterating through backing chains so
>>>> filters do not break the chain.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    block.c | 40 ++++++++++++++++++++++++++++------------
>>>>    1 file changed, 28 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 11f37983d9..505b3e9a01 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>
>> [...]
>>
>>>> @@ -4273,11 +4274,18 @@ int bdrv_change_backing_file(BlockDriverStat=
e *bs,
>>>>    BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>>>                                        BlockDriverState *bs)
>>>>    {
>>>> -    while (active && bs !=3D backing_bs(active)) {
>>>> -        active =3D backing_bs(active);
>>>> +    bs =3D bdrv_skip_rw_filters(bs);
>>>> +    active =3D bdrv_skip_rw_filters(active);
>>>> +
>>>> +    while (active) {
>>>> +        BlockDriverState *next =3D bdrv_backing_chain_next(active);=

>>>> +        if (bs =3D=3D next) {
>>>> +            return active;
>>>> +        }
>>>> +        active =3D next;
>>>>        }
>>>>   =20
>>>> -    return active;
>>>> +    return NULL;
>>>>    }
>>>
>>> Semantics changed for this function.
>>> It is used in two places
>>> 1. from bdrv_find_base wtih @bs=3DNULL, it should be unchanged, as I =
hope we will never have
>>>      filter node as a bottom of some valid chain
>>>
>>> 2. from qmp_block_commit, only to check op-blocker... hmmm. I really =
don't understand,
>>> why do we check BLOCK_OP_TYPE_COMMIT_TARGET on top_bs overlay.. top_b=
s overlay is out of the job,
>>> what is this check for?
>>
>> There is a loop before this check which checks that the same blocker i=
s
>> not set on any nodes between top and base (both inclusive).  I guess
>> non-active commit checks the node above @top, too, because its backing=

>> file will change.
>=20
> So in this case frozen chain works better.

Perhaps.  The op blockers are in this weird state anyway.  I don=E2=80=99=
t think
we even need them any more, because the permissions were intended to
replace them (they were originally called =E2=80=9Cfine-grained op blocke=
rs=E2=80=9D, I
seem to remember).

I dare not touch them.

>>>>    /* Given a BDS, searches for the base layer. */
>>
>> [...]
>>
>>>> @@ -5149,7 +5165,7 @@ BlockDriverState *bdrv_find_backing_image(Bloc=
kDriverState *bs,
>>>>                char *backing_file_full_ret;
>>>>   =20
>>>>                if (strcmp(backing_file, curr_bs->backing_file) =3D=3D=
 0) {
>>>
>>> hmm, interesting, what bs->backing_file now means? It's strange enoug=
h to store such field on
>>> bds, when we have backing link anyway..
>>
>> Patch 37 has you covered. :-)
>>
>=20
> Hmm, if it has removed this field, but it doesn't)

Because it=E2=80=99s needed.  (Just not in the current form, but that=E2=80=
=99s what 37
is for.)

> So, we finished with some object, called "overlay", but it is not an ov=
erlay of bs, it's overlay of
> first non-implicit filtered node in bs backing chain, it may be found b=
y bdrv_find_overlay() helper (which is
> almost unused and my be safely dropped), and filename of this "overlay"=
 is stored in bs->backing_file string
> variable, keeping in mind that bs->backing is pointer to backing child =
of bs which is completely another thing?

I don=E2=80=99t quite see what you mean.  There is no =E2=80=9Coverlay=E2=
=80=9D in this function.

> Oh, no, everything related to filename-based backing chain logic is not=
 for me o_O. If something doesn't work
> with filename-based logic users should use node-names..

In theory yes, but that isn=E2=80=99t an option for qemu-img commit, for =
example.

> And I'd prefer to deprecate filename based interfaces at all.

Me too.

https://lists.nongnu.org/archive/html/qemu-devel/2014-09/msg04878.html

:-/

Max


--kzgfAfa8hrRlGSmW6bnqX4uljFledJH56--

--m2DOqb10zjGW1N3kHJaLWfIySfUCykX0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DxQsACgkQ9AfbAGHV
z0BrdwgAv9CqLmG/eeDoX/mxJxNK2xMFfOlFS+L7hrtRx79IHZWWB54EGiy7wmS6
tsuSxQm4yf8VR0Q7KFzC5LvjJnErVWOVVXLloFJ5OBuxHRbMvNF+S6oqp3bR8YDo
qcffxuBEOQC3x1Lg5QnP7VzERIDTsVPmSnxx+XYqBL4UJZJmeTE5sB96U4EFAp8H
iqh57cfvid9KRHkdcDiPrvX6MNXpdB317SPQzsn3f9Z70kIGeogy1YMrm/mTtXRq
rtZqw+s+4pqlSFT1+0gpwmO798lDL9UWAiQDF44lTTo+mFMBsO3vJgtI7uGdAzMe
Pc/a/8NpDJgWrc+fNpgZTaL0x+tKuQ==
=BqB8
-----END PGP SIGNATURE-----

--m2DOqb10zjGW1N3kHJaLWfIySfUCykX0c--

