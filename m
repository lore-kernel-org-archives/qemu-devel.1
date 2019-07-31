Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D2BC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6858020693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6858020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsks1-0005NW-J7
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskrS-0004V4-LG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskrR-0001n6-NY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskrP-0001m5-JA; Wed, 31 Jul 2019 05:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E92E48552A;
 Wed, 31 Jul 2019 09:25:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7BF1000329;
 Wed, 31 Jul 2019 09:25:23 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-11-mreitz@redhat.com>
 <b851fa96-85ea-f20b-5d6b-969ee7c6756c@redhat.com>
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
Message-ID: <49f4b347-8d1b-98e2-5a72-b34e93512ad2@redhat.com>
Date: Wed, 31 Jul 2019 11:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b851fa96-85ea-f20b-5d6b-969ee7c6756c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TRK0xCZfpsmqkIMa2LqxmPbTUwZKzwfI9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 31 Jul 2019 09:25:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 10/13] qcow2: Repair snapshot table
 with too many entries
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
--TRK0xCZfpsmqkIMa2LqxmPbTUwZKzwfI9
Content-Type: multipart/mixed; boundary="Ww0nw1xR7mg7YLOBZlHTpJ27RpV2EbGwS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <49f4b347-8d1b-98e2-5a72-b34e93512ad2@redhat.com>
Subject: Re: [PATCH for-4.2 10/13] qcow2: Repair snapshot table with too many
 entries
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-11-mreitz@redhat.com>
 <b851fa96-85ea-f20b-5d6b-969ee7c6756c@redhat.com>
In-Reply-To: <b851fa96-85ea-f20b-5d6b-969ee7c6756c@redhat.com>

--Ww0nw1xR7mg7YLOBZlHTpJ27RpV2EbGwS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:10, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-snapshot.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>=20
> Same problem as for 9/13 - should we really be throwing away the user's=

> data like this?  (9/13 hits if the user has a small number of snapshots=
,
> but each has enough extra data, that the overall table is bigger than w=
e
> like; 10/13 hits if the user has more snapshots than we like, but
> otherwise they do the same thing).

The same arguments apply (though the =E2=80=9Cit must be a corruption=E2=80=
=9D argument
applies even more, because having more than 65536 snapshots just isn=E2=80=
=99t
right.)

Max


--Ww0nw1xR7mg7YLOBZlHTpJ27RpV2EbGwS--

--TRK0xCZfpsmqkIMa2LqxmPbTUwZKzwfI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BXoEACgkQ9AfbAGHV
z0C0Hwf/T3jfxa2pW4xpYLbZ55CKXtuJVDT9Rg9IVKLxDzQvQ3ZRtNpgK73lbwt5
9z0mRqI+2R5lLRd3OtTudnCKmpD94Nso9y5JkcT+7Sjzq5wG9UHvFCv5ba/xuFkX
u9ve/TRrrPeYhbMWxarb2Mm/SNmTSU1hsSw23P+F3EJ7GimfkvIeI0guJxeaM4B9
kgSFdUX2o6LfLQAana+AUSXTsy17tQ0iWtokPbBzcI5PbVZn/vFQsPFVSosYjeeR
HxznHk7ITcBcP8YAMwtYa7Mmyol6S3QdGapW+E264ymDtsCNMaaqK8kW1VWKj1c1
ytEXrJpWP815yO26Nzt6KJYQAwKHVg==
=VvDK
-----END PGP SIGNATURE-----

--TRK0xCZfpsmqkIMa2LqxmPbTUwZKzwfI9--

