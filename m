Received: from eggs.gnu.org ([2001:4830:134:3::10]:56092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvEfi-00036d-B2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvEfe-0004fm-Ck
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvEfe-0004fM-67
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 23:30:30 -0400
Date: Fri, 22 Sep 2017 11:30:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922033026.GE1397@lemon.lan>
References: <20170921170209.9101-1-ehabkost@redhat.com>
	<7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build
 and test automation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 09/22 05:14, Thomas Huth wrote:
> On 21.09.2017 19:02, Eduardo Habkost wrote:
> > The subsystem name for the "Build test automation" section is
> > "-------------------------", because an actual subsystem name
> > line is missing:
> >=20
> >   $ ./scripts/get_maintainer.pl -f tests/docker/docker.py
> >   "Alex Benn=E9e" <alex.bennee@linaro.org> (maintainer:--------------=
---...)
> >   Fam Zheng <famz@redhat.com> (maintainer:-----------------...)
> >   "Philippe Mathieu-Daud=E9" <f4bug@amsat.org> (reviewer:------------=
-----...)
> >   qemu-devel@nongnu.org (open list:-----------------...)
> >=20
> > Fix the issue by inserting a subsystem name line where
> > get_maintainer.pl expects it.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e511ba780f..13c1ac65b7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1896,6 +1896,7 @@ F: docs/block-replication.txt
> > =20
> >  Build and test automation
> >  -------------------------
> > +Build and test automation
>=20
> Would it make sense to use something more specific here? Like "Travis
> and Docker" or so? ... in case we add other subsections in the future?

Unless we are to split off (i.e. more people volunteering maintaining a c=
ertain
subset), the list will just go on and on in this line. For not it's alrea=
dy
going to be "Travis, Shippable, Docker and VM test".. so I think a generi=
c
description here is okay, though the duplication is a bit odd (but I don'=
t have
a better idea).

Fam
