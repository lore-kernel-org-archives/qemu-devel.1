Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F5C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CFF22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CFF22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0agp-0001Mt-8o
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0af2-00086b-1G
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0af0-0006WJ-R1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0aey-0006Lb-2T; Wed, 21 Aug 2019 20:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 561A0898105;
 Thu, 22 Aug 2019 00:08:59 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 859766114F;
 Thu, 22 Aug 2019 00:08:51 +0000 (UTC)
Message-ID: <98aa8733d9676324ac973efd7569599fe895a79d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 22 Aug 2019 03:08:50 +0300
In-Reply-To: <20190821153929.GG29327@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-2-mlevitsk@redhat.com>
 <20190821153929.GG29327@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 22 Aug 2019 00:08:59 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-21 at 16:39 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:07PM +0300, Maxim Levitsky wrote:
> > * rename the write_func to create_write_func,
> >   and init_func to create_init_func
> >   this is  preparation for other write_func that will
> >   be used to update the encryption keys.
> >=20
> > No functional changes
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 8237424ae6..42a3f0898b 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -51,7 +51,6 @@ static int block_crypto_probe_generic(QCryptoBlockF=
ormat format,
> >      }
> >  }
> > =20
> > -
>=20
> Unrelated whitespace change
>=20
> >  static ssize_t block_crypto_read_func(QCryptoBlock *block,
> >                                        size_t offset,
> >                                        uint8_t *buf,
> > @@ -77,7 +76,7 @@ struct BlockCryptoCreateData {
> >  };
> > =20
> > =20
> > -static ssize_t block_crypto_write_func(QCryptoBlock *block,
> > +static ssize_t block_crypto_create_write_func(QCryptoBlock *block,
> >                                         size_t offset,
> >                                         const uint8_t *buf,
> >                                         size_t buflen,
>=20
> Re-indent.
>=20
> > @@ -95,8 +94,7 @@ static ssize_t block_crypto_write_func(QCryptoBlock=
 *block,
> >      return ret;
> >  }
> > =20
> > -
>=20
> Unrelated whitespace
>=20
> > -static ssize_t block_crypto_init_func(QCryptoBlock *block,
> > +static ssize_t block_crypto_create_init_func(QCryptoBlock *block,
> >                                        size_t headerlen,
> >                                        void *opaque,
> >                                        Error **errp)
>=20
> Re-indent.
>=20
> > @@ -108,7 +106,8 @@ static ssize_t block_crypto_init_func(QCryptoBloc=
k *block,
> >          return -EFBIG;
> >      }
> > =20
> > -    /* User provided size should reflect amount of space made
> > +    /*
> > +     * User provided size should reflect amount of space made
>=20
> Unrelated whitespace
>=20
> >       * available to the guest, so we must take account of that
> >       * which will be used by the crypto header
> >       */
> > @@ -117,6 +116,8 @@ static ssize_t block_crypto_init_func(QCryptoBloc=
k *block,
> >  }
> > =20
> > =20
> > +
> > +
>=20
> Unrelated whitespace
>=20
> >  static QemuOptsList block_crypto_runtime_opts_luks =3D {
> >      .name =3D "crypto",
> >      .head =3D QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks=
.head),
> > @@ -272,8 +273,8 @@ static int block_crypto_co_create_generic(BlockDr=
iverState *bs,
> >      };
> > =20
> >      crypto =3D qcrypto_block_create(opts, NULL,
> > -                                  block_crypto_init_func,
> > -                                  block_crypto_write_func,
> > +                                  block_crypto_create_init_func,
> > +                                  block_crypto_create_write_func,
> >                                    &data,
> >                                    errp);
>=20
> With the whitespace changes removed & indent fixed
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel

Thanks you!

Best regards,
	Maxim Levitsky


