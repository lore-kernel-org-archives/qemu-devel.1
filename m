Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18652C41517
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FAE22BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FAE22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgbX-0007s8-Ty
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36961)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqgaX-0003k9-Ik
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqgaV-0003wa-Aj
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:27:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqgaQ-0003rd-4a; Thu, 25 Jul 2019 12:27:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5DE0C302246C;
 Thu, 25 Jul 2019 16:27:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 915F15DE8E;
 Thu, 25 Jul 2019 16:27:19 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-10-mreitz@redhat.com>
 <70f1dff28165e6e2ae4443730f66ec36769c0394.camel@redhat.com>
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
Message-ID: <668f5e60-6eaa-4f32-0446-7f41885483b3@redhat.com>
Date: Thu, 25 Jul 2019 18:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <70f1dff28165e6e2ae4443730f66ec36769c0394.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zFiVQjZBUrqAgHgHOW2dULL7Usi9KLUXh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 25 Jul 2019 16:27:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/11] iotests: Convert to preallocated
 encrypted qcow2
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zFiVQjZBUrqAgHgHOW2dULL7Usi9KLUXh
Content-Type: multipart/mixed; boundary="oTTH8ugUQNplM9pApXr69uGAIvoRmG8Z0";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <668f5e60-6eaa-4f32-0446-7f41885483b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/11] iotests: Convert to preallocated
 encrypted qcow2
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-10-mreitz@redhat.com>
 <70f1dff28165e6e2ae4443730f66ec36769c0394.camel@redhat.com>
In-Reply-To: <70f1dff28165e6e2ae4443730f66ec36769c0394.camel@redhat.com>

--oTTH8ugUQNplM9pApXr69uGAIvoRmG8Z0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 17:30, Maxim Levitsky wrote:
> On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
>> Add a test case for converting an empty image (which only returns zero=
es
>> when read) to a preallocated encrypted qcow2 image.
>> qcow2_has_zero_init() should return 0 then, thus forcing qemu-img
>> convert to create zero clusters.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
>> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  tests/qemu-iotests/188     | 20 +++++++++++++++++++-
>>  tests/qemu-iotests/188.out |  4 ++++
>>  2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
>> index be7278aa65..afca44df54 100755
>> --- a/tests/qemu-iotests/188
>> +++ b/tests/qemu-iotests/188
>> @@ -48,7 +48,7 @@ SECRETALT=3D"secret,id=3Dsec0,data=3Dplatypus"
>> =20
>>  _make_test_img --object $SECRET -o "encrypt.format=3Dluks,encrypt.key=
-secret=3Dsec0,encrypt.iter-time=3D10" $size
>> =20
>> -IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,encrypt.key-sec=
ret=3Dsec0"
>> +IMGSPEC=3D"driver=3D$IMGFMT,encrypt.key-secret=3Dsec0,file.filename=3D=
$TEST_IMG"
> This change I think doesn't change anything
>=20
>> =20
>>  QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
>> =20
>> @@ -68,6 +68,24 @@ echo
>>  echo "=3D=3D verify open failure with wrong password =3D=3D"
>>  $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $I=
MGSPEC | _filter_qemu_io | _filter_testdir
>> =20
>> +_cleanup_test_img
>> +
>> +echo
>> +echo "=3D=3D verify that has_zero_init returns false when preallocati=
ng =3D=3D"
>> +
>> +# Empty source file
>> +if [ -n "$TEST_IMG_FILE" ]; then
>> +    TEST_IMG_FILE=3D"${TEST_IMG_FILE}.orig" _make_test_img $size
>> +else
>> +    TEST_IMG=3D"${TEST_IMG}.orig" _make_test_img $size
>> +fi
>=20
> I wonder why do we have TEST_IMG_FILE and TEST_IMG, I don't know iotest=
s well enough
> From the quick look at the code, the TEST_IMG_FILE is an actual file, w=
hile TEST_IMG can
> be various URL like address.

In theory, $TEST_IMG is what you give to the various qemu commands for
what you want to test.  It can be a URL, a plain path, or even in option
syntax (think file.filename=3D$TEST_IMG_FILE).  $TEST_IMG_FILE points to
the actual file on the local filesystem.

In practice, $TEST_IMG_FILE can be empty and then you only have
$TEST_IMG to work with.  Also, many tests only support the file protocol
anyway, which is exactly one such case, so they just use $TEST_IMG all
the time.

Max

>> +
>> +$QEMU_IMG convert -O "$IMGFMT" --object $SECRET \
>> +    -o "encrypt.format=3Dluks,encrypt.key-secret=3Dsec0,encrypt.iter-=
time=3D10,preallocation=3Dmetadata" \
>> +    "${TEST_IMG}.orig" "$TEST_IMG"
>> +
>> +$QEMU_IMG compare --object $SECRET --image-opts "${IMGSPEC}.orig" "$I=
MGSPEC"
>> +
>> =20
>>  # success, all done
>>  echo "*** done"
>> diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
>> index 97b1402671..c568ef3701 100644
>> --- a/tests/qemu-iotests/188.out
>> +++ b/tests/qemu-iotests/188.out
>> @@ -15,4 +15,8 @@ read 16777216/16777216 bytes at offset 0
>> =20
>>  =3D=3D verify open failure with wrong password =3D=3D
>>  qemu-io: can't open: Invalid password, cannot unlock any keyslot
>> +
>> +=3D=3D verify that has_zero_init returns false when preallocating =3D=
=3D
>> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D16777216
>> +Images are identical.
>>  *** done
>=20
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Best regards,
> 	Maxim Levitsky
>=20



--oTTH8ugUQNplM9pApXr69uGAIvoRmG8Z0--

--zFiVQjZBUrqAgHgHOW2dULL7Usi9KLUXh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl052GUACgkQ9AfbAGHV
z0DcKAf/RfFBbsrQp9rCGkPgQhvF1Q/XSvNc5X03By/TKusShhLOH2oU4BRNAuu/
e/2pLee9koySpU0n6uRHD8NuUw3/Uy2NP8uxKE8iBHIJjejp7IvkBAWSzZxa7Uxz
Yz2Ar07sPGZ1QrohQQ64tGu0+d+wMm2GgQo55kfA+fJjOSSZfmGlO5Uj9onXXru8
k6x5LtT4fqij0cji/oXPlffdrOWF1p7/F8pw/y1wpC84y4Gf2gyNbUqL/tYZkDb0
DWWec6VrpaU9v294bR73mO6cV1W7UJ/DGQMEZvAJcylT/5oeu58wucPc5o20t8jU
ItucgtvBIHbJcs2AjcdPQ/8EevgvDg==
=Gk9O
-----END PGP SIGNATURE-----

--zFiVQjZBUrqAgHgHOW2dULL7Usi9KLUXh--

