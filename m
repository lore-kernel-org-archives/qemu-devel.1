Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ABC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6302089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6302089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwNJ-0003df-RN
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIwMF-00034g-DI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIwMD-0002ae-Bf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:57:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIwM3-0002SE-AI; Fri, 11 Oct 2019 10:57:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EDC903082128;
 Fri, 11 Oct 2019 14:57:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 522805D71C;
 Fri, 11 Oct 2019 14:57:14 +0000 (UTC)
Subject: Re: [PATCH v2 04/16] qcow2: Keep unknown extra snapshot data
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
 <e0c477a9-7889-3042-382a-8cb511ea96b3@redhat.com>
 <72822609-d767-ace1-4a0c-6f6d0d7a361d@redhat.com>
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
Message-ID: <45f90b77-14c5-eec9-4298-abdcc22adb62@redhat.com>
Date: Fri, 11 Oct 2019 16:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <72822609-d767-ace1-4a0c-6f6d0d7a361d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YHEU6r5ZUy2VOszPtVTtE3Iwi5NFvjMWK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 14:57:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YHEU6r5ZUy2VOszPtVTtE3Iwi5NFvjMWK
Content-Type: multipart/mixed; boundary="mm649bOThEhm7Yg6FwdKJewv8AP8CAjjh"

--mm649bOThEhm7Yg6FwdKJewv8AP8CAjjh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 13:42, Max Reitz wrote:
> On 19.08.19 21:23, Eric Blake wrote:
>> On 8/19/19 1:55 PM, Max Reitz wrote:
>>> The qcow2 specification says to ignore unknown extra data fields in
>>> snapshot table entries.  Currently, we discard it whenever we update =
the
>>> image, which is a bit different from "ignore".
>>>
>>> This patch makes the qcow2 driver keep all unknown extra data fields
>>> when updating an image's snapshot table.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block/qcow2.h          |  5 ++++
>>>  block/qcow2-snapshot.c | 61 +++++++++++++++++++++++++++++++++++-----=
--
>>>  2 files changed, 56 insertions(+), 10 deletions(-)
>>>
>>
>>> @@ -162,7 +184,7 @@ static int qcow2_write_snapshots(BlockDriverState=
 *bs)
>>>          sn =3D s->snapshots + i;
>>>          offset =3D ROUND_UP(offset, 8);
>>>          offset +=3D sizeof(h);
>>> -        offset +=3D sizeof(extra);
>>> +        offset +=3D MAX(sizeof(extra), sn->extra_data_size);
>>
>> Why would we ever have less than sizeof(extra) bytes to write on outpu=
t,
>> since we always produce the fields on creation and synthesize the
>> missing fields of extra on read?  Can't you rewrite this as:
>>
>> assert(sn->extra_data_size >=3D sizeof(extra));
>> offset +=3D sn->extra_data_size;
>=20
> Hm, but I don=E2=80=99t prop up extra_data_size to be at least sizeof(e=
xtra).  I
> can do that, but it would add a few extra lines here and there.

On second thought, it doesn=E2=80=99t work at all because then there is n=
o way
to later detect whether the image is compliant or not.

Max


--mm649bOThEhm7Yg6FwdKJewv8AP8CAjjh--

--YHEU6r5ZUy2VOszPtVTtE3Iwi5NFvjMWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2gmEgACgkQ9AfbAGHV
z0D7Ogf9F+lCgLbAnbdwUeeKnIk4fJtwoOhm7BSzOMFhR8jxXU4bwltXWzQbhSFA
7u7NbNlCBFXe1aB7cEvNmt3sVDLqAJsXz9dSPMxkj1QTnIN+vEKcaXBvDBrljHKE
cScV2uaWcSMoMAGPCbRUDSlRWFrNNykKStC3+qcTyktwII9kwI9sWB42nzYJtqUE
L/KHfQI2OivwnTD9FK3Bdg4A7/GGCf2jCYSPjYVmhKmNah3eKldvPRcI9W8DqRC4
ZiYbg9BNoNsgaJzMly2d5TcksnizuvABLfpW3oLW4j9wZeBY4bxT4fM24D/vkm8t
rRcGTg+y13GztgrvFVXz75jfKodNRg==
=F7X6
-----END PGP SIGNATURE-----

--YHEU6r5ZUy2VOszPtVTtE3Iwi5NFvjMWK--

