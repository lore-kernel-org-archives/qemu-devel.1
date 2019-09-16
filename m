Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD1C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA3520644
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9r3P-0008Sm-BX
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9r1y-0007Qi-Tb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9r1x-0001fF-Gc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9r1u-0001dz-HE; Mon, 16 Sep 2019 09:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EEF010F2E89;
 Mon, 16 Sep 2019 13:26:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F27E05C299;
 Mon, 16 Sep 2019 13:26:35 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
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
Message-ID: <3a239280-40ab-a100-bd13-c0fd45ea46e4@redhat.com>
Date: Mon, 16 Sep 2019 15:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H8sr00Clybq2RlDXT5VIyDGNlxOxkEPZ0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 16 Sep 2019 13:26:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/5] qcow2: async handling of fragmented
 io
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H8sr00Clybq2RlDXT5VIyDGNlxOxkEPZ0
Content-Type: multipart/mixed; boundary="EojK7vWntFFT2xWpQASuprec9YZx96IaX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 kwolf@redhat.com, den@openvz.org, stefanha@redhat.com
Message-ID: <3a239280-40ab-a100-bd13-c0fd45ea46e4@redhat.com>
Subject: Re: [PATCH v4 0/5] qcow2: async handling of fragmented io
References: <20190816153015.447957-1-vsementsov@virtuozzo.com>
 <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>
In-Reply-To: <11e54b5c-eafd-411e-aadf-5b9fa4d8dc4c@redhat.com>

--EojK7vWntFFT2xWpQASuprec9YZx96IaX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 10:58, Max Reitz wrote:
> On 16.08.19 17:30, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is an asynchronous scheme for handling fragmented qcow2
>> reads and writes. Both qcow2 read and write functions loops through
>> sequential portions of data. The series aim it to parallelize these
>> loops iterations.
>> It improves performance for fragmented qcow2 images, I've tested it
>> as described below.
>=20
> Thanks, I=E2=80=99ve changed two things:
> - Replaced assert((x & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0) by
>   assert(QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE)) in patch 3 (conflict wit=
h
>   =E2=80=9Cblock: Use QEMU_IS_ALIGNED=E2=80=9D), and
> - Replaced the remaining instance of =E2=80=9Cqcow2_co_do_pwritev()=E2=80=
=9D by
>   =E2=80=9Cqcow2_co_pwritev_task()=E2=80=9D in a comment in patch 4
>=20
> and applied the series to my block branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Unfortunately, I=E2=80=99ll have to unstage the series for now because th=
e fix
to 026=E2=80=99s reference output isn=E2=80=99t stable.

When running the test in parallel (I can reproduce it with four
instances on my machine with two cores + HT), I get failures like:

026      fail       [15:21:09] [15:21:37]      (last: 18s)   output
mismatch (see 026.out.bad)
--- tests/qemu-iotests/026.out 2019-09-16 14:49:20.720410701 +0200
+++ tests/qemu-iotests/026.out.bad       2019-09-16 15:21:37.180711936 +0=
200
@@ -563,7 +563,7 @@
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device

-74 leaked clusters were found on the image.
+522 leaked clusters were found on the image.
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824

Failures: 026
Failed 1 of 1 iotests

Max


--EojK7vWntFFT2xWpQASuprec9YZx96IaX--

--H8sr00Clybq2RlDXT5VIyDGNlxOxkEPZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1/jYkACgkQ9AfbAGHV
z0B9RwgAiCXHh9a3b963pbokvsQCUokXg5JXoSYmBhqSBgFMhW3i5vC7USm1Xkyr
gCncSavbHJ/UegYCwkIii1Hi1TlajmWKIpu9CUOWsWAA+8113XBAKhYXhWMHW02P
5ztGtFHDPGoZIPJkSifkhQJur4lSZxq3wLorwP1Og2+4LR4u79++OVOodiC/c7g5
i5t8g7kcGfEs+HLQtN3KeBlJ8WR6fcIsEIsjX5xdKHoWGZ8a5VWvvNJtMD3ox3jW
Nt2mT+bmvV3V9UARHF+wsBCZL/AtEWtB8u+jpWoX8T44Jc3Mr+/ty87mOa1dXCIU
tGf4qoJ404PaM+HyuPrN4kRgd9Z3pg==
=oB+j
-----END PGP SIGNATURE-----

--H8sr00Clybq2RlDXT5VIyDGNlxOxkEPZ0--

