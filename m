Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1742089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1742089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7evW-0004T5-Ma
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7etD-0003LG-OY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7etC-0004Tc-Mo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7et9-0004QW-2v; Tue, 10 Sep 2019 08:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 040F2300BC78;
 Tue, 10 Sep 2019 12:04:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D8C5C226;
 Tue, 10 Sep 2019 12:04:48 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-21-mreitz@redhat.com>
 <20190910115620.GE4446@localhost.localdomain>
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
Message-ID: <4fd84192-0078-07e9-b972-2f10030fb15f@redhat.com>
Date: Tue, 10 Sep 2019 14:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910115620.GE4446@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8tdC790XFil8lYgpiZzbns5y8NZvzTS9Q"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 10 Sep 2019 12:04:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 20/42] block/snapshot: Fix fallback
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8tdC790XFil8lYgpiZzbns5y8NZvzTS9Q
Content-Type: multipart/mixed; boundary="J1lvGwE78SNvvK6CBPCBrYlyO1iODg7kz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4fd84192-0078-07e9-b972-2f10030fb15f@redhat.com>
Subject: Re: [PATCH v6 20/42] block/snapshot: Fix fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-21-mreitz@redhat.com>
 <20190910115620.GE4446@localhost.localdomain>
In-Reply-To: <20190910115620.GE4446@localhost.localdomain>

--J1lvGwE78SNvvK6CBPCBrYlyO1iODg7kz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 13:56, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> If the top node's driver does not provide snapshot functionality and w=
e
>> want to fall back to a node down the chain, we need to snapshot all
>> non-COW children.  For simplicity's sake, just do not fall back if the=
re
>> is more than one such child.
>>
>> bdrv_snapshot_goto() becomes a bit weird because we may have to redire=
ct
>> the actual child pointer, so it only works if the fallback child is
>> bs->file or bs->backing (and then we have to find out which it is).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/snapshot.c | 100 +++++++++++++++++++++++++++++++++++++---------=
-
>>  1 file changed, 79 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index f2f48f926a..35403c167f 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -146,6 +146,32 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDrive=
rState *bs,
>>      return ret;
>>  }
>> =20
>> +/**
>> + * Return the child BDS to which we can fall back if the given BDS
>> + * does not support snapshots.
>> + * Return NULL if there is no BDS to (safely) fall back to.
>> + */
>> +static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)=

>> +{
>> +    BlockDriverState *child_bs =3D NULL;
>> +    BdrvChild *child;
>> +
>> +    QLIST_FOREACH(child, &bs->children, next) {
>> +        if (child =3D=3D bdrv_filtered_cow_child(bs)) {
>> +            /* Ignore: COW children need not be included in snapshots=
 */
>> +            continue;
>> +        }
>> +
>> +        if (child_bs) {
>> +            /* Cannot fall back to a single child if there are multip=
le */
>> +            return NULL;
>> +        }
>> +        child_bs =3D child->bs;
>> +    }
>> +
>> +    return child_bs;
>> +}
>=20
> Why do we return child->bs here when bdrv_snapshot_goto() then needs to=

> reconstruct what the associated BdrvChild was? Wouldn't it make more
> sense to return BdrvChild** from here and maybe have a small wrapper fo=
r
> the other functions that only need a BDS?

What would you return instead?  &child doesn=E2=80=99t work.

We could limit ourselves to bs->file and bs->backing.  It just seemed
like a bit of an artificial limit to me, because we only really have it
for bdrv_snapshot_goto().

Max


--J1lvGwE78SNvvK6CBPCBrYlyO1iODg7kz--

--8tdC790XFil8lYgpiZzbns5y8NZvzTS9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13kV8ACgkQ9AfbAGHV
z0AMdgf8DtLHKXlucaopAqKmX8y1SiAnDXMkT9QUbpibl5rMLcend5Grg24Pr2KN
P4etxvJQDnG368pafpF3kmdTj7/gZm5VQaZg2njCS6ZHaSjDtBHg/CUsooSpYsiZ
nMfJ7wFrJtIsvXNr+KzAUWzmrSAOge+WTIaQr7d782R7taHbCCvAj1Ny0Om9C1PD
WLo7vhA9h7ToMGVOBCQ4D33aMl2/H6tP95Jmz57m6tbwH5QpvAzzcHp41C9C8ypK
BeAeI6+qLPB1blRQjxbc5XOs8Am4zJNGeR84MgipW+Xr4MZBfWBp74IIXmprUVl9
FvpvyEp0wv+kEE9Kkn824GycdkijvQ==
=n4RD
-----END PGP SIGNATURE-----

--8tdC790XFil8lYgpiZzbns5y8NZvzTS9Q--

