Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998CBC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC5C20651
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5C20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxANX-0005Wi-Mw
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxAN9-000544-WC
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxAN9-0000NR-1G
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxAN6-0000Kl-So; Mon, 12 Aug 2019 09:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D31330EE131;
 Mon, 12 Aug 2019 13:28:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0159371D42;
 Mon, 12 Aug 2019 13:28:22 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-31-mreitz@redhat.com>
 <8970b4b2-a81b-aee2-c422-35f39155aa12@virtuozzo.com>
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
Message-ID: <39416e43-4aee-82f7-45f8-52d41bd4c688@redhat.com>
Date: Mon, 12 Aug 2019 15:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8970b4b2-a81b-aee2-c422-35f39155aa12@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q7Hiy9kEGSumRXAU7XZbnMVU2mb0Y1Z2i"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 13:28:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 30/42] qemu-img: Use child access
 functions
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
--q7Hiy9kEGSumRXAU7XZbnMVU2mb0Y1Z2i
Content-Type: multipart/mixed; boundary="KvmhxwmhKYEpnDncOuzE4yks8Jp5Zu7EY";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <39416e43-4aee-82f7-45f8-52d41bd4c688@redhat.com>
Subject: Re: [PATCH v6 30/42] qemu-img: Use child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-31-mreitz@redhat.com>
 <8970b4b2-a81b-aee2-c422-35f39155aa12@virtuozzo.com>
In-Reply-To: <8970b4b2-a81b-aee2-c422-35f39155aa12@virtuozzo.com>

--KvmhxwmhKYEpnDncOuzE4yks8Jp5Zu7EY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 14:14, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:13, Max Reitz wrote:
>> This changes iotest 204's output, because blkdebug on top of a COW nod=
e
>> used to make qemu-img map disregard the rest of the backing chain (the=

>> backing chain was broken by the filter).  With this patch, the
>> allocation in the base image is reported correctly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qemu-img.c                 | 33 ++++++++++++++++++++-------------
>>   tests/qemu-iotests/204.out |  1 +
>>   2 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 79983772de..3b30c5ae70 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c

[...]

>> @@ -2490,7 +2492,8 @@ static int img_convert(int argc, char **argv)
>>            * s.target_backing_sectors has to be negative, which it wil=
l
>>            * be automatically).  The backing file length is used only
>>            * for optimizations, so such a case is not fatal. */
>> -        s.target_backing_sectors =3D bdrv_nb_sectors(out_bs->backing-=
>bs);
>> +        s.target_backing_sectors =3D
>> +            bdrv_nb_sectors(bdrv_filtered_cow_bs(out_bs));
>=20
> why not skip_rw_filters? It will fail if out_bs is filter..

Because I forgot this place. :-)  Although backing_chain_next() would be
simpler here and do the same, effectively.

Max


--KvmhxwmhKYEpnDncOuzE4yks8Jp5Zu7EY--

--q7Hiy9kEGSumRXAU7XZbnMVU2mb0Y1Z2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RaXUACgkQ9AfbAGHV
z0B0YQf9EQ0eKzMZFlwoIlVLZYa6Ad5EGYe3/4DPYu7O4k69+bCsRnW7G0iC9JrM
1zKBmu4a57xueVQ1c2H2ufnj2G6cXj5CDa3sZQLlq373mmKBJ0DVfO2nNMIpIdgX
CEpgSIY8JJm1WoDDJ4XDDAI1aNvUAuSoLuWSoGP1E/uXMCB5cMUNC0d25EUI1Edp
CZ5qWlHmdN8glqqeawRqFprBISfgImwwOyr3V694X01IeEjIu/7BCaaWXL7IjFnZ
EjkvlDzNVgHU9hh1GiNM9MZET30UddLnFrjEF07Zdi4X9nwugD+pbMpA1YTxGk+f
wRQzxAnlWAEQZGbG9UQZVlyYCDjiDw==
=Dnjm
-----END PGP SIGNATURE-----

--q7Hiy9kEGSumRXAU7XZbnMVU2mb0Y1Z2i--

