Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B2EC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D06B20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D06B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8UVm-0007gN-H7
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8UUt-0007Bp-8x
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8UUs-00007X-9N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8UUo-000054-Gi; Thu, 12 Sep 2019 15:11:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9DA818C892F;
 Thu, 12 Sep 2019 19:11:09 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C9DC5D712;
 Thu, 12 Sep 2019 19:11:05 +0000 (UTC)
Message-ID: <8c427f2b801ebb7bbe910c441655fa087306889c.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 22:11:04 +0300
In-Reply-To: <20190906140634.GO5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-7-mlevitsk@redhat.com>
 <20190906140634.GO5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 12 Sep 2019 19:11:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/10] qcow2: implement crypto amend options
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

On Fri, 2019-09-06 at 15:06 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:04PM +0300, Maxim Levitsky wrote:
> > ---
> >  block/qcow2.c | 79 ++++++++++++++++++++++++++++++++++++++++---------=
--
> >  1 file changed, 63 insertions(+), 16 deletions(-)
> >=20
> > @@ -4888,9 +4899,22 @@ static int qcow2_amend_options(BlockDriverStat=
e *bs, QemuOpts *opts,
> >                  return -ENOTSUP;
> >              }
> >          } else if (g_str_has_prefix(desc->name, "encrypt.")) {
> > -            error_setg(errp,
> > -                       "Changing the encryption parameters is not su=
pported");
> > -            return -ENOTSUP;
> > +
> > +            if (!s->crypto) {
> > +                error_setg(errp,
> > +                           "Can't amend encryption options - encrypt=
ion not supported");
> > +                return -ENOTSUP;
> > +
> > +            }
>=20
> Perhaps  ' - encryption not present', and -EINVAL
Agree. Fixed.

>=20
> > +
> > +            if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
> > +                error_setg(errp,
> > +                           "Only LUKS encryption options can be amen=
ded");
> > +                return -ENOTSUP;
> > +            }
> > +
> > +            encryption_update =3D true;
> > +
> >          } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
> >              cluster_size =3D qemu_opt_get_size(opts, BLOCK_OPT_CLUST=
ER_SIZE,
> >                                               cluster_size);
> > @@ -4927,7 +4951,7 @@ static int qcow2_amend_options(BlockDriverState=
 *bs, QemuOpts *opts,
> >                                   "images");
> >                  return -EINVAL;
> >              }
> > -        } else {
> > +        } else  {
>=20
> Accidental change
Fixed.
>=20
> >              /* if this point is reached, this probably means a new o=
ption was
> >               * added without having it covered here */
> >              abort();
> > @@ -4940,7 +4964,8 @@ static int qcow2_amend_options(BlockDriverState=
 *bs, QemuOpts *opts,
> >          .original_status_cb =3D status_cb,
> >          .original_cb_opaque =3D cb_opaque,
> >          .total_operations =3D (new_version < old_version)
> > -                          + (s->refcount_bits !=3D refcount_bits)
> > +                          + (s->refcount_bits !=3D refcount_bits) +
> > +                          (encryption_update =3D=3D true)
> >      };
> > =20
> >      /* Upgrade first (some features may require compat=3D1.1) */
> > @@ -4954,6 +4979,28 @@ static int qcow2_amend_options(BlockDriverStat=
e *bs, QemuOpts *opts,
> >          }
> >      }
> > =20
> > +    if (encryption_update) {
> > +
>=20
> Redundant blank line
Fixed.
>=20
> > +        QCryptoBlockCreateOptions *cryptoopts;
> > +
> > +        cryptoopts =3D qcow2_extract_crypto_create_opts(opts, "luks"=
, errp);
> > +        if (!cryptoopts)
> > +            return -EINVAL;
> > +
> > +        helper_cb_info.current_operation =3D QCOW2_UPDATING_ENCRYPTI=
ON;
> > +
> > +        ret =3D qcrypto_block_amend_options(s->crypto,
> > +                                          qcow2_crypto_hdr_read_func=
,
> > +                                          qcow2_crypto_hdr_write_fun=
c,
> > +                                          bs,
> > +                                          cryptoopts,
> > +                                          force,
> > +                                          errp);
> > +        if (ret) {
>=20
> Check  ret < 0
Fixed.
>=20
> > +            return ret;
> > +        }
> > +    }
> > +
>=20
> Regards,
> Daniel

Best regards,
	Maxim Levitsky



