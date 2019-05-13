Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE412C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9395520879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9395520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQD3a-0001Lm-QL
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:40:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQCyg-0006ag-3Y
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hQCye-00084h-RD
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hQCyZ-00081F-LF; Mon, 13 May 2019 11:34:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2D2E30031BE;
	Mon, 13 May 2019 15:34:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.206.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 241DD84EA;
	Mon, 13 May 2019 15:34:46 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>
References: <20190510211954.29574-1-mreitz@redhat.com>
	<CAMRbyytDVz=tTgPKOxZNBR=suohjw6bi7EsP=u5682ZRCsHfag@mail.gmail.com>
	<cafef82a-a00c-f1a2-3202-1f2b1b8b82f1@redhat.com>
	<17b92298-f339-ea44-2d37-43955666f733@redhat.com>
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
Message-ID: <8b2aa8ba-48be-0e42-e1d3-9598075994fa@redhat.com>
Date: Mon, 13 May 2019 17:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <17b92298-f339-ea44-2d37-43955666f733@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eDpFs4lqzNUzOxZ5qfITMLzLCDvLm0gdU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 13 May 2019 15:34:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] iotests: Filter 175's allocation
 information
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eDpFs4lqzNUzOxZ5qfITMLzLCDvLm0gdU
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Message-ID: <8b2aa8ba-48be-0e42-e1d3-9598075994fa@redhat.com>
Subject: Re: [PATCH] iotests: Filter 175's allocation information
References: <20190510211954.29574-1-mreitz@redhat.com>
 <CAMRbyytDVz=tTgPKOxZNBR=suohjw6bi7EsP=u5682ZRCsHfag@mail.gmail.com>
 <cafef82a-a00c-f1a2-3202-1f2b1b8b82f1@redhat.com>
 <17b92298-f339-ea44-2d37-43955666f733@redhat.com>
In-Reply-To: <17b92298-f339-ea44-2d37-43955666f733@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.05.19 17:33, John Snow wrote:
>=20
>=20
> On 5/13/19 9:20 AM, Max Reitz wrote:
>> On 10.05.19 23:45, Nir Soffer wrote:
>>> On Sat, May 11, 2019 at 12:19 AM Max Reitz <mreitz@redhat.com
>>> <mailto:mreitz@redhat.com>> wrote:
>>>
>>>     It is possible for an empty file to take up blocks on a filesyste=
m.
>>>     Make iotest 175 take this into account.
>>>
>>>     Reported-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.c=
om>>
>>>     Signed-off-by: Max Reitz <mreitz@redhat.com <mailto:mreitz@redhat=
=2Ecom>>
>>>     ---
>>>     =C2=A0tests/qemu-iotests/175=C2=A0 =C2=A0 =C2=A0| 15 +++++++++++-=
---
>>>     =C2=A0tests/qemu-iotests/175.out |=C2=A0 8 ++++----
>>>     =C2=A02 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>>     diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
>>>     index d0ffc495c2..b5652a3889 100755
>>>     --- a/tests/qemu-iotests/175
>>>     +++ b/tests/qemu-iotests/175
>>>     @@ -28,7 +28,8 @@ status=3D1=C2=A0 =C2=A0 =C2=A0 # failure is the=
 default!
>>>
>>>     =C2=A0_cleanup()
>>>     =C2=A0{
>>>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0_cleanup_test_img
>>>     +=C2=A0 =C2=A0 _cleanup_test_img
>>>     +=C2=A0 =C2=A0 rm -f "$TEST_DIR/empty"
>>>     =C2=A0}
>>>     =C2=A0trap "_cleanup; exit \$status" 0 1 2 3 15
>>>
>>>     @@ -40,18 +41,24 @@ _supported_fmt raw
>>>     =C2=A0_supported_proto file
>>>     =C2=A0_supported_os Linux
>>>
>>>     -size=3D1m
>>>     +size=3D$((1 * 1024 * 1024))
>>>
>>>     +
>>>     +touch "$TEST_DIR/empty"
>>>     +empty_blocks=3D$(stat -c '%b' "$TEST_DIR/empty")
>>>
>>>
>>> Maybe extra_blocks?
>>
>> Why not.
>>
>>>     =C2=A0echo
>>>     =C2=A0echo "=3D=3D creating image with default preallocation =3D=3D=
"
>>>     =C2=A0_make_test_img $size | _filter_imgfmt
>>>     -stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
>>>     +stat -c "size=3D%s, blocks=3D%b" $TEST_IMG \
>>>     +=C2=A0 =C2=A0 | sed -e "s/blocks=3D$empty_blocks/nothing allocat=
ed/"
>>>
>>>     =C2=A0for mode in off full falloc; do
>>>     =C2=A0 =C2=A0 =C2=A0echo
>>>     =C2=A0 =C2=A0 =C2=A0echo "=3D=3D creating image with preallocatio=
n $mode =3D=3D"
>>>     =C2=A0 =C2=A0 =C2=A0IMGOPTS=3Dpreallocation=3D$mode _make_test_im=
g $size | _filter_imgfmt
>>>     -=C2=A0 =C2=A0 stat -c "size=3D%s, blocks=3D%b" $TEST_IMG
>>>     +=C2=A0 =C2=A0 stat -c "size=3D%s, blocks=3D%b" $TEST_IMG \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 | sed -e "s/blocks=3D$empty_blocks/n=
othing allocated/" \
>>>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 | sed -e "s/blocks=3D$((empty_blocks=
 + size /
>>>     512))/everything allocated/"
>>>
>>>
>>> "fully allocated"?
>>
>> I didn=E2=80=99t like that because that sounds like it only applies to=

>> preallocation=3Dfull.
>>
>>> Maybe add a helper like this:
>>>
>>> _filter_blocks() {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Some file systems sometimes allocate ex=
tra blocks
>>> =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0sed -e "s/blocks=3D$empty_block=
s/nothing allocated/" \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e "s/blocks=3D=
$((empty_blocks + size / 512))/everything
>>> allocated/"
>>> }
>>>
>>> So we can do:
>>>
>>> =C2=A0 =C2=A0=C2=A0stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filt=
er_blocks
>>>
>>> And it is also clear why we need to run sed without looking up the
>>> commit message.
>>
>> Makes sense to me, but I find it a bit awkward to make a filter rely o=
n
>> a data value determined outside of the filter...  I=E2=80=99ll see wha=
t I can do
>> to calm my conscience.
>>
>> Max
>>
>=20
> You can always parameterize the filter so that the relationship is
> explicit, no? Does that still feel icky?

Hmmm. :-)  Sounds good, thanks.

I was thinking of just a comment.  =E2=80=9CNeeds variable $foo set.=E2=80=
=9D  But a
parameter works nicely, yes.

Max


--eDpFs4lqzNUzOxZ5qfITMLzLCDvLm0gdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzZjpUACgkQ9AfbAGHV
z0BoYAf/W+O0LykxlNy6iUtevKGvafL2XK2Ei5ACHL4/iOBceOop0nlaHMIcCtpX
dwSqSn0pPHlfk6h5LBZ7qZQ+2pOBFVvrOq03fqOtGE8EB0r8S6oujA/LInEDmYDq
dgA6X9Ohins5S4uwMOV8P/zIvd9VF11tUqckL/i+RCx0SiGgP9qWM2uYFw2YwWjs
vAme4u1QLxUrtbU0f/Zfg2E6u4OaddOypcBdOOQHXL8k5DDJ0G/H4Q6BZHq6QP/Q
A3JfXDp2G3SeKfF5xB7iMqrew+RfYsGfX7XNe2F342PKYPqWUFNhuNsL3/n/2/8T
ZEi8/l9ZpoXuXnHcZr0ckr9rPvZdjA==
=T9tp
-----END PGP SIGNATURE-----

--eDpFs4lqzNUzOxZ5qfITMLzLCDvLm0gdU--

