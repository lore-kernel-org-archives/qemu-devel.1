Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B6C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729092070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729092070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxhz-0004q5-Km
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:29:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVxh4-0004Kk-QR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVxh3-00013d-KC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVxh0-0000q7-RU; Wed, 29 May 2019 08:28:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70FE330001DD;
	Wed, 29 May 2019 12:28:14 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9209D77DC0;
	Wed, 29 May 2019 12:28:11 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, eblake@redhat.com,
	kwolf@redhat.com
References: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
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
Message-ID: <505f1c2a-0856-58e1-ea60-a962cf083e04@redhat.com>
Date: Wed, 29 May 2019 14:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yeOH5bipBTdyVwpCyeRQsu5TAxQhqmoeZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 29 May 2019 12:28:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: add pattern file for write
 command
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yeOH5bipBTdyVwpCyeRQsu5TAxQhqmoeZ
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, eblake@redhat.com,
 kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <505f1c2a-0856-58e1-ea60-a962cf083e04@redhat.com>
Subject: Re: [PATCH v2] qemu-io: add pattern file for write command
References: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190529114624.23107-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.05.19 13:46, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
> ---
>  qemu-io-cmds.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 54 insertions(+), 4 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..148f2ff92a 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -21,6 +21,7 @@
>  #include "qemu/option.h"
>  #include "qemu/timer.h"
>  #include "qemu/cutils.h"
> +#include "string.h"
> =20
>  #define CMD_NOFILE_OK   0x01
> =20
> @@ -343,6 +344,35 @@ static void *qemu_io_alloc(BlockBackend *blk, size=
_t len, int pattern)
>      return buf;
>  }
> =20
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     char *file_name)
> +{
> +    void *buf;
> +    FILE *f =3D fopen(file_name, "r");
> +
> +    if (!f) {
> +        printf("cannot open file '%s'\n", file_name);

strerror(errno) would probably be helpful.

> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len +=3D MISALIGN_OFFSET;
> +    }
> +    buf =3D blk_blockalign(blk, len);
> +    memset(buf, 0, len);
> +
> +    if (!fread(buf, sizeof(char), len, f)) {

(1) You should probably check ferror(f),

(2) Currently, on a short read, the rest in buf is unallocated.  I think
it would be nicest if the pattern would be repeated to fill the whole
buffer.

> +        printf("file '%s' is empty\n", file_name);
> +        qemu_vfree(buf);
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        buf +=3D MISALIGN_OFFSET;

This still uses pointer arithmetic on a void * pointer as Vladimir has
said.  Making buf a char * pointer should be the simplest way to fix this=
=2E

> +    }
> +    return buf;
> +}
> +
>  static void qemu_io_free(void *p)
>  {
>      if (qemuio_misalign) {
> @@ -965,7 +995,7 @@ static const cmdinfo_t write_cmd =3D {
>      .perm       =3D BLK_PERM_WRITE,
>      .argmin     =3D 2,
>      .argmax     =3D -1,
> -    .args       =3D "[-bcCfnquz] [-P pattern] off len",
> +    .args       =3D "[-bcCfnquz] [-P pattern | -s source_file] off len=
",
>      .oneline    =3D "writes a number of bytes at a specified offset",
>      .help       =3D write_help,
>  };
> @@ -974,7 +1004,7 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
>  {
>      struct timeval t1, t2;
>      bool Cflag =3D false, qflag =3D false, bflag =3D false;
> -    bool Pflag =3D false, zflag =3D false, cflag =3D false;
> +    bool Pflag =3D false, zflag =3D false, cflag =3D false, sflag =3D =
false;
>      int flags =3D 0;
>      int c, cnt, ret;
>      char *buf =3D NULL;
> @@ -983,8 +1013,9 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
>      /* Some compilers get confused and warn if this is not initialized=
=2E  */
>      int64_t total =3D 0;
>      int pattern =3D 0xcd;
> +    char *file_name;
> =20
> -    while ((c =3D getopt(argc, argv, "bcCfnpP:quz")) !=3D -1) {
> +    while ((c =3D getopt(argc, argv, "bcCfnpP:quzs:")) !=3D -1) {
>          switch (c) {
>          case 'b':
>              bflag =3D true;
> @@ -1020,6 +1051,10 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>          case 'z':
>              zflag =3D true;
>              break;
> +        case 's':
> +            sflag =3D true;
> +            file_name =3D g_strdup(optarg);
> +            break;
>          default:
>              qemuio_command_usage(&write_cmd);
>              return -EINVAL;
> @@ -1056,6 +1091,14 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>          return -EINVAL;
>      }
> =20
> +    if (sflag && Pflag) {
> +        printf("-s and -P cannot be specified at the same time\n");
> +    }
> +
> +    if (sflag && zflag) {
> +        printf("-s and -z cannot be specified at the same time\n");
> +    }
> +

Well, you also need to return from this function, just printing the
message is not sufficient to abort the operation.

Also, the shorter way would be something like:

if ((int)zflag + (int)Pflag + (int)sflag >=3D 1) {
    printf("Only one of -z, -P, and -s can be specified at the same
time\n");
    return -EINVAL;
}

Max

>      offset =3D cvtnum(argv[optind]);
>      if (offset < 0) {
>          print_cvtnum_err(offset, argv[optind]);
> @@ -1088,7 +1131,14 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>      }
> =20
>      if (!zflag) {
> -        buf =3D qemu_io_alloc(blk, count, pattern);
> +        if (sflag) {
> +            buf =3D qemu_io_alloc_from_file(blk, count, file_name);
> +            if (!buf) {
> +                return -EINVAL;
> +            }
> +        } else {
> +            buf =3D qemu_io_alloc(blk, count, pattern);
> +        }
>      }
> =20
>      gettimeofday(&t1, NULL);
>=20



--yeOH5bipBTdyVwpCyeRQsu5TAxQhqmoeZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzuetoACgkQ9AfbAGHV
z0ASIgf9EyMbAVEHz83kUy9N6BNfFceFbIgq/XmyHszVCjdz9vC1peqtkvOVlCJ7
r+ku+Usl4cmEdfU+FexcD9kX2Y8+GU0qwAsLZQImY/SkLkPokp9oyYJQ1KaFzhrJ
X8/P0F41nBPZ3T0NQBANvJ/XeADb8mCgfHmnWQZ1Qz8B1Lm+HQ5HVQ8o2bNoISiE
sWGIjGJ1QKMssIPRPCxhJfaZXigc6JKLJdZUiAehYaRS0CyJwPWvZv67PLC3DQ/Y
tEmiecrC4nVJS3AvqjuSqXZVsWXPww00uQuX5V96LMdzBpWwaK4GODRvIxOcHJAq
CgkNP5gwJmurKYPLt/UVZd5a3Px5ig==
=zlMR
-----END PGP SIGNATURE-----

--yeOH5bipBTdyVwpCyeRQsu5TAxQhqmoeZ--

