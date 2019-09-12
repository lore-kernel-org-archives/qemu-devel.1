Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E348C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011AF20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011AF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8M2Y-0007x5-1r
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8M1u-0007HD-8Y
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8M1t-0003r0-7T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:08:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8M1p-0003op-QY; Thu, 12 Sep 2019 06:08:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E71893086246;
 Thu, 12 Sep 2019 10:08:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD3C8194B9;
 Thu, 12 Sep 2019 10:08:36 +0000 (UTC)
Message-ID: <3bf61bfe4c8931e0993132178f5a6455d179c76d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 13:08:35 +0300
In-Reply-To: <20190906140423.GN5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-6-mlevitsk@redhat.com>
 <20190906140423.GN5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 12 Sep 2019 10:08:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/10] block/crypto: implement the
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 15:04 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:03PM +0300, Maxim Levitsky wrote:
> > This implements the encryption key management
> > using the generic code in qcrypto layer
> > (currently only for qemu-img amend)
> >=20
> > This code adds another 'write_func' because the initialization
> > write_func works directly on the underlying file,
> > because during the creation, there is no open instance
> > of the luks driver, but during regular use, we have it,
> > and should use it instead.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++=
--
> >  1 file changed, 103 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index a6a3e1f1d8..dbd95a99ba 100644
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
> > @@ -70,6 +71,24 @@ static ssize_t block_crypto_read_func(QCryptoBlock=
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
>=20
> Indent off-by-1 - align with param on the first line
I hope you won't hate me after all these indent bugs.
I'll learn to notice, I promise :-)

>=20
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
> > @@ -647,6 +666,88 @@ block_crypto_get_specific_info_luks(BlockDriverS=
tate *bs, Error **errp)
> >      return spec_info;
> >  }
> > =20
> > +
> > +static int
> > +block_crypto_amend_options(BlockDriverState *bs,
> > +                           QemuOpts *opts,
> > +                           BlockDriverAmendStatusCB *status_cb,
> > +                           void *cb_opaque,
> > +                           bool force,
> > +                           Error **errp)
> > +{
> > +    BlockCrypto *crypto =3D bs->opaque;
> > +    QDict *cryptoopts =3D NULL;
> > +    QCryptoBlockCreateOptions *amend_options =3D NULL;
> > +    int ret;
> > +
> > +    assert(crypto);
> > +    assert(crypto->block);
> > +
> > +    crypto->updating_keys =3D true;
> > +
> > +    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
> > +    if (ret) {
>=20
> I can;'t remember - does this need to be "ret < 0" or
> does refresh_perms return positive errnos ?
I don't really know but looking at the source the=20
bdrv_child_refresh_perms calls the bdrv_child_try_set_perm
which seems to forward only negative error codes,
so I'll do this here as well.
Also an iotest for this is a must, now I remember.=20


Best regards,
	Maxim Levitsky


