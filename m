Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DEC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91709208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91709208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoHQ-000241-O9
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfnxW-0004Pm-7v
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfnxU-0006l3-6h
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfnxQ-0006bZ-2O; Tue, 25 Jun 2019 12:06:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D130300B916;
 Tue, 25 Jun 2019 16:06:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FFAB5D70D;
 Tue, 25 Jun 2019 16:06:04 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190506122322.90035-1-sgarzare@redhat.com>
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
Message-ID: <90af513d-7051-45f7-2953-55e0c8460be5@redhat.com>
Date: Tue, 25 Jun 2019 18:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190506122322.90035-1-sgarzare@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WhbUSNj8eME1mDj9m3sM7hnxmYMguzJMY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 16:06:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] block/rbd: add preallocation support
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WhbUSNj8eME1mDj9m3sM7hnxmYMguzJMY
Content-Type: multipart/mixed; boundary="88FjVcCXJYlgpHMwqDXaZpRa17405vbyP";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jason Dillaman <jdillama@redhat.com>,
 Josh Durgin <jdurgin@redhat.com>, qemu-block@nongnu.org
Message-ID: <90af513d-7051-45f7-2953-55e0c8460be5@redhat.com>
Subject: Re: [PATCH v2] block/rbd: add preallocation support
References: <20190506122322.90035-1-sgarzare@redhat.com>
In-Reply-To: <20190506122322.90035-1-sgarzare@redhat.com>

--88FjVcCXJYlgpHMwqDXaZpRa17405vbyP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.19 14:23, Stefano Garzarella wrote:
> This patch adds the support of preallocation (off/full) for the RBD
> block driver.
> If available, we use rbd_writesame() to quickly fill the image when
> full preallocation is required.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - Use 4 KiB buffer for rbd_writesame() [Jason]
> - Use "rbd_concurrent_management_ops" and "stripe_unit" to limit
>   concurrent ops to the backing cluster [Jason]
> ---
>  block/rbd.c          | 188 +++++++++++++++++++++++++++++++++++++++----=

>  qapi/block-core.json |   4 +-
>  2 files changed, 175 insertions(+), 17 deletions(-)

This patch conflicts a bit with the rbd file growth patch, so that would
need to be resolved in a v3.

But still, that doesn=E2=80=99t prevent me from reviewing it as it is:

> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..bc54395e1c 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -331,6 +333,147 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t=
 offs)

[...]

> +static int qemu_rbd_do_truncate(rados_t cluster, rbd_image_t image,
> +                                int64_t offset, PreallocMode prealloc,=

> +                                Error **errp)
> +{

[...]

> +#ifdef LIBRBD_SUPPORTS_WRITESAME
> +        uint64_t stripe_unit, writesame_max_size;
> +        int max_concurrent_ops;
> +
> +        max_concurrent_ops =3D qemu_rbd_get_max_concurrent_ops(cluster=
);
> +        ret =3D rbd_get_stripe_unit(image, &stripe_unit);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to get stripe unit");=

> +            goto out;
> +        }
> +
> +        /*
> +         * We limit the rbd_writesame() size to avoid to spawn more th=
en

s/then/than/

> +         * 'rbd_concurrent_management_ops' concurrent operations.
> +         */
> +        writesame_max_size =3D MIN(stripe_unit * max_concurrent_ops, I=
NT_MAX);
> +#endif /* LIBRBD_SUPPORTS_WRITESAME */
> +
> +        buf =3D g_malloc(buf_size);
> +        /*
> +         * Some versions of rbd_writesame() discards writes of buffers=
 with
> +         * all zeroes. In order to avoid this behaviour, we set the fi=
rst byte
> +         * to one.
> +         */
> +        buf[0] =3D 1;

But I guess you=E2=80=99ll need to rewrite it as zero later, or the
=E2=80=9Cbdrv_rbd.bdrv_has_zero_init =3D bdrv_has_zero_init_1=E2=80=9D is=
 no longer quite
true.

[...]

> @@ -449,6 +603,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(co=
nst char *filename,
>                                                     BLOCK_OPT_CLUSTER_S=
IZE, 0);
>      rbd_opts->has_cluster_size =3D (rbd_opts->cluster_size !=3D 0);
> =20
> +    prealloc =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    rbd_opts->preallocation =3D qapi_enum_parse(&PreallocMode_lookup, =
prealloc,
> +                                              PREALLOC_MODE_OFF, &loca=
l_err);

You also need to set rbd_opts->has_preallocation to true.

> +    g_free(prealloc);
> +    if (local_err) {
> +        ret =3D -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto exit;
> +    }
> +
>      options =3D qdict_new();
>      qemu_rbd_parse_filename(filename, options, &local_err);
>      if (local_err) {

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..db25a4065b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4277,13 +4277,15 @@
>  #                   point to a snapshot.
>  # @size             Size of the virtual disk in bytes
>  # @cluster-size     RBD object size
> +# @preallocation    Preallocation mode (allowed values: off, full)

There should be a "(Since: 4.1)" note here.

Max

>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsRbd',
>    'data': { 'location':         'BlockdevOptionsRbd',
>              'size':             'size',
> -            '*cluster-size' :   'size' } }
> +            '*cluster-size' :   'size',
> +            '*preallocation':   'PreallocMode' } }
> =20
>  ##
>  # @BlockdevVmdkSubformat:
>=20



--88FjVcCXJYlgpHMwqDXaZpRa17405vbyP--

--WhbUSNj8eME1mDj9m3sM7hnxmYMguzJMY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0SRmoACgkQ9AfbAGHV
z0A3Xwf6A1+DEIXy7njnIg2PL1SPdGr3fAZ2S0zG3XQbSR3cj66bfj7RJYLMcrSI
hIURgFGEQDJO4bkq6P1F6aTeu9f5SzJ1O+oKMUq3KYcn4YSptncMudt3q6a4B9o5
RHm4h8gKsGImfziHdvomzYi8MmNZ5pebse4X1iU1WYBNN1W8EHyT4QmkqBu7kwZl
4wM8vY0v+QQ843x1AxUoBccEye7vOT8NCIyHHknLPZuc0h+w7FlYosIsoHWxwP28
l2DW2/2BgHgdzrCAeN3nzY0jmr3oJ0834GcYZvc2IDW7+l/oQ2c3hTKDAPlKne6k
MuSbUPhL+IeMkLfw36T7RTAbeU20fQ==
=DfHm
-----END PGP SIGNATURE-----

--WhbUSNj8eME1mDj9m3sM7hnxmYMguzJMY--

