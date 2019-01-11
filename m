Received: from eggs.gnu.org ([209.51.188.92]:50478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghpeB-0000ZQ-EO
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghpe5-0000wQ-12
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:46:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghpe4-0000vT-Qp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 00:46:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B365E8E67E
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:46:14 +0000 (UTC)
Date: Fri, 11 Jan 2019 06:46:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190111054613.e2vka5ywjij53tjl@sirius.home.kraxel.org>
References: <20190110120047.25369-1-berrange@redhat.com>
	<20190110120047.25369-2-berrange@redhat.com>
	<c471db17-bab0-21e7-d8c2-7f1b8c1ef742@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c471db17-bab0-21e7-d8c2-7f1b8c1ef742@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Thu, Jan 10, 2019 at 09:00:27AM -0600, Eric Blake wrote:
> On 1/10/19 6:00 AM, Daniel P. Berrang=E9 wrote:
> > QEMU currently installs loogs to $prefix/share/qemu/ which means no G=
UI
>=20
> s/loogs/logos/
>=20
> > toolkit or applications can find them by default.
> >=20
> > The accepted standards for desktop applications declare that applicat=
ion
> > logos / icons should be installed under $prefix/share/icons, so use t=
his
> > directory location.
> >=20
> > Pre-rendered icons are provided at the standard sizes expected for GU=
I
> > applications, along with the scalable SVG, to ensure maximum portabil=
ity.
> >=20
> > The PNGs are rendered from the SVG using inkscape, however, this is n=
ot
> > wired up into the default make rules to avoid requiring inkscape as a
> > mandatory tool in build systems / developer workstations..
>=20
> double trailing '.'. I like that the rules for automating it are there
> as a separate make target, and that they are not part of the default
> build (and hence the generated files must live in git).  That said,...

/me can fix that on commit.

> > +++ b/ui/icons/Makefile
> > @@ -0,0 +1,13 @@
> > +
> > +# Regenerate bitmaps from the SVG using inkscape CLI export
> > +# and ImageMagick. Don't use ImageMagick for the initial
> > +# SVG conversion, since it merely calls inkscape, but uses
> > +# 96 DPI res resulting in poor quality output.
>=20
> ...should this comment mention that it is intentional that this target
> is not part of 'make all'? Should the target be named 'maint-regenerate=
'
> to call attention to the fact that it is a maintainer-specific target?

roms/Makefile targets (which is basically the same, but for guest
firmware) don't have a maint prefix either ...

cheers,
  Gerd
