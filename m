Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64826C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E372063F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 15:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E372063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxupY-0007Ru-AR
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 11:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hxuob-0006w4-6c
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxuoZ-0000v4-Gv
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 11:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxuoW-0000tc-Ef; Wed, 14 Aug 2019 11:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86F648EB53;
 Wed, 14 Aug 2019 15:03:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8025C1D4;
 Wed, 14 Aug 2019 15:03:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
 <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
 <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
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
Message-ID: <c846caa9-2f7c-70e5-5a5c-6a41c5027895@redhat.com>
Date: Wed, 14 Aug 2019 17:03:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VTZ5idRpFshaWAzss8HVbf8cg2b9te0K5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 14 Aug 2019 15:03:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/qcow2: refactor
 qcow2_co_preadv_part
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VTZ5idRpFshaWAzss8HVbf8cg2b9te0K5
Content-Type: multipart/mixed; boundary="5qTOUYxaVRKGMqJpB0VN7roASU3XToL5e";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <c846caa9-2f7c-70e5-5a5c-6a41c5027895@redhat.com>
Subject: Re: [PATCH v2 2/4] block/qcow2: refactor qcow2_co_preadv_part
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
 <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
 <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
In-Reply-To: <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>

--5qTOUYxaVRKGMqJpB0VN7roASU3XToL5e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.08.19 11:11, Vladimir Sementsov-Ogievskiy wrote:
> 14.08.2019 0:31, Max Reitz wrote:
>> On 30.07.19 16:18, Vladimir Sementsov-Ogievskiy wrote:
>>> Further patch will run partial requests of iterations of
>>> qcow2_co_preadv in parallel for performance reasons. To prepare for
>>> this, separate part which may be parallelized into separate function
>>> (qcow2_co_preadv_task).
>>>
>>> While being here, also separate encrypted clusters reading to own
>>> function, like it is done for compressed reading.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   qapi/block-core.json |   2 +-
>>>   block/qcow2.c        | 206 +++++++++++++++++++++++-----------------=
---
>>>   2 files changed, 112 insertions(+), 96 deletions(-)
>>
>> Looks good to me overall, just wondering about some details, as always=
=2E
>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 93ab7edcea..7fa71968b2 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1967,17 +1967,115 @@ out:
>>>       return ret;
>>>   }
>>>  =20
>>> +static coroutine_fn int
>>> +qcow2_co_preadv_encrypted(BlockDriverState *bs,
>>> +                           uint64_t file_cluster_offset,
>>> +                           uint64_t offset,
>>> +                           uint64_t bytes,
>>> +                           QEMUIOVector *qiov,
>>> +                           uint64_t qiov_offset)
>>> +{
>>> +    int ret;
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    uint8_t *buf;
>>> +
>>> +    assert(bs->encrypted && s->crypto);
>>> +    assert(bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
>>> +
>>> +    /*
>>> +     * For encrypted images, read everything into a temporary
>>> +     * contiguous buffer on which the AES functions can work.
>>> +     * Note, that we can implement enctyption, working on qiov,
>>
>> -, and s/enctyption/encryption/
>>
>>> +     * but we must not do decryption in guest buffers for security
>>> +     * reasons.
>>
>> "for security reasons" is a bit handwave-y, no?
>=20
> Hmm, let's think of it a bit.
>=20
> WRITE
>=20
> 1. We can't do any operations on write buffers, as guest may use them f=
or
> something else and not prepared for their change. [thx to Den, pointed =
to this fact]

Yep.  So we actually cannot implement encryption in the guest buffer. :-)=


> READ
>=20
> Hmm, here otherwise, guest should not expect something meaningful in bu=
ffers until the
> end of read operation, so theoretically we may decrypt directly in gues=
t buffer.. What is
> bad with it?
>=20
> 1. Making read-part different from write and implementing support of qi=
ov for decryptin for
> little outcome (hmm, don't double allocation for reads, is it little or=
 not? [*]).
>=20
> 2. Guest can read its buffers.
> So, it may see encrypted data and guess something about it. Ideally gue=
st
> should know nothing about encryption, but on the other hand, is there a=
ny
> real damage? I don't sure..
>=20
> 3. Guest can modify its buffers.
> 3.1 I think there is no guarantee that guest will not modify its data b=
efore we finished
> copying to separate buffer, so what guest finally reads is not predicta=
ble anyway.
> 3.2 But, modifying during decryption may possibly lead to guest visible=
 error
> (which will never be if we operate on separated cluster)
>=20
> So if we don't afraid of [2] and [3.2], and in a specific case [*] is s=
ignificant, we may want
> implement decryption on guest buffers at least as an option..
> But all it looks for me like we'll never do it.

Well, I do think it would be weird from a guest perspective to see data
changing twice.  I just couldn=E2=80=99t figure out what the security pro=
blem
might be.

> =3D=3D=3D
>=20
> So, I'd rewrite my "Note" like this:
>=20
>     Also, decryption in separate buffer is better as it hides from the =
guest information
>     it doesn't own (about encrypted nature of virtual disk).

Sounds good.

>> [...]
>>
>>> +static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
>>> +                                             QCow2ClusterType cluste=
r_type,
>>> +                                             uint64_t file_cluster_o=
ffset,
>>> +                                             uint64_t offset, uint64=
_t bytes,
>>> +                                             QEMUIOVector *qiov,
>>> +                                             size_t qiov_offset)
>>> +{
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    int offset_in_cluster =3D offset_into_cluster(s, offset);
>>> +
>>> +    switch (cluster_type) {
>>
>> [...]
>>
>>> +    default:
>>> +        g_assert_not_reached();
>>> +        /*
>>> +         * QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC han=
dled
>>> +         * in qcow2_co_preadv_part
>>
>> Hmm, I=E2=80=99d still add them explicitly as cases and put their own
>> g_assert_not_reach() there.
>>
>>> +         */
>>> +    }
>>> +
>>> +    g_assert_not_reached();
>>> +
>>> +    return -EIO;
>>
>> Maybe abort()ing instead of g_assert_not_reach() would save you from
>> having to return here?
>>
>=20
> Hmm, will check. Any reason to use g_assert_not_reached() instead of ab=
ort() in "default"?

g_assert_not_reached() makes it more explicit what it=E2=80=99s about.

> I just kept it like it was. But it seems to be more often practice to u=
se just abort() in
> Qemu code.

Yes, we often use abort() instead because it always has _Noreturn (and
thus saves us from such useless return statements).

Max


--5qTOUYxaVRKGMqJpB0VN7roASU3XToL5e--

--VTZ5idRpFshaWAzss8HVbf8cg2b9te0K5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1UIscACgkQ9AfbAGHV
z0Dxiwf/XA0V4KEaYRXqZUEdgxt3TJWhuWZEODPq1vGM50I7NkQaKVU1JE6ygm8U
5aR/eAAcuFLunoiIpvrzRAozs3g2iGaMkrpV2O8DygZP85r3cbFFVHzASty9r14L
D4ikuAmpffycXfmvSMzX05DQDlN+0rWBXVCTUxF04JqHB2WM79UYw7amxjPFx/sT
5XVDJlhkpKxs6ZNBSb+43At0O6z1ggD0Uiw9JlPqjBRTdzbuooBM21W0rcH7krsd
8k3sS0ifRp8xa4Jn2qB3QU40jQVS7ZXcSAI/UJq+fyJ2upFBF9kDojUKqQAw1o8F
Y/XHx1aHTG8w2U61GZ7Io/fAuorxPg==
=VAnn
-----END PGP SIGNATURE-----

--VTZ5idRpFshaWAzss8HVbf8cg2b9te0K5--

