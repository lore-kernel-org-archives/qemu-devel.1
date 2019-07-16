Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B57C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE5B205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE5B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQ4h-0008V3-0z
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnQ4V-00082P-BL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnQ4U-0006x6-8P
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:12:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnQ4R-0006vJ-OE; Tue, 16 Jul 2019 12:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08EC181129;
 Tue, 16 Jul 2019 16:12:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E270860C4C;
 Tue, 16 Jul 2019 16:12:44 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-3-thuth@redhat.com>
 <1832e90b-0fd2-19ac-f90e-572147e51f53@redhat.com>
 <62ec1243-3bb9-c18d-0ff6-4c4ad193620c@redhat.com>
 <03b260f7-b108-f035-2974-17b5ef74e4e6@redhat.com>
 <99ee850e-d9e0-1079-7fb2-64a1901009e6@redhat.com>
 <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
 <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
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
Message-ID: <94a85c94-5758-0e09-1a34-127cb26fe115@redhat.com>
Date: Tue, 16 Jul 2019 18:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bLmiklO7ZpX3HfsXvlpI3Gaovs92nfHLB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 16 Jul 2019 16:12:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tests/qemu-iotests/group: Remove
 some more tests from the "auto" group
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bLmiklO7ZpX3HfsXvlpI3Gaovs92nfHLB
Content-Type: multipart/mixed; boundary="NB9FjcQ7hrCFsGbmqLbIMWEIXfHlCo3Ch";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org
Message-ID: <94a85c94-5758-0e09-1a34-127cb26fe115@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/qemu-iotests/group: Remove some more tests
 from the "auto" group
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-3-thuth@redhat.com>
 <1832e90b-0fd2-19ac-f90e-572147e51f53@redhat.com>
 <62ec1243-3bb9-c18d-0ff6-4c4ad193620c@redhat.com>
 <03b260f7-b108-f035-2974-17b5ef74e4e6@redhat.com>
 <99ee850e-d9e0-1079-7fb2-64a1901009e6@redhat.com>
 <cc4c609e-d8e6-bdeb-8c15-c7617ee09fdc@redhat.com>
 <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>
In-Reply-To: <f2cde3ed-f776-5c1e-cc57-a9cff7190502@redhat.com>

--NB9FjcQ7hrCFsGbmqLbIMWEIXfHlCo3Ch
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 18:09, Eric Blake wrote:
> On 7/16/19 10:58 AM, Max Reitz wrote:
>=20
>>>> Ah, OK.  So, uh, we effectively can=E2=80=99t run any Python tests o=
n macOS?
>>>
>>> Not when our CI is set up to use super-long file names:
>>>
>>> +  File
>>> "/private/var/folders/sy/2x5qvs0n4lg18fry9jz4y21m0000gn/T/cirrus-ci-b=
uild/tests/qemu-iotests/../../python/qemu/machine.py",
>>> line 294, in launch
>>
>> That isn=E2=80=99t really long.
>=20
> The MacOS limit is 104 (or 103 if you insist on using the trailing NUL
> yourself), compared to Linux at 108 (107).  And:
>=20
> $ printf
> "/private/var/folders/sy/2x5qvs0n4lg18fry9jz4y21m0000gn/T/cirrus-ci-bui=
ld/tests/qemu-iotests/scratch/name"
> | wc -c
> 104
>=20
> shows that we are right on the verge of overflowing the space allotted,=

> with any socket name worth using when the socket lives inside
> qemu-iotests/scratch.
>=20
>>
>>> Is there any way to create our sockets somewhere under /tmp instead o=
f
>>> inside tests/qemu-iotests, so that we have a shorter filename for
>>> sockets no matter how deep in the file hierarchy the tests themselves=
 live?
>>>
>>> Also, at one point, we tossed around the idea of
>>> s/qemu-iotests/iotests/, to shave off 5 characters that don't really =
add
>>> anything.
>>
>> I=E2=80=99d personally rather just skip the iotests if we detect such =
a silly
>> OS, but maybe that=E2=80=99s just me.
>=20
> It's a rather unfortunate limit, but it's not all that silly (the limit=

> is based on the fact that struct sockaddr has to fit inside a nice
> power-of-2 structure somewhere in the kernel, and enough else is used
> that you really are left with just 104/108 bytes, or even 92 bytes if
> you use HP-UX 11).  POSIX does not place a minimum length on sun_path,
> but I know of no system that does not allow at least 92 bytes, if you
> are aiming for a portably-small name.

It does come to me as a surprise that the sockaddr is a path instead of,
say, an inode number.

But shaving off the =E2=80=9Cqemu-=E2=80=9D seems like the wrong approach=
 to me still.

Max


--NB9FjcQ7hrCFsGbmqLbIMWEIXfHlCo3Ch--

--bLmiklO7ZpX3HfsXvlpI3Gaovs92nfHLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0t93oACgkQ9AfbAGHV
z0ChpggAsvj9Cph/e4OK1wkjZ/qqS+aOG0ojagzJcjwQNU68TBUKh1WTVoNslvLQ
y54o+ytLGHPFuO4vK0bg4bQT9pUeyDPCENPc3X4Ce15GtMA04gVMKnLrjzV+Ft9/
WFLqFNonJgybNnojv8BFTX9bsOOgZBhHc1GdUIa6T+NQYYZqBmnv4M6Hoi0Gb9lE
Pg+2aIvHwTxknVFTFgDPVGwv+V+RrqbldrNg3C2Ana+u4++op8BUwioVomBE5oE3
CgTYBqhQVDQ0M4ndctEvt99xnNDaHfNsIo1RECVAFwUI6tcl/HZY4+kW2dX80J72
agvnBMvjhG3YX7J9L2LOixu5pP60bw==
=TwfA
-----END PGP SIGNATURE-----

--bLmiklO7ZpX3HfsXvlpI3Gaovs92nfHLB--

