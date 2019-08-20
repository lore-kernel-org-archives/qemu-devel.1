Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9051DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AE6214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AE6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04J4-000208-Kr
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i04IH-0001Vz-JX
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i04ID-0008Cz-Sh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i04I9-000892-2a; Tue, 20 Aug 2019 09:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 214CC302C063;
 Tue, 20 Aug 2019 13:35:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4B97E54;
 Tue, 20 Aug 2019 13:35:14 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20190819161811.15872-1-dplotnikov@virtuozzo.com>
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
Message-ID: <f3eb6ae0-98d9-b7d1-3c04-60b37444fa68@redhat.com>
Date: Tue, 20 Aug 2019 15:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819161811.15872-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wP0JI1vWK1w5CbrwRipRYQtoeQNsVNZ9Z"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 13:35:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9] qemu-io: add pattern file for write
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wP0JI1vWK1w5CbrwRipRYQtoeQNsVNZ9Z
Content-Type: multipart/mixed; boundary="5af3A8lKA1c5YPd2J4GNImrMYH52T4cTI";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <f3eb6ae0-98d9-b7d1-3c04-60b37444fa68@redhat.com>
Subject: Re: [PATCH v9] qemu-io: add pattern file for write command
References: <20190819161811.15872-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190819161811.15872-1-dplotnikov@virtuozzo.com>

--5af3A8lKA1c5YPd2J4GNImrMYH52T4cTI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 18:18, Denis Plotnikov wrote:
> The patch allows to provide a pattern file for write
> command. There was no similar ability before.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
> v9:
>   * replace flag cast to int with bool [Eric]
>   * fix the error message [Eric]
>   * use qemu_io_free instead of qemu_vfree [Eric]
>   * add function description [Eric]
>=20
> v8: fix according to Max's comments
>   * get rid of unnecessary buffer for the pattern
>   * buffer allocation just in bytes
>   * take into account the missalign offset
>   * don't copy file name
>   * changed char* to const char* in input params
>=20
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
>  qemu-io-cmds.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++----=

>  1 file changed, 91 insertions(+), 6 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a23ce..f7bdfe673b 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -351,6 +351,77 @@ static void qemu_io_free(void *p)
>      qemu_vfree(p);
>  }
> =20
> +/*
> + * qemu_io_alloc_from_file()
> + *
> + * Allocates the buffer and populates it with the content of the given=
 file
> + * up to @len bytes. If the file length is less then @len, then the bu=
ffer

s/then/than/ (the first one)

> + * is populated with then file content cyclically.

s/then/the/

> + *
> + * @blk - the block backend where the buffer content is going to be wr=
itten to
> + * @len - the buffer length
> + * @file_name - the file to copy the content from

Probably better s/copy/read/

> + *
> + * Returns: the buffer pointer on success
> + *          NULL on error
> + */
> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> +                                     const char *file_name)
> +{
> +    char *buf, *buf_origin;
> +    FILE *f =3D fopen(file_name, "r");
> +    int pattern_len;
> +
> +    if (!f) {
> +        perror(file_name);
> +        return NULL;
> +    }
> +
> +    if (qemuio_misalign) {
> +        len +=3D MISALIGN_OFFSET;
> +    }
> +
> +    buf_origin =3D buf =3D blk_blockalign(blk, len);
> +
> +    if (qemuio_misalign) {
> +        buf_origin +=3D MISALIGN_OFFSET;
> +    }
> +
> +    pattern_len =3D fread(buf_origin, 1, len, f);

Pulling the misalignment up here has more effects than just requiring
qemu_io_free() rather than qemu_vfree().

First, it breaks this fread(), because @len is the length of the buffer
in total, so this here is a buffer overflow.

> +
> +    if (ferror(f)) {
> +        perror(file_name);
> +        goto error;
> +    }
> +
> +    if (pattern_len =3D=3D 0) {
> +        fprintf(stderr, "%s: file is empty\n", file_name);
> +        goto error;
> +    }
> +
> +    fclose(f);
> +
> +    if (len > pattern_len) {
> +        len -=3D pattern_len;
> +        buf +=3D pattern_len;
> +
> +        while (len > 0) {
> +            size_t len_to_copy =3D MIN(pattern_len, len);
> +
> +            memcpy(buf, buf_origin, len_to_copy);

Second, it breaks this memcpy(), because now [buf, buf + len_to_copy)
and [buf_origin, buf_origin + len_to_copy) may overlap.

I think the solution would be (1) to add MISALIGN_OFFSET not only to
@buf_origin, but to @buf also, and (2) to reduce len by MISALIGN_OFFSET.


So all in all, I think both issues should be fixed if you add
=E2=80=9Cbuf +=3D MISALIGN_OFFSET=E2=80=9D and =E2=80=9Clen -=3D MISALIGN=
_OFFSET=E2=80=9D to the second
=E2=80=9Cif (qemuio_misalign)=E2=80=9D block.  I think.

> +
> +            len -=3D len_to_copy;
> +            buf +=3D len_to_copy;
> +        }
> +    }
> +
> +    return buf_origin;
> +
> +error:
> +    qemu_io_free(buf_origin);
> +    return NULL;
> +}
> +
>  static void dump_buffer(const void *buffer, int64_t offset, int64_t le=
n)
>  {
>      uint64_t i;

[...]

> @@ -1051,8 +1128,9 @@ static int write_f(BlockBackend *blk, int argc, c=
har **argv)
>          return -EINVAL;
>      }
> =20
> -    if (zflag && Pflag) {
> -        printf("-z and -P cannot be specified at the same time\n");
> +    if ((bool)zflag + (bool)Pflag + (bool)sflag > 1) {

Eric=E2=80=99s point was that you don=E2=80=99t need to cast at all.

Max

> +        printf("Only one of -z, -P, and -s "
> +               "can be specified at the same time\n");
>          return -EINVAL;
>      }
> =20


--5af3A8lKA1c5YPd2J4GNImrMYH52T4cTI--

--wP0JI1vWK1w5CbrwRipRYQtoeQNsVNZ9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b9xEACgkQ9AfbAGHV
z0AGBQf9E50IlG+ew2vjZLHmOJmRdF7ZtbpM5OxpcFEzLik/tMZt7ps6HaiUe4hl
KetneuqDbh2beF6apOHVt42yaaeJaJ9PgNzPQdHWaqkz+T3KLaMwIDT9kwb60GTy
6exbLgjxRN19QhsgpKDLkQF3u5ROR2zjUJmUT1pDGEy80v4KMn7lYo1qYlAQ//hT
OfBIw8EFB5L2Q1IQcVH8L4Dt3nyzE7WlZcYysIqhVNscsVzawxnY2oYI18pFu8h6
Al3OW0INXXrOJ3M+Q/426hNLDgHIKrBj2eX0tcMYUlOlwiKa0+ZmgnqEJAsYLoei
PGYXwqGJhKkT34fCPJZR/yvcQ2SGKA==
=MXIL
-----END PGP SIGNATURE-----

--wP0JI1vWK1w5CbrwRipRYQtoeQNsVNZ9Z--

