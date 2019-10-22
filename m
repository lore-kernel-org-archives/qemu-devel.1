Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C14BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F2E2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP6puUVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F2E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqTx-0005Iy-Cz
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMqT2-0004Qq-V0
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMqT0-0002hc-FQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMqT0-0002h0-44
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571736516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FD1alTZMj9lSgS/9kAWhN36C1BGxCnGHb/CAdOfOrJ8=;
 b=cP6puUVHfwnzpLaiqY295VSyKe3qcIuSdGO5x5sCNSSaCSu3YXgcSRt7ldZtHZCTSR50aD
 yyPbDcboGd5agfL1GsP06eOrIOZ6vSX6NDdrlVhMtKv0B/q2M9aGbsDqv2WxzHgnW57+R4
 waOydykxUlR+befXcngQ4sVealz1uWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-qsTNNn3TPy-NULVHRp82Rw-1; Tue, 22 Oct 2019 05:28:35 -0400
X-MC-Unique: qsTNNn3TPy-NULVHRp82Rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0201005512;
 Tue, 22 Oct 2019 09:28:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A28E5DA8D;
 Tue, 22 Oct 2019 09:28:31 +0000 (UTC)
Subject: Re: [PATCH v5 4/4] tests/qemu-iotests: add case for block-stream
 compress
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-5-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <b707d68c-f9c0-2264-04ac-2070c969770f@redhat.com>
Date: Tue, 22 Oct 2019 11:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571603828-185910-5-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TtRsnYoRsuv2o8nnHHx9C5zvrn6tusF2s"
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 armbru@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TtRsnYoRsuv2o8nnHHx9C5zvrn6tusF2s
Content-Type: multipart/mixed; boundary="xmCNGnNnlgoq3M63tI8vhAC31g5lrKWsH"

--xmCNGnNnlgoq3M63tI8vhAC31g5lrKWsH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.10.19 22:37, Andrey Shinkevich wrote:
> Add a case to the iotest #030 that tests the 'compress' option for a
> block-stream job.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/030     | 34 +++++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/030.out |  4 ++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index f3766f2..f33fd21 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -21,7 +21,8 @@
>  import time
>  import os
>  import iotests
> -from iotests import qemu_img, qemu_io
> +from iotests import qemu_img, qemu_io, qemu_img_pipe
> +import json
> =20
>  backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
>  mid_img =3D os.path.join(iotests.test_dir, 'mid.img')
> @@ -956,6 +957,37 @@ class TestSetSpeed(iotests.QMPTestCase):
> =20
>          self.cancel_and_wait(resume=3DTrue)
> =20
> +class TestCompressed(iotests.QMPTestCase):
> +    allocated_clusters =3D 8
> +
> +    def setUp(self):
> +        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
> +        qemu_img('create', '-f', iotests.imgfmt, '-o',
> +                 'backing_file=3D{}'.format(backing_img), test_img)
> +        cluster_size =3D 0x10000
> +        data_size =3D self.allocated_clusters * cluster_size
> +        qemu_io('-c', 'write -P 0x1 0 {}'.format(data_size), backing_img=
)
> +        self.vm =3D iotests.VM().add_drive(test_img, "compress=3Don")

I don=E2=80=99t think it makes sense to add a drive with compress=3Don to a=
 VM.
If the VM writes to any cluster more than once, the request will fail.

> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        os.remove(test_img)
> +        os.remove(backing_img)
> +
> +    def test_stream_compress(self):
> +        self.assert_no_active_block_jobs()
> +
> +        result =3D self.vm.qmp('block-stream', device=3D'drive0')
> +        self.assert_qmp(result, 'return', {})

In this example, it=E2=80=99s actually even a bit worse: The VM might be aw=
are
that it may only write to each cluster exactly once.  But if it writes
to any of the first eight clusters after the stream job as done so
(invisibly to the VM guest), it will get an error.

You could see that by adding a qemu-io write here and see that it fails.
 (In practice you won=E2=80=99t because the error goes to stdout and that i=
s
lost in Python tests).

Max

> +        match =3D {'data': {'type': 'stream', 'device': 'drive0'}}
> +        self.vm.event_wait(name=3D'BLOCK_JOB_COMPLETED', match=3Dmatch)
> +        self.vm.shutdown()
> +
> +        top =3D json.loads(qemu_img_pipe('check', '--output=3Djson', tes=
t_img))
> +        self.assertEqual(top['compressed-clusters'], self.allocated_clus=
ters)
> +
>  if __name__ =3D=3D '__main__':
>      iotests.main(supported_fmts=3D['qcow2', 'qed'],
>                   supported_protocols=3D['file'])
> diff --git a/tests/qemu-iotests/030.out b/tests/qemu-iotests/030.out
> index 6d9bee1..af8dac1 100644
> --- a/tests/qemu-iotests/030.out
> +++ b/tests/qemu-iotests/030.out
> @@ -1,5 +1,5 @@
> -...........................
> +............................
>  ----------------------------------------------------------------------
> -Ran 27 tests
> +Ran 28 tests
> =20
>  OK
>=20



--xmCNGnNnlgoq3M63tI8vhAC31g5lrKWsH--

--TtRsnYoRsuv2o8nnHHx9C5zvrn6tusF2s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2uy70ACgkQ9AfbAGHV
z0ApVQf/ZYvd5N89IBoQ7WJNlsMin7tuua5l54S+kWnarWJNUEtOvM3W2Xez1zzC
S1p3o0Lae23AUj0bTLlQYOKyz5dw+Qbhqt1/kg6xnZixbMn6dMMDQjhnPDpJggdm
1F1q39O4lcIW5OitwC+0jFdFETh9IrJ5OLC18KbmZE3/WfXbJatngK5tEkrVR63c
Urbyl1Gg9aHRCY0wXe3/4EXH0sbkRWqFgRDSps4V1X6XV2MIIfRVEDsk33rMge0p
2YM0tvzr7m0llFc2/Q5ptPi5SClsqITuETth0CFeOURbTjcg64w+LSeVEMhZlhY3
FPfVsjaytnpvEPUGnBpVm8Q7oWbM7w==
=K2La
-----END PGP SIGNATURE-----

--TtRsnYoRsuv2o8nnHHx9C5zvrn6tusF2s--


