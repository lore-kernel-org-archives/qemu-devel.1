Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F7C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D062086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D062086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvtr-0000L0-GD
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvsQ-0007ZL-UJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvsP-0005LD-Pt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvsM-0005KL-HR; Mon, 30 Sep 2019 09:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56395307D84B;
 Mon, 30 Sep 2019 13:38:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2827B60CD0;
 Mon, 30 Sep 2019 13:38:03 +0000 (UTC)
Subject: Re: [PATCH 15/18] iotests: Make 137 work with data_file
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-16-mreitz@redhat.com>
 <7e9c44bc0ca4b195939b0723db11eebc3fe11e2e.camel@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <5dff56b6-dca2-a28a-4a6a-2a6638300ff3@redhat.com>
Date: Mon, 30 Sep 2019 15:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <7e9c44bc0ca4b195939b0723db11eebc3fe11e2e.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iQMngPyY8udhRH3HIHfzebjt3Z3W4U1mk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 30 Sep 2019 13:38:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
--iQMngPyY8udhRH3HIHfzebjt3Z3W4U1mk
Content-Type: multipart/mixed; boundary="Xgpyx83N5HVhqGY26Xfm1EUNB7GCcE1xV"

--Xgpyx83N5HVhqGY26Xfm1EUNB7GCcE1xV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:38, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> When using an external data file, there are no refcounts for data
>> clusters.  We thus have to adjust the corruption test in this patch to=

>> not be based around a data cluster allocation, but the L2 table
>> allocation (L2 tables are still refcounted with external data files).
>>
>> Doing so means this test works both with and without external data
>> files.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/137     | 10 ++++++----
>>  tests/qemu-iotests/137.out |  4 +---
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
>> index 6cf2997577..dd3484205e 100755
>> --- a/tests/qemu-iotests/137
>> +++ b/tests/qemu-iotests/137
>> @@ -138,14 +138,16 @@ $QEMU_IO \
>>      "$TEST_IMG" 2>&1 | _filter_qemu_io
>> =20
>>  # The dirty bit must not be set
>> -$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features=

>> +# (Filter the external data file bit)
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features=
 \
>> +    | sed -e 's/0x4/0x0/'
> Maybe it is better to filter all the feature bits, but the dirty bit,
> since only it is needed here, so that when we start running tests with
> more features, we won't need to do this again?

I=E2=80=99d hate a filter s/[02468ace]$/no dirty bit/ though.

>> =20
>>  # Similarly we can test whether corruption detection has been enabled=
:
>> -# Create L1/L2, overwrite first entry in refcount block, allocate som=
ething.
>> +# Create L1, overwrite refcounts, force allocation of L2 by writing
>> +# data.
>>  # Disabling the checks should fail, so the corruption must be detecte=
d.
>>  _make_test_img 64M
>> -$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
>> -poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00"
>> +poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00\x00\x00\x00\x00\x00\x0=
0"
>=20
> I am wondering if there is any better way to do this (regardless of thi=
s patch),
> Basically the above code pokes into the 3rd cluster on the disk I *thin=
k*, and I don't
> understand why it has to contain refcounts. Hmm...
> First cluster I can guess will have the header, 2nd cluster probably L1=
 table, and 3rd, refcounts?
> If so, the test should specify that it needs 64K clusters, because the =
day will come when
> we will need to test this as well, but I guess in a separate patch,

When that day comes, a whole lot of other stuff will break, too.

Max


--Xgpyx83N5HVhqGY26Xfm1EUNB7GCcE1xV--

--iQMngPyY8udhRH3HIHfzebjt3Z3W4U1mk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SBToACgkQ9AfbAGHV
z0CiWAgAn5ydVkcnvdKEKeF3I3r/FzfOXR0MOwlevcaRNNjCZVgZ4fKoK+n2I9bv
o6TA/rbMr39FPRcUjbYc8okP1XhTGxwRC59Z/K4G90rrGS+5KmJ7xulCTR/sLtkz
QazsKKa4tiEBqifnf5wlOp42Sn+Uo9q7LEUsgUp37B65rinz3XHP0myH49YYpFLx
0+uqPlQyVlAhai3dE1CaOMkbDKqI3Ca3vAO+7VER7Px+OscHE6+zTyQa3gNWT0/z
+P1bbWszgLLsUoWm+4kLSkSQqrKyzrWzY2cHOos1t+sKkN/h0yMu+yIIZ8thnM0U
vD+g1nu0wqYhbNPNS3VwwT15XDDD0Q==
=aTE4
-----END PGP SIGNATURE-----

--iQMngPyY8udhRH3HIHfzebjt3Z3W4U1mk--

