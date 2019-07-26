Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B4C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE93821994
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE93821994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxwh-00050l-2E
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqxwU-0004ZS-KI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqxwP-0005a3-6q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqxwH-000504-7v; Fri, 26 Jul 2019 06:59:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7977D307D985;
 Fri, 26 Jul 2019 10:59:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E821001B02;
 Fri, 26 Jul 2019 10:58:59 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-4-mreitz@redhat.com>
 <20190726090432.x6hk3rt57jip7iwu@steredhat>
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
Message-ID: <dbd3dd12-8baa-b27e-59cf-966f5ddc83e4@redhat.com>
Date: Fri, 26 Jul 2019 12:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726090432.x6hk3rt57jip7iwu@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jw2pBaloo1x92utgnBpav3yb6j794vruw"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 26 Jul 2019 10:59:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Add
 bdrv_has_zero_init_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jw2pBaloo1x92utgnBpav3yb6j794vruw
Content-Type: multipart/mixed; boundary="ILYWcwKVy2XTE7lPwPd9mQT93qsgO2Npa";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <dbd3dd12-8baa-b27e-59cf-966f5ddc83e4@redhat.com>
Subject: Re: [PATCH v2 03/11] block: Add bdrv_has_zero_init_truncate()
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-4-mreitz@redhat.com>
 <20190726090432.x6hk3rt57jip7iwu@steredhat>
In-Reply-To: <20190726090432.x6hk3rt57jip7iwu@steredhat>

--ILYWcwKVy2XTE7lPwPd9mQT93qsgO2Npa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.19 11:04, Stefano Garzarella wrote:
> On Wed, Jul 24, 2019 at 07:12:31PM +0200, Max Reitz wrote:
>> No .bdrv_has_zero_init() implementation returns 1 if growing the file
>> would add non-zero areas (at least with PREALLOC_MODE_OFF), so using i=
t
>> in lieu of this new function was always safe.
>>
>> But on the other hand, it is possible that growing an image that is no=
t
>> zero-initialized would still add a zero-initialized area, like when
>> using nonpreallocating truncation on a preallocated image.  For caller=
s
>> that care only about truncation, not about creation with potential
>> preallocation, this new function is useful.
>>
>> Alternatively, we could have added a PreallocMode parameter to
>> bdrv_has_zero_init().  But the only user would have been qemu-img
>> convert, which does not have a plain PreallocMode value right now -- i=
t
>> would have to parse the creation option to obtain it.  Therefore, the
>> simpler solution is to let bdrv_has_zero_init() inquire the
>> preallocation status and add the new bdrv_has_zero_init_truncate() tha=
t
>> presupposes PREALLOC_MODE_OFF.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block.h     |  1 +
>>  include/block/block_int.h |  7 +++++++
>>  block.c                   | 21 +++++++++++++++++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 50a07c1c33..5321d8afdf 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -438,6 +438,7 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset=
, int64_t bytes);
>>  int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)=
;
>>  int bdrv_has_zero_init_1(BlockDriverState *bs);
>>  int bdrv_has_zero_init(BlockDriverState *bs);
>> +int bdrv_has_zero_init_truncate(BlockDriverState *bs);
>>  bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
>>  bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>>  int bdrv_block_status(BlockDriverState *bs, int64_t offset,
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 6a0b1b5008..d7fc6b296b 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -420,9 +420,16 @@ struct BlockDriver {
>>      /*
>>       * Returns 1 if newly created images are guaranteed to contain on=
ly
>>       * zeros, 0 otherwise.
>> +     * Must return 0 if .bdrv_has_zero_init_truncate() returns 0.
>>       */
>=20
> Does it make sense to make sure of that in the bdrv_has_zero_init()?
>=20
> I mean something like this:
>=20
> int bdrv_has_zero_init(BlockDriverState *bs)
> {
>     ...
>     if (bs->drv->bdrv_has_zero_init && bs->drv->bdrv_has_zero_init_trun=
cate) {
>         return bs->drv->bdrv_has_zero_init_truncate(bs) &&
>                bs->drv->bdrv_has_zero_init(bs);
>     } else if (bs->drv->bdrv_has_zero_init)
>         return bs->drv->bdrv_has_zero_init(bs);
>     }
>     ...
> }

I thought about it, but I didn=E2=80=99t like it because that would mean =
that
bdrv_has_zero_init() kind of differs from .bdrv_has_zero_init().

Max

> Thanks,
> Stefano
>=20
>>      int (*bdrv_has_zero_init)(BlockDriverState *bs);
>> =20
>> +    /*
>> +     * Returns 1 if new areas added by growing the image with
>> +     * PREALLOC_MODE_OFF contain only zeros, 0 otherwise.
>> +     */
>> +    int (*bdrv_has_zero_init_truncate)(BlockDriverState *bs);
>> +
>>      /* Remove fd handlers, timers, and other event loop callbacks so =
the event
>>       * loop is no longer in use.  Called with no in-flight requests a=
nd in
>>       * depth-first traversal order with parents before child nodes.
>> diff --git a/block.c b/block.c
>> index cbd8da5f3b..81ae44dcf3 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5066,6 +5066,27 @@ int bdrv_has_zero_init(BlockDriverState *bs)
>>      return 0;
>>  }
>> =20
>> +int bdrv_has_zero_init_truncate(BlockDriverState *bs)
>> +{
>> +    if (!bs->drv) {
>> +        return 0;
>> +    }
>> +
>> +    if (bs->backing) {
>> +        /* Depends on the backing image length, but better safe than =
sorry */
>> +        return 0;
>> +    }
>> +    if (bs->drv->bdrv_has_zero_init_truncate) {
>> +        return bs->drv->bdrv_has_zero_init_truncate(bs);
>> +    }
>> +    if (bs->file && bs->drv->is_filter) {
>> +        return bdrv_has_zero_init_truncate(bs->file->bs);
>> +    }
>> +
>> +    /* safe default */
>> +    return 0;
>> +}
>> +
>>  bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
>>  {
>>      BlockDriverInfo bdi;
>> --=20
>> 2.21.0
>>
>=20



--ILYWcwKVy2XTE7lPwPd9mQT93qsgO2Npa--

--jw2pBaloo1x92utgnBpav3yb6j794vruw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl063PIACgkQ9AfbAGHV
z0AGbQf/Qp36rwp213R5c1jwOEWegNdLzCrnXubS8KnzYp6BgPc8PiukJLh3a74S
eyfB4PNYRj+sH/qQx7hrGM0wZaTh6W2+9PQQS+ip7om5Vu6zF6xAp/osZ1DKkuTJ
+BcfIejbXwNqNfjrQpsXKzWHqfIvoo5vk5Qhm+kP8w36XdABbhXww6Q0p94bWjNb
HIn3u5AvJUeDkQ1SBNGslPaRTACEBDRv7Jc4pZ2KQbBfNtaZEXSysLl6F8HVgBlo
4vKyPTjIp8tdXhOxXwzL8bG6yqVv3Pzma6F71h2T3bEIYSCHqfOvKdB/yDgvD4eu
3DSjeTtOORPJBzL2BRU1Nbw/Ou7/1g==
=Xf19
-----END PGP SIGNATURE-----

--jw2pBaloo1x92utgnBpav3yb6j794vruw--

