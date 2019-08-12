Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2242070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 19:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2242070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxFjn-0002lz-O1
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 15:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxFiz-0001be-Cj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxFiy-0003VR-Au
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 15:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxFiv-0003Tz-TM; Mon, 12 Aug 2019 15:11:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DFFBA85542;
 Mon, 12 Aug 2019 19:11:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0065E19C4F;
 Mon, 12 Aug 2019 19:11:12 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190725155512.9827-1-mreitz@redhat.com>
 <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>
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
Message-ID: <e6bc8a2d-4541-60a3-64a7-294c4dee0c32@redhat.com>
Date: Mon, 12 Aug 2019 21:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SenCr0Wjz9yu6Yy2VSsbfBmVEDB2eqA0e"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 12 Aug 2019 19:11:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block: Make various
 formats' block_status recurse again
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
--SenCr0Wjz9yu6Yy2VSsbfBmVEDB2eqA0e
Content-Type: multipart/mixed; boundary="8BR4u9brWrtHzjbSOfBkOvzkFuDPJ310b";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Message-ID: <e6bc8a2d-4541-60a3-64a7-294c4dee0c32@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/3] block: Make various formats'
 block_status recurse again
References: <20190725155512.9827-1-mreitz@redhat.com>
 <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>
In-Reply-To: <125926bf-4c5a-939a-2cc7-01e11a1a2511@redhat.com>

--8BR4u9brWrtHzjbSOfBkOvzkFuDPJ310b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 20:39, John Snow wrote:
>=20
>=20
> On 7/25/19 11:55 AM, Max Reitz wrote:
>> Hi,
>>
>> 69f47505ee66afaa513305de0c1895a224e52c45 changed block_status so that =
it
>> would only go down to the protocol layer if the format layer returned
>> BDRV_BLOCK_RECURSE, thus indicating that it has no sufficient
>> information whether a given range in the image is zero or not.
>> Generally, this is because the image is preallocated and thus all rang=
es
>> appear as zeroes.
>>
>> However, it only implemented this preallocation detection for qcow2.
>> There are more formats that support preallocation, though: vdi, vhdx,
>> vmdk, vpc.  (Funny how they all start with =E2=80=9Cv=E2=80=9D.)
>>
>> For vdi, vmdk, and vpc, the fix is rather simple, because they really
>> have different subformats depending on whether an image is preallocate=
d
>> or not.  This makes the check very simple.
>>
>> vhdx is more like qcow2, where after the image has been created, it
>> isn=E2=80=99t clear whether it=E2=80=99s been preallocated or everythi=
ng is allocated
>> because everything was already written to.  69f47505ee added a heurist=
ic
>> to qcow2 to get around this, but I think that=E2=80=99s too much for v=
hdx.  I
>> just left it unfixed, because I don=E2=80=99t care that much, honestly=
 (and I
>> don=E2=80=99t think anyone else does).
>>
>=20
> What's the practical outcome of that, and is the limitation documented
> somewhere?

The outcome is that it if you preallocate a vhdx image
(subformat=3Dfixed), you=E2=80=99ll see that all sectors contain data, ev=
en if
they may be zero sectors on the filesystem level.

I don=E2=80=99t think it=E2=80=99s user-visible whatsoever.

> (I'm fine with not fixing it, I just want it documented somehow.)

I am really not inclined to start any documentation on the
particularities with which qemu handles vhdx images.

(Especially so considering we don=E2=80=99t even have any documentation o=
n the
qcow2 case.  The stress in my paragraph was =E2=80=9Cheuristic=E2=80=9D. =
 If you
preallocate a qcow2 image, but then discard enough sectors that the
heuristic thinks you didn=E2=80=99t, you=E2=80=99ll have the same effect.=
  Or if you
grow a preallocated image without preallocating the new area.)

Max

>>
>> Max Reitz (3):
>>   vdi: Make block_status recurse for fixed images
>>   vmdk: Make block_status recurse for flat extents
>>   vpc: Do not return RAW from block_status
>>
>>  block/vdi.c  | 3 ++-
>>  block/vmdk.c | 3 +++
>>  block/vpc.c  | 2 +-
>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>



--8BR4u9brWrtHzjbSOfBkOvzkFuDPJ310b--

--SenCr0Wjz9yu6Yy2VSsbfBmVEDB2eqA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Ruc8ACgkQ9AfbAGHV
z0BOowf/U0/l0e5La4gTyv8lVMe8iOwNJmBgmGRoe1hDxpdPW4VCawEbIGP41TL6
meejTwuhyTSyjZr+8ai2uszDQNNdRD52QH0Qj7SLNAKEX/IYXRzg5iE2KpfEIqvv
WJRGBMptVe10sYugDZEjil29xyP1leXZZya8KxhgV3Bj1zXDKp1cc5H42SANRCtl
6JF5cGV7Vh2dw0N+//bO0XCDJA2S3rQTWhpqH940oH41bO526kZYUUlO4peGjC4w
YC5bJsHh7VxNj2fG9Wmcpd3HI9j6QlWjfBbGyhrda1tOP4+P5mPyyHzj9NG7yKkj
twkUHp9ouQ3w1x745D/GiG2WzHwVxA==
=7rGW
-----END PGP SIGNATURE-----

--SenCr0Wjz9yu6Yy2VSsbfBmVEDB2eqA0e--

