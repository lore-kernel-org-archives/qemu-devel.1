Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C600C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04A322CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04A322CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55ik-0003El-Vs
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i55ha-0002Bp-1s
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i55hY-00081S-PT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1i55hY-00080O-Hd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F7C1308FC4B;
 Tue,  3 Sep 2019 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56E7560C05;
 Tue,  3 Sep 2019 10:06:14 +0000 (UTC)
Date: Tue, 3 Sep 2019 12:06:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190903100612.GE4582@localhost.localdomain>
References: <20190807142114.17569-1-danielhb413@gmail.com>
 <20190807142114.17569-3-danielhb413@gmail.com>
 <a3b0480c-da0e-d182-335d-77568efb8121@redhat.com>
 <20190903092253.GB4582@localhost.localdomain>
 <eeb3a0ff-2b95-2285-10e1-ae9bd2c4ba0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <eeb3a0ff-2b95-2285-10e1-ae9bd2c4ba0e@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 03 Sep 2019 10:06:15 +0000 (UTC)
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
Cc: berrange@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 11:55 hat Daniel Henrique Barboza geschrieben:
>=20
>=20
> On 9/3/19 6:22 AM, Kevin Wolf wrote:
> > Am 29.08.2019 um 04:07 hat John Snow geschrieben:
> > >=20
> > > On 8/7/19 10:21 AM, Daniel Henrique Barboza wrote:
> > > > Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
> > > > can be used in a way similar of the existing bdrv_create_file to
> > > > to clean up a created file.
> > > >=20
> > > > The logic is also similar to what is already done in bdrv_create_=
file:
> > > > a qemu_coroutine is created if needed, a specialized function
> > > > bdrv_delete_co_entry is used to call the bdrv_co_delete_file
> > > > co-routine of the driver, if the driver implements it.
> > > >=20
> > > > Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > > ---
> > > >   block.c               | 77 ++++++++++++++++++++++++++++++++++++=
+++++++
> > > >   include/block/block.h |  1 +
> > > >   2 files changed, 78 insertions(+)
> > > >=20
> > > > diff --git a/block.c b/block.c
> > > > index cbd8da5f3b..1e20250627 100644
> > > > --- a/block.c
> > > > +++ b/block.c
> > > > @@ -547,6 +547,83 @@ int bdrv_create_file(const char *filename, Q=
emuOpts *opts, Error **errp)
> > > >       return ret;
> > > >   }
> > > > +typedef struct DeleteCo {
> > > > +    BlockDriver *drv;
> > > > +    BlockDriverState *bs;
> > > > +    int ret;
> > > > +    Error *err;
> > > > +} DeleteCo;
> > > > +
> > > > +static void coroutine_fn bdrv_delete_co_entry(void *opaque)
> > > > +{
> > > > +    Error *local_err =3D NULL;
> > > > +    DeleteCo *dco =3D opaque;
> > > > +
> > > > +    assert(dco->bs);
> > > > +
> > > > +    dco->ret =3D dco->drv->bdrv_co_delete_file(dco->bs, &local_e=
rr);
> > > > +    error_propagate(&dco->err, local_err);
> > > > +}
> > > > +
> > > > +int bdrv_delete_file(const char *filename, Error **errp)
> > > > +{
> > > > +    BlockDriver *drv =3D bdrv_find_protocol(filename, true, NULL=
);
> > > > +    BlockDriverState *bs =3D bdrv_open(filename, NULL, NULL,
> > > > +                                     BDRV_O_RDWR | BDRV_O_PROTOC=
OL, NULL);
> > > > +    DeleteCo dco =3D {
> > > > +        .drv =3D drv,
> > > > +        .bs =3D bs,
> > > > +        .ret =3D NOT_DONE,
> > > > +        .err =3D NULL,
> > > > +    };
> > > > +    Coroutine *co;
> > > > +    int ret;
> > > > +
> > > > +    if (!drv) {
> > > > +        error_setg(errp, "File '%s' has unknown format", filenam=
e);
> > > > +        ret =3D -ENOENT;
> > > > +        goto out;
> > > > +    }
> > > > +
> > > I was going to say that ENOENT is a weird error here, but I see it =
used
> > > for !drv a few other places in block.c too, alongside EINVAL and
> > > ENOMEDIUM. ENOMEDIUM loks like the most popular.
> > >=20
> > > > +    if (!drv->bdrv_co_delete_file) {
> > > > +        error_setg(errp, "Driver '%s' does not support image del=
ete",
> > > > +                   drv->format_name);
> > > > +        ret =3D -ENOTSUP;
> > > > +        goto out;
> > > > +    }
> > > > +
> > > > +    if (!bs) {
> > > > +        error_setg(errp, "Could not open image '%s' for erasing"=
,
> > > > +                   filename);
> > > > +        ret =3D 1;
> > > Please keep all errors negative (or at least consistent within a fu=
nction).
> > >=20
> > >=20
> > > I'm also wondering if we want a version of delete that doesn't try =
to
> > > open a file directly -- i.e. a version that exists like this:
> > >=20
> > > bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
> > >=20
> > > That simply dispatches based on bs->drv to the correct routine.
> > >=20
> > > Then, you are free to have bdrv_delete_file handle the open (and le=
t the
> > > opening figure out what driver it needs), and just hand off the bds=
 to
> > > bdrv_co_delete_file.
> > >=20
> > > I'm not the authority for block.c, though, so maaaybe I'm giving yo=
u bad
> > > advice here. Kevin's away on PTO for a bit and gave you advice most
> > > recently, so I might try to gently ask him for more feedback next w=
eek.
> > Yes, this was definitely the idea I had in mind when I suggested that
> > bdrv_co_delete_file() should take a BDS.
> >=20
> > And I think the callers that want to call this function (for failures
> > during image creation) all already have a BDS pointer, so nobody will
> > actually need the additional open.
> >=20
> > const char *filename only works for the local filesystem (and even th=
en
> > I think not for all filenames) and some URLs, so this is not what we
> > want to have in a public interface to identify an image file.
>=20
> Hmpf, I understood your idead wrong in the v4 review and ended up
> changing the co_routine (bdrv_co_delete_file) to use the BlockDriverSta=
te
> instead of the public interface bdrv_delete_file that will be called in=
side
> crypto.c.
>=20
> I'll respin it again with this change. Thanks for clarifying!

Yes, I see that I only really commented on the BlockDriver callback, so
it wasn't very clear what I actually meant. Sorry for that.

Kevin

