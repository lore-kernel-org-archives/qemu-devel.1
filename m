Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCAEC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975592084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975592084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSvs-00012A-Og
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGSrU-0006Hp-4a
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGSrS-0006aP-5D
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGSrM-0006X5-Nq; Fri, 04 Oct 2019 15:03:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F0B83067285;
 Fri,  4 Oct 2019 19:03:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF624600D1;
 Fri,  4 Oct 2019 19:03:17 +0000 (UTC)
Subject: Re: [PATCH v2 09/11] block/qcow2: implement blockdev-amend
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-10-mlevitsk@redhat.com>
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
Message-ID: <c26f4f4a-2f2e-84d9-a516-36c7150b6332@redhat.com>
Date: Fri, 4 Oct 2019 21:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912223028.18496-10-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zpJ3H0NUnYiqThpexb1qMDsf0kVeaERMx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 04 Oct 2019 19:03:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zpJ3H0NUnYiqThpexb1qMDsf0kVeaERMx
Content-Type: multipart/mixed; boundary="EhdvnfRAepJef1sJlyD2aHN6VSzUuuJTv"

--EhdvnfRAepJef1sJlyD2aHN6VSzUuuJTv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:30, Maxim Levitsky wrote:
> Currently only for changing crypto parameters

Yep, that elegantly avoids most of the problems we=E2=80=99d have otherwi=
se. :-)

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/qcow2.c        | 71 ++++++++++++++++++++++++++++++++++++++++++++=

>  qapi/block-core.json |  6 ++--
>  2 files changed, 75 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 26f83aeb44..c8847ec6e2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3079,6 +3079,18 @@ qcow2_co_create(BlockdevCreateOptions *create_op=
tions, Error **errp)
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
>      qcow2_opts =3D &create_options->u.qcow2;
> =20
> +    if (!qcow2_opts->has_size) {
> +        error_setg(errp, "Size is manadatory for image creation");
> +        return -EINVAL;
> +
> +    }
> +
> +    if (!qcow2_opts->has_file) {
> +        error_setg(errp, "'file' is manadatory for image creation");
> +        return -EINVAL;
> +
> +    }
> +
>      bs =3D bdrv_open_blockdev_ref(qcow2_opts->file, errp);
>      if (bs =3D=3D NULL) {
>          return -EIO;
> @@ -5111,6 +5123,64 @@ static int qcow2_amend_options(BlockDriverState =
*bs, QemuOpts *opts,
>      return 0;
>  }
> =20
> +
> +static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
> +                                       BlockdevCreateOptions *opts,
> +                                       bool force,
> +                                       Error **errp)
> +{
> +    BlockdevCreateOptionsQcow2 *qopts =3D &opts->u.qcow2;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    /*
> +     * This is ugly as hell, in later versions of this patch
> +     * something has to be done about this

Well, at least the language of the comment needs adjustment. :-)

> +     */
> +    if (qopts->has_file || qopts->has_size || qopts->has_data_file ||
> +        qopts->has_data_file_raw || qopts->has_version ||
> +        qopts->has_backing_file || qopts->has_backing_fmt ||
> +        qopts->has_cluster_size || qopts->has_preallocation ||
> +        qopts->has_lazy_refcounts || qopts->has_refcount_bits) {
> +
> +        error_setg(errp,
> +                "Only LUKS encryption options can be amended for qcow2=
 with blockdev-amend");
> +        return -EOPNOTSUPP;
> +
> +    }
> +
> +    if (qopts->has_encrypt) {
> +        if (!s->crypto) {
> +            error_setg(errp, "QCOW2 image is not encrypted, can't amen=
d");
> +            return -EOPNOTSUPP;
> +        }
> +
> +        if (qopts->encrypt->format !=3D Q_CRYPTO_BLOCK_FORMAT_LUKS) {
> +            error_setg(errp,
> +                       "Amend can't be used to change the qcow2 encryp=
tion format");
> +            return -EOPNOTSUPP;
> +        }
> +
> +        if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
> +            error_setg(errp,
> +                       "Only LUKS encryption options can be amended fo=
r qcow2 with blockdev-amend");
> +            return -EOPNOTSUPP;
> +        }
> +
> +        ret =3D qcrypto_block_amend_options(s->crypto,
> +                                          qcow2_crypto_hdr_read_func,
> +                                          qcow2_crypto_hdr_write_func,=

> +                                          bs,
> +                                          qopts->encrypt,
> +                                          force,
> +                                          errp);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;

I suppose we need to do the same permission stuff as for LUKS, though;
i.e., unshare CONSISTENT_READ while this operation is ongoing.

> +}
> +
>  /*
>   * If offset or size are negative, respectively, they will not be incl=
uded in
>   * the BLOCK_IMAGE_CORRUPTED event emitted.
> @@ -5303,6 +5373,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .mutable_opts        =3D mutable_opts,
>      .bdrv_co_check       =3D qcow2_co_check,
>      .bdrv_amend_options  =3D qcow2_amend_options,
> +    .bdrv_co_amend       =3D qcow2_co_amend,
> =20
>      .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
>      .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4a6db98938..0eb4e45168 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4294,6 +4294,7 @@
>  # Driver specific image creation options for qcow2.
>  #
>  # @file             Node to create the image format on
> +#                   Mandatory for create
>  # @data-file        Node to use as an external data file in which all =
guest
>  #                   data is stored so that only metadata remains in th=
e qcow2
>  #                   file (since: 4.0)
> @@ -4301,6 +4302,7 @@
>  #                   standalone (read-only) raw image without looking a=
t qcow2
>  #                   metadata (default: false; since: 4.0)
>  # @size             Size of the virtual disk in bytes
> +#                   Mandatory for create
>  # @version          Compatibility level (default: v3)
>  # @backing-file     File name of the backing file if a backing file
>  #                   should be used
> @@ -4315,10 +4317,10 @@
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> -  'data': { 'file':             'BlockdevRef',
> +  'data': { '*file':            'BlockdevRef',
>              '*data-file':       'BlockdevRef',
>              '*data-file-raw':   'bool',
> -            'size':             'size',
> +            '*size':            'size',
>              '*version':         'BlockdevQcow2Version',
>              '*backing-file':    'str',
>              '*backing-fmt':     'BlockdevDriver',
>=20

Making these fields optional makes me wonder whether it actually make
sense to have both create and amend share a single QAPI structure.
Wouldn=E2=80=99t it better to have a separate amend structure that then a=
ctually
reflects what we support?  (This would also solve the problem of how to
express in the code what is and what isn=E2=80=99t supported through
blockdev-amend.)

Max


--EhdvnfRAepJef1sJlyD2aHN6VSzUuuJTv--

--zpJ3H0NUnYiqThpexb1qMDsf0kVeaERMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Xl3QACgkQ9AfbAGHV
z0Bf2Qf/RGQRtit9E4X7pUNNZz1aW45AwVslWNP01I+H5wbZo9DScBPHU+vzEzfc
F1unvf6X/lt0czztE8uP2KyBQRbKCCH+Mq4F9HubYwDHC9LFe9Wf//XvbTag8Ijz
VYNldWjUJk9CU0+iPJX3LahUpr4LWJNfVD9BM1x5qb0Qt7gobPJATkVswm4BNXua
gAA7cxPLw0Rapm/0yHQw1+DJsJLeB1P+B086utNTqngAgOc5Ex8nUnblKCdB8Mvo
fS1DlsIvVWswHhGHwXAIeFNUmmod2r+J6HZhPdHK+HdmPXD4f5viRbcKBx7O5xah
K+k3QPDDiQBj1pur9eB8R6gwJcDT5A==
=vYJl
-----END PGP SIGNATURE-----

--zpJ3H0NUnYiqThpexb1qMDsf0kVeaERMx--

