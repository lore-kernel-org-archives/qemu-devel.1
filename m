Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0043C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FAA22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FAA22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SjL-0005eU-Jh
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0SiC-0004eL-TV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0SiB-0001xr-Kl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0Si3-0001uL-Ld; Wed, 21 Aug 2019 11:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C3A9C056807;
 Wed, 21 Aug 2019 15:39:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7929D6CE40;
 Wed, 21 Aug 2019 15:39:32 +0000 (UTC)
Date: Wed, 21 Aug 2019 16:39:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190821153929.GG29327@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202219.1870-2-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 21 Aug 2019 15:39:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/13] block-crypto: misc refactoring
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019 at 11:22:07PM +0300, Maxim Levitsky wrote:
> * rename the write_func to create_write_func,
>   and init_func to create_init_func
>   this is  preparation for other write_func that will
>   be used to update the encryption keys.
>=20
> No functional changes
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 8237424ae6..42a3f0898b 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -51,7 +51,6 @@ static int block_crypto_probe_generic(QCryptoBlockFor=
mat format,
>      }
>  }
> =20
> -

Unrelated whitespace change

>  static ssize_t block_crypto_read_func(QCryptoBlock *block,
>                                        size_t offset,
>                                        uint8_t *buf,
> @@ -77,7 +76,7 @@ struct BlockCryptoCreateData {
>  };
> =20
> =20
> -static ssize_t block_crypto_write_func(QCryptoBlock *block,
> +static ssize_t block_crypto_create_write_func(QCryptoBlock *block,
>                                         size_t offset,
>                                         const uint8_t *buf,
>                                         size_t buflen,

Re-indent.

> @@ -95,8 +94,7 @@ static ssize_t block_crypto_write_func(QCryptoBlock *=
block,
>      return ret;
>  }
> =20
> -

Unrelated whitespace

> -static ssize_t block_crypto_init_func(QCryptoBlock *block,
> +static ssize_t block_crypto_create_init_func(QCryptoBlock *block,
>                                        size_t headerlen,
>                                        void *opaque,
>                                        Error **errp)

Re-indent.

> @@ -108,7 +106,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock =
*block,
>          return -EFBIG;
>      }
> =20
> -    /* User provided size should reflect amount of space made
> +    /*
> +     * User provided size should reflect amount of space made

Unrelated whitespace

>       * available to the guest, so we must take account of that
>       * which will be used by the crypto header
>       */
> @@ -117,6 +116,8 @@ static ssize_t block_crypto_init_func(QCryptoBlock =
*block,
>  }
> =20
> =20
> +
> +

Unrelated whitespace

>  static QemuOptsList block_crypto_runtime_opts_luks =3D {
>      .name =3D "crypto",
>      .head =3D QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.h=
ead),
> @@ -272,8 +273,8 @@ static int block_crypto_co_create_generic(BlockDriv=
erState *bs,
>      };
> =20
>      crypto =3D qcrypto_block_create(opts, NULL,
> -                                  block_crypto_init_func,
> -                                  block_crypto_write_func,
> +                                  block_crypto_create_init_func,
> +                                  block_crypto_create_write_func,
>                                    &data,
>                                    errp);

With the whitespace changes removed & indent fixed

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

