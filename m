Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D6C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79162070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeQf2vBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79162070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0013-00037Z-VF
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k000G-000268-CW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:05:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k000E-0000QQ-HR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595844301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hASKZIY7M4UTE7bOoaTaJD0kkDNEGc+GF2dQUu3+jV8=;
 b=CeQf2vBDH/vSnr5Y771guA0K67QL93nUfcagilUjxzPTTR8OHgLn+PwMBpjjzIFZhvXp5r
 e0Q3cayabDAsrU8akapc1MjAYKLMKHxp5cQQsMIHzHGsq2RaSS86JFDyzN2vcZRkHSL6/Z
 tLhGAOV9Fpcku6KHXbXDrzunNxLFxlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-JEB0hYl5NvKnqbLQUQXsKA-1; Mon, 27 Jul 2020 06:04:57 -0400
X-MC-Unique: JEB0hYl5NvKnqbLQUQXsKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FBFD8017FB;
 Mon, 27 Jul 2020 10:04:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-45.ams2.redhat.com
 [10.36.113.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C694712C2;
 Mon, 27 Jul 2020 10:04:54 +0000 (UTC)
Subject: Re: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-3-nsoffer@redhat.com>
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
Message-ID: <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
Date: Mon, 27 Jul 2020 12:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726152532.256261-3-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p0Je8yia3qKPE7cJ4OkXwWOhJ9KbbiDwM"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p0Je8yia3qKPE7cJ4OkXwWOhJ9KbbiDwM
Content-Type: multipart/mixed; boundary="1cEucd41vZqzQ0aRTqoRc1ZhobdpVTSBH"

--1cEucd41vZqzQ0aRTqoRc1ZhobdpVTSBH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.20 17:25, Nir Soffer wrote:
> Add test for "qemu-img convert -O qcow2 -c" to NBD target. The use case
> is writing compressed disk content to OVA archive.
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  tests/qemu-iotests/302     | 83 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/302.out | 27 +++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/qemu-iotests/302
>  create mode 100644 tests/qemu-iotests/302.out
>=20
> diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
> new file mode 100755
> index 0000000000..cefde1f7cf
> --- /dev/null
> +++ b/tests/qemu-iotests/302
> @@ -0,0 +1,83 @@
> +#!/usr/bin/env python3
> +#
> +# Tests conveting qcow2 compressed to NBD

*converting

> +#
> +# Copyright (c) 2020 Nir Soffer <nirsof@gmail.com>
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# owner=3Dnirsof@gmail.com
> +
> +import json
> +import iotests
> +
> +from iotests import (
> +    file_path,
> +    qemu_img,
> +    qemu_img_create,
> +    qemu_img_log,
> +    qemu_img_pipe,
> +    qemu_io,
> +    qemu_nbd,
> +)
> +
> +iotests.script_initialize(supported_fmts=3D["qcow2"])
> +
> +# Create source disk, format does not matter.
> +src_disk =3D file_path("disk.img")
> +qemu_img_create("-f", "raw", src_disk, "10m")

If the format doesn=E2=80=99t matter, why not just use qcow2 and so put
iotests.imgfmt here?  (And everywhere else where you now have -f raw.)

> +qemu_io("-f", "raw", "-c", "write 1m 64K", src_disk)

(Except I think qemu_io already has -f qcow2 in its arguments by
default, so specifying the format wouldn=E2=80=99t even be necessary here.)

> +# The use case is writing qcow2 image directly into a tar file. Code to =
create
> +# real tar file not included.
> +#
> +# offset    content
> +# -------------------------------
> +#      0    first memebr header

*member

> +#    512    first member data
> +#   1024    second memeber header

*member

> +#   1536    second member data
> +
> +tar_file =3D file_path("test.tar")
> +out =3D qemu_img_pipe("measure", "-O", "qcow2", "--output", "json", src_=
disk)
> +measure =3D json.loads(out)
> +qemu_img_create("-f", "raw", tar_file, str(measure["required"]))

Should this be measure["required"] + 1536?

> +
> +nbd_sock =3D file_path("nbd-sock", base_dir=3Diotests.sock_dir)
> +nbd_uri =3D "nbd+unix:///exp?socket=3D" + nbd_sock
> +
> +# Use raw format to allow creating qcow2 directy into tar file.
> +qemu_nbd(
> +    "--socket", nbd_sock,
> +    "--persistent",
> +    "--export-name", "exp",
> +    "--format", "raw",
> +    "--offset", "1536",
> +    tar_file)
> +
> +iotests.log("=3D=3D=3D Target image info =3D=3D=3D")
> +qemu_img_log("info", nbd_uri)
> +
> +# Write image into the tar file. In a real applicatio we would write a t=
ar

*application

> +# entry after writing the image.
> +qemu_img("convert", "-f", "raw", "-O", "qcow2", "-c", src_disk, nbd_uri)
> +
> +iotests.log("=3D=3D=3D Converted image info =3D=3D=3D")
> +qemu_img_log("info", nbd_uri)
> +
> +iotests.log("=3D=3D=3D Converted image check =3D=3D=3D")
> +qemu_img_log("check", nbd_uri)
> +
> +iotests.log("=3D=3D=3D Comparing to source disk =3D=3D=3D")
> +qemu_img_log("compare", src_disk, nbd_uri)
> diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
> new file mode 100644
> index 0000000000..babef3d574
> --- /dev/null
> +++ b/tests/qemu-iotests/302.out
> @@ -0,0 +1,27 @@
> +=3D=3D=3D Target image info =3D=3D=3D
> +image: nbd+unix:///exp?socket=3DSOCK_DIR/PID-nbd-sock
> +file format: raw
> +virtual size: 446 KiB (457216 bytes)
> +disk size: unavailable
> +
> +=3D=3D=3D Converted image info =3D=3D=3D
> +image: nbd+unix:///exp?socket=3DSOCK_DIR/PID-nbd-sock
> +file format: qcow2
> +virtual size: 10 MiB (10485760 bytes)
> +disk size: unavailable
> +cluster_size: 65536
> +Format specific information:
> +    compat: 1.1
> +    compression type: zlib
> +    lazy refcounts: false
> +    refcount bits: 16
> +    corrupt: false
> +
> +=3D=3D=3D Converted image check =3D=3D=3D
> +No errors were found on the image.
> +1/160 =3D 0.62% allocated, 100.00% fragmented, 100.00% compressed cluste=
rs
> +Image end offset: 393216

I hope none of this is fs-dependant.  (I don=E2=80=99t think it is, but who
knows.  I suppose we=E2=80=99ll find out.)

Max

> +=3D=3D=3D Comparing to source disk =3D=3D=3D
> +Images are identical.
> +
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 1d0252e1f0..1e1cb27bc8 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -308,3 +308,4 @@
>  297 meta
>  299 auto quick
>  301 backing quick
> +302 quick
>=20



--1cEucd41vZqzQ0aRTqoRc1ZhobdpVTSBH--

--p0Je8yia3qKPE7cJ4OkXwWOhJ9KbbiDwM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8epsQACgkQ9AfbAGHV
z0DcWQgAud7nr/3GWM/89hFjQe9307nwEqX7k1vBnHIOCNmbr1MGm+nie+2va+WU
RXPSegqhcrEu8YmpP/JqFU5bhLca9NiAebrq99NAuIw9ddOt+WzKyL6bJc6z7sQZ
+x4dLd10F3FvzpN5dcwBxg/veVnx3KT4yzy9SbnUa4RwzPelALH7l+6uYzGr88Uk
/BEVNFtSvqWISCiqfT2YzJhosoifQawz4wLYbDycdPiJZvff5WdlkjaU+D566G9d
FTStKR1pvru2rg+hE8rdvk/l6CcmMoPqF0B6eNbCe1TYI/dPBSYFJ/xszKUdqTgH
ZRoiUXUK9puyuQ4/JqHtyjhALMd8QA==
=WM8F
-----END PGP SIGNATURE-----

--p0Je8yia3qKPE7cJ4OkXwWOhJ9KbbiDwM--


