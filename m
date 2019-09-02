Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBCC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C2420449
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C2420449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nvt-0005xA-ID
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 11:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4nv6-0005Mx-Sy
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4nv5-00053D-Pg
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4nv2-0004vU-Sl; Mon, 02 Sep 2019 11:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09CB93082126;
 Mon,  2 Sep 2019 15:07:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE3660C05;
 Mon,  2 Sep 2019 15:06:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-40-mreitz@redhat.com>
 <098d2ce3-5ff1-8b27-cada-1f738011424d@virtuozzo.com>
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
Message-ID: <50e2621b-d6f2-186a-4b40-6cf563d62d8b@redhat.com>
Date: Mon, 2 Sep 2019 17:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <098d2ce3-5ff1-8b27-cada-1f738011424d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jEZ1K2hKTka4pXXOsEKAPaa7bzChiwSyr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 02 Sep 2019 15:07:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 39/42] iotests: Add filter commit test
 cases
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jEZ1K2hKTka4pXXOsEKAPaa7bzChiwSyr
Content-Type: multipart/mixed; boundary="3w1nw2GeFcMoD1zg0lOtTwbL67JCBK1rh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <50e2621b-d6f2-186a-4b40-6cf563d62d8b@redhat.com>
Subject: Re: [PATCH v6 39/42] iotests: Add filter commit test cases
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-40-mreitz@redhat.com>
 <098d2ce3-5ff1-8b27-cada-1f738011424d@virtuozzo.com>
In-Reply-To: <098d2ce3-5ff1-8b27-cada-1f738011424d@virtuozzo.com>

--3w1nw2GeFcMoD1zg0lOtTwbL67JCBK1rh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.08.19 13:41, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:14, Max Reitz wrote:
>> This patch adds some tests on how commit copes with filter nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/040     | 177 +++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/040.out |   4 +-
>>   2 files changed, 179 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
>> index 6db9abf8e6..a0a0db8889 100755
>> --- a/tests/qemu-iotests/040
>> +++ b/tests/qemu-iotests/040

[...]

>> +    def tearDown(self):
>> +        self.vm.shutdown(has_quit=3Dself.has_quit)
>> +
>> +        for index in range(len(self.pattern_files)):
>=20
> you may use enumerate for such cases:
> for ind, file in enumerate(self.pattern_files):
>     ...

Ah, nice.

>> +            result =3D qemu_io('-f', iotests.imgfmt,
>> +                             '-c', 'read -P %i %iM 1M' % (index + 1, =
index),
>> +                             self.pattern_files[index])
>> +            self.assertFalse('Pattern verification failed' in result)=

>=20
> A bit better would be to keep this loop in a function and do "writes" t=
hrough it too,
> to make it more obvious that they are the same.. But I'm OK with it as =
is.

Hm, yes.  I=E2=80=99ll have a look.

>> +
>> +        os.remove(self.img3)
>> +        os.remove(self.img2)
>> +        os.remove(self.img1)
>> +        os.remove(self.img0)
>> +
>> +    # Filters make for funny filenames, so we cannot just use
>> +    # self.imgX to get them
>> +    def get_filename(self, node):
>> +        return self.vm.node_info(node)['image']['filename']
>> +
>=20
> maybe:
> def assertHasNode(self, node_name):
>    self.assertIsNotNone(self.vm.node_info(node_name))
>=20
> and similar for assertNoNode...

Hm, I don=E2=80=99t know.  It fits on one line either way.

>> +    def test_filterless_commit(self):
>> +        self.assert_no_active_block_jobs()
>=20
> why not just to include this call into setUp() ? Or even, just drop it?=

> We create and start new vm in setUp, it don't have any block jobs for s=
ure.

Other tests do it the same way, e.g. 030, 040, and 041.

[...]

>> +        self.assertIsNone(self.vm.node_info('top-filter'))
>> +        self.assertIsNone(self.vm.node_info('cow-3'))
>> +        self.assertIsNotNone(self.vm.node_info('cow-2'))
>=20
> It would be good to assert here the cow-2 became drv0 child. However, o=
therwise
> it should be automatically dropped, so it's not necessary.

Yep, like cow-3.  I=E2=80=99ll look into it anyway.

>> +
>> +        # 3 has been comitted into 2
>> +        self.pattern_files[3] =3D self.img2
>> +
>> +    def test_filtered_active_commit_without_filter(self):
>> +        self.assert_no_active_block_jobs()
>> +        result =3D self.vm.qmp('block-commit',
>> +                             job_id=3D'commit',
>> +                             device=3D'top-filter',
>> +                             top_node=3D'cow-3',
>> +                             base_node=3D'cow-2')
>> +        self.assert_qmp(result, 'return', {})
>=20
> can we check that really "active" commit is started, i.e. mirror block =
job?

We do:

>> +        self.complete_and_wait(drive=3D'commit')

wait_ready is True by default, so this will first wait for a READY
event.  That only happens for active commit.

Max


--3w1nw2GeFcMoD1zg0lOtTwbL67JCBK1rh--

--jEZ1K2hKTka4pXXOsEKAPaa7bzChiwSyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tMBEACgkQ9AfbAGHV
z0CHOQf/egz0+55KtggHmWp/nyWBL4TjM05DyZ5L/lsdz8PLOBJJo6r+eCQpQiVu
aPJByH6gNW08oOFb0ldg97WDmyRuSR/XJCsJRMp39kF2D9adcADtNVjSXoqCT7Rw
0Sa0QX9N+brqtlMWSPpfm7NManZEBb0tFy1Gl8+JQAhds9QYKkov9QM3G56xVKyH
FJNu5jdqAZhdJntlNI1KP1e8yxp0ICZdJcXq+3Q/TflE6iTYW1fP4Md0HBr4Uuiy
uYEDe2RmXGlrcPBsyIVIBcrHv3ujq4gxBLj0Ry0VOE0j3djOzImBUjsai/q0/VKn
MzDr2YMf6QJeoNtb6DN0VISXmeS4Sg==
=I3e0
-----END PGP SIGNATURE-----

--jEZ1K2hKTka4pXXOsEKAPaa7bzChiwSyr--

