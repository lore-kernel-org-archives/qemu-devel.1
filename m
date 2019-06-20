Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3935C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AC9206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AC9206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2EB-00004r-Uv
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he1zM-0000sN-L6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he1yq-00039v-4e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he1uK-0008W6-8O; Thu, 20 Jun 2019 14:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D207F3002F44;
 Thu, 20 Jun 2019 18:35:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A9675C221;
 Thu, 20 Jun 2019 18:35:20 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-12-jsnow@redhat.com>
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
Message-ID: <4f98c07a-cc3a-f249-ba62-b8a98a47ab53@redhat.com>
Date: Thu, 20 Jun 2019 20:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pihDxBJLaMnS2O7tpZUIJpoZKwT2hGkMN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 20 Jun 2019 18:35:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/12] iotests: add test 257 for
 bitmap-mode backups
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pihDxBJLaMnS2O7tpZUIJpoZKwT2hGkMN
Content-Type: multipart/mixed; boundary="GBoBCeQOAPu3LgFPCoDHGosW4H4zMFx2q";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <4f98c07a-cc3a-f249-ba62-b8a98a47ab53@redhat.com>
Subject: Re: [PATCH 11/12] iotests: add test 257 for bitmap-mode backups
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-12-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-12-jsnow@redhat.com>

--GBoBCeQOAPu3LgFPCoDHGosW4H4zMFx2q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/257     |  412 +++++++
>  tests/qemu-iotests/257.out | 2199 ++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/group   |    1 +
>  3 files changed, 2612 insertions(+)
>  create mode 100755 tests/qemu-iotests/257
>  create mode 100644 tests/qemu-iotests/257.out

This test is actually quite nicely written.

I like that I don=E2=80=99t have to read the reference output but can jus=
t grep
for =E2=80=9Cerror=E2=80=9D.

Only minor notes below.

> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
> new file mode 100755
> index 0000000000..5f7f388504
> --- /dev/null
> +++ b/tests/qemu-iotests/257

[...]

> +class PatternGroup:
> +    """Grouping of Pattern objects. Initialize with an iterable of Pat=
terns."""
> +    def __init__(self, patterns):
> +        self.patterns =3D patterns
> +
> +    def bits(self, granularity):
> +        """Calculate the unique bits dirtied by this pattern grouping"=
""
> +        res =3D set()
> +        for pattern in self.patterns:
> +            lower =3D math.floor(pattern.offset / granularity)
> +            upper =3D math.floor((pattern.offset + pattern.size - 1) /=
 granularity)
> +            res =3D res | set(range(lower, upper + 1))

Why you=E2=80=99d do floor((x - 1) / y) + 1 has confused me quite a while=
=2E
Until I realized that oh yeah, Python=E2=80=99s range() is a right-open
interval.  I don=E2=80=99t like Python=E2=80=99s range().

(Yes, you=E2=80=99re right, this is better to read than just ceil(x / y).=

Because it reminds people like me that range() is weird.)

> +        return res
> +
> +GROUPS =3D [
> +    PatternGroup([
> +        # Batch 0: 4 clusters
> +        mkpattern('0x49', 0x0000000),
> +        mkpattern('0x6c', 0x0100000),   # 1M
> +        mkpattern('0x6f', 0x2000000),   # 32M
> +        mkpattern('0x76', 0x3ff0000)]), # 64M - 64K
> +    PatternGroup([
> +        # Batch 1: 6 clusters (3 new)
> +        mkpattern('0x65', 0x0000000),   # Full overwrite
> +        mkpattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
> +        mkpattern('0x72', 0x2008000),   # Partial-right (32M+32K)
> +        mkpattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
> +    PatternGroup([
> +        # Batch 2: 7 clusters (3 new)
> +        mkpattern('0x74', 0x0010000),   # Adjacent-right
> +        mkpattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
> +        mkpattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
> +        mkpattern('0x67', 0x3fe0000,
> +                  2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
> +    PatternGroup([
> +        # Batch 3: 8 clusters (5 new)
> +        # Carefully chosen such that nothing re-dirties the one cluste=
r
> +        # that copies out successfully before failure in Group #1.
> +        mkpattern('0xaa', 0x0010000,
> +                  3*GRANULARITY),       # Overwrite and 2x Adjacent-ri=
ght
> +        mkpattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
> +        mkpattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
> +        mkpattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the ri=
ght
> +    ]

I=E2=80=99d place this four spaces to the left.  But maybe placing it her=
e is
proper Python indentation, while moving it to the left would be C
indentation.

> +class Drive:
> +    """Represents, vaguely, a drive attached to a VM.
> +    Includes format, graph, and device information."""
> +
> +    def __init__(self, path, vm=3DNone):
> +        self.path =3D path
> +        self.vm =3D vm
> +        self.fmt =3D None
> +        self.size =3D None
> +        self.node =3D None
> +        self.device =3D None
> +
> +    @property
> +    def name(self):
> +        return self.node or self.device
> +
> +    def img_create(self, fmt, size):
> +        self.fmt =3D fmt
> +        self.size =3D size
> +        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.si=
ze))
> +
> +    def create_target(self, name, fmt, size):
> +        basename =3D os.path.basename(self.path)
> +        file_node_name =3D "file_{}".format(basename)
> +        vm =3D self.vm
> +
> +        log(vm.command('blockdev-create', job_id=3D'bdc-file-job',
> +                       options=3D{
> +                           'driver': 'file',
> +                           'filename': self.path,
> +                           'size': 0,
> +                       }))
> +        vm.run_job('bdc-file-job')
> +        log(vm.command('blockdev-add', driver=3D'file',
> +                       node_name=3Dfile_node_name, filename=3Dself.pat=
h))
> +
> +        log(vm.command('blockdev-create', job_id=3D'bdc-fmt-job',
> +                       options=3D{
> +                           'driver': fmt,
> +                           'file': file_node_name,
> +                           'size': size,
> +                       }))
> +        vm.run_job('bdc-fmt-job')
> +        log(vm.command('blockdev-add', driver=3Dfmt,
> +                       node_name=3Dname,
> +                       file=3Dfile_node_name))
> +        self.fmt =3D fmt
> +        self.size =3D size
> +        self.node =3D name

It=E2=80=99s cool that you use blockdev-create here, but would it not hav=
e been
easier to just use self.img_create() + blockdev-add?

I mean, there=E2=80=99s no point in changing it now, I=E2=80=99m just won=
dering.

> +
> +def query_bitmaps(vm):
> +    res =3D vm.qmp("query-block")
> +    return {"bitmaps": {device['device'] or device['qdev']:
> +                        device.get('dirty-bitmaps', []) for
> +                        device in res['return']}}

Python=E2=80=99s just not for me if I find this syntax unintuitive and
confusing, hu?

[...]

> +def bitmap_comparison(bitmap, groups=3DNone, want=3D0):
> +    """
> +    Print a nice human-readable message checking that this bitmap has =
as
> +    many bits set as we expect it to.
> +    """
> +    log("=3D Checking Bitmap {:s} =3D".format(bitmap.get('name', '(ano=
nymous)')))
> +
> +    if groups:
> +        want =3D calculate_bits(groups)
> +    have =3D int(bitmap['count'] / bitmap['granularity'])

Or just bitmap['count'] // bitmap['granularity']?

[...]

> +def test_bitmap_sync(bsync_mode, failure=3DNone):

[...]

> +        log('--- Preparing image & VM ---\n')
> +        drive0 =3D Drive(img_path, vm=3Dvm)
> +        drive0.img_create(iotests.imgfmt, SIZE)
> +        vm.add_device('virtio-scsi-pci,id=3Dscsi0')

Judging from 238, this should be virtio-scsi-ccw on s390-ccw-virtio.

(This is the reason I cannot give an R-b.)

[...]

> +        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
> +                   pre_finalize=3D_callback,
> +                   cancel=3Dfailure =3D=3D 'simulated')

I=E2=80=99d prefer =E2=80=9Ccancel=3D(failure =3D=3D 'simulated')=E2=80=9D=
=2E  (Or spaces around =3D).

Also in other places elsewhere that are of the form x=3Dy where y contain=
s
spaces.

[...]

> +def main():
> +    for bsync_mode in ("never", "conditional", "always"):
> +        for failure in ("simulated", None):
> +            test_bitmap_sync(bsync_mode, failure)
> +
> +    for bsync_mode in ("never", "conditional", "always"):
> +        test_bitmap_sync(bsync_mode, "intermediate")

Why are these separate?  Couldn=E2=80=99t you just iterate over
("simulated", None, "intermediate")?

Max


--GBoBCeQOAPu3LgFPCoDHGosW4H4zMFx2q--

--pihDxBJLaMnS2O7tpZUIJpoZKwT2hGkMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0L0eYACgkQ9AfbAGHV
z0CFRQf/azjVyEq7LOdhW62mgznwIqBJYit7nnQ7lhD4rTvh1hKbXNiukBkQfGy7
Efs0pkWOU4Jg/r0HfYa1DISXa9aJb61dXqpAl0gvvYmFgs74SbqP6qug8SllZUSI
QNVZhcLf56NO9tAiduTrPfj3i0WPRRmUP4luvCYmR6LJJt0377M+omtvvhi2bN7p
c7sQl5x2jKl7qafF80jdFAudAbdcrsL8GDZXqnPKwko4lLPxyptE6u5Cl39wNdUF
kUeOWs20dU+4hq+1u/05qAQf1Yx57/ENi62bE78TEr2IdquEN4aEPBACvGDUSNWP
iXVi1bkIGobBJ2YGMn5BkZi3TCcz/g==
=tX+V
-----END PGP SIGNATURE-----

--pihDxBJLaMnS2O7tpZUIJpoZKwT2hGkMN--

