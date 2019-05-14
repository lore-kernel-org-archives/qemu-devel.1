Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704BC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973D321473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973D321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVOF-0003Tg-Un
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:14:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQVNO-00036N-C2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQVNL-0002Yn-JO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hQVNG-0002T8-59; Tue, 14 May 2019 07:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4995589C33;
	Tue, 14 May 2019 11:13:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.248])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30319608A6;
	Tue, 14 May 2019 11:13:32 +0000 (UTC)
Date: Tue, 14 May 2019 12:13:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190514111330.GA8548@redhat.com>
References: <20180312150218.1314-1-kwolf@redhat.com>
	<20180312150218.1314-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312150218.1314-3-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 14 May 2019 11:13:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] luks: Create
 block_crypto_co_create_generic()
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 12, 2018 at 04:02:14PM +0100, Kevin Wolf wrote:
> Everything that refers to the protocol layer or QemuOpts is moved out o=
f
> block_crypto_create_generic(), so that the remaining function is
> suitable to be called by a .bdrv_co_create implementation.
>=20
> LUKS is the only driver that actually implements the old interface, and
> we don't intend to use it in any new drivers, so put the moved out code
> directly into a LUKS function rather than creating a generic
> intermediate one.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++-------------=
--------
>  1 file changed, 61 insertions(+), 34 deletions(-)


Reviving a year old commit...

The LUKS driver doesn't implement preallocation during create.

Before this commit this would be reported

 $ qemu-img create -f luks --object secret,id=3Dsec0,data=3Dbase -o key-s=
ecret=3Dsec0 base.luks 1G -o preallocation=3Dfull
 Formatting 'base.luks', fmt=3Dluks size=3D1073741824 key-secret=3Dsec0 p=
reallocation=3Dfull
 qemu-img: base.luks: Parameter 'preallocation' is unexpected


After this commit, there is no error reported - it just silently
ignores the preallocation=3Dfull option.

I'm a bit lost in block layer understanding where is the right
place to fix the error reporting in this case.

>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 77871640cc..b0a4cb3388 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -306,43 +306,29 @@ static int block_crypto_open_generic(QCryptoBlock=
Format format,
>  }
> =20
> =20
> -static int block_crypto_create_generic(QCryptoBlockFormat format,
> -                                       const char *filename,
> -                                       QemuOpts *opts,
> -                                       Error **errp)
> +static int block_crypto_co_create_generic(BlockDriverState *bs,
> +                                          int64_t size,
> +                                          QCryptoBlockCreateOptions *o=
pts,
> +                                          Error **errp)
>  {
> -    int ret =3D -EINVAL;
> -    QCryptoBlockCreateOptions *create_opts =3D NULL;
> +    int ret;
> +    BlockBackend *blk;
>      QCryptoBlock *crypto =3D NULL;
> -    struct BlockCryptoCreateData data =3D {
> -        .size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE,=
 0),
> -                         BDRV_SECTOR_SIZE),
> -    };
> -    QDict *cryptoopts;
> -
> -    /* Parse options */
> -    cryptoopts =3D qemu_opts_to_qdict(opts, NULL);
> +    struct BlockCryptoCreateData data;
> =20
> -    create_opts =3D block_crypto_create_opts_init(format, cryptoopts, =
errp);
> -    if (!create_opts) {
> -        return -1;
> -    }
> +    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
> =20
> -    /* Create protocol layer */
> -    ret =3D bdrv_create_file(filename, opts, errp);
> +    ret =3D blk_insert_bs(blk, bs, errp);
>      if (ret < 0) {
> -        return ret;
> +        goto cleanup;
>      }
> =20
> -    data.blk =3D blk_new_open(filename, NULL, NULL,
> -                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTO=
COL,
> -                            errp);
> -    if (!data.blk) {
> -        return -EINVAL;
> -    }
> +    data =3D (struct BlockCryptoCreateData) {
> +        .blk =3D blk,
> +        .size =3D size,
> +    };
> =20
> -    /* Create format layer */
> -    crypto =3D qcrypto_block_create(create_opts, NULL,
> +    crypto =3D qcrypto_block_create(opts, NULL,
>                                    block_crypto_init_func,
>                                    block_crypto_write_func,
>                                    &data,
> @@ -355,10 +341,8 @@ static int block_crypto_create_generic(QCryptoBloc=
kFormat format,
> =20
>      ret =3D 0;
>   cleanup:
> -    QDECREF(cryptoopts);
>      qcrypto_block_free(crypto);
> -    blk_unref(data.blk);
> -    qapi_free_QCryptoBlockCreateOptions(create_opts);
> +    blk_unref(blk);
>      return ret;
>  }
> =20
> @@ -563,8 +547,51 @@ static int coroutine_fn block_crypto_co_create_opt=
s_luks(const char *filename,
>                                                           QemuOpts *opt=
s,
>                                                           Error **errp)
>  {
> -    return block_crypto_create_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
> -                                       filename, opts, errp);
> +    QCryptoBlockCreateOptions *create_opts =3D NULL;
> +    BlockDriverState *bs =3D NULL;
> +    QDict *cryptoopts;
> +    int64_t size;
> +    int ret;
> +
> +    /* Parse options */
> +    size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> +
> +    cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
> +                                             &block_crypto_create_opts=
_luks,
> +                                             true);
> +
> +    create_opts =3D block_crypto_create_opts_init(Q_CRYPTO_BLOCK_FORMA=
T_LUKS,
> +                                                cryptoopts, errp);
> +    if (!create_opts) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Create protocol layer */
> +    ret =3D bdrv_create_file(filename, opts, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    bs =3D bdrv_open(filename, NULL, NULL,
> +                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp=
);
> +    if (!bs) {
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    /* Create format layer */
> +    ret =3D block_crypto_co_create_generic(bs, size, create_opts, errp=
);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret =3D 0;
> +fail:
> +    bdrv_unref(bs);
> +    qapi_free_QCryptoBlockCreateOptions(create_opts);
> +    QDECREF(cryptoopts);
> +    return ret;
>  }
> =20
>  static int block_crypto_get_info_luks(BlockDriverState *bs,
> --=20
> 2.13.6
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

