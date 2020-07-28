Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A898C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D0B206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIiejBUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D0B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QAS-00006w-8K
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0Q9b-00083S-Uv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:00:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0Q9a-0005TD-CN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XdRx9RfntRvN1LAdfUlY4UXQyYIsAs8rH8Ht/mUNM3M=;
 b=GIiejBUZZq/3gDy6Uh6GmX2wKEH2QyepuRB1S7lD5Hj9GsjB3vElOw4r2w5EqVZUfD3bxh
 kjgDgFDfwDetLHAShI/3kRl6tOgLdlt6zDgXCaFH9a3TMfQCcgOVVGYtgMTbZ/XpU5i3Hp
 TW1VCknmoErtkIAm3dg61gAPceNdN7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-VQmQ6mGQNQeqdg_SzDcbvQ-1; Tue, 28 Jul 2020 10:00:20 -0400
X-MC-Unique: VQmQ6mGQNQeqdg_SzDcbvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D348E101C8AB;
 Tue, 28 Jul 2020 14:00:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-145.ams2.redhat.com
 [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2B060BF4;
 Tue, 28 Jul 2020 14:00:18 +0000 (UTC)
Subject: Re: [PATCH v7 44/47] iotests: Add filter commit test cases
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-45-mreitz@redhat.com>
 <2c1c30da-a1e5-3bc6-0620-50ebdccb7dfc@virtuozzo.com>
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
Message-ID: <6a0540c2-d6f2-a59d-0ba0-11572f9897e6@redhat.com>
Date: Tue, 28 Jul 2020 16:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c1c30da-a1e5-3bc6-0620-50ebdccb7dfc@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tCypa2MSY19Upn9GHsvccJ2BBVXPIcL9S"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
--tCypa2MSY19Upn9GHsvccJ2BBVXPIcL9S
Content-Type: multipart/mixed; boundary="iQz2pz1rHUVm2IQldPZf82CXMg4knMzNF"

--iQz2pz1rHUVm2IQldPZf82CXMg4knMzNF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.07.20 19:45, Andrey Shinkevich wrote:
> On 25.06.2020 18:22, Max Reitz wrote:
>> This patch adds some tests on how commit copes with filter nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/040=C2=A0=C2=A0=C2=A0=C2=A0 | 177 ++++++++++++=
+++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/040.out |=C2=A0=C2=A0 4 +-
>> =C2=A0 2 files changed, 179 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
>> index 32c82b4ec6..e7fa244738 100755
>> --- a/tests/qemu-iotests/040
>> +++ b/tests/qemu-iotests/040
>> @@ -713,6 +713,183 @@ class TestErrorHandling(iotests.QMPTestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(i=
otests.compare_images(mid_img, backing_img,
>> fmt2=3D'raw'),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'target image does not match source after
>> commit')
>> =C2=A0 +class TestCommitWithFilters(iotests.QMPTestCase):
>> +=C2=A0=C2=A0=C2=A0 img0 =3D os.path.join(iotests.test_dir, '0.img')
>> +=C2=A0=C2=A0=C2=A0 img1 =3D os.path.join(iotests.test_dir, '1.img')
>> +=C2=A0=C2=A0=C2=A0 img2 =3D os.path.join(iotests.test_dir, '2.img')
>> +=C2=A0=C2=A0=C2=A0 img3 =3D os.path.join(iotests.test_dir, '3.img')
>> +
>> +=C2=A0=C2=A0=C2=A0 def do_test_io(self, read_or_write):
>=20
>=20
> The method defenition could be moved down after the ones of setUp() and
> tearDown().

Yes, but it=E2=80=99s used by setUp(), so I thought maybe it=E2=80=99s nice=
r to place it
first.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for index, pattern_file in e=
numerate(self.pattern_files):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resu=
lt =3D qemu_io('-f', iotests.imgfmt,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 '-c', '{} -P {} {}M
>> 1M'.format(read_or_write,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index +
>> 1, index),
>=20
>=20
> The Python3 format string f'{rad_or_write} ..' might be used instead of
> the .format one.

Ah, sure.  The test is a bit older already, from when we didn=E2=80=99t yet=
 use
format strings as often in the iotests. :)

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pattern_file)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertFalse('Pattern verification failed' in result)
>> +
>> +=C2=A0=C2=A0=C2=A0 def setUp(self):
>=20
> ...
>=20
>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>=20
>=20



--iQz2pz1rHUVm2IQldPZf82CXMg4knMzNF--

--tCypa2MSY19Upn9GHsvccJ2BBVXPIcL9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8gL3AACgkQ9AfbAGHV
z0AwUggAqJMiQAxn477NrET4kk302zpWMaUdAYJ5KvDTBYDhV5OA8FVstGxPmdy3
onRQqLfCkuALu3v2MYpLPcd2Z3R7/wv2O3xv/zOdYXsNbXkc0ayXKMY6kzaLRdLJ
RQSwYYVIRvXhyatjgFsNrZkY9BsT6E7e47NH58DHnbmc/RzJ6WPDYnI+vjMPPRie
FauRVk2yPSRS6ZzBR/7UYGgbxbsRCXliRZhpAuvE7COcwFP6MZz+ofYIGipENk5L
BbCNq4YMgwZYA52c1Zo+tHdBf1fpoGVvvIyFC+ZzdHiUJ2NKFsMv0Fl+waMl8ZKG
Yn5m2vRCG1f1nLVgpvD6V6VFKGR8Kw==
=A4aj
-----END PGP SIGNATURE-----

--tCypa2MSY19Upn9GHsvccJ2BBVXPIcL9S--


