Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9ADC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F3020645
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F3020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTym-0006Jj-NJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbSLG-00067T-VW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbSLE-0008Lp-Bp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:12:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbSL4-0006cw-4C; Thu, 13 Jun 2019 12:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65C1A3091D73;
 Thu, 13 Jun 2019 16:12:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 292335C29A;
 Thu, 13 Jun 2019 16:12:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <4c6524b7-2feb-2b92-6929-54629ece1e29@virtuozzo.com>
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
Message-ID: <25f94c28-0f03-f2dc-9a26-314af8d0937f@redhat.com>
Date: Thu, 13 Jun 2019 18:12:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4c6524b7-2feb-2b92-6929-54629ece1e29@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F0sGjpUmDV4JYDZEXBJCt1l6gZmvpwWAi"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 13 Jun 2019 16:12:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 00/42] block: Deal with filters
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
--F0sGjpUmDV4JYDZEXBJCt1l6gZmvpwWAi
Content-Type: multipart/mixed; boundary="akisZMwe7H8xHkd8U3UKV2NwnzOfMQWi5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <25f94c28-0f03-f2dc-9a26-314af8d0937f@redhat.com>
Subject: Re: [PATCH v5 00/42] block: Deal with filters
References: <20190612221004.2317-1-mreitz@redhat.com>
 <4c6524b7-2feb-2b92-6929-54629ece1e29@virtuozzo.com>
In-Reply-To: <4c6524b7-2feb-2b92-6929-54629ece1e29@virtuozzo.com>

--akisZMwe7H8xHkd8U3UKV2NwnzOfMQWi5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 17:28, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Hi,
>>
>> When we introduced filters, we did it a bit casually.  Sure, we talked=
 a
>> lot about them before, but that was mostly discussion about where
>> implicit filters should be added to the graph (note that we currently
>> only have two implicit filters, those being mirror and commit).  But i=
n
>> the end, we really just designated some drivers filters (Quorum,
>> blkdebug, etc.) and added some specifically (throttle, COR), without
>> really looking through the block layer to see where issues might occur=
=2E
>>
>> It turns out vast areas of the block layer just don=E2=80=99t know abo=
ut filters
>> and cannot really handle them.  Many cases will work in practice, in
>> others, well, too bad, you cannot use some feature because some part
>> deep inside the block layer looks at your filters and thinks they are
>> format nodes.
>>
>> This is one reason why this series is needed.  Over time (since v1), a=

>> second reason has made its way in:
>>
>> bs->file is not necessarily the place where a node=E2=80=99s data is s=
tored.
>> qcow2 now has external data files, and currently there is no way for t=
he
>> general block layer to know that the data is not stored in bs->file.
>> Right now, I do not think that has any real consequences (all function=
s
>> that need access to the actual data storage file should only do so as =
a
>> fallback if the driver does not provide some functionality, but qcow2
>> should provide it all), but it still shows that we need some way to le=
t
>> the general block layer know about such data files.  (Also, I will nee=
d
>> this for v1 of my =E2=80=9CInquire images=E2=80=99 rotational info=E2=80=
=9D series.)
>>
>> I won=E2=80=99t go on and on about this series now, I think the patche=
s pretty
>> much speak for themselves now.  If the cover letter gets too long,
>> nobody reads it anyway (see previous versions).
>>
>>
>> *** This series depends on some others. ***
>>
>> Dependencies:
>> - [PATCH 0/4] block: Keep track of parent quiescing
>> - [PATCH 0/2] vl: Drain before (block) job cancel when quitting
>> - [PATCH v2 0/2] blockdev: Overlays are not snapshots
>>
>> Based-on: <20190605161118.14544-1-mreitz@redhat.com>
>> Based-on: <20190612220839.1374-1-mreitz@redhat.com>
>> Based-on: <20190603202236.1342-1-mreitz@redhat.com>
>=20
> Could you please export a branch?

Sure:

https://git.xanclic.moe/XanClic/qemu child-access-functions-v5
Or:
https://github.com/XanClic/qemu child-access-functions-v5


(And the base branch is:

https://git.xanclic.moe/XanClic/qemu child-access-functions-base
https://github.com/XanClic/qemu child-access-functions-base
)

>> v5:
>> - Split the huge patches 2 and 3 from the previous version into many
>>    smaller patches to maintain the potential reviewers=E2=80=99 sanity=
 [Vladimir]
>=20
> Thank you! In spite of frightening amount of patches, reviewing became =
a lot
> simpler.

I had hoped making it exactly 42 patches would make it a bit more welcomi=
ng.

Again, thanks a lot for reviewing!

Max


--akisZMwe7H8xHkd8U3UKV2NwnzOfMQWi5--

--F0sGjpUmDV4JYDZEXBJCt1l6gZmvpwWAi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CddYACgkQ9AfbAGHV
z0BZ0gf+KIjoyUTV01nLvD5wquA6Jh4OVIuwSkN/XUFghDRt18BwbBCciXKDgTiX
j4W8B6lL3kPvyouUFoTNRpT7ion96zfARuVWWBN4yBNNIXlTM3/DI1oERJY4zVxF
Ypl6HJfKxuAFbsxEFueXI82hVUHQTyNk+ftRhDKvUC7fH8rSvjrANOM0FvjJO/jH
OpNreil7QD48Kp7IxFcJbVfqfe/DBQwmow6jl+BHxyFgRnlVjf7xGqWAHGWf5CNr
jqx3d3dsx8xGtKCsGKACtY1uGysXqaHbLTULmRbSzb41q4xh1LIn7Z5onXX+aDGT
N3M2Y2R8ADY4np5ZBd13zELihlFcNQ==
=2SSg
-----END PGP SIGNATURE-----

--F0sGjpUmDV4JYDZEXBJCt1l6gZmvpwWAi--

