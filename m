Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666D6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF1420679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF1420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZYj-0006QM-Gw
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxZYJ-0005wE-0v
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxZYH-0007dO-L4
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxZYE-0007cR-Pc; Tue, 13 Aug 2019 12:21:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8BEE3083362;
 Tue, 13 Aug 2019 16:21:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AB6F18E35;
 Tue, 13 Aug 2019 16:21:32 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <20190813154122.GL4663@localhost.localdomain>
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
Message-ID: <f7a26ca9-2fa7-d217-fc43-d93ebe0d8063@redhat.com>
Date: Tue, 13 Aug 2019 18:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813154122.GL4663@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ueuCVnW1GvqJnx0OC14WC7KhTyCtmiEvF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 16:21:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueuCVnW1GvqJnx0OC14WC7KhTyCtmiEvF
Content-Type: multipart/mixed; boundary="JfE6ZvnV6mCwHcIXdQRZzYVLL8O4w21a7";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org
Message-ID: <f7a26ca9-2fa7-d217-fc43-d93ebe0d8063@redhat.com>
Subject: Re: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <20190813154122.GL4663@localhost.localdomain>
In-Reply-To: <20190813154122.GL4663@localhost.localdomain>

--JfE6ZvnV6mCwHcIXdQRZzYVLL8O4w21a7
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 17:41, Kevin Wolf wrote:
> Am 13.08.2019 um 16:43 hat Max Reitz geschrieben:
>> On 13.08.19 13:04, Kevin Wolf wrote:
>>> Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to
>>>> returned file. But is it correct behavior at all? If returned file
>>>> itself has a backing file, we may report as totally unallocated and
>>>> area which actually has data in bottom backing file.
>>>>
>>>> So, mirroring of qcow2 under raw-format is broken. Which is illustra=
ted
>>>> by following commit with a test. Let's make raw-format behave more
>>>> correctly returning BDRV_BLOCK_DATA.
>>>>
>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>
>>> After some reading, I think I came to the conclusion that RAW is the
>>> correct thing to do. There is indeed a problem, but this patch is try=
ing
>>> to fix it in the wrong place.
>>>
>>> In the case where the backing file contains some data, and we have a
>>> 'raw' node above the qcow2 overlay node, the content of the respectiv=
e
>>> block is not defined by the queried backing file layer, so it is
>>> completely correct that bdrv_is_allocated() returns false,like it wou=
ld
>>> if you queried the qcow2 layer directly.
>>
>> I disagree.  The queried backing file layer is the raw node.  As I sai=
d,
>> in my opinion raw nodes are not filter nodes, neither in behavior (the=
y
>> have an offset option), nor in how they are generally used (as a forma=
t).
>>
>> The raw format does not support backing files.  Therefore, everything =
on
>> a raw node is allocated.
>>
>> (That is, like, my opinion.)
>>
>>>                                          If it returned true, we woul=
d
>>> copy everything, which isn't right either (the test cases should may =
add
>>> the qemu-img map output of the target so this becomes visible).
>>
>> It is right.
>=20
> So we don't even agree what mirroring the raw node should even mean.
>=20
> I can the see your point when you say that the raw node has no backing
> file, so everything should be copied. But I can also see the point that=

> the raw node can really just be used as a filter that limits the data
> exposed from the qcow2 layer, and you want to keep the copy a COW
> overlay over the same backing file.

But it is not a filter.  If you limit the data by using an offset, that
precisely makes it not a filter.

> Both are valid use cases in principle and there is no single right or
> wrong.

I don=92t get what you mean because raw is not a filter.

If it were a filter, it=92d be clear: Regarding allocation information, w=
e
skip it.  But it isn=92t.  Hence we cannot skip it.

I don=92t see why you=92re trying to make the point with raw, when it sim=
ply
is not a filter.


> We don't currently support the latter use case because we have only
> sync=3Dfull or sync=3Dtop, but if you could specify a base node instead=
, we
> could probably suport the case without all of the special-casing filter=

> nodes and backing file childs.

This sounds like it=92d be difficult to special-case filter nodes.  It is=
n=92t.

Whenever the user specifies some node that should refer to a backing
chain element, all you do is call bdrv_skip_rw_filters() and you land at
the corresponding COW node.

> You would call bdrv_co_block_status_above() with the right base node an=
d
> it would just recurse whereever the data is stored, be it bs->backing,
> bs->file or even driver-specific children. This would allow you to find=

> out whether some block in the top node came from the base node that
> we're going to keep. If yes, skip it; if no, copy it.
>=20
> This way we wouldn't have to decide whether raw is a filter or not,

Well, it isn=92t.

> because it wouldn't make a difference. The behaviour would only depend
> on the base node given by the user. If you specified the top-level qcow=
2
> file as the base, you get your full copy; if you specified the backing
> qcow2, you get the partial copy where the target still uses the same
> backing file.

I simply do not see your point.

For two reasons:

(1) I don=92t think anyone should use is_allocate on nodes that are not
COW nodes.  They are likely to be doing something wrong then.

You don=92t seem to agree, because you say this makes the callers
complicated.  What I think is that we don=92t have that many callers, and=

it=92s probably a good thing when they have to think about the backing
chain structure.

But anyway.

(2) What I understand is that you propose adding some way to find out
the next element in the COW chain if is_allocated returns false.  Well,
my =93Deal with filters=94 series adds two ways to do that:

- bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs)) will return the first
child behind the COW node, but that may be another filter.

- bdrv_backing_chain_next(bs) will return =93the first non-filter backing=

image of the first non-filter image.=94.  It=92s just
bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs))).

So the thing is, we don=92t need to modify block_status to return that
information.  If is_allocated returns that something is not allocated,
the caller can just call one of these and thus get the next node where
to look.

When it comes to bdrv_is_allocated_above(), my series fixes that anyway,
no?  (In the sense that it does not choke on filters.)


So I cannot see how it does not come down to the callers.

Max


--JfE6ZvnV6mCwHcIXdQRZzYVLL8O4w21a7--

--ueuCVnW1GvqJnx0OC14WC7KhTyCtmiEvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1S44oACgkQ9AfbAGHV
z0B9lggAs2c9pqsl0+VxSgbbJ/nTC8actmTsBxYPujvxCtEg4G/ef+UqSKbVgJNI
50f63tKdwkFgwgxZLTX7TeEWV0gLrY4Cto3URnQ09LVLHNg82q+T/TDiWns2Z71j
tdrf8vROVTXaRK8JzLQAT2d6LgE0l7j82HF06vCw9gHpLC59ejuiDLrY4X8QyrZ1
3v/ebGBNsxN5H4ypGJnL7xNcsj8IMTO3/F5MSxaSj8L13KCGN/GPOthzh1WW+F3F
TrR2omuyLCUXIs/XPaitFzZ4bZn5EFx6pXEw5C1PK+FMS0E5GiS8VJdwGPmIrvW8
GPb2I5Y7CmUxHnR4ues63LWL+g1FiA==
=Muj7
-----END PGP SIGNATURE-----

--ueuCVnW1GvqJnx0OC14WC7KhTyCtmiEvF--

