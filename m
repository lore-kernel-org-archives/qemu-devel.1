Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6607C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C90A2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO6eL+PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C90A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSe1C-00019J-PZ
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSdya-0000EE-R2
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSdyX-0005Lj-JR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:21:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSdyV-0004vM-Ja
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573118464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h7gWfOsUUk6aEAP3v1i67X38tJ+ndL7NNJk1Y4E6xIE=;
 b=bO6eL+PRLSg3KW4TFRX/CpabENx/r98JeWFa/V6uDuHSzJYAXjYgI0gJdw56z3Mc4O9hih
 g/p/4E/SAWYO4hT/rM5793Q2L3AKxKcgetUj+CCBLNdCgYO1FVXKk91Hm28Ru1IN4Xxqc2
 h47WkKxMdAgZ2R8LpLbwCXcMYfpVo38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-3L6E8XQdP8O_pECZ8DOWTQ-1; Thu, 07 Nov 2019 04:21:03 -0500
X-MC-Unique: 3L6E8XQdP8O_pECZ8DOWTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC448017E0;
 Thu,  7 Nov 2019 09:21:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-202.ams2.redhat.com
 [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 380FF5D6B7;
 Thu,  7 Nov 2019 09:21:01 +0000 (UTC)
Subject: Re: [PATCH v2 10/21] iotests: Replace IMGOPTS= by -o
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-11-mreitz@redhat.com>
 <25befdcb33d3e77f7cab05c98609b88d6ff26766.camel@redhat.com>
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
Message-ID: <08e8683a-04b2-1604-3b9f-cb2fff8669f1@redhat.com>
Date: Thu, 7 Nov 2019 10:20:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <25befdcb33d3e77f7cab05c98609b88d6ff26766.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C5h7pA4hvgvL2vZS1Cif4tDOdH1pMxO4P"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--C5h7pA4hvgvL2vZS1Cif4tDOdH1pMxO4P
Content-Type: multipart/mixed; boundary="JKLaoQSQp9dhze5fUJN2HNsaFLJApmZbk"

--JKLaoQSQp9dhze5fUJN2HNsaFLJApmZbk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 16:47, Maxim Levitsky wrote:
> On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
>> Tests should not overwrite all user-supplied image options, but only add
>> to it (which will effectively overwrite conflicting values).  Accomplish
>> this by passing options to _make_test_img via -o instead of $IMGOPTS.
>>
>> For some tests, there is no functional change because they already only
>> appended options to IMGOPTS.  For these, this patch is just a
>> simplification.
>>
>> For others, this is a change, so they now heed user-specified $IMGOPTS.
>> Some of those tests do not work with all image options, though, so we
>> need to disable them accordingly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/031 |  9 ++++---
>>  tests/qemu-iotests/039 | 24 ++++++------------
>>  tests/qemu-iotests/059 | 18 ++++++-------
>>  tests/qemu-iotests/060 |  6 ++---
>>  tests/qemu-iotests/061 | 57 ++++++++++++++++++++++--------------------
>>  tests/qemu-iotests/079 |  3 +--
>>  tests/qemu-iotests/106 |  2 +-
>>  tests/qemu-iotests/108 |  2 +-
>>  tests/qemu-iotests/112 | 32 ++++++++++++------------
>>  tests/qemu-iotests/115 |  3 +--
>>  tests/qemu-iotests/121 |  6 ++---
>>  tests/qemu-iotests/125 |  2 +-
>>  tests/qemu-iotests/137 |  2 +-
>>  tests/qemu-iotests/138 |  3 +--
>>  tests/qemu-iotests/175 |  2 +-
>>  tests/qemu-iotests/190 |  2 +-
>>  tests/qemu-iotests/191 |  3 +--
>>  tests/qemu-iotests/220 |  4 ++-
>>  tests/qemu-iotests/243 |  6 +++--
>>  tests/qemu-iotests/244 | 10 +++++---
>>  tests/qemu-iotests/250 |  3 +--
>>  tests/qemu-iotests/265 |  2 +-
>>  22 files changed, 100 insertions(+), 101 deletions(-)

[...]

>> @@ -161,7 +161,7 @@ _cleanup_test_img
>> =20
>>  echo
>>  echo "=3D=3D=3D Testing 4TB monolithicFlat creation and IO =3D=3D=3D"
>> -IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 4T
>> +_make_test_img -o "subformat=3DmonolithicFlat" 4T
>>  _img_info
>>  $QEMU_IO -c "write -P 0xa 900G 512" "$TEST_IMG" | _filter_qemu_io
>>  $QEMU_IO -c "read -v 900G 1024" "$TEST_IMG" | _filter_qemu_io
>> @@ -170,7 +170,7 @@ _cleanup_test_img
>>  echo
>>  echo "=3D=3D=3D Testing qemu-img map on extents =3D=3D=3D"
>>  for fmt in monolithicSparse twoGbMaxExtentSparse; do
>> -    IMGOPTS=3D"subformat=3D$fmt" _make_test_img 31G
>> +    _make_test_img -o "subformat=3D$fmt" 31G
>>      $QEMU_IO -c "write 65024 1k" "$TEST_IMG" | _filter_qemu_io
>>      $QEMU_IO -c "write 2147483136 1k" "$TEST_IMG" | _filter_qemu_io
>>      $QEMU_IO -c "write 5G 1k" "$TEST_IMG" | _filter_qemu_io
>=20
> Looks good. Another test that pokes at guessed locations... :-)

Actually, no.  These are writes on the format, not the file itself.  The
monolithicSparse subformat will store everything in a single file,
whereas twoGbMaxExtentSparse will create one file per 2 GB of guest
disk.  So the locations are chosen accordingly to that 2 GB limit ((1)
something somewhere in the first extent, (2) something that wraps around
the first 2 GB limit, so hits extents #0 and #1, and (3) something in
the middle of extent #2.)

(The following qemu-img map call then verifies that it lands in the
different files for twoGbMaxExtentSparse, and that monolithicSparse is
at least indeed sparsely allocated.)

Max


--JKLaoQSQp9dhze5fUJN2HNsaFLJApmZbk--

--C5h7pA4hvgvL2vZS1Cif4tDOdH1pMxO4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3D4fsACgkQ9AfbAGHV
z0BQQQf/fnHw/Nsum/M83lmXlPUh8R/ud82Tzkwuyg21tfQad63XxfsZ7dTOZpVJ
aUzKuh5wjChlb5f0aCubY1bSzfp3PCVwsI6BwVpCt5nEgNLNttIpkn22CFra9pXE
obt6ut+O+50DLM+tQ/95z9JkbjnemIex0g2NCNNoloU4k8kZws02Wm4ruu7oQ+zs
k233VphuR/xoEicghIpqlmbnV/61IfcbXVWCikO0wPhH0m+KF/UH4vXKt8stNv0A
3a+I0VKcG5LXV78F2nPjz0PunJKLOLDxQgs29R7bfBNCo6diQa/Jr7GQFcnmrB1V
M9Ap/fJNGq5toI5sE161hl+hBoyJKQ==
=TNBt
-----END PGP SIGNATURE-----

--C5h7pA4hvgvL2vZS1Cif4tDOdH1pMxO4P--


