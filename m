Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBBC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBEE2183F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBEE2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpZe-0001Vi-MR
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbon9-0000mF-Tw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbon6-0002Qo-LW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hboml-00027V-5v; Fri, 14 Jun 2019 12:10:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 305BBC1EB1F7;
 Fri, 14 Jun 2019 16:10:38 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0868A17F51;
 Fri, 14 Jun 2019 16:10:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-21-mreitz@redhat.com>
 <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>
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
Message-ID: <bc1cdeca-2708-e122-c157-d08750e32ed6@redhat.com>
Date: Fri, 14 Jun 2019 18:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ctcaaKpKA8YYOxM1TYGpilOAkU9QXaJNW"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 16:10:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 20/42] block/snapshot: Fall back to
 storage child
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
--ctcaaKpKA8YYOxM1TYGpilOAkU9QXaJNW
Content-Type: multipart/mixed; boundary="kUEaJo29yHoS4aalAe0IC9cmD2UQ8ZUQ6";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <bc1cdeca-2708-e122-c157-d08750e32ed6@redhat.com>
Subject: Re: [PATCH v5 20/42] block/snapshot: Fall back to storage child
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-21-mreitz@redhat.com>
 <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>
In-Reply-To: <ceef507e-16d0-0edf-0e2d-64c5b4d613ef@virtuozzo.com>

--kUEaJo29yHoS4aalAe0IC9cmD2UQ8ZUQ6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 17:22, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> If the top node's driver does not provide snapshot functionality and w=
e
>> want to go down the chain, we should go towards the child which stores=

>> the data, i.e. the storage child.
>>
>> bdrv_snapshot_goto() becomes a bit weird because we may have to redire=
ct
>> the actual child pointer, so it only works if the storage child is
>> bs->file or bs->backing (and then we have to find out which it is).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/snapshot.c | 74 ++++++++++++++++++++++++++++++++++------------=
--
>>   1 file changed, 53 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index f2f48f926a..58cd667f3a 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -154,8 +154,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
>>       }
>>  =20
>>       if (!drv->bdrv_snapshot_create) {
>> -        if (bs->file !=3D NULL) {
>> -            return bdrv_can_snapshot(bs->file->bs);
>> +        BlockDriverState *storage_bs =3D bdrv_storage_bs(bs);
>> +        if (storage_bs) {
>> +            return bdrv_can_snapshot(storage_bs);
>>           }
>>           return 0;
>>       }
>=20
> Hmm is it correct at all doing a snapshot, when top format node doesn't=
 support it,
> metadata child doesn't support it and storage child supports? Doing sna=
pshots of
> storage child seems useless, as data file must be in sync with metadata=
=2E

You=E2=80=99re right.

That=E2=80=99s actually a bug already.  VMDK can store data in multiple
children, but it does not support snapshots.  So if you store such a
split VMDK disk on an RBD volume, it is possible that just the
descriptor file is snapshotted, but nothing else.

Hmmm.  I think the best way is to check whether there is exactly one
child that is not the bdrv_filtered_cow_child().  If so, we can go down
to it and snapshot it.  Otherwise, the node does not support snapshots.

Max


--kUEaJo29yHoS4aalAe0IC9cmD2UQ8ZUQ6--

--ctcaaKpKA8YYOxM1TYGpilOAkU9QXaJNW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DxvsACgkQ9AfbAGHV
z0CrOAf+OBUyvgVlN40IW1njIOGrPouBI7ulsvvNU1YNGz/0FQDWBgux1dCDSDOz
Tdr1om+rJiKbzpvKG4iLqj6MThQxvOMv6+/+kBShvY3M9Ae2C1wybW58ugmum8DF
Ap87m1fTkC/WinpYKC/qz+mPOtw38+SiMSWh9nVMzgl0iu0oGYPY/1X9lhNmolm2
1cBW7lKYmXevVjy16iPFE+UAlzrJTHb9TFgbgBMvRR2fyrzJtXLGxC0jLvKQ3vio
s1EAilc27EW30qIOma3JCUoYnk9OHJ75ixOIizgTqJikvB03seIUbZRtFiD0r6xO
ENz0uos0JKH1haC2HyZkU6/SKXu97A==
=ViG+
-----END PGP SIGNATURE-----

--ctcaaKpKA8YYOxM1TYGpilOAkU9QXaJNW--

