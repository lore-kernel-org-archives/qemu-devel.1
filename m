Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CFBC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282C22173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282C22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2eoS-0007JD-B3
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2enW-0006gy-No
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2enV-0001Ci-Ei
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2enO-00017g-Sj; Tue, 27 Aug 2019 12:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB92B301A3AE;
 Tue, 27 Aug 2019 16:58:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5952910016EA;
 Tue, 27 Aug 2019 16:58:12 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
References: <20190827010528.8818-1-nsoffer@redhat.com>
 <20190827010528.8818-2-nsoffer@redhat.com>
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
Message-ID: <a2073695-e146-ffa3-7707-4e1f15d309cd@redhat.com>
Date: Tue, 27 Aug 2019 18:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827010528.8818-2-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Au9oWb4IJM8O0cwOP4cCZrsrTDTnXzZqn"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 27 Aug 2019 16:58:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Au9oWb4IJM8O0cwOP4cCZrsrTDTnXzZqn
Content-Type: multipart/mixed; boundary="8RqCYTtfslKgw2m49URRyUpVqC6Pt8rud";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <a2073695-e146-ffa3-7707-4e1f15d309cd@redhat.com>
Subject: Re: [PATCH v3 1/2] block: posix: Always allocate the first block
References: <20190827010528.8818-1-nsoffer@redhat.com>
 <20190827010528.8818-2-nsoffer@redhat.com>
In-Reply-To: <20190827010528.8818-2-nsoffer@redhat.com>

--8RqCYTtfslKgw2m49URRyUpVqC6Pt8rud
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.19 03:05, Nir Soffer wrote:
> When creating an image with preallocation "off" or "falloc", the first
> block of the image is typically not allocated. When using Gluster
> storage backed by XFS filesystem, reading this block using direct I/O
> succeeds regardless of request length, fooling alignment detection.
>=20
> In this case we fallback to a safe value (4096) instead of the optimal
> value (512), which may lead to unneeded data copying when aligning
> requests.  Allocating the first block avoids the fallback.
>=20
> Since we allocate the first block even with preallocation=3Doff, we no
> longer create images with zero disk size:
>=20
>     $ ./qemu-img create -f raw test.raw 1g
>     Formatting 'test.raw', fmt=3Draw size=3D1073741824
>=20
>     $ ls -lhs test.raw
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
>=20
> And converting the image requires additional cluster:
>=20
>     $ ./qemu-img measure -f raw -O qcow2 test.raw
>     required size: 458752
>     fully allocated size: 1074135040
>=20
> When using format like vmdk with multiple files per image, we allocate
> one block per file:
>=20
>     $ ./qemu-img create -f vmdk -o subformat=3DtwoGbMaxExtentFlat test.=
vmdk 4g
>     Formatting 'test.vmdk', fmt=3Dvmdk size=3D4294967296 compat6=3Doff =
hwversion=3Dundefined subformat=3DtwoGbMaxExtentFlat
>=20
>     $ ls -lhs test*.vmdk
>     4.0K -rw-r--r--. 1 nsoffer nsoffer 2.0G Aug 27 03:23 test-f001.vmdk=

>     4.0K -rw-r--r--. 1 nsoffer nsoffer 2.0G Aug 27 03:23 test-f002.vmdk=

>     4.0K -rw-r--r--. 1 nsoffer nsoffer  353 Aug 27 03:23 test.vmdk
>=20
> I did quick performance test for copying disks with qemu-img convert to=

> new raw target image to Gluster storage with sector size of 512 bytes:
>=20
>     for i in $(seq 10); do
>         rm -f dst.raw
>         sleep 10
>         time ./qemu-img convert -f raw -O raw -t none -T none src.raw d=
st.raw
>     done
>=20
> Here is a table comparing the total time spent:
>=20
> Type    Before(s)   After(s)    Diff(%)
> ---------------------------------------
> real      530.028    469.123      -11.4
> user       17.204     10.768      -37.4
> sys        17.881      7.011      -60.7
>=20
> We can see very clear improvement in CPU usage.
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/file-posix.c                            | 51 +++++++++++++++++++=

>  tests/qemu-iotests/059.out                    |  2 +-
>  tests/qemu-iotests/{150.out =3D> 150.out.qcow2} |  0
>  tests/qemu-iotests/150.out.raw                | 12 +++++
>  tests/qemu-iotests/175                        | 19 ++++---
>  tests/qemu-iotests/175.out                    |  8 +--
>  tests/qemu-iotests/178.out.qcow2              |  4 +-
>  tests/qemu-iotests/221.out                    | 12 +++--
>  tests/qemu-iotests/253.out                    | 12 +++--
>  9 files changed, 99 insertions(+), 21 deletions(-)
>  rename tests/qemu-iotests/{150.out =3D> 150.out.qcow2} (100%)
>  create mode 100644 tests/qemu-iotests/150.out.raw

Reviewed-by: Max Reitz <mreitz@redhat.com>

Maybe it=E2=80=99ll break the vmdk iotests when using a non-default subfo=
rmat;
but currently running the iotests for non-default VMDK subformats is
broken anyway, so it doesn=E2=80=99t matter.

Max


--8RqCYTtfslKgw2m49URRyUpVqC6Pt8rud--

--Au9oWb4IJM8O0cwOP4cCZrsrTDTnXzZqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1lYSIACgkQ9AfbAGHV
z0CYwQf/TBizHz+kGDIGC7+ARSCDc/9u7rqveyQlqZQXiiIkt4KE7RPSWxGuNKp1
ownnLKCQ7VAIKA3yFvYcS3/+9REIay9mFvMPmjELQSQgoCYkrwAT6c+4oP2fh0w/
PSZoHZY5xj8iRCL5wXl3tFecgTZe1QWWH7Rn42QAzhK1Ryq4EVby9VOw+tpSiMjA
Fl7BuwwL5UoL524yjaEU8f7bEDxRO8/uiImSs5G1YUrdVe3auei6r8kgVwt/IDpj
whF5tBuaL9V3XayNSho8aFVaweZU84E2OoA/4f///+jMi1lOis7ieRV4PmYf1cLl
0BiaDUeoJsuXj2qf7JHEmRcI7Jlirw==
=VdMf
-----END PGP SIGNATURE-----

--Au9oWb4IJM8O0cwOP4cCZrsrTDTnXzZqn--

