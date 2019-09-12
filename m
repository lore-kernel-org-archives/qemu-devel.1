Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A44C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F18720830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F18720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ugy-0004li-Gb
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Ufn-0004EM-4c
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Ufl-0004l1-Ug
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8Ufj-0004jh-Ey; Thu, 12 Sep 2019 15:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B672019D369;
 Thu, 12 Sep 2019 19:22:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CFB65D712;
 Thu, 12 Sep 2019 19:22:22 +0000 (UTC)
Message-ID: <4c2af664bb2c47a33c43b260e4b6bbd62a03a18b.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 22:22:20 +0300
In-Reply-To: <20190906141210.GQ5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-10-mlevitsk@redhat.com>
 <20190906141210.GQ5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 12 Sep 2019 19:22:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 09/10] block/qcow2: implement blockdev-amend
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

On Fri, 2019-09-06 at 15:12 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:07PM +0300, Maxim Levitsky wrote:
> > Currently only for changing crypto parameters
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/qcow2.c        | 71 ++++++++++++++++++++++++++++++++++++++++++=
++
> >  qapi/block-core.json |  4 +--
> >  2 files changed, 73 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 8dff4c6b5f..327d2afd9f 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -3082,6 +3082,18 @@ qcow2_co_create(BlockdevCreateOptions *create_=
options, Error **errp)
> >      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> >      qcow2_opts =3D &create_options->u.qcow2;
> > =20
> > +    if (!qcow2_opts->has_size) {
> > +        error_setg(errp, "Size is manadatory for image creation");
> > +        return -EINVAL;
> > +
> > +    }
> > +
> > +    if (!qcow2_opts->has_file) {
> > +        error_setg(errp, "'file' is manadatory for image creation");
> > +        return -EINVAL;
> > +
> > +    }
> > +
> >      bs =3D bdrv_open_blockdev_ref(qcow2_opts->file, errp);
> >      if (bs =3D=3D NULL) {
> >          return -EIO;
> > @@ -5112,6 +5124,64 @@ static int qcow2_amend_options(BlockDriverStat=
e *bs, QemuOpts *opts,
> >      return 0;
> >  }
> > =20
> > +
> > +static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
> > +                                       BlockdevCreateOptions *opts,
> > +                                       bool force,
> > +                                       Error **errp)
> > +{
> > +    BlockdevCreateOptionsQcow2 *qopts =3D &opts->u.qcow2;
> > +    BDRVQcow2State *s =3D bs->opaque;
> > +    int ret;
> > +
> > +    /*
> > +     * This is ugly as hell, in later versions of this patch
> > +     * something has to be done about this
> > +     */
> > +    if (qopts->has_file || qopts->has_size || qopts->has_data_file |=
|
> > +        qopts->has_data_file_raw || qopts->has_version ||
> > +        qopts->has_backing_file || qopts->has_backing_fmt ||
> > +        qopts->has_cluster_size || qopts->has_preallocation ||
> > +        qopts->has_lazy_refcounts || qopts->has_refcount_bits) {
> > +
> > +        error_setg(errp,
> > +                "Only LUKS encryption options can be amended for qco=
w2 with blockdev-amend");
> > +        return -EOPNOTSUPP;
> > +
> > +    }
> > +
> > +    if (qopts->has_encrypt) {
> > +        if (!s->crypto) {
> > +            error_setg(errp, "QCOW2 image is not encrypted, can't am=
end");
> > +            return -EOPNOTSUPP;
> > +        }
> > +
> > +        if (qopts->encrypt->format !=3D Q_CRYPTO_BLOCK_FORMAT_LUKS) =
{
> > +            error_setg(errp,
> > +                       "Amend can't be used to change the qcow2 encr=
yption format");
> > +            return -EOPNOTSUPP;
> > +        }
> > +
> > +        if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
> > +            error_setg(errp,
> > +                       "Only LUKS encryption options can be amended =
for qcow2 with blockdev-amend");
> > +            return -EOPNOTSUPP;
> > +        }
> > +
> > +        ret =3D qcrypto_block_amend_options(s->crypto,
> > +                                          qcow2_crypto_hdr_read_func=
,
> > +                                          qcow2_crypto_hdr_write_fun=
c,
> > +                                          bs,
> > +                                          qopts->encrypt,
> > +                                          force,
> > +                                          errp);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> >  /*
> >   * If offset or size are negative, respectively, they will not be in=
cluded in
> >   * the BLOCK_IMAGE_CORRUPTED event emitted.
> > @@ -5304,6 +5374,7 @@ BlockDriver bdrv_qcow2 =3D {
> >      .mutable_opts        =3D mutable_opts,
> >      .bdrv_co_check       =3D qcow2_co_check,
> >      .bdrv_amend_options  =3D qcow2_amend_options,
> > +    .bdrv_co_amend       =3D qcow2_co_amend,
> > =20
> >      .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
> >      .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 02375fb59a..ba41744427 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4312,10 +4312,10 @@
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > -  'data': { 'file':             'BlockdevRef',
> > +  'data': { '*file':            'BlockdevRef',
> >              '*data-file':       'BlockdevRef',
> >              '*data-file-raw':   'bool',
> > -            'size':             'size',
> > +            '*size':            'size',
> >              '*version':         'BlockdevQcow2Version',
> >              '*backing-file':    'str',
> >              '*backing-fmt':     'BlockdevDriver',
>=20
> Docs comment to say they  are mandatory for creation.
Done
>=20
>=20
> Regards,
> Daniel

Best regards,
	Maxim Levitsky


