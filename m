Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65274C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C49B21479
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C49B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXvL-0006wA-Fm
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hdXsB-0003HS-Iq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hdXlu-0004Mv-Mn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hdXlt-0004LI-Cs; Wed, 19 Jun 2019 06:24:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9DD897FDF6;
 Wed, 19 Jun 2019 10:24:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8817C19C71;
 Wed, 19 Jun 2019 10:24:38 +0000 (UTC)
Date: Wed, 19 Jun 2019 11:24:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190619102434.GC13569@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-8-mehta.aaru20@gmail.com>
 <dc84836e922049a290ea900be3cb542b3cc1a1ab.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <dc84836e922049a290ea900be3cb542b3cc1a1ab.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 19 Jun 2019 10:24:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 07/12] blockdev: accept io_uring as
 option
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 04:01:45PM +0300, Maxim Levitsky wrote:
> On Mon, 2019-06-10 at 19:19 +0530, Aarushi Mehta wrote:
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  blockdev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/blockdev.c b/blockdev.c
> > index 3f44b891eb..a2a5b32604 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -386,6 +386,8 @@ static void extract_common_blockdev_options(QemuOpt=
s *opts, int *bdrv_flags,
> >          if ((aio =3D qemu_opt_get(opts, "aio")) !=3D NULL) {
> >              if (!strcmp(aio, "native")) {
> >                  *bdrv_flags |=3D BDRV_O_NATIVE_AIO;
> > +            } else if (!strcmp(aio, "io_uring")) {
> > +                *bdrv_flags |=3D BDRV_O_IO_URING;
> >              } else if (!strcmp(aio, "threads")) {
> >                  /* this is the default */
> >              } else {
> > @@ -4579,7 +4581,7 @@ QemuOptsList qemu_common_drive_opts =3D {
> >          },{
> >              .name =3D "aio",
> >              .type =3D QEMU_OPT_STRING,
> > -            .help =3D "host AIO implementation (threads, native)",
> > +            .help =3D "host AIO implementation (threads, native, io_ur=
ing)",
> >          },{
> >              .name =3D BDRV_OPT_CACHE_WB,
> >              .type =3D QEMU_OPT_BOOL,
>=20
> Nitpick: Maybe we should rename the native to libaio (accept both but giv=
e an deprication warning)?

"libaio" is a clearer name but I'm afraid changing it or introducing a
new name is not worth it with so many users, command-lines, scripts, and
management tools that know about "native".  Having two names that mean
the same thing might cause confusion.

Let's leave it as is.

Stefan

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0KDWIACgkQnKSrs4Gr
c8ir1gf+JE9aYqoWnNRtKEa3jNmRQkQNM8pQvNrlGd0WbtGqZJA+Gzx3zOT2q9uo
jwNVM76n8mwSKLJi2FtACdU+sJT8OE4n5Opr5ngwTKySbgfMAC6h2gpUNaZDY0Ef
HLrI7/Q+p9Ih1iwrL+AXeLi7264/q134qO8sXXkZco4oBZ7BYBvzUgtiRifl5ifY
9qJFw9lhXoWUXJ76YdnJlIv+pAEm3xV8fs1q7y+DeJ9FSTZbe9mbWdYE/N6Wgrqo
PhWpGhK1vBDdmSerVy2bH7zieIZ3VGJ7LT5gLvPiqODF/8DS5FomBfuOx2FUH5nN
HK2Dh0zUsyfd+FB4gSMBEF8nk+i18g==
=fi2f
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

