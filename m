Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC7C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098F22133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098F22133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVqo-0004gJ-Aj
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbVme-00017E-LH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbVmc-0004SV-LN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbVmF-000476-V0; Thu, 13 Jun 2019 15:52:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5E1F30832DA;
 Thu, 13 Jun 2019 19:52:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AAB560BE2;
 Thu, 13 Jun 2019 19:52:39 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190507203508.18026-1-mreitz@redhat.com>
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
Message-ID: <01c11e01-8ddb-4281-72ad-9e9b30eafdeb@redhat.com>
Date: Thu, 13 Jun 2019 21:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190507203508.18026-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UcIgmlrmV7OnOvj5x9y2Dq3JDjxdGScdQ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 13 Jun 2019 19:52:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/7] qemu-img: Add salvaging mode to
 convert
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UcIgmlrmV7OnOvj5x9y2Dq3JDjxdGScdQ
Content-Type: multipart/mixed; boundary="YWIQFmOfhYma90UIVJj8aXE41PHfuJbyY";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <01c11e01-8ddb-4281-72ad-9e9b30eafdeb@redhat.com>
Subject: Re: [PATCH v4 0/7] qemu-img: Add salvaging mode to convert
References: <20190507203508.18026-1-mreitz@redhat.com>
In-Reply-To: <20190507203508.18026-1-mreitz@redhat.com>

--YWIQFmOfhYma90UIVJj8aXE41PHfuJbyY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.05.19 22:35, Max Reitz wrote:
> Hi,
>=20
> This series adds a --salvage option to qemu-img convert.  With this,
> qemu-img will not abort when it encounters an I/O error.  Instead, it
> tries to narrow it down and will treat the affected sectors as being
> completely 0 (and print a warning).
>=20
> Testing this is not so easy, because while real I/O errors during read
> operations should be treated as described above, errors encountered
> during bdrv_block_status() should just be ignored and the affected
> sectors should be considered allocated.  But blkdebug does not yet have=

> a way to intercept this, and:
>=20
> (1) Just adding a new block-status event would be silly, because I don'=
t
>     want an event, I want it to fail on a certain kind of operation, on=

>     a certain sector range, independently of any events, so why can't w=
e
>     just do that?  See patch 4.
>=20
> (2) If we just make blkdebug intercept .bdrv_co_block_status() like all=

>     other kinds of operations, at least iotest 041 fails, which does
>     exactly that silly thing: It uses the read_aio event to wait for an=
y
>     read.  But it turns out that there may be a bdrv_*block_status()
>     call in between, so suddenly the wrong operation yields an error.
>     As I said, the real fault here is that it does not really make sens=
e
>     to pray that the operation you want to fail is the one that is
>     immediately executed after some event that you hope will trigger
>     that operation.
>     See patch 3.
>=20
> So patch 3 allows blkdebug users to select which kind of I/O operation
> they actually want to make fail, and patch 4 allows them to not use any=

> event, but to have a rule active all the time.
>=20
> Together, we can then enable error injection for block-status in patch =
5
> and make use of event=3Dnone iotype=3Dblock-status in patch 6.

Applied the series to my block branch, and fixed _filter_offsets in
patch 6 as suggested by Vladimir.

Max


--YWIQFmOfhYma90UIVJj8aXE41PHfuJbyY--

--UcIgmlrmV7OnOvj5x9y2Dq3JDjxdGScdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CqYUACgkQ9AfbAGHV
z0Ci3QgApYEAbwQxtvKcGwTJMm2gJs5duzskatUCv5oRD7ml751ZMQrGxBlYnrrC
+7U7/O1CesvKkmyyS5urx9EjLGL9mO71dxwaEheuFlQnyYXrTyfypQnhtn7oJjYh
b+jkpByoAiar59lOJcCCaYGJmR/R01cQ/j96aZRMhYFAiqL+KeyxJiGfbtSZf/Ik
/fqQkmWjdn2SY2W4i8I+o9x1ffwa8vtJg/DK7Sb0FlQ6UHiwyqieXt4yyX+au0uy
WiV0CGWncu3f0j2xFmz3+9YBd/rdMBi1aX46+5TQkgl1CUxr8H7BrMO5Bu8KNaja
XkaH1JEVT8bfDDi9+D1wVgDUDdl7gQ==
=rDcV
-----END PGP SIGNATURE-----

--UcIgmlrmV7OnOvj5x9y2Dq3JDjxdGScdQ--

