Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC06C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D3A2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D3A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8oy-0008FJ-CA
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:56:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP8bS-0003Kb-Ld
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP8bR-0001xz-Ms
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hP8bM-0001vu-N9; Fri, 10 May 2019 12:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DB1B81F2F;
	Fri, 10 May 2019 16:42:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-72.ams2.redhat.com [10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8BAE608C2;
	Fri, 10 May 2019 16:42:24 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<b121ec96-4cfe-47fe-0415-533cfd842777@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <0eb76ceb-8fdd-6db3-86ff-b0aa7ca32141@redhat.com>
Date: Fri, 10 May 2019 18:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b121ec96-4cfe-47fe-0415-533cfd842777@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Z3IOb6egV9itUuA4mlsm5eUgNoUcnxPmV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 10 May 2019 16:42:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z3IOb6egV9itUuA4mlsm5eUgNoUcnxPmV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/05/2019 15.54, Max Reitz wrote:
> On 28.04.19 17:18, Thomas Huth wrote:
>> QEMU iotest 175 is failing for me when I run it with -raw:
>>
>> $ ./check -raw 175
>> QEMU          --
>> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qe=
mu-system-x86_64"
>> -nodefaults -machine accel=3Dqtest
>> QEMU_IMG      --
>> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache=

>> writeback -f raw
>> QEMU_NBD      --
>> "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- raw
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
>> TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch=

>> SOCKET_SCM_HELPER --
>> /home/thuth/tmp/qemu-build/tests/qemu-iotests/socket_scm_helper
>>
>> 175         - output mismatch (see 175.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/175.out	2019-04-23
>> 16:43:12.000000000 +0200
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/175.out.bad	2019-04-=
28
>> 17:17:32.000000000 +0200
>> @@ -2,17 +2,17 @@
>>
>>  =3D=3D creating image with default preallocation =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
>> -size=3D1048576, blocks=3D0
>> +size=3D1048576, blocks=3D2
>>
>>  =3D=3D creating image with preallocation off =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloca=
tion=3Doff
>> -size=3D1048576, blocks=3D0
>> +size=3D1048576, blocks=3D2
>>
>>  =3D=3D creating image with preallocation full =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloca=
tion=3Dfull
>> -size=3D1048576, blocks=3D2048
>> +size=3D1048576, blocks=3D2050
>>
>>  =3D=3D creating image with preallocation falloc =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
>> preallocation=3Dfalloc
>> -size=3D1048576, blocks=3D2048
>> +size=3D1048576, blocks=3D2050
>>   *** done
>> Failures: 175
>> Failed 1 of 1 tests
>>
>> Any ideas how to fix this?
>=20
> Hm.  What output does
>=20
> $ touch foo
> $ stat -c "size=3D%s, blocks=3D%b" foo
> $ truncate -s 1M foo
> $ stat -c "size=3D%s, blocks=3D%b" foo
>=20
> give for you?
>=20
> If any of that returns blocks=3D2, we can probably just use that operat=
ion
> to fix the result, then.

$ stat -c "size=3D%s, blocks=3D%b" foo
size=3D0, blocks=3D2
$ truncate -s 1M foo
$ stat -c "size=3D%s, blocks=3D%b" foo
size=3D1048576, blocks=3D2

 Thomas


--Z3IOb6egV9itUuA4mlsm5eUgNoUcnxPmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJc1anvAAoJEC7Z13T+cC21A3MQAJqkgxMighd2fbplwfELPIxY
8g61pVcF4qEqWnplVZ5F9Iq3MpCU0kG3ZLw/UnVaHSNe8bd6w8ZKTu7PDbptgrgZ
HHPZxcwpKGSsZrOT5EBmNAE4PtjkmMBdwjSDApRoUN3NBboQow5sVBtYxhbXLmv7
RlxpsyykeL2TyMy9ZwJjuhiydb74KUGIbqLDnK+jX4QYx1vspzUYJygkor+z2ryd
C2zwppqrxvUjLQ2dMYingLf88HbPQgP/Rn2UsJY4lfIzEGOVWwp4/eycxLLaqcDr
CwLFg7yx9QQXw/Za/LVs5UIzpRCgTlzJ4X8aIG42dEMk7HUeFDF77hD/wEJCOCx7
jn3DQqN3pmRUS6gtfbwXPzXL0B/CEwTE44XyOR+Zb9G/Q77/e/0PmefPPa1H8lqs
ArkVBC/sNpvx1+WfHs03EAvLjX+rijp+DK3dfd4dB9Mv264BRG+L0+QVXtHZk/cg
VvpjQsPdHY+ogMB9z3frT0QPzmXGeJfrO06xXUvgTLT1GARe1KW8fC7t7c4Q+WKc
20gH8r+S5Ut/InI2ZEajRykpqJ2Kap77CMurDpFtwv+q8rCESftOTcxmdOZFYd3w
CdZlZt6Ldpnh5TsVl+Q3hCBinLsPAjIIaCU5ufoPlyc51a4FW+l+1dCBCsWSimB6
jj3tMFZX4vqhy4Q1/zkF
=avrF
-----END PGP SIGNATURE-----

--Z3IOb6egV9itUuA4mlsm5eUgNoUcnxPmV--

