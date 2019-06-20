Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD6C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D0420665
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D0420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2R2-0000RM-7i
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:09:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he25x-0003U1-Mz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he25p-0008U7-9f
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he25Y-00081m-Qs; Thu, 20 Jun 2019 14:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A66588304;
 Thu, 20 Jun 2019 18:46:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3731B60477;
 Thu, 20 Jun 2019 18:46:25 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-3-jsnow@redhat.com>
 <e7143bb8-afb6-8326-6e93-49a7470b9b98@redhat.com>
 <5a873055-72c2-ac4c-074d-2c31c8b4c863@redhat.com>
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
Message-ID: <070fe637-f10f-0e3b-7fc3-e0ea1ecb6ae2@redhat.com>
Date: Thu, 20 Jun 2019 20:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5a873055-72c2-ac4c-074d-2c31c8b4c863@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ttXvptYEExBvOeKWOJV27ICUiQW0KDkUU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 20 Jun 2019 18:46:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/12] block/backup: Add mirror sync mode
 'bitmap'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ttXvptYEExBvOeKWOJV27ICUiQW0KDkUU
Content-Type: multipart/mixed; boundary="vgwFx0mYKSYUk9DlnyMB5IfQRvE4qpT6d";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <070fe637-f10f-0e3b-7fc3-e0ea1ecb6ae2@redhat.com>
Subject: Re: [PATCH 02/12] block/backup: Add mirror sync mode 'bitmap'
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-3-jsnow@redhat.com>
 <e7143bb8-afb6-8326-6e93-49a7470b9b98@redhat.com>
 <5a873055-72c2-ac4c-074d-2c31c8b4c863@redhat.com>
In-Reply-To: <5a873055-72c2-ac4c-074d-2c31c8b4c863@redhat.com>

--vgwFx0mYKSYUk9DlnyMB5IfQRvE4qpT6d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 18:01, John Snow wrote:
>=20
>=20
> On 6/20/19 11:00 AM, Max Reitz wrote:
>> On 20.06.19 03:03, John Snow wrote:
>>> We don't need or want a new sync mode for simple differences in
>>> semantics.  Create a new mode simply named "BITMAP" that is designed =
to
>>> make use of the new Bitmap Sync Mode field.
>>>
>>> Because the only bitmap mode is 'conditional', this adds no new
>>> functionality to the backup job (yet). The old incremental backup mod=
e
>>> is maintained as a syntactic sugar for sync=3Dbitmap, mode=3Dconditio=
nal.
>>>
>>> Add all of the plumbing necessary to support this new instruction.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  qapi/block-core.json      | 30 ++++++++++++++++++++++--------
>>>  include/block/block_int.h |  6 +++++-
>>>  block/backup.c            | 35 ++++++++++++++++++++++++++++-------
>>>  block/mirror.c            |  6 ++++--
>>>  block/replication.c       |  2 +-
>>>  blockdev.c                |  8 ++++++--
>>>  6 files changed, 66 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index caf28a71a0..6d05ad8f47 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1127,12 +1127,15 @@
>>>  #
>>>  # @none: only copy data written from now on
>>>  #
>>> -# @incremental: only copy data described by the dirty bitmap. Since:=
 2.4
>>> +# @incremental: only copy data described by the dirty bitmap. (since=
: 2.4)
>>
>> Why not deprecate this in the process and note that this is equal to
>> sync=3Dbitmap, bitmap-mode=3Dconditional?
>>
>> (I don=E2=80=99t think there is a rule that forces us to actually remo=
ve
>> deprecated stuff after two releases if it doesn=E2=80=99t hurt to keep=
 it.)
>>
>=20
> Mostly I thought it would be fine to keep as sugar. In your replies so
> far I gather that "incremental" and "differential" don't mean specific
> backup paradigms to you, so maybe these seem like worthless words.
>=20
> It was my general understanding that in terms of backup
> paradigms/methodologies that "incremental" and "differential" mean very=

> specific things.
>=20
> Incremental: Each backup contains only the delta from the last
> incremental backup.
> Differential: Each backup contains the delta from the last FULL backup.=

>=20
> You can search "incremental vs differential backup" on your search
> engine of choice and find many relevant results. I took a Networking/IT=

> vocational degree in 2007 and these terms were taught in textbooks then=
=2E
>=20
> So I will resist quite strongly changing them, and for this reason, fel=
t
> that it was strictly a good thing to keep incremental as sugar, because=

> I thought that people would know what it meant.

:C

OK.  I=E2=80=99m happy as long as it=E2=80=99s all explained somewhere (i=
=2Ee.
bitmaps.rst).  Personally, I=E2=80=99d also like a pointer to that docume=
ntation
here.  (Sure, people should just look there if they don=E2=80=99t underst=
and
something about bitmaps anyway, but I can=E2=80=99t see it hurting to jus=
t put a
pointer here anyway.)

> (More than "conditional", anyway, which is jargon I made up.)

But you make it up in this series, which is great for me, because that
means I get the definition (from the cover letter) without having to
look it up. O:-)

[...]

>>>  #
>>> +# @bitmap-mode: Specifies the type of data the bitmap should contain=
 after
>>> +#               the operation concludes. Must be present if sync is =
"bitmap".
>>> +#               Must NOT be present otherwise. (Since 4.1)
>>
>> Do we have any rule that qemu must enforce =E2=80=9Cmust not=E2=80=9Ds=
? :-)
>>
>> (No, I don=E2=80=99t think so.  I think it=E2=80=99s very reasonable t=
hat you accept
>> bitmap-mode=3Dconditional for sync=3Dincremental.)
>>
>=20
> Right, I left this a secret wiggle room. If you specify the correct
> bitmap sync mode for the incremental sugar, it will actually let it
> slide. If you specify the wrong one, it will error out.
>=20
> However, I think this is perfectly correct advice from the API: Please
> use this mode with sync=3Dbitmap and do not use it otherwise.
>=20
> Would you like me to change it to be more technically correct and
> document the little affordance I made?

It=E2=80=99s probably better not to.  Better forbid as much as we can so =
that we
can break compatibility to users that happened to use it still =E2=80=9Cb=
ecause
it works=E2=80=9D.

Max


--vgwFx0mYKSYUk9DlnyMB5IfQRvE4qpT6d--

--ttXvptYEExBvOeKWOJV27ICUiQW0KDkUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0L1H8ACgkQ9AfbAGHV
z0AYSAf/RsqrKuU0YlD9e2KI1Z8Eq3tQY3T09E4rJZGnuVr2Pb2NIdDsfDRt/Jk3
Dii8VJe9n9GsrJsTKM9g4xpI4E9fQ5ymCZtKOtPI7Ma+XYHox6BqMSKVvScwIEri
5m42r1vdTal0hDPOap07rH7GrWLdSxEFQZ3DxuBy6asO1pxZJH9wYK7CN6HI6ZOI
gz6QvdbRLdn9enrZ6xUDtticDOlUDCbDO9qw0SHsPC+fzblpWVUHlO8GwNTfXvwp
4hNVTgEZygC3yqDh2sXDdNA3Ga8wHSrcsiDAVFdyYWTCkMub/+PmaMYvzKznNSJM
uycR1f4IGHsIL+ylC/0q0xIj/0euLQ==
=orx7
-----END PGP SIGNATURE-----

--ttXvptYEExBvOeKWOJV27ICUiQW0KDkUU--

