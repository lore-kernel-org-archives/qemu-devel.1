Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBC522DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBC522DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0U3R-0004T6-Ob
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0U2B-0003fR-Gm
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0U2A-0001yn-54
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0U26-0001uW-TM; Wed, 21 Aug 2019 13:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 636FF315C009;
 Wed, 21 Aug 2019 17:04:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80D545D6B7;
 Wed, 21 Aug 2019 17:04:19 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
References: <20190817212111.13265-1-nsoffer@redhat.com>
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
Message-ID: <9b59c887-ff97-ff0a-fa18-ef9a19c1ad6e@redhat.com>
Date: Wed, 21 Aug 2019 19:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817212111.13265-1-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hWc6yHwzjYBB2StFzb4GR0qR7qaQqFatz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 21 Aug 2019 17:04:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: gluster: Probe alignment limits
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
 integration@gluster.org, qemu-devel@nongnu.org,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWc6yHwzjYBB2StFzb4GR0qR7qaQqFatz
Content-Type: multipart/mixed; boundary="agE4LFLyPvCxqP4o5iD8sEx6GZFX525hS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, integration@gluster.org,
 Niels de Vos <ndevos@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <9b59c887-ff97-ff0a-fa18-ef9a19c1ad6e@redhat.com>
Subject: Re: [PATCH] block: gluster: Probe alignment limits
References: <20190817212111.13265-1-nsoffer@redhat.com>
In-Reply-To: <20190817212111.13265-1-nsoffer@redhat.com>

--agE4LFLyPvCxqP4o5iD8sEx6GZFX525hS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.19 23:21, Nir Soffer wrote:
> Implement alignment probing similar to file-posix, by reading from the
> first 4k of the image.
>=20
> Before this change, provisioning a VM on storage with sector size of
> 4096 bytes would fail when the installer try to create filesystems. Her=
e
> is an example command that reproduces this issue:
>=20
>     $ qemu-system-x86_64 -accel kvm -m 2048 -smp 2 \
>         -drive file=3Dgluster://gluster1/gv0/fedora29.raw,format=3Draw,=
cache=3Dnone \
>         -cdrom Fedora-Server-dvd-x86_64-29-1.2.iso
>=20
> The installer fails in few seconds when trying to create filesystem on
> /dev/mapper/fedora-root. In error report we can see that it failed with=

> EINVAL (I could not extract the error from guest).
>=20
> Copying disk fails with EINVAL:
>=20
>     $ qemu-img convert -p -f raw -O raw -t none -T none \
>         gluster://gluster1/gv0/fedora29.raw \
>         gluster://gluster1/gv0/fedora29-clone.raw
>     qemu-img: error while writing sector 4190208: Invalid argument
>=20
> This is a fix to same issue fixed in commit a6b257a08e3d (file-posix:
> Handle undetectable alignment) for gluster:// images.
>=20
> This fix has the same limit, that the first block of the image should b=
e
> allocated, otherwise we cannot detect the alignment and fallback to a
> safe value (4096) even when using storage with sector size of 512 bytes=
=2E
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/gluster.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/block/gluster.c b/block/gluster.c
> index f64dc5b01e..d936240b72 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -52,6 +52,9 @@
> =20
>  #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
> =20
> +/* The value is known only on the server side. */
> +#define MAX_ALIGN 4096
> +
>  typedef struct GlusterAIOCB {
>      int64_t size;
>      int ret;
> @@ -902,8 +905,52 @@ out:
>      return ret;
>  }
> =20
> +/*
> + * Check if read is allowed with given memory buffer and length.
> + *
> + * This function is used to check O_DIRECT request alignment.
> + */
> +static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf, size_=
t len)
> +{
> +    ssize_t ret =3D glfs_pread(fd, buf, len, 0, 0, NULL);
> +    return ret >=3D 0 || errno !=3D EINVAL;

Is glfs_pread() guaranteed to return EINVAL on invalid alignment?
file-posix says this is only the case on Linux (for normal files).  Now
I also don=E2=80=99t know whether the gluster driver works on anything bu=
t Linux
anyway.

> +}
> +
> +static void gluster_probe_alignment(BlockDriverState *bs, struct glfs_=
fd *fd,
> +                                    Error **errp)
> +{
> +    char *buf;
> +    size_t alignments[] =3D {1, 512, 1024, 2048, 4096};
> +    size_t align;
> +    int i;
> +
> +    buf =3D qemu_memalign(MAX_ALIGN, MAX_ALIGN);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
> +        align =3D alignments[i];
> +        if (gluster_is_io_aligned(fd, buf, align)) {
> +            /* Fallback to safe value. */
> +            bs->bl.request_alignment =3D (align !=3D 1) ? align : MAX_=
ALIGN;
> +            break;
> +        }
> +    }

I don=E2=80=99t like the fact that the last element of alignments[] shoul=
d be
the same as MAX_ALIGN, without that ever having been made explicit anywhe=
re.

It=E2=80=99s a bit worse in the file-posix patch, because if getpagesize(=
) is
greater than 4k, max_align will be greater than 4k.  But MAX_BLOCKSIZE
is 4k, too, so I suppose we wouldn=E2=80=99t support any block size beyon=
d that
anyway, which makes the error message appropriate still.

> +
> +    qemu_vfree(buf);
> +
> +    if (!bs->bl.request_alignment) {
> +        error_setg(errp, "Could not find working O_DIRECT alignment");=

> +        error_append_hint(errp, "Try cache.direct=3Doff\n");
> +    }
> +}
> +
>  static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error **=
errp)
>  {
> +    BDRVGlusterState *s =3D bs->opaque;
> +
> +    gluster_probe_alignment(bs, s->fd, errp);
> +
> +    bs->bl.min_mem_alignment =3D bs->bl.request_alignment;

Well, I=E2=80=99ll just trust you that there is no weird system where the=
 memory
alignment is greater than the request alignment.

> +    bs->bl.opt_mem_alignment =3D MAX(bs->bl.request_alignment, MAX_ALI=
GN);

Isn=E2=80=99t request_alignment guaranteed to not exceed MAX_ALIGN, i.e. =
isn=E2=80=99t
this always MAX_ALIGN?

>      bs->bl.max_transfer =3D GLUSTER_MAX_TRANSFER;
>  }

file-posix has a check in raw_reopen_prepare() whether we can find a
working alignment for the new FD.  Shouldn=E2=80=99t we do the same in
qemu_gluster_reopen_prepare()?

Max


--agE4LFLyPvCxqP4o5iD8sEx6GZFX525hS--

--hWc6yHwzjYBB2StFzb4GR0qR7qaQqFatz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1deZEACgkQ9AfbAGHV
z0CVsggAnjaggy60WnXuQzkjIDite8qLRh9IFClzaZ8rqJQiRTJBUyTRhqaEdHcH
GyvtuClAB7rcrz+HvZ4obrcDb1D5Wae/bKohLvtcP3DvhTJRgeiKuYx8wjuHOUIH
fDk1iVnUKh322MDZG0pis27GAJntb1y2Sq0zHmu63ton41JlK0eJQbxX4p0duK9q
7CrA89o/MlmL/qH2h5F+7Hc6Qk5xDXxkcQFVbrSjTMfN3z/56C2GwJaeKK0tSMtJ
/2yoG9E1jjgastiSFCvzf3doZs32koD3FRZ8IiRrKnW5eCHMAyefX4dFv+GN8uLt
1I6lvzIBhOZXX7gFzSkQ7oW1E6B7Gg==
=wK//
-----END PGP SIGNATURE-----

--hWc6yHwzjYBB2StFzb4GR0qR7qaQqFatz--

