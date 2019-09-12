Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B25BC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFE720830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8UdO-00036A-Sc
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8UcP-0002ZN-73
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8UcO-0003DF-2D
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:19:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8UcK-0003Ar-H4; Thu, 12 Sep 2019 15:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7C20308FBA0;
 Thu, 12 Sep 2019 19:18:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B58B5D713;
 Thu, 12 Sep 2019 19:18:51 +0000 (UTC)
Message-ID: <51598c73f98fc505045c4a83d19cc096a6953ae6.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 22:18:49 +0300
In-Reply-To: <20190906141054.GP5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-9-mlevitsk@redhat.com>
 <20190906141054.GP5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 12 Sep 2019 19:18:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/10] block/crypto: implement
 blockdev-amend
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

On Fri, 2019-09-06 at 15:10 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:06PM +0300, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c       | 86 +++++++++++++++++++++++++++++++++---------=
--
> >  qapi/block-core.json |  4 +--
> >  2 files changed, 68 insertions(+), 22 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> >  static int
> >  block_crypto_amend_options(BlockDriverState *bs,
> >                             QemuOpts *opts,
> > @@ -678,44 +722,45 @@ block_crypto_amend_options(BlockDriverState *bs=
,
> >      BlockCrypto *crypto =3D bs->opaque;
> >      QDict *cryptoopts =3D NULL;
> >      QCryptoBlockCreateOptions *amend_options =3D NULL;
> > -    int ret;
> > +    int ret=3D -EINVAL;
>=20
> nitpick - space before '=3D'
Done. This is one of the few errors that checkpatch.pl does catch,
but apparently I forgot to run it on this patch.
>=20
> > =20
> >      assert(crypto);
> >      assert(crypto->block);
> > =20
> > -    crypto->updating_keys =3D true;
> > -
> > -    ret =3D bdrv_child_refresh_perms(bs, bs->file, errp);
> > -    if (ret) {
> > -        goto cleanup;
> > -    }
> > -
> >      cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
> >                                               &block_crypto_create_op=
ts_luks,
> >                                               true);
> > =20
> >      qdict_put_str(cryptoopts, "format", "luks");
> >      amend_options =3D block_crypto_create_opts_init(cryptoopts, errp=
);
> > +
> >      if (!amend_options) {
> > -        ret =3D -EINVAL;
> > -        goto cleanup;
> > +        goto out;
> >      }
> > =20
> > -    ret =3D qcrypto_block_amend_options(crypto->block,
> > -                                      block_crypto_read_func,
> > -                                      block_crypto_write_func,
> > -                                      bs,
> > -                                      amend_options,
> > -                                      force,
> > -                                      errp);
> > -cleanup:
> > -    crypto->updating_keys =3D false;
> > -    bdrv_child_refresh_perms(bs, bs->file, errp);
> > +    ret =3D block_crypto_amend_options_generic(bs, amend_options, fo=
rce, errp);
> > +out:
>=20
> No need to rename the "cleanup" label to "out"
All right.
>=20
> >      qapi_free_QCryptoBlockCreateOptions(amend_options);
> >      qobject_unref(cryptoopts);
> >      return ret;
> >  }
> > =20
> > +static int
> > +coroutine_fn block_crypto_co_amend(BlockDriverState *bs,
> > +                                   BlockdevCreateOptions *opts,
> > +                                   bool force,
> > +                                   Error **errp)
> > +{
> > +    QCryptoBlockCreateOptions amend_opts;
> > +
> > +    amend_opts =3D (QCryptoBlockCreateOptions) {
> > +        .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
> > +        .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(&opts->u.lu=
ks),
> > +    };
> > +
> > +    return block_crypto_amend_options_generic(bs, &amend_opts, force=
, errp);
> > +}
> > +
> > =20
> >  static void
> >  block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
> > @@ -774,6 +819,7 @@ static BlockDriver bdrv_crypto_luks =3D {
> >      .bdrv_get_info      =3D block_crypto_get_info_luks,
> >      .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
> >      .bdrv_amend_options =3D block_crypto_amend_options,
> > +    .bdrv_co_amend      =3D block_crypto_co_amend,
> > =20
> >      .strong_runtime_opts =3D block_crypto_strong_runtime_opts,
> >  };
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7900914506..02375fb59a 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4220,8 +4220,8 @@
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsLUKS',
> >    'base': 'QCryptoBlockCreateOptionsLUKS',
> > -  'data': { 'file':             'BlockdevRef',
> > -            'size':             'size',
> > +  'data': { '*file':             'BlockdevRef',
> > +            '*size':             'size',
>=20
> Docs comment to explain they are mandatory for create=20
Done
>=20
> >              '*preallocation':   'PreallocMode' } }
> > =20
> >  ##
> > --=20
> > 2.17.2
> >=20
>=20
> Regards,
> Daniel

Best regards,
	Maxim Levitsky


