Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0ADC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DB42082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DB42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpDh-0003aJ-Lh
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbork-0005fH-Ej
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbori-0005uP-CY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hborb-0005jY-Lv; Fri, 14 Jun 2019 12:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3F0C30832F4;
 Fri, 14 Jun 2019 16:15:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 672D2605C9;
 Fri, 14 Jun 2019 16:15:30 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-23-mreitz@redhat.com>
 <e748a63f-2ee7-1c43-df21-573d038444b8@virtuozzo.com>
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
Message-ID: <a0972294-7049-3e93-ae4d-23238e953615@redhat.com>
Date: Fri, 14 Jun 2019 18:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e748a63f-2ee7-1c43-df21-573d038444b8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rMYfRj4YcI8e7cijsdSulEv76QisnDcmn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 14 Jun 2019 16:15:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
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
--rMYfRj4YcI8e7cijsdSulEv76QisnDcmn
Content-Type: multipart/mixed; boundary="uXfYjL18sHKLQLdrEeced1isJAJQ7rFMS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <a0972294-7049-3e93-ae4d-23238e953615@redhat.com>
Subject: Re: [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-23-mreitz@redhat.com>
 <e748a63f-2ee7-1c43-df21-573d038444b8@virtuozzo.com>
In-Reply-To: <e748a63f-2ee7-1c43-df21-573d038444b8@virtuozzo.com>

--uXfYjL18sHKLQLdrEeced1isJAJQ7rFMS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 17:41, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c | 26 ++++++++++++++++++++++++--
>>   1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 11b7ba8cf6..856d9b58be 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4511,15 +4511,37 @@ exit:
>>   int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>>   {
>>       BlockDriver *drv =3D bs->drv;
>> +    BlockDriverState *storage_bs, *metadata_bs;
>> +
>>       if (!drv) {
>>           return -ENOMEDIUM;
>>       }
>> +
>>       if (drv->bdrv_get_allocated_file_size) {
>>           return drv->bdrv_get_allocated_file_size(bs);
>>       }
>> -    if (bs->file) {
>> -        return bdrv_get_allocated_file_size(bs->file->bs);
>> +
>> +    storage_bs =3D bdrv_storage_bs(bs);
>> +    metadata_bs =3D bdrv_metadata_bs(bs);
>> +
>> +    if (storage_bs) {
>> +        int64_t data_size, metadata_size =3D 0;
>> +
>> +        data_size =3D bdrv_get_allocated_file_size(storage_bs);
>> +        if (data_size < 0) {
>> +            return data_size;
>> +        }
>> +
>> +        if (storage_bs !=3D metadata_bs) {
>> +            metadata_size =3D bdrv_get_allocated_file_size(metadata_b=
s);
>> +            if (metadata_size < 0) {
>> +                return metadata_size;
>> +            }
>> +        }
>> +
>> +        return data_size + metadata_size;
>>       }
>> +
>>       return -ENOTSUP;
>>   }
>>  =20
>>
>=20
> Again, I dislike nailing down new fresh feature about separate metadata=
 and storage child
> to the generic block layer, as it's simple to imagine a driver which ne=
eds three or more
> children to store all its data and metadata..

Yes, we have that, it=E2=80=99s VMDK.

> Isn't it better by default loop through all children and sum all their =
allocated sizes?
>=20
> Hmm, but we want exclude backing, yes? Still we may ignore it while ite=
rating.

I want to object in that there could be drivers that have children that
should not count towards their allocated size other than COW backing
files.  But I actually cannot imagine a reasonable scenario.  (The only
reason why COW backing files should be excluded is because they are
generally listed separately.)

So, yes, that sounds good.

Max


--uXfYjL18sHKLQLdrEeced1isJAJQ7rFMS--

--rMYfRj4YcI8e7cijsdSulEv76QisnDcmn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DyCAACgkQ9AfbAGHV
z0Ae0Af6Alqp11hKxtWcLk8RIhtD78AfZYPfG3u5UJcP8bEyjiaN3f/sQgGk31CW
o6BtQd/CAzcWq33OFcaRL9FiiucBv5irOaptFo6R13fuk5k4iJh1k2uWeA86J17c
x3HiFWMhEWHhOIQgO4oUfBaIeYg9lw6sJP4Zx/oryZgKUYNKlsLiqu/6JQm3XQzC
i6FRASWGeIoGys0WPhejpmlo0Q3oTBi3E0X5lJDmMVk0KME4JRdkL+1QRAGQ1Bkh
LjafDR9p2zkmfeP3V7QEnLSQgkVb77dhCOuJeWSVLjcglV+4KvPAUeqa3zhUNr4D
Yk04OoWYeiIZgHuLWJdpFE5SNXAdIw==
=23Pw
-----END PGP SIGNATURE-----

--rMYfRj4YcI8e7cijsdSulEv76QisnDcmn--

