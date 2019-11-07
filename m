Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2642FC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FF32084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 11:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF3dhwm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FF32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSg7D-0004uT-Tk
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 06:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSg5Z-0003B0-Cq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSg5X-0001Vs-12
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSg5W-0001Vj-S0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 06:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573126590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JxN+SDoDVg4xy9F+8EmIifNapEawm+sz28dJ+UiyHm4=;
 b=IF3dhwm7MY9Ahouvn7vwAyt3ZDB91Nfz+5jfjekSSewDmmuaDs0/3fcNtwtbnASQZsDoof
 6nGUz9AGR9nVut8hwlTVh0wJEQaSAtHpheicOR2w0EwiTEIkeuhMUIGyGyb8rC9HsnVAB6
 CfzhbI9/YCAbSqDpYxkk6lklw+rnXLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-G-vYToQ7NMu-hlsSQnkSBA-1; Thu, 07 Nov 2019 06:36:26 -0500
X-MC-Unique: G-vYToQ7NMu-hlsSQnkSBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF3A8800C61;
 Thu,  7 Nov 2019 11:36:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-202.ams2.redhat.com
 [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61CFC608AC;
 Thu,  7 Nov 2019 11:36:24 +0000 (UTC)
Subject: Re: [PATCH v2 20/21] iotests: Disable data_file where it cannot be
 used
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-21-mreitz@redhat.com>
 <d6b0e876927d8e6c28d708f7ac460e48f2b24384.camel@redhat.com>
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
Message-ID: <ec97587f-db3b-65ba-0dab-16b2c86002d0@redhat.com>
Date: Thu, 7 Nov 2019 12:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d6b0e876927d8e6c28d708f7ac460e48f2b24384.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="um9moCoB39sbddOLkyBcij1Aaz01TM9rA"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--um9moCoB39sbddOLkyBcij1Aaz01TM9rA
Content-Type: multipart/mixed; boundary="E43Wmmo5uf9Ndj2PhwmYG4ODoqBnJZQxj"

--E43Wmmo5uf9Ndj2PhwmYG4ODoqBnJZQxj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 16:52, Maxim Levitsky wrote:
> On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/007 | 5 +++--
>>  tests/qemu-iotests/014 | 2 ++
>>  tests/qemu-iotests/015 | 5 +++--
>>  tests/qemu-iotests/026 | 5 ++++-
>>  tests/qemu-iotests/029 | 5 +++--
>>  tests/qemu-iotests/031 | 6 +++---
>>  tests/qemu-iotests/036 | 5 +++--
>>  tests/qemu-iotests/039 | 3 +++
>>  tests/qemu-iotests/046 | 2 ++
>>  tests/qemu-iotests/048 | 2 ++
>>  tests/qemu-iotests/051 | 5 +++--
>>  tests/qemu-iotests/058 | 5 +++--
>>  tests/qemu-iotests/060 | 6 ++++--
>>  tests/qemu-iotests/061 | 6 ++++--
>>  tests/qemu-iotests/062 | 2 +-
>>  tests/qemu-iotests/066 | 2 +-
>>  tests/qemu-iotests/067 | 6 ++++--
>>  tests/qemu-iotests/068 | 5 +++--
>>  tests/qemu-iotests/071 | 3 +++
>>  tests/qemu-iotests/073 | 2 ++
>>  tests/qemu-iotests/074 | 2 ++
>>  tests/qemu-iotests/080 | 5 +++--
>>  tests/qemu-iotests/090 | 2 ++
>>  tests/qemu-iotests/098 | 6 ++++--
>>  tests/qemu-iotests/099 | 3 ++-
>>  tests/qemu-iotests/103 | 5 +++--
>>  tests/qemu-iotests/108 | 6 ++++--
>>  tests/qemu-iotests/112 | 5 +++--
>>  tests/qemu-iotests/114 | 2 ++
>>  tests/qemu-iotests/121 | 3 +++
>>  tests/qemu-iotests/138 | 2 ++
>>  tests/qemu-iotests/156 | 2 ++
>>  tests/qemu-iotests/176 | 7 +++++--
>>  tests/qemu-iotests/191 | 2 ++
>>  tests/qemu-iotests/201 | 6 +++---
>>  tests/qemu-iotests/214 | 3 ++-
>>  tests/qemu-iotests/217 | 3 ++-
>>  tests/qemu-iotests/220 | 5 +++--
>>  tests/qemu-iotests/243 | 6 ++++--
>>  tests/qemu-iotests/244 | 5 +++--
>>  tests/qemu-iotests/250 | 2 ++
>>  tests/qemu-iotests/267 | 5 +++--
>>  42 files changed, 117 insertions(+), 52 deletions(-)

[...]

>> diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
>> index c44fcf91bb..646ecd593f 100755
>> --- a/tests/qemu-iotests/031
>> +++ b/tests/qemu-iotests/031
>> @@ -40,9 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qcow2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -# We want to test compat=3D0.10, which does not support refcount widths
>> -# other than 16
>> -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
>> +# We want to test compat=3D0.10, which does not support external data
>> +# files or refcount widths other than 16
>> +_unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
>=20
> This is maybe another reason to split this test for compat=3D0.10 and for=
 compat=3D1.1
> But still can be done later of course.

Hm, but I don=E2=80=99t really think this test is important for external da=
ta
files.  There is no I/O.

[...]

>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>> index bbaf0ef45b..512598421c 100755
>> --- a/tests/qemu-iotests/036
>> +++ b/tests/qemu-iotests/036
>> @@ -43,8 +43,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qcow2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -# Only qcow2v3 and later supports feature bits
>> -_unsupported_imgopts 'compat=3D0.10'
>> +# Only qcow2v3 and later supports feature bits;
>> +# qcow2.py does not support external data files
>=20
> Minor nitpick, maybe tag this with TODO or so. No need to do now.

Hm, well, and the same applies here.  (Just not a very important test.)

[...]

>> diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
>> index 4e03ead7b1..a066eec605 100755
>> --- a/tests/qemu-iotests/046
>> +++ b/tests/qemu-iotests/046
>> @@ -38,6 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file
>> +# data_file does not support compressed clusters
>> +_unsupported_imgopts data_file
> This is a very nice test, which doesn't seem to  use compressed
> clusters that much. I think it should be split as well.
> No need to do this now of course, but maybe mark with TODO to=20
> avoid loosing that info.

The other problem is that blkdebug doesn=E2=80=99t work so well with extern=
al
data files, so basically this whole test doesn=E2=80=99t work.

[...]

>> diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
>> index a8feb76184..2af6b74b41 100755
>> --- a/tests/qemu-iotests/048
>> +++ b/tests/qemu-iotests/048
>> @@ -49,6 +49,8 @@ _compare()
>>  _supported_fmt raw qcow2 qed luks
>>  _supported_proto file
>>  _supported_os Linux
>> +# Using 'cp' is incompatible with external data files
>> +_unsupported_imgopts data_file
> You could compare the external files instead in theory *I think*.
> Another item on some TODO list I guess.

This is a test of qemu-img compare, not of the image format.  So it
doesn=E2=80=99t make much sense to me to compare the external files, and al=
so it
should be completely sufficient to run this test only without external
data files.

[...]

>> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
>> index 9cd1d60d45..0053bad46a 100755
>> --- a/tests/qemu-iotests/051
>> +++ b/tests/qemu-iotests/051
>> @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  # A compat=3D0.10 image is created in this test which does not support =
anything
>> -# other than refcount_bits=3D16
> Here also the compat=3D0.10 image is only a small part of the test,
> although it seems to get used later in the rest of the test,
>=20
> so the test I think should be split so that rest of the test could run in=
 all
> configurations.=20

This too isn=E2=80=99t an image format test (specifically, there=E2=80=99s =
no I/O but
for the snapshotting test, which mostly uses a different image anyway),
so I don=E2=80=99t think it=E2=80=99s necessary to allow this test for data=
_file.

[...]

>> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
>> index 92243c2edd..8ad0d7a904 100755
>> --- a/tests/qemu-iotests/060
>> +++ b/tests/qemu-iotests/060
>> @@ -48,8 +48,10 @@ _filter_io_error()
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> -# These tests only work for compat=3D1.1 images with refcount_bits=3D16
>> -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]\|=
$\)\)'
>> +# These tests only work for compat=3D1.1 images without an external
>> +# data file with refcount_bits=3D16
> Yea, with all hardcoded offsets, that isn't going to work.

This isn=E2=80=99t about hardcoded offsets, it=E2=80=99s about the fact tha=
t the test
references data cluster that are part of the qcow2 file (i.e., not in an
external file).

[...]

>> diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
>> index ac0d2a9a3b..68e52a6402 100755
>> --- a/tests/qemu-iotests/062
>> +++ b/tests/qemu-iotests/062
>> @@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  # We need zero clusters and snapshots
>> -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]' data_fil=
e
>> =20
>>  IMG_SIZE=3D64M
>> =20
> Maybe split that test as well in the long run.

How would that be possible, though?  There is only a single test case here.

>> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
>> index 00eb80d89e..0fff3e3a52 100755
>> --- a/tests/qemu-iotests/066
>> +++ b/tests/qemu-iotests/066
>> @@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  # We need zero clusters and snapshots
>> -_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]' data_fil=
e
> Yet again, one small test case forcing the whole test to be skipped.
> This should be split as well eventually.

This I agree with.

>> diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
>> index 926c79b37c..3bc6e719eb 100755
>> --- a/tests/qemu-iotests/067
>> +++ b/tests/qemu-iotests/067
>> @@ -32,8 +32,10 @@ status=3D1=09# failure is the default!
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -# Because anything other than 16 would change the output of query-block
>> -_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
>> +# Because anything other than 16 would change the output of query-block=
,
>> +# and external data files would change the output of
>> +# query-named-block-ndoes
>> +_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)' data_file
> OK. There probably is a way to filter that, but I don't know if this is w=
orth it.

Not really, because this again isn=E2=80=99t really a test of the image for=
mat.

[...]

>> diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
>> index e684b1b780..903dc9c9ab 100755
>> --- a/tests/qemu-iotests/073
>> +++ b/tests/qemu-iotests/073
>> @@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _unsupported_proto vxhs
>> +# External data files do not support compressed clusters
>> +_unsupported_imgopts data_file
> This test should be split as well eventually.

Hm, yes.  I don=E2=80=99t know if it can be fully split.  I think what woul=
d
work is a trimmed down copy just for external data files, but, well...

[...]

>> diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
>> index b1ecafb41e..a3d13c414e 100755
>> --- a/tests/qemu-iotests/080
>> +++ b/tests/qemu-iotests/080
>> @@ -40,9 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> -# - Internal snapshots are (currently) impossible with refcount_bits=3D=
1
>> +# - Internal snapshots are (currently) impossible with refcount_bits=3D=
1,
>> +#   and generally impossible with external data files
>>  # - This is generally a test for compat=3D1.1 images
>> -_unsupported_imgopts 'refcount_bits=3D1[^0-9]' 'compat=3D0.10'
>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file 'compat=3D0.10=
'
> I would more say that the test is too hardcoded for more that exact
> settings it expects. It is all right in this case IMHO.
> ACK.

I suppose we=E2=80=99d want a different test for data file validation, if
anything, but I don=E2=80=99t think there is anything to validate there...

[...]

>> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
>> index 700068b328..1e29d96b3d 100755
>> --- a/tests/qemu-iotests/098
>> +++ b/tests/qemu-iotests/098
>> @@ -40,8 +40,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -# The code path we want to test here only works for compat=3D1.1 images
>> -_unsupported_imgopts 'compat=3D0.10'
>> +# The code path we want to test here only works for compat=3D1.1 images=
;
>> +# blkdebug can only inject errors on bs->file, so external data files
>> +# do not work with this test
>> +_unsupported_imgopts 'compat=3D0.10' data_file
> ACK, but this is already 3rd test we loose. Maybe add to a TODO to extend=
 blkdebug
> to access data file as well.

That won=E2=80=99t work, though.  The problem is that in the block graph,
blkdebug just exists between the format and the file node.  You=E2=80=99d n=
eed a
second instance above the external data file node, but then those
instances wouldn=E2=80=99t share data, and qcow2 only issues blkdebug event=
s to
the file node.

One could make qcow2 duplicate all events to the data file, but then you
still wouldn=E2=80=99t share the same state in both instances.

In all, it would just be a mess.

>> diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
>> index b383c11e6a..65e8e92572 100755
>> --- a/tests/qemu-iotests/099
>> +++ b/tests/qemu-iotests/099
>> @@ -46,8 +46,9 @@ _supported_fmt qcow qcow2 qed vdi vhdx vmdk vpc
>>  _supported_proto file
>>  _supported_os Linux
>>  _require_drivers blkdebug blkverify
>> +# data_file would change the json:{} filenames
> True but maybe still worth it to support the case?

I don=E2=80=99t think so, because this is specifically a test to check thos=
e
filenames.

[...]

>> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
>> index 554b9de054..8c1ebe0443 100755
>> --- a/tests/qemu-iotests/103
>> +++ b/tests/qemu-iotests/103
>> @@ -38,8 +38,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file nfs
>> -# Internal snapshots are (currently) impossible with refcount_bits=3D1
>> -_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
>> +# Internal snapshots are (currently) impossible with refcount_bits=3D1,
>> +# and generally impossible with external data files
>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file
> ACK.
> The test also only needs the snapshot in a part of it, so maybe split as =
well
> later.

But this test too is just an interface test, so I don=E2=80=99t quite see t=
he need.

[...]

>> diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
>> index f90a744fc0..26104fff6c 100755
>> --- a/tests/qemu-iotests/114
>> +++ b/tests/qemu-iotests/114
>> @@ -39,6 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _unsupported_proto vxhs
>> +# qcow2.py does not work too well with external data files
> ACK, but should be fixed later.

Probably, but I don=E2=80=99t think this test would benefit much from it.
(Because it isn=E2=80=99t too important to be able to run this with an exte=
rnal
data file)

[...]

>> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
>> index 66ae9d5e78..7b0bc62a74 100755
>> --- a/tests/qemu-iotests/138
>> +++ b/tests/qemu-iotests/138
>> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> +# These refcount calculations do not work with external data files
>> +_unsupported_imgopts data_file
> Thats why I don't like the hardcoded tests that much.

Good point.  I was wondering what the problem was here because I was
sure it didn=E2=80=99t have anything to do with something hard-coded, and i=
t
doesn=E2=80=99t.

The actual reason is simply that there is no refcounting for external
data files.  I=E2=80=99ll fix the comment.

>> diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
>> index 3f27db71f2..5559df63a5 100755
>> --- a/tests/qemu-iotests/156
>> +++ b/tests/qemu-iotests/156
>> @@ -51,6 +51,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2 qed
>>  _supported_proto generic
>>  _unsupported_proto vxhs
>> +# Copying files around with cp does not work with external data files
>> +_unsupported_imgopts data_file
> Another place to fix later I guess.

I don=E2=80=99t know, this type of storage migration simply doesn=E2=80=99t=
 work this
way with external data files.

Max


--E43Wmmo5uf9Ndj2PhwmYG4ODoqBnJZQxj--

--um9moCoB39sbddOLkyBcij1Aaz01TM9rA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3EAbcACgkQ9AfbAGHV
z0C3+Af8DZNaZbb+uY9hggxhkMwwOpWIKaxRdon7lD+fNbhzGGuV+tHS6RruCNTr
3/R5eNUUMzZIz8HRf5ZFaD0E1p+nLOdX4FlsKHQny9pyZBL0/+T0KdQszD/QGZtu
QBwCucqlvrOyAm7ofyFAtOr/lU3Jy9Bee5TEyBS6FpZQXl/2u+w7gkHRb5R74t/2
L7Kq8a1oOf2p9RkrVqYU/G4bB58+WzBOFnolS5FXesjxF8OHxIoRg9k/GLDdKfGy
uY7/h2uObJkKCNJLkIXSxMI16k86sxHciKmUsoPo2X6cVYPmYK+qRW9rDJHfIv4E
6GJ4jlpRo4Q/gHrLzarvkkDXpcnKng==
=ctK2
-----END PGP SIGNATURE-----

--um9moCoB39sbddOLkyBcij1Aaz01TM9rA--


