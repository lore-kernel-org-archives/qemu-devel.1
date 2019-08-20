Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BFAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69800214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 11:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69800214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i02Xd-0007y9-B7
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 07:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i02Wr-0007TL-PM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i02Wq-0002fE-NM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 07:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i02Wn-0002dd-WE; Tue, 20 Aug 2019 07:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAD8D30860DC;
 Tue, 20 Aug 2019 11:42:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A08C5D9E1;
 Tue, 20 Aug 2019 11:42:15 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
 <e0c477a9-7889-3042-382a-8cb511ea96b3@redhat.com>
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
Message-ID: <72822609-d767-ace1-4a0c-6f6d0d7a361d@redhat.com>
Date: Tue, 20 Aug 2019 13:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e0c477a9-7889-3042-382a-8cb511ea96b3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s74NRDeXAiBvpWINV876gk79L3ljYJpY3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 20 Aug 2019 11:42:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/16] qcow2: Keep unknown extra
 snapshot data
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s74NRDeXAiBvpWINV876gk79L3ljYJpY3
Content-Type: multipart/mixed; boundary="wPIJ6HUguOfTNX4Q3IjojEaVpTGTC16Rg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <72822609-d767-ace1-4a0c-6f6d0d7a361d@redhat.com>
Subject: Re: [PATCH v2 04/16] qcow2: Keep unknown extra snapshot data
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-5-mreitz@redhat.com>
 <e0c477a9-7889-3042-382a-8cb511ea96b3@redhat.com>
In-Reply-To: <e0c477a9-7889-3042-382a-8cb511ea96b3@redhat.com>

--wPIJ6HUguOfTNX4Q3IjojEaVpTGTC16Rg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 21:23, Eric Blake wrote:
> On 8/19/19 1:55 PM, Max Reitz wrote:
>> The qcow2 specification says to ignore unknown extra data fields in
>> snapshot table entries.  Currently, we discard it whenever we update t=
he
>> image, which is a bit different from "ignore".
>>
>> This patch makes the qcow2 driver keep all unknown extra data fields
>> when updating an image's snapshot table.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.h          |  5 ++++
>>  block/qcow2-snapshot.c | 61 +++++++++++++++++++++++++++++++++++------=
-
>>  2 files changed, 56 insertions(+), 10 deletions(-)
>>
>=20
>> @@ -162,7 +184,7 @@ static int qcow2_write_snapshots(BlockDriverState =
*bs)
>>          sn =3D s->snapshots + i;
>>          offset =3D ROUND_UP(offset, 8);
>>          offset +=3D sizeof(h);
>> -        offset +=3D sizeof(extra);
>> +        offset +=3D MAX(sizeof(extra), sn->extra_data_size);
>=20
> Why would we ever have less than sizeof(extra) bytes to write on output=
,
> since we always produce the fields on creation and synthesize the
> missing fields of extra on read?  Can't you rewrite this as:
>=20
> assert(sn->extra_data_size >=3D sizeof(extra));
> offset +=3D sn->extra_data_size;

Hm, but I don=E2=80=99t prop up extra_data_size to be at least sizeof(ext=
ra).  I
can do that, but it would add a few extra lines here and there.

> Otherwise,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

In any case, thanks for reviewing again :-)

Max


--wPIJ6HUguOfTNX4Q3IjojEaVpTGTC16Rg--

--s74NRDeXAiBvpWINV876gk79L3ljYJpY3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b3JUACgkQ9AfbAGHV
z0AFeggAkbVkmYm1uw0iwntBA1XhEWw8XTZbcmwuzS9ZUmDfE3fZgKgwZeFpUL7M
RRzxpiy5gIR3bFG5IGY4tQ5nrOFRH2cpvkzHlQjSXsGAtxVSVJOKKDRYZ99DRuQN
1uIsWVo8/YOK0a/eXYVvGWw96DJo9PZD1S3hciyPL046OoB3CfES7XBhH1oalTC5
89Kuy8VlTpE7H0dq43UpbMjaaLgsGJBBW6GWySoiQjullzW0oL3zyRZlHoa60OKH
wzcQLZ6NdlcYz0L0mw3ivcwSSI/nV0NgM0t2WTvjryYiREmeKgtIoHJaIlcy2IDA
xAoR/rk/wsnmOJGZzBboMaA4SCkyAQ==
=tf5A
-----END PGP SIGNATURE-----

--s74NRDeXAiBvpWINV876gk79L3ljYJpY3--

