Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA495C742B2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC152084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC152084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltN1-0003GQ-Tz
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hltMr-0002mn-4F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hltMq-0001Qz-0k
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hltMn-0001OB-DM; Fri, 12 Jul 2019 07:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A373E308AA11;
 Fri, 12 Jul 2019 11:05:28 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B245600CD;
 Fri, 12 Jul 2019 11:05:24 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-4-mreitz@redhat.com>
 <20190712100439.GD4514@dhcp-200-226.str.redhat.com>
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
Message-ID: <9a9b84db-9fed-d3a9-7adc-10220be8123b@redhat.com>
Date: Fri, 12 Jul 2019 13:05:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712100439.GD4514@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ud8m5AGEnowiNOXGenR0IMFsg31QlcVlq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 12 Jul 2019 11:05:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 3/5] block: Fall back to fallback truncate
 function
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ud8m5AGEnowiNOXGenR0IMFsg31QlcVlq
Content-Type: multipart/mixed; boundary="OLXP2R3qCifxpFR67s2xIuirHBRlp3E1Y";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9a9b84db-9fed-d3a9-7adc-10220be8123b@redhat.com>
Subject: Re: [RFC 3/5] block: Fall back to fallback truncate function
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-4-mreitz@redhat.com>
 <20190712100439.GD4514@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190712100439.GD4514@dhcp-200-226.str.redhat.com>

--OLXP2R3qCifxpFR67s2xIuirHBRlp3E1Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.07.19 12:04, Kevin Wolf wrote:
> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
>> file-posix does not need to basically duplicate our fallback truncate
>> implementation; and sheepdog can fall back to it for "shrinking" files=
=2E
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 21 +--------------------
>>  block/sheepdog.c   |  2 +-
>>  2 files changed, 2 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index ab05b51a66..bcddfc7fbe 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2031,23 +2031,7 @@ static int coroutine_fn raw_co_truncate(BlockDr=
iverState *bs, int64_t offset,
>>          return raw_regular_truncate(bs, s->fd, offset, prealloc, errp=
);
>>      }
>=20
> The only thing that is left here is a fstat() check to see that we
> really have a regular file here. But since this function is for the
> 'file' driver, we can just assume this and the function can go away
> altogether.
>=20
> In fact, 'file' with block/character devices has been deprecated since
> 3.0, so we can just remove support for it now and make it more than jus=
t
> an assumption.
>=20
>> diff --git a/block/sheepdog.c b/block/sheepdog.c
>> index 6f402e5d4d..4af4961cb7 100644
>> --- a/block/sheepdog.c
>> +++ b/block/sheepdog.c
>> @@ -2301,7 +2301,7 @@ static int coroutine_fn sd_co_truncate(BlockDriv=
erState *bs, int64_t offset,
>>      max_vdi_size =3D (UINT64_C(1) << s->inode.block_size_shift) * MAX=
_DATA_OBJS;
>>      if (offset < old_size) {
>>          error_setg(errp, "shrinking is not supported");
>> -        return -EINVAL;
>> +        return -ENOTSUP;
>>      } else if (offset > max_vdi_size) {
>>          error_setg(errp, "too big image size");
>>          return -EINVAL;
>=20
> The image will be unchanged and the guest will keep seeing the old imag=
e
> size, so is there any use case where having the fallback here makes
> sense? The only expected case where an image is shrunk is that the user=

> explicitly sent block_resize - and in that case returning success, but
> doing nothing achieves nothing except confusing the user.
>=20
> file-posix has the same confusing case, but at least it also has cases
> where the fake truncate actually achieves something (such a allowing to=

> create images on block devices).

Hm, yes, that=E2=80=99s right.  It is as confusing for block devices, but=
 that
at least gives something in return.  For sheepdog (and others, like
ssh), there is nothing in return.

Explaining for every block driver why it needs to be a bit confusing and
fall back to the fixed-size device implementation (because it doesn=E2=80=
=99t
implement creation) seems a bit off, too.

Hm.  Maybe the protocol creation fallback should just ignore failures
when truncating an image and in such a case zero the first sector of the
image?  Maybe it should just ignore ENOTSUP errors?

Max


--OLXP2R3qCifxpFR67s2xIuirHBRlp3E1Y--

--Ud8m5AGEnowiNOXGenR0IMFsg31QlcVlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0oaXMACgkQ9AfbAGHV
z0B0PAgAxA+D6srH1Fdy2C++fs4MJqTB9OfFwTK6DTD8zx9QKsK3oypDz8A6yCl2
ATV+bSNZ3uh5ZlxNEF1QyJElnDFGwtuIqC0n+Yg8ks5eFDGwwszYU0mTT/H5y+2E
/ETEJpJblMnHfw3bhQdyQp/V2sNZfJTWjppVCsaTubHwBnYjoCFb3bIX7SAdjlct
OgB9LNHl8P+Up5Q6qUNQgVu7owk2Ua1IUQGBAvLoZt97+YlNY/2K0tgyda5j486C
8+k18GNNaCJLg2/oYoAzhaQQR1Cz8XZZpbx8BUy0BzQIITTL13xcLidRYUXzoDS4
rCwJRVqxRpp1m+LtkT9csisUARv4iw==
=vZTS
-----END PGP SIGNATURE-----

--Ud8m5AGEnowiNOXGenR0IMFsg31QlcVlq--

