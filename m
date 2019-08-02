Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269DC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A5A2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A5A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta6l-0004uX-3z
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hta3o-0007Hn-Pz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hta3n-0002es-7Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hta3c-0002TM-Sx; Fri, 02 Aug 2019 12:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 409784E927;
 Fri,  2 Aug 2019 16:05:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD75C5D961;
 Fri,  2 Aug 2019 16:05:23 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
References: <20190705102101.1114-1-dplotnikov@virtuozzo.com>
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
Message-ID: <7b6b6f68-ba63-e243-ec0a-0e2e35ed0937@redhat.com>
Date: Fri, 2 Aug 2019 18:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190705102101.1114-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VsmIsU7wZ6yOwTFyUMJo5dVjbwkCHIPAV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 02 Aug 2019 16:05:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7] qemu-io: add pattern file for write
 command
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VsmIsU7wZ6yOwTFyUMJo5dVjbwkCHIPAV
Content-Type: multipart/mixed; boundary="P8xodEJ6gymGfI7FZQam5Oa4Mjeemjuyr";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, vsementsov@virtuozzo.com,
 den@virtuozzo.com
Message-ID: <7b6b6f68-ba63-e243-ec0a-0e2e35ed0937@redhat.com>
Subject: Re: [PATCH v7] qemu-io: add pattern file for write command
References: <20190705102101.1114-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190705102101.1114-1-dplotnikov@virtuozzo.com>

--P8xodEJ6gymGfI7FZQam5Oa4Mjeemjuyr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.19 12:21, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
> v7:
>   * fix variable naming
>   * make code more readable
>   * extend help for write command
>=20
> v6:
>   * the pattern file is read once to reduce io
>=20
> v5:
>   * file name initiated with null to make compilers happy
>=20
> v4:
>   * missing signed-off clause added
>=20
> v3:
>   * missing file closing added
>   * exclusive flags processing changed
>   * buffer void* converted to char* to fix pointer arithmetics
>   * file reading error processing added
> ---
>  qemu-io-cmds.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 80 insertions(+), 6 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..495170380a 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -343,6 +343,66 @@ static void *qemu_io_alloc(BlockBackend *blk, size=
_t len, int pattern)
>      return buf;
>  }
> =20
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     char *file_name)

Wouldn=E2=80=99t a const char * suffice?

> +{
> +    char *buf, *buf_origin;
> +    FILE *f =3D fopen(file_name, "r");
> +    int pattern_len;
> +
> +    if (!f) {
> +        printf("'%s': %s\n", file_name, strerror(errno));

(1) Why stdout and not stderr?

(2) Why not just perror()?

> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len +=3D MISALIGN_OFFSET;
> +    }
> +
> +    buf_origin =3D buf =3D blk_blockalign(blk, len);
> +
> +    pattern_len =3D fread(buf, sizeof(char), len, f);

I know I pointed out already that the C standard defines sizeof(char) to
be 1, but I just want to add that =E2=80=9Csizeof(char)=E2=80=9D does not=
 appear
anywhere in qemu so far.

That doesn=E2=80=99t make it wrong, but here it looks a bit weird...

> +
> +    if (ferror(f)) {
> +        printf("'%s': %s\n", file_name, strerror(errno));
> +        goto error;
> +    }
> +
> +    if (pattern_len =3D=3D 0) {
> +        printf("'%s' is empty\n", file_name);
> +        goto error;
> +    }
> +
> +    fclose(f);
> +
> +    if (len > pattern_len) {
> +        char *file_buf =3D g_malloc(sizeof(char) * pattern_len);

=2E..and here you=E2=80=99d actually have to check that the multiplicatio=
n doesn=E2=80=99t
overflow if you actually consider it a possibility that
sizeof(char) !=3D 1.

But actually, this allocation is just unnecessary altogether, as
Vladimir has said for v6.  You can drop this line,...

> +        memcpy(file_buf, buf, pattern_len);

=2E..this line,...

> +        len -=3D pattern_len;
> +        buf +=3D pattern_len;
> +
> +        while (len > 0) {
> +            size_t len_to_copy =3D MIN(pattern_len, len);
> +
> +            memcpy(buf, file_buf, len_to_copy);

=2E..make this a memcpy(buf, buf_origin, len_to_copy);,...

> +
> +            len -=3D len_to_copy;
> +            buf +=3D len_to_copy;
> +        }
> +        qemu_vfree(file_buf);

=2E..and drop this line, too.

> +    }
> +
> +    if (qemuio_misalign) {
> +        buf_origin +=3D MISALIGN_OFFSET;

This will change the pattern, though, because now you=E2=80=99re skipping=
 the
first MISALIGN_OFFSET bytes.  Should the fread() above read to
buf_origin + MISALIGN_OFFSET in that case?

[...]

> @@ -983,8 +1044,9 @@ static int write_f(BlockBackend *blk, int argc, ch=
ar **argv)
>      /* Some compilers get confused and warn if this is not initialized=
=2E  */
>      int64_t total =3D 0;
>      int pattern =3D 0xcd;
> +    char *file_name =3D NULL;
> =20
> -    while ((c =3D getopt(argc, argv, "bcCfnpP:quz")) !=3D -1) {
> +    while ((c =3D getopt(argc, argv, "bcCfnpP:quzs:")) !=3D -1) {
>          switch (c) {
>          case 'b':
>              bflag =3D true;
> @@ -1020,6 +1082,10 @@ static int write_f(BlockBackend *blk, int argc, =
char **argv)
>          case 'z':
>              zflag =3D true;
>              break;
> +        case 's':
> +            sflag =3D true;
> +            file_name =3D g_strdup(optarg);

Why does file_name need to be a char * and duplicated here?  (optarg
always points into argv, so as long as that doesn=E2=80=99t change, the o=
ptarg
pointer stays valid.)

Max

> +            break;
>          default:
>              qemuio_command_usage(&write_cmd);
>              return -EINVAL;


--P8xodEJ6gymGfI7FZQam5Oa4Mjeemjuyr--

--VsmIsU7wZ6yOwTFyUMJo5dVjbwkCHIPAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1EX0IACgkQ9AfbAGHV
z0DwAgf+JDhNshdn/OGUsWf7flI0BgJddqu8PJuC5Dmvjir1qKHtRvOT5qr/H4S8
E1M4YoOAd3QyQcYG46O5cp2v07+DN3OtgrQMYTy/DHJBEXbi7v+2np7ESNIqAkSK
36VzJlMLUagk7/KLpVdQLaf/yLI0zZHROc+N77jyi/rwsFfMkfExi47crR0L+v60
S3pIxWZyUQfiHV6XImf2/nle2Av43qpCwUU/PtOwrUMHibPPrak0qU+P+HYy+iuK
QZl4AGk3kijei2nCPvNe/pKS6e1yqUsorvPtsMCrys0vTsVUl0kS0/FZk4LDSzwR
X6/raja4zaQVuodxTJ0oP5aMtlzDKQ==
=VRUC
-----END PGP SIGNATURE-----

--VsmIsU7wZ6yOwTFyUMJo5dVjbwkCHIPAV--

