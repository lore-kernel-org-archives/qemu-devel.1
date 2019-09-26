Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B6CC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF221A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRjH-00008o-Pf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDRi4-0007VX-I8
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDRi3-0007Jg-Dp
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDRi1-0007HV-1A; Thu, 26 Sep 2019 07:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49299A44AC4;
 Thu, 26 Sep 2019 11:13:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E769860C80;
 Thu, 26 Sep 2019 11:13:14 +0000 (UTC)
Subject: Re: [PATCH 09/22] quorum: Add QuorumChild.to_be_replaced
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-10-mreitz@redhat.com>
 <c5ae76f5-9b41-a00b-ef92-d419e334f660@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <7a3288f0-bd76-637f-143e-b6305cb8ecd3@redhat.com>
Date: Thu, 26 Sep 2019 13:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c5ae76f5-9b41-a00b-ef92-d419e334f660@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hJcjDBq5MdiZhDuQvVoa6qSsYRRiKNybO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 26 Sep 2019 11:13:16 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hJcjDBq5MdiZhDuQvVoa6qSsYRRiKNybO
Content-Type: multipart/mixed; boundary="rTv2ZCTJa7909hrqHaxVHe3UKb0cWi5Ot"

--rTv2ZCTJa7909hrqHaxVHe3UKb0cWi5Ot
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.09.19 15:45, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:
>> We will need this to verify that Quorum can let one of its children be=

>> replaced without breaking anything else.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/quorum.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/block/quorum.c b/block/quorum.c
>> index cf2171cc74..207054a64e 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
>>  =20
>>   typedef struct QuorumChild {
>>       BdrvChild *child;
>> +
>> +    /*
>> +     * If set, check whether this node can be replaced without any
>> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
>> +     * WRITE permission.
>> +     */
>> +    bool to_be_replaced;
>>   } QuorumChild;
>>  =20
>>   /* the following structure holds the state of one quorum instance */=

>> @@ -1128,6 +1135,16 @@ static void quorum_child_perm(BlockDriverState =
*bs, BdrvChild *c,
>>                                 uint64_t perm, uint64_t shared,
>>                                 uint64_t *nperm, uint64_t *nshared)
>>   {
>> +    BDRVQuorumState *s =3D bs->opaque;
>> +    int i;
>> +
>> +    for (i =3D 0; i < s->num_children; i++) {
>> +        if (s->children[i].child =3D=3D c) {
>> +            break;
>> +        }
>> +    }
>> +    assert(!c || i < s->num_children);
>=20
> seems, the loop is useless if c =3D=3D NULL.

Not wrong.  I=E2=80=99ll put it all into an if (c) and initialize i to -1=
=2E

Max


--rTv2ZCTJa7909hrqHaxVHe3UKb0cWi5Ot--

--hJcjDBq5MdiZhDuQvVoa6qSsYRRiKNybO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2MnUkACgkQ9AfbAGHV
z0DZ3wgAlMQLoTDL3Y31FBT2W1kspzkywdfTF9jShKmYfUO0kTlhOUChKjBJWwDG
W3dnLB4XbZf+XmVjP/+8YatkZqJ/fJ3BiO0rzCD5YpvJYxABDqRZmdQnrNyck/qi
0aKKFEOgc72FfQyXCQdxlTarChMGn2M/QdG2xz+hZ2opzhKp2qIm9Z/T+EPb9ZE/
13HNha4BlTniNGRwPaz1BznBEN69ktC9DB4GGe0my7/GMAlo6W0PlcaTGwLy81An
iW+g6XQN7cnAnQ6094MF7K6BhKx9C5PEnepBDsbNSmKoPSkiqQGA3eCfcIs7ADoM
P8Qc7Qp+j77nb3BFP48t5pZmILvr/w==
=aFCU
-----END PGP SIGNATURE-----

--hJcjDBq5MdiZhDuQvVoa6qSsYRRiKNybO--

