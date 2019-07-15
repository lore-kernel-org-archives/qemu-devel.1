Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1543EC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D428820868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D428820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxb0-0005Aq-U5
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmxan-0004lH-BI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmxal-00065e-0z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:48:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmxaf-00061K-6B; Mon, 15 Jul 2019 05:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87CF4308FB93;
 Mon, 15 Jul 2019 09:48:11 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B70D2608CD;
 Mon, 15 Jul 2019 09:48:09 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-8-mreitz@redhat.com>
 <5c73228a-a6b2-31fa-a33d-0c65863acce5@redhat.com>
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
Message-ID: <734f491b-9393-d380-0425-278901774723@redhat.com>
Date: Mon, 15 Jul 2019 11:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5c73228a-a6b2-31fa-a33d-0c65863acce5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JQqjYTKwGnWYRTVQcwI07rhLNwybhkWeY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 15 Jul 2019 09:48:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Add test for image creation
 fallback
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
--JQqjYTKwGnWYRTVQcwI07rhLNwybhkWeY
Content-Type: multipart/mixed; boundary="7iZNgLADHgrUSBL2sfOwjJlI9pP4pQI65";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <734f491b-9393-d380-0425-278901774723@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Add test for image creation
 fallback
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-8-mreitz@redhat.com>
 <5c73228a-a6b2-31fa-a33d-0c65863acce5@redhat.com>
In-Reply-To: <5c73228a-a6b2-31fa-a33d-0c65863acce5@redhat.com>

--7iZNgLADHgrUSBL2sfOwjJlI9pP4pQI65
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.07.19 11:31, Thomas Huth wrote:
> On 12/07/2019 19.36, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/259     | 61 +++++++++++++++++++++++++++++++++++++=
+
>>  tests/qemu-iotests/259.out | 14 +++++++++
>>  tests/qemu-iotests/group   |  1 +
>>  3 files changed, 76 insertions(+)
>>  create mode 100755 tests/qemu-iotests/259
>>  create mode 100644 tests/qemu-iotests/259.out
>>
>> diff --git a/tests/qemu-iotests/259 b/tests/qemu-iotests/259
>> new file mode 100755
>> index 0000000000..22b4c10241
>> --- /dev/null
>> +++ b/tests/qemu-iotests/259
>> @@ -0,0 +1,61 @@
>> +#!/usr/bin/env bash
>> +#
>> +# Test generic image creation fallback (by using NBD)
>> +#
>> +# Copyright (C) 2019 Red Hat, Inc.
>> +#
>> +# This program is free software; you can redistribute it and/or modif=
y
>> +# it under the terms of the GNU General Public License as published b=
y
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +
>> +# creator
>> +owner=3Dmreitz@redhat.com
>> +
>> +seq=3D$(basename $0)
>> +echo "QA output created by $seq"
>> +
>> +status=3D1	# failure is the default!
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_test_img
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and checks
>> +. ./common.rc
>> +. ./common.filter
>> +
>> +_supported_fmt raw
>=20
> Why is this stating "raw" here...
>=20
>> +_supported_proto nbd

Because it=E2=80=99s an NBD test.

>> +_supported_os Linux
>> +
>> +
>> +_make_test_img 64M

Also, because I don=E2=80=98t want this to create a qcow2 image.  This sh=
ould
just set up a raw NBD node.

>> +echo
>> +echo '--- Testing creation ---'
>> +
>> +$QEMU_IMG create -f qcow2 "$TEST_IMG" 64M | _filter_img_create
>=20
> ... and using qcow2 here instead?

Practical answer: Nobody tests qcow2+nbd.  Ever.  Because it is
generally a stupid combination.  We need it for this test, though,
because NBD is the simplest way to get a fixed-size block device.

The more involved answer is because nobody has introduced anything yet
to simply let the test decide on which format/protocol combination to
use by default (and then let the check script just use that, unless
overridden by the user).

But there=E2=80=98s also the _make_test_img thing.

>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index b34c8e3c0c..80e7603174 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -269,3 +269,4 @@
>>  254 rw auto backing quick
>>  255 rw auto quick
>>  256 rw auto quick
>> +259 rw auto quick
>=20
> If this test only supports "raw", I think it should not be in the "auto=
"
> group anymore.

Oh, I didn=E2=80=98t know that only runs qcow2 tests.  OK then.

Max


--7iZNgLADHgrUSBL2sfOwjJlI9pP4pQI65--

--JQqjYTKwGnWYRTVQcwI07rhLNwybhkWeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0sS9IACgkQ9AfbAGHV
z0BdxQgAoNpGv5fSonSU+Y7fEmhA9Z+UIuf2ZD9e0qJzk1i4xGWg30NqP8hoSjRu
xiPbdpAE4J496O0DU0VfiCL6m7zdPn/3iYc7zuD2xO8l5PNNepd5gtS+85Ic2b/1
K8bqdmXdrruPuvgdakxtbIwZApMN+7Vg3VNNN8jlJuzzMOnIRi7dzTxG9M7uDq2J
Oj8/rKQW5jwuum0faOdCk4DsL1BtW0iYZZGCiDRVfigRqr7FQEajTp7rYIZGl3uk
seTbVJGJxMJDD+C8Bkth0Ux+eEpyvDJpG94FcUvSAdtbAtZWDaa+BzYT02OeQzcO
VwMnnp/iTpWY5ij0XBjPlK51D5nnYg==
=E8F/
-----END PGP SIGNATURE-----

--JQqjYTKwGnWYRTVQcwI07rhLNwybhkWeY--

