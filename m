Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9827BC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637912178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCYDDXF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637912178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdos-0003g6-Iw
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSdm7-0002O4-JH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSdm5-0004SA-Ad
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:08:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSdm5-0004Ny-5J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573117696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YjhIwwdI94Qc4SsV/IdGN3LfiEMkB8VASNC8ENkojJI=;
 b=GCYDDXF+pB4BqaLGO8o7w8MQMy7LiDJ/Z3F7chd37ujqwt+OMO3nBPAE5/NlglavlCmupT
 rBr+k1IA6CzNdDC3RwH+hHXvYHoxHFoScrzggn/5PMluwM3ICRcgm/7E0uN8k71UIBrexq
 oWZLP1bZuqh1gR81+ae2ewTNIIwRmww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-ecPVFrpCObqMGXxrCiJTkg-1; Thu, 07 Nov 2019 04:08:09 -0500
X-MC-Unique: ecPVFrpCObqMGXxrCiJTkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54A7E1800D6B;
 Thu,  7 Nov 2019 09:08:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-202.ams2.redhat.com
 [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35B3E60BE0;
 Thu,  7 Nov 2019 09:08:07 +0000 (UTC)
Subject: Re: [PATCH v2 05/21] iotests: Replace IMGOPTS by _unsupported_imgopts
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-6-mreitz@redhat.com>
 <4d3ed1468e966b14aa5b6453327be0710bc26ed7.camel@redhat.com>
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
Message-ID: <7e3bbbb8-416b-eae9-7e51-a816045b83dd@redhat.com>
Date: Thu, 7 Nov 2019 10:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4d3ed1468e966b14aa5b6453327be0710bc26ed7.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oyr5nmyl0wS8KQX9azl1UH8GOzwtrEbAC"
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
--oyr5nmyl0wS8KQX9azl1UH8GOzwtrEbAC
Content-Type: multipart/mixed; boundary="3oaVv9M6aFewo6IKJx2VRwg4WgtFuD7CQ"

--3oaVv9M6aFewo6IKJx2VRwg4WgtFuD7CQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 16:45, Maxim Levitsky wrote:
> On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
>> Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
>> globally.  That is not how it should be done; instead, they should
>> simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
>> default anyway).
>>
>> This makes the tests heed user-specified $IMGOPTS.  Some do not work
>> with all image options, though, so we need to disable them accordingly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/036 | 3 +--
>>  tests/qemu-iotests/060 | 4 ++--
>>  tests/qemu-iotests/062 | 3 ++-
>>  tests/qemu-iotests/066 | 3 ++-
>>  tests/qemu-iotests/068 | 3 ++-
>>  tests/qemu-iotests/098 | 4 ++--
>>  6 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>> index 5f929ad3be..bbaf0ef45b 100755
>> --- a/tests/qemu-iotests/036
>> +++ b/tests/qemu-iotests/036
>> @@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qcow2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -
>>  # Only qcow2v3 and later supports feature bits
>> -IMGOPTS=3D"compat=3D1.1"
>> +_unsupported_imgopts 'compat=3D0.10'
>> =20
>>  echo
>>  echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
>> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
>> index b91d8321bb..9c2ef42522 100755
>> --- a/tests/qemu-iotests/060
>> +++ b/tests/qemu-iotests/060
>> @@ -48,6 +48,8 @@ _filter_io_error()
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> +# These tests only work for compat=3D1.1 images with refcount_bits=3D16
>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]\|=
$\)\)'
> Looks like the reason for that is that the test hardcodes (or guesses tha=
t is) various qcow2 structures
> thing I have seen few times already in the iotests.
> Not now but sometime in the future it would be nice to extend qcow2.py (o=
r something
> like that) to dump location of all qcow2 structures so that the guesswork=
 could be eliminated.

With the peek_file* functions we have now it=E2=80=99s actually simple to d=
ump
that location ($(peek_file_be "$TEST_IMG" 48 8) for the refcount table
offset, for example).

But it wouldn=E2=80=99t help, because compat=3D0.10 or refcount_bits !=3D 1=
6 won=E2=80=99t
change those locations.  So the locations aren=E2=80=99t the reason why we =
need
to forbid those options here.

The reason we need refcount_bits=3D16 is that we=E2=80=99re going to direct=
ly
manipulate a refcount block.  To do so, we need to know the refcount
width, and I don=E2=80=99t think it=E2=80=99s worth trying to implement som=
ething generic.

We need compat=3D1.1 because compat=3D0.10 doesn=E2=80=99t have feature bit=
s, so
there=E2=80=99s no =E2=80=9Ccorrupt=E2=80=9D bit there.

Max


--3oaVv9M6aFewo6IKJx2VRwg4WgtFuD7CQ--

--oyr5nmyl0wS8KQX9azl1UH8GOzwtrEbAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3D3vUACgkQ9AfbAGHV
z0Duhwf/RrPmrFSqJl3t7cnq40KqIrTc7BZOXiS0BIxa66Se+SzVOgzdqCRdbmcV
zq0RTWrEghn3wp/f9Y8fZ4huftSmrklJ7mZa9FkGP+z39M+O6bkexOfXkjIqoA4X
K42BwYSDi41QD1K3u7OuZEgxrTzhUBp5L6YPsXPtGpIIR9wP0Ivzk5P2otQtVc58
LA9RfQImpkDOCaY7w4euvWhCokrGYX40DbcZmOstegiva3i6XkVrjW/oW3DJTg+j
248ZYeqt/RjSTUBwhVhdVP6otqDoU4VCS3Igj3zPHUju+16coSxagOYthl2C4A64
MERPIszFbLuJ901MJppLpBwyJjzsLg==
=c7y/
-----END PGP SIGNATURE-----

--oyr5nmyl0wS8KQX9azl1UH8GOzwtrEbAC--


