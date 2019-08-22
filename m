Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD35C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AB12339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AB12339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lhd-0002z0-7c
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0lPI-00054z-VM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0lPA-0007zE-Sm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0lOs-0007h6-Bp; Thu, 22 Aug 2019 07:37:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B2D3C049D7C;
 Thu, 22 Aug 2019 11:37:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BDA25D712;
 Thu, 22 Aug 2019 11:36:59 +0000 (UTC)
Message-ID: <f32d5642b26c6d5457fbf35a94b43c1bbc5b396e.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 22 Aug 2019 14:36:58 +0300
In-Reply-To: <20190822112946.GP3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-11-mlevitsk@redhat.com>
 <20190822112946.GP3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 22 Aug 2019 11:37:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 10/13] block/crypto: implement the
 encryption key management
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 12:29 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:16PM +0300, Maxim Levitsky wrote:
> > This implements the encryption key management
> > using the generic code in qcrypto layer
> >=20
> > This code adds another 'write_func' because the initialization
> > write_func works directly on the underlying file,
> > because during the creation, there is no open instance
> > of the luks driver, but during regular use, we have it,
> > and should use it instead.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++=
--
> >  1 file changed, 93 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 42a3f0898b..415b6db041 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -36,6 +36,7 @@ typedef struct BlockCrypto BlockCrypto;
> > =20
> >  struct BlockCrypto {
> >      QCryptoBlock *block;
> > +    bool updating_keys;
> >  };
> > =20
> > =20
> > @@ -69,6 +70,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock=
 *block,
> >      return ret;
> >  }
> > =20
> > +static ssize_t block_crypto_write_func(QCryptoBlock *block,
> > +                                      size_t offset,
> > +                                      const uint8_t *buf,
> > +                                      size_t buflen,
> > +                                      void *opaque,
> > +                                      Error **errp)
> > +{
> > +    BlockDriverState *bs =3D opaque;
> > +    ssize_t ret;
> > +
> > +    ret =3D bdrv_pwrite(bs->file, offset, buf, buflen);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Could not write encryption hea=
der");
> > +        return ret;
> > +    }
> > +    return ret;
> > +}
> > +
> > =20
> >  struct BlockCryptoCreateData {
> >      BlockBackend *blk;
> > @@ -622,6 +641,78 @@ block_crypto_get_specific_info_luks(BlockDriverS=
tate *bs, Error **errp)
> >      return spec_info;
> >  }
> > =20
> > +
> > +static int
> > +block_crypto_setup_encryption(BlockDriverState *bs,
> > +                              enum BlkSetupEncryptionAction action,
> > +                              QCryptoEncryptionSetupOptions *options=
,
> > +                              bool force,
> > +                              Error **errp)
> > +{
> > +    BlockCrypto *crypto =3D bs->opaque;
> > +    int ret;
> > +
> > +    assert(crypto);
> > +    assert(crypto->block);
> > +
> > +    crypto->updating_keys =3D true;
> > +
> > +    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
> > +
> > +    if (ret) {
> > +        crypto->updating_keys =3D false;
> > +        return ret;
> > +    }
> > +
> > +    ret =3D qcrypto_block_setup_encryption(crypto->block,
> > +                                          block_crypto_read_func,
> > +                                          block_crypto_write_func,
> > +                                          bs,
> > +                                          action,
> > +                                          options,
> > +                                          force,
> > +                                          errp);
> > +
> > +    crypto->updating_keys =3D false;
> > +    bdrv_child_refresh_perms(bs, bs->file, errp);
> > +
> > +
> > +    return ret;
> > +
> > +}
> > +
> > +
> > +static void
> > +block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > +                         const BdrvChildRole *role,
> > +                         BlockReopenQueue *reopen_queue,
> > +                         uint64_t perm, uint64_t shared,
> > +                         uint64_t *nperm, uint64_t *nshared)
> > +{
> > +
> > +    BlockCrypto *crypto =3D bs->opaque;
> > +
> > +    /*
> > +     * This driver doesn't modify LUKS metadata except
> > +     * when updating the encryption slots.
> > +     * Allow share-rw=3Don as a special case.
> > +     *
> > +     * Encryption update will set the crypto->updating_keys
> > +     * during that period and refresh permissions
> > +     *
> > +     * */
> > +
> > +    if (crypto->updating_keys) {
> > +        /*need exclusive write access for header update  */
> > +        perm |=3D BLK_PERM_WRITE;
> > +        shared &=3D ~BLK_PERM_WRITE;
> > +    }
>=20
> So if 2 QEMU's have the same LUKS image open, this means that
> if one tries to update the header, it will fail to upgrade
> its lock & thus be blocked from updating header ?
>=20
I guess so.=20

That what I understood from our talk with Kevin and then also from
my own understanding of the permission code.
I absolutely don't like the 'global' variable 'crypto->updating_keys'
but we kind of agreed that this must be done like that.
In the defense of this, this code is only needed for backward compatibili=
ty,
so maybe this is the right solution after all.

> > +
> > +    bdrv_filter_default_perms(bs, c, role, reopen_queue,
> > +            perm, shared, nperm, nshared);
> >=20

Best regards,
	Maxim Levitsky



