Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB954C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655021569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKK/3kDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58549 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudsn-00082R-JA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iubJr-0007Sk-DT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iubJp-0004tf-Au
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:10:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iubJp-0004tF-69
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579781440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LtfSDkEf1AU5AvkjMit3K+8UdmWrf4ph4ZJbNGW0Vu8=;
 b=AKK/3kDv5QRZ9lesaespj3XOTQ45JV6fdVwvQ80uni+EqGV0+m9m49swDLEe4lRxl1M+3s
 DGetxWSYuKqh8WcQ+jlJ1zPfgPLLf3In5FDEUfbV29hCwJiJ1mfCHTT+qPs9ZyMxCuY9Zo
 w5wAu68tkxkZJOVK/jl1bzv7AcGAkJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-4lm6tF-8PvWwplsBAoH_5w-1; Thu, 23 Jan 2020 07:10:38 -0500
X-MC-Unique: 4lm6tF-8PvWwplsBAoH_5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86CF6107ACC4;
 Thu, 23 Jan 2020 12:10:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9D8386CCC;
 Thu, 23 Jan 2020 12:10:33 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Removed deprecated --partition option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200122214328.1413664-1-eblake@redhat.com>
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
Message-ID: <bcf38c8e-c207-73bd-8707-44b500ef3fa2@redhat.com>
Date: Thu, 23 Jan 2020 13:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200122214328.1413664-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hj9lHhDEoXjJdtdY7VcjikG7udFMNyOjH"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hj9lHhDEoXjJdtdY7VcjikG7udFMNyOjH
Content-Type: multipart/mixed; boundary="VWMuulXVrJGfWrxOAIYiNLGfShF63IMiB"

--VWMuulXVrJGfWrxOAIYiNLGfShF63IMiB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.20 22:43, Eric Blake wrote:
> The option was deprecated in 4.0.0 (commit 0ae2d546); it's now been
> long enough with no complaints to follow through with that process.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-deprecated.texi |  49 ++++++----------
>  qemu-nbd.c           | 133 +------------------------------------------
>  qemu-nbd.texi        |  13 ++---
>  3 files changed, 24 insertions(+), 171 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 8471eef9c22d..1b4c638db8e0 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -304,37 +304,6 @@ The above, converted to the current supported format=
:
>=20
>  @section Related binaries
>=20
> -@subsection qemu-nbd --partition (since 4.0.0)
> -
> -The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
> -can only handle MBR partitions, and has never correctly handled
> -logical partitions beyond partition 5.  If you know the offset and
> -length of the partition (perhaps by using @code{sfdisk} within the
> -guest), you can achieve the effect of exporting just that subset of
> -the disk by use of the @option{--image-opts} option with a raw
> -blockdev using the @code{offset} and @code{size} parameters layered on
> -top of any other existing blockdev. For example, if partition 1 is
> -100MiB long starting at 1MiB, the old command:
> -
> -@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
> -
> -can be rewritten as:
> -
> -@code{qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file=
.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile.qco=
w2}
> -
> -Alternatively, the @code{nbdkit} project provides a more powerful
> -partition filter on top of its nbd plugin, which can be used to select
> -an arbitrary MBR or GPT partition on top of any other full-image NBD
> -export.  Using this to rewrite the above example results in:
> -
> -@code{qemu-nbd -t -k /tmp/sock -f qcow2 file.qcow2 &}
> -@code{nbdkit -f --filter=3Dpartition nbd socket=3D/tmp/sock partition=3D=
1}
> -
> -Note that if you are exposing the export via /dev/nbd0, it is easier
> -to just export the entire image and then mount only /dev/nbd0p1 than
> -it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
> -subset of the image.
> -
>  @subsection qemu-img convert -n -o (since 4.2.0)
>=20
>  All options specified in @option{-o} are image creation options, so
> @@ -383,3 +352,21 @@ trouble after a recent upgrade.
>=20
>  The "autoload" parameter has been ignored since 2.12.0. All bitmaps
>  are automatically loaded from qcow2 images.
> +
> +@section Related binaries
> +
> +@subsection qemu-nbd --partition (removed in 5.0.0)
> +
> +The ``qemu-nbd --partition $digit'' code (also spelled @option{-P})
> +could only handle MBR partitions, and never correctly handled logical
> +partitions beyond partition 5.  Exporting a partition can still be
> +done by utilizing the @option{--image-opts} option with a raw blockdev
> +using the @code{offset} and @code{size} parameters layered on top of
> +any other existing blockdev. For example, if partition 1 is 100MiB
> +long starting at 1MiB, the old command:
> +
> +@code{qemu-nbd -t -P 1 -f qcow2 file.qcow2}
> +
> +can be rewritten as:
> +
> +@code{qemu-nbd -t --image-opts driver=3Draw,offset=3D1M,size=3D100M,file=
.driver=3Dqcow2,file.backing.driver=3Dfile,file.backing.filename=3Dfile.qco=
w2}

I know you just moved it from above, but isn=E2=80=99t this wrong?  Shouldn=
=E2=80=99t it
be s/backing/file/g?

Max


--VWMuulXVrJGfWrxOAIYiNLGfShF63IMiB--

--hj9lHhDEoXjJdtdY7VcjikG7udFMNyOjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4pjTcACgkQ9AfbAGHV
z0Ax3Af+LTlzLCLpOs/DK9f8GP+bDB8UHUdhMILE7PVVRZj8Hb1Z2RDoRO5dwRWq
vk9biQmi6mDu/w4sLl6oxDMcfQwYtOoK3olD3olAiahJoTuSrWiKMCxZiZ3aS/CO
OiB00b6GQ7dGEH3unUsah4eOexfrmej9bow9hM6gMFrivs2VWT1HVVip1wG0RHFz
fgkaQLhjIqfoKOCDrvd1OLE/R8tvSwcYovMa7srA0cmoiysmZcb40+QoIE8wgXu7
7Gy6zxPMBgyilyW7BbxWG+hB9tpXq4BCJ1EEmk8o6LwSrjsy3NiEgia+n/T+1H/5
9qDl7sz9JALhjvnnpyy3d0BO1uMAng==
=F+xn
-----END PGP SIGNATURE-----

--hj9lHhDEoXjJdtdY7VcjikG7udFMNyOjH--


