Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F28C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D97B2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D97B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxFoE-0006A4-Dj
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxFnG-0005Ud-Lb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxFnF-0005Sh-Gp
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxFnB-0005RT-Q0; Mon, 12 Aug 2019 15:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20DE0300CB2B;
 Mon, 12 Aug 2019 19:15:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E93B65C548;
 Mon, 12 Aug 2019 19:15:39 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <c5571509-98ed-b99d-37fe-39a1067105cd@virtuozzo.com>
 <4a2b0a48-5ee0-85b7-7519-a3633cefd803@redhat.com>
 <994ec2e4-23fe-58d2-bc4e-120ec1e89d25@virtuozzo.com>
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
Message-ID: <42ba1ef7-0073-42f6-76f1-b3537f56f96b@redhat.com>
Date: Mon, 12 Aug 2019 21:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <994ec2e4-23fe-58d2-bc4e-120ec1e89d25@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CKHfB6n1nD2Gla4h4W2jXNyq70y7wtfZv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 19:15:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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
--CKHfB6n1nD2Gla4h4W2jXNyq70y7wtfZv
Content-Type: multipart/mixed; boundary="ZTODKkm6ryCmxaomHX9jH8rf8o48mB8HC";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <42ba1ef7-0073-42f6-76f1-b3537f56f96b@redhat.com>
Subject: Re: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <c5571509-98ed-b99d-37fe-39a1067105cd@virtuozzo.com>
 <4a2b0a48-5ee0-85b7-7519-a3633cefd803@redhat.com>
 <994ec2e4-23fe-58d2-bc4e-120ec1e89d25@virtuozzo.com>
In-Reply-To: <994ec2e4-23fe-58d2-bc4e-120ec1e89d25@virtuozzo.com>

--ZTODKkm6ryCmxaomHX9jH8rf8o48mB8HC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 19:14, Vladimir Sementsov-Ogievskiy wrote:
> 12.08.2019 16:09, Max Reitz wrote:
>> On 10.08.19 18:41, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.08.2019 19:13, Max Reitz wrote:
>>>> If the driver does not implement bdrv_get_allocated_file_size(), we
>>>> should fall back to cumulating the allocated size of all non-COW
>>>> children instead of just bs->file.
>>>>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    block.c | 22 ++++++++++++++++++++--
>>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index 1070aa1ba9..6e1ddab056 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -4650,9 +4650,27 @@ int64_t bdrv_get_allocated_file_size(BlockDri=
verState *bs)
>>>>        if (drv->bdrv_get_allocated_file_size) {
>>>>            return drv->bdrv_get_allocated_file_size(bs);
>>>>        }
>>>> -    if (bs->file) {
>>>> -        return bdrv_get_allocated_file_size(bs->file->bs);
>>>> +
>>>> +    if (!QLIST_EMPTY(&bs->children)) {
>>>> +        BdrvChild *child;
>>>> +        int64_t child_size, total_size =3D 0;
>>>> +
>>>> +        QLIST_FOREACH(child, &bs->children, next) {
>>>> +            if (child =3D=3D bdrv_filtered_cow_child(bs)) {
>>>> +                /* Ignore COW backing files */
>>>> +                continue;
>>>> +            }
>>>> +
>>>> +            child_size =3D bdrv_get_allocated_file_size(child->bs);=

>>>> +            if (child_size < 0) {
>>>> +                return child_size;
>>>> +            }
>>>> +            total_size +=3D child_size;
>>>> +        }
>>>> +
>>>> +        return total_size;
>>>>        }
>>>> +
>>>>        return -ENOTSUP;
>>>>    }
>>>>   =20
>>>>
>>>
>>> Hmm..
>>>
>>> 1. No children -> -ENOTSUP
>>> 2. Only cow child -> 0
>>> 3. Some non-cow children -> SUM
>>>
>>> It's all arguable (the strictest way is -ENOTSUP in either case),
>>> but if we want to fallback to SUM of non-cow children, 1. and 2. shou=
ld return
>>> the same.
>>
>> I don=E2=80=99t think 2 is possible at all.  If you have a COW child, =
you need
>> some other child to COW to.
>>
>> And in the weird (and probably impossible) case where a node really on=
ly
>> has a COW child, I=E2=80=99d say it=E2=80=99s correct that it has a di=
sk size of 0 =E2=80=93
>> because it hasn=E2=80=99t COWed anything yet.  (Just like a new qcow2 =
image with
>> a backing file only has its metadata as its disk size.)
>>
>=20
> Agreed. Then, why not return 0 on [1] ?

(1) Because that=E2=80=99s the current behavior. :-)

(2) Nodes that have no children are protocol nodes.  Protocol nodes
(apart from null) still have to store their data somewhere.  Therefore,
they must implement .bdrv_get_allocated_file_size() to report that.  If
they don=E2=80=99t, that doesn=E2=80=99t mean they don=E2=80=99t store an=
y data, but only that
we don=E2=80=99t know how much data they store.

> Also, another idea: shouldn't we return 0 for filters, i.e. skip filter=
ed_rw_child too?
> [as filtered-child is more like backing child than file one, it's "less=
 owned" by its parent]

Why would we do that?  If I have a block device with a throttle node
attached to it and request how much space it uses, of course I will want
to know how much space the whole tree below it uses.

(Otherwise, bdrv_get_allocated_file_size() should only report anything
for protocol nodes, and 0 for everything else.)

Max

> with or without any of these suggestions:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>




--ZTODKkm6ryCmxaomHX9jH8rf8o48mB8HC--

--CKHfB6n1nD2Gla4h4W2jXNyq70y7wtfZv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RutoACgkQ9AfbAGHV
z0D6WwgAhPQXJJpuknuRDiAF6GI5pQksvvNy7AVbl+Dsi5L4Xi10bWYFf8p1Q4mW
e529Ha0IjQiPrDwQW2gI6MRmpRV8p8JHqOlpHlY+tCfVxYDveYz7pbHjNOfG1g+J
z6d4ryi4mEjRIvev1bRusqzg2sDkkrC+OSSLCCxa7/Rhpo64ncyUv2Q8pTOy6rgh
PPAyiwdWx384W22Yexvk0IrFzQyepGzmHzE0LEYP6DNQwpfmivB5OuweGKT+PUxR
pmG6279zcWs+9e0WdOkC2RYeGN4NpoY/16m3NSVxiw+7zBzgjBimWp0gNQY4EOpR
elim0Zzy6nDMWPnREXHO8BrAjorTFw==
=3IAy
-----END PGP SIGNATURE-----

--CKHfB6n1nD2Gla4h4W2jXNyq70y7wtfZv--

