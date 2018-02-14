Received: from eggs.gnu.org ([2001:4830:134:3::10]:56741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ellRu-00069T-WB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ellRr-0000JI-RG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:01:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ellRr-0000Ij-Ln
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 20:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3E7181638F0
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 01:01:17 +0000 (UTC)
Date: Wed, 14 Feb 2018 09:01:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180214010111.GB15103@lemon.usersys.redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180213180918.GY573@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 02/13 18:09, Daniel P. Berrang=E9 wrote:
> On Tue, Feb 13, 2018 at 05:34:25PM +0000, Stefan Hajnoczi wrote:
> > From: Fam Zheng <famz@redhat.com>
> >=20
> > git-publish [1] is a convenient tool to send patches and has been
> > popular among QEMU developers.  Recently it has been made available i=
n
> > Fedora official repo thanks to Stefan's work.
> >=20
> > One nice feature of the tool is a per-project configuration with
> > profiles, especially in which the cccmd option is a handy method to
> > create the Cc list.
> >=20
> > [1]: https://github.com/stefanha/git-publish
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Message-id: 20180205054725.25634-2-famz@redhat.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 .gitpublish
> >=20
> > diff --git a/.gitpublish b/.gitpublish
> > new file mode 100644
> > index 0000000000..ed48f6e52c
> > --- /dev/null
> > +++ b/.gitpublish
> > @@ -0,0 +1,58 @@
> > +#
> > +# Common git-publish profiles that can be used to send patches to QE=
MU upstream.
> > +#
> > +# See https://github.com/stefanha/git-publish for more information
> > +#
> > +[gitpublishprofile "default"]
> > +base =3D master
> > +prefix =3D PATCH
> > +to =3D qemu-devel@nongnu.org
> > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
> > +
> > +[gitpublishprofile "rfc"]
> > +base =3D master
> > +prefix =3D RFC PATCH
> > +to =3D qemu-devel@nongnu.org
> > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
> > +
> > +[gitpublishprofile "stable"]
> > +base =3D master
> > +prefix =3D PATCH
> > +to =3D qemu-devel@nongnu.org
> > +cc =3D qemu-stable@nongnu.org
> > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
> > +
> > +[gitpublishprofile "trivial"]
> > +base =3D master
> > +prefix =3D PATCH
> > +to =3D qemu-devel@nongnu.org
> > +cc =3D qemu-trivial@nongnu.org
> > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
> > +
> > +[gitpublishprofile "block"]
> > +base =3D master
> > +prefix =3D PATCH
> > +to =3D qemu-devel@nongnu.org
> > +cc =3D qemu-block@nongnu.org
> > +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit =
--nogit-fallback 2>/dev/null
>=20
> Why is a custom entry needed for block here (and other things
> below).   Won't running get_maintainer.pl already correctly
> report when a patch needs cc'ing to qemu-block@nongnu.org
> based on MAINTAINER rules ?

Yeah, dropping them should be fine. What do you think, Stefan?

Fam
