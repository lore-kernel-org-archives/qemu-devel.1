Received: from eggs.gnu.org ([2001:4830:134:3::10]:37749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUY6G-0005fP-TY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUY6G-00077Z-6G
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:24:28 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 14:24:04 +0000
Message-ID: <f0d21d9e49ef496f9e7c1949bbc1d473@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-5-paul.durrant@citrix.com>
	<20181129184841.GJ14786@perard.uk.xensource.com>
	<589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
	<d5bf17f689a34e69b9e3b7b92bcfe4fd@AMSPEX02CL03.citrite.net>
	<20181205135839.GB1259@perard.uk.xensource.com>
In-Reply-To: <20181205135839.GB1259@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 04/18] xen: create xenstore areas for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 05 December 2018 13:59
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-devel@nongnu.org;
> Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org
> Subject: Re: [PATCH 04/18] xen: create xenstore areas for XenDevice-s
>=20
> On Wed, Dec 05, 2018 at 12:43:57PM +0000, Paul Durrant wrote:
> > > > > +    value =3D g_strdup_vprintf(fmt, ap);
> > > >
> > > > Looks like g_vasprintf() would be better, since it returns the
> lenght as
> > > > well.
> > > >
> > >
> > > Yes.
> >
> > I tried this and it appears not to exist in the version of glib in my
> environment so I guess I'll stick with g_strdup_printf().
>=20
> It's probably because you need to include "glib/gprintf.h", I've
> suggested it because I've seen the function use elsewhere in QEMU. But
> g_strdup_printf is fine too.
>=20
> https://developer.gnome.org/glib/stable/glib-String-Utility-
> Functions.html#g-vasprintf

Ah, that's what I needed. Thanks,

  Paul

>=20
> --
> Anthony PERARD
