Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E2C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A3020861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A3020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYbg-0006AR-Sp
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkYao-0005gU-H6
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkYam-0004vk-J0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkYai-0004rc-OB; Mon, 08 Jul 2019 14:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90AAFC0586C4;
 Mon,  8 Jul 2019 18:42:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-127.brq.redhat.com
 [10.40.204.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFEC2579B2;
 Mon,  8 Jul 2019 18:42:10 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-12-jsnow@redhat.com>
 <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
 <750e0c38-ba17-b6ae-82d4-bc946b3d029e@redhat.com>
 <4fb4979b-0b38-a581-25e7-a1e8007850ce@redhat.com>
 <a73f60bd-ce91-39ef-810a-f1712b2ef1e7@redhat.com>
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
Message-ID: <6ab01815-9a51-6f8f-c59c-ec6234d12e3b@redhat.com>
Date: Mon, 8 Jul 2019 20:42:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a73f60bd-ce91-39ef-810a-f1712b2ef1e7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VlfXKxKjmPlZQY4cKdzx7p7Czu544twt8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 08 Jul 2019 18:42:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/18] block/backup: upgrade copy_bitmap
 to BdrvDirtyBitmap
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VlfXKxKjmPlZQY4cKdzx7p7Czu544twt8
Content-Type: multipart/mixed; boundary="pvF8Ygn4xlPcKZ5jiBsXPZq83SC1hNvuM";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <6ab01815-9a51-6f8f-c59c-ec6234d12e3b@redhat.com>
Subject: Re: [PATCH v2 11/18] block/backup: upgrade copy_bitmap to
 BdrvDirtyBitmap
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-12-jsnow@redhat.com>
 <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
 <750e0c38-ba17-b6ae-82d4-bc946b3d029e@redhat.com>
 <4fb4979b-0b38-a581-25e7-a1e8007850ce@redhat.com>
 <a73f60bd-ce91-39ef-810a-f1712b2ef1e7@redhat.com>
In-Reply-To: <a73f60bd-ce91-39ef-810a-f1712b2ef1e7@redhat.com>

--pvF8Ygn4xlPcKZ5jiBsXPZq83SC1hNvuM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.19 20:32, John Snow wrote:
>=20
>=20
> On 7/8/19 8:02 AM, Max Reitz wrote:
>> On 05.07.19 18:52, John Snow wrote:
>>>
>>>
>>> On 7/4/19 1:29 PM, Max Reitz wrote:
>>
>> [...]
>>
>>>> Which brings me to a question: Why is the copy bitmap assigned to th=
e
>>>> target in the first place?  Wouldn=E2=80=99t it make more sense on t=
he source?
>>>>
>>>
>>> *cough*;
>>>
>>> the idea was that the target is *most likely* to be the temporary nod=
e
>>> created for the purpose of this backup, even though backup does not
>>> explicitly create the node.
>>>
>>> So ... by creating it on the target, we avoid cluttering up the resul=
ts
>>> in block query; and otherwise it doesn't actually matter what node we=

>>> created it on, really.
>>>
>>> I can move it over to the source, but the testing code has to get a
>>> little smarter in order to find the "right" anonymous bitmap, which i=
s
>>> not impossible; but I thought this would actually be a convenience fo=
r
>>> people.
>>
>> You didn=E2=80=99t really say whether you think it makes more sense on=
 the
>> source or on the target.
>>
>=20
> Yeah, a bitmap that isn't recording writes seems to make about equal
> sense on either to me; I chose the destination because it was more
> likely to be temporary (in the drive-backup case) and I considered this=

> a temporary bitmap for use by the job.
>=20
> Organizationally I felt that made sense. I realize it's also not
> strictly true for the blockdev-backup case, but it also doesn't matter
> terribly.
>=20
> Semantically, it's a toss-up. Another coder could conceivably one day
> decided to re-enable this bitmap and then it would make more sense on
> the source. (That coder would be wrong to do that.)

Hm.  If we had a filter node like we do for mirror, it should be there,
clearly.

=2E..is what I wanted to say.  But then I looked it up and found out that=

mirror actually still puts its bitmap on the source node.

Sure, one of the differences between backup and mirror is that backup=E2=80=
=99s
bitmap does not record writes and thus it functionally doesn=E2=80=99t ma=
tter
where it=E2=80=99s placed.  But why make mirror and backup behave more
differently than necessary?  They should be a single block job anyway.

>> So for me, it comes down to where it makes more sense.  And I think it=

>> makes more sense on the source, because it flags source clusters to co=
py.
>>
>> Max
>>
>=20
> If you insist.

I guess I kind of do, yes.

Max


--pvF8Ygn4xlPcKZ5jiBsXPZq83SC1hNvuM--

--VlfXKxKjmPlZQY4cKdzx7p7Czu544twt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0jjnwACgkQ9AfbAGHV
z0B1+AgAnUx6Ko7HHwkYx+lVkV9nJxbvFVqf9t2R9N/3RE4qWzM0We5IvkNhq2zW
gr2W+OvGRddbHWtlYtWRJ4QM2LujG2PkGUtQV07IY0DiqL/E3XdBbavUxAnvvtcb
MgVcXJQUoOdNbfQdOxT88F9Wa/BPICcV1opJRDb1CeJ0HByGR8ONV4CObFF4OGd1
0tdL1nKIAOh8wxzQBk7AMxsIq4G9b9CzgwaO5g1X6njL4zC7d3MkYGDh460Y9Hhk
33ZVLd0/eAYzfK5O6EWFFj8ltEpiNL0fKEgMsvDf4Z/p1avLOrc3luLEFSeiaNdH
zjw7LXxY6GEPKajysVAXoTpSX8evIw==
=+kGy
-----END PGP SIGNATURE-----

--VlfXKxKjmPlZQY4cKdzx7p7Czu544twt8--

