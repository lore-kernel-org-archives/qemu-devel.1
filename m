Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E8822CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E8822CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i552Y-0002DJ-Tx
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i551g-0001Pb-PP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i551f-0003fh-Fm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1i551f-0003fR-7i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:22:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8017F8AC6E1;
 Tue,  3 Sep 2019 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48CDE60127;
 Tue,  3 Sep 2019 09:22:54 +0000 (UTC)
Date: Tue, 3 Sep 2019 11:22:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190903092253.GB4582@localhost.localdomain>
References: <20190807142114.17569-1-danielhb413@gmail.com>
 <20190807142114.17569-3-danielhb413@gmail.com>
 <a3b0480c-da0e-d182-335d-77568efb8121@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a3b0480c-da0e-d182-335d-77568efb8121@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 03 Sep 2019 09:22:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/4] block.c: adding bdrv_delete_file
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.08.2019 um 04:07 hat John Snow geschrieben:
>=20
>=20
> On 8/7/19 10:21 AM, Daniel Henrique Barboza wrote:
> > Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
> > can be used in a way similar of the existing bdrv_create_file to
> > to clean up a created file.
> >=20
> > The logic is also similar to what is already done in bdrv_create_file=
:
> > a qemu_coroutine is created if needed, a specialized function
> > bdrv_delete_co_entry is used to call the bdrv_co_delete_file
> > co-routine of the driver, if the driver implements it.
> >=20
> > Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > ---
> >  block.c               | 77 +++++++++++++++++++++++++++++++++++++++++=
++
> >  include/block/block.h |  1 +
> >  2 files changed, 78 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index cbd8da5f3b..1e20250627 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -547,6 +547,83 @@ int bdrv_create_file(const char *filename, QemuO=
pts *opts, Error **errp)
> >      return ret;
> >  }
> > =20
> > +typedef struct DeleteCo {
> > +    BlockDriver *drv;
> > +    BlockDriverState *bs;
> > +    int ret;
> > +    Error *err;
> > +} DeleteCo;
> > +
> > +static void coroutine_fn bdrv_delete_co_entry(void *opaque)
> > +{
> > +    Error *local_err =3D NULL;
> > +    DeleteCo *dco =3D opaque;
> > +
> > +    assert(dco->bs);
> > +
> > +    dco->ret =3D dco->drv->bdrv_co_delete_file(dco->bs, &local_err);
> > +    error_propagate(&dco->err, local_err);
> > +}
> > +
> > +int bdrv_delete_file(const char *filename, Error **errp)
> > +{
> > +    BlockDriver *drv =3D bdrv_find_protocol(filename, true, NULL);
> > +    BlockDriverState *bs =3D bdrv_open(filename, NULL, NULL,
> > +                                     BDRV_O_RDWR | BDRV_O_PROTOCOL, =
NULL);
> > +    DeleteCo dco =3D {
> > +        .drv =3D drv,
> > +        .bs =3D bs,
> > +        .ret =3D NOT_DONE,
> > +        .err =3D NULL,
> > +    };
> > +    Coroutine *co;
> > +    int ret;
> > +
> > +    if (!drv) {
> > +        error_setg(errp, "File '%s' has unknown format", filename);
> > +        ret =3D -ENOENT;
> > +        goto out;
> > +    }
> > +
>=20
> I was going to say that ENOENT is a weird error here, but I see it used
> for !drv a few other places in block.c too, alongside EINVAL and
> ENOMEDIUM. ENOMEDIUM loks like the most popular.
>=20
> > +    if (!drv->bdrv_co_delete_file) {
> > +        error_setg(errp, "Driver '%s' does not support image delete"=
,
> > +                   drv->format_name);
> > +        ret =3D -ENOTSUP;
> > +        goto out;
> > +    }
> > +
> > +    if (!bs) {
> > +        error_setg(errp, "Could not open image '%s' for erasing",
> > +                   filename);
> > +        ret =3D 1;
>=20
> Please keep all errors negative (or at least consistent within a functi=
on).
>=20
>=20
> I'm also wondering if we want a version of delete that doesn't try to
> open a file directly -- i.e. a version that exists like this:
>=20
> bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
>=20
> That simply dispatches based on bs->drv to the correct routine.
>=20
> Then, you are free to have bdrv_delete_file handle the open (and let th=
e
> opening figure out what driver it needs), and just hand off the bds to
> bdrv_co_delete_file.
>=20
> I'm not the authority for block.c, though, so maaaybe I'm giving you ba=
d
> advice here. Kevin's away on PTO for a bit and gave you advice most
> recently, so I might try to gently ask him for more feedback next week.

Yes, this was definitely the idea I had in mind when I suggested that
bdrv_co_delete_file() should take a BDS.

And I think the callers that want to call this function (for failures
during image creation) all already have a BDS pointer, so nobody will
actually need the additional open.

const char *filename only works for the local filesystem (and even then
I think not for all filenames) and some URLs, so this is not what we
want to have in a public interface to identify an image file.

Kevin

