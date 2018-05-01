Received: from eggs.gnu.org ([2001:4830:134:3::10]:35613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=652da4df7=Paul.Durrant@citrix.com>)
	id 1fDSZo-0002xc-Fj
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=652da4df7=Paul.Durrant@citrix.com>)
	id 1fDSZn-0003a9-5r
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:32:04 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 1 May 2018 10:31:51 +0000
Message-ID: <28b92130893d43578fe4bbfb4028f693@AMSPEX02CL03.citrite.net>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
	<1525089699-13411-3-git-send-email-paul.durrant@citrix.com>
	<20180430151145.iyou5pisaclvvn3v@MacBook-Pro-de-Roger.local>
	<dfeffd8d0d9f46fbbed1abb2bdaccd27@AMSPEX02CL03.citrite.net>
	<20180430152826.puhl4lzvbdpdmomj@MacBook-Pro-de-Roger.local>
	<8579bd8e6cbf4dd598df66a85d07e524@AMSPEX02CL03.citrite.net>
	<20180501102959.maktlnyz4vxmuvdq@citrix.com>
In-Reply-To: <20180501102959.maktlnyz4vxmuvdq@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/4] block/xen_disk: remove use
 of grant map/unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Liu <wei.liu2@citrix.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Wei Liu [mailto:wei.liu2@citrix.com]
> Sent: 01 May 2018 11:30
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Roger Pau Monne <roger.pau@citrix.com>; Kevin Wolf
> <kwolf@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; qemu-
> block@nongnu.org; qemu-devel@nongnu.org; Max Reitz
> <mreitz@redhat.com>; Anthony Perard <anthony.perard@citrix.com>; xen-
> devel@lists.xenproject.org; Wei Liu <wei.liu2@citrix.com>
> Subject: Re: [Xen-devel] [PATCH 2/4] block/xen_disk: remove use of grant
> map/unmap
>=20
> On Mon, Apr 30, 2018 at 03:30:02PM +0000, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Roger Pau Monne
> > > Sent: 30 April 2018 16:28
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> > > devel@nongnu.org; Anthony Perard <anthony.perard@citrix.com>;
> Kevin
> > > Wolf <kwolf@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>;
> Max
> > > Reitz <mreitz@redhat.com>
> > > Subject: Re: [Xen-devel] [PATCH 2/4] block/xen_disk: remove use of
> grant
> > > map/unmap
> > >
> > > On Mon, Apr 30, 2018 at 04:16:52PM +0100, Paul Durrant wrote:
> > > > > -----Original Message-----
> > > > > From: Roger Pau Monne
> > > > > Sent: 30 April 2018 16:12
> > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> > > > > devel@nongnu.org; Anthony Perard <anthony.perard@citrix.com>;
> > > Kevin
> > > > > Wolf <kwolf@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>;
> > > Max
> > > > > Reitz <mreitz@redhat.com>
> > > > > Subject: Re: [Xen-devel] [PATCH 2/4] block/xen_disk: remove use o=
f
> > > grant
> > > > > map/unmap
> > > > >
> > > > > On Mon, Apr 30, 2018 at 01:01:37PM +0100, Paul Durrant wrote:
> > > > > > The grant copy operation was added to libxengnttab in Xen 4.8.0=
. If
> > > grant
> > > > > > copy is available then data from the guest will be copied rathe=
r than
> > > > > > mapped.
> > > > > > The xen_disk source can be significantly simplified by removing=
 this
> > > now
> > > > > > redundant code.
> > > > >
> > > > > Hm, I know this is a PITA, but FreeBSD gntdev hasn't implemented =
the
> > > > > grant-copy operation yet.
> > > > >
> > > > > I could try to implement it, but I can't make any promises on the=
 time
> > > > > ATM, since I'm quite busy.
> > > > >
> > > >
> > > > I guess we could carry a compat patch in QEMU that implements grant
> copy
> > > by doing a map/memcpy/unmap , but QEMU feels like the wrong place
> for
> > > that. I could try putting together a similar patch for the freebsd.c
> component
> > > of libxengnttab in the xen source rather than it simply failing with =
ENOSYS
> as
> > > it does now. Would either of those help?
> > >
> > > Maybe this could be implemented in gnttab_core.c, so it can also be
> > > used by MiniOS and Linux versions not supporting the copy ioctl as a
> > > fallback?
> >
> > That sounds like a reasonable idea. I'll put something together so that=
 it can
> go in early in 4.12.
> >
>=20
> This will not work if XSM disallows grant map but allows grant copy.
> Not sure how important that is.

I think it's just 'tough' at that point. This is only compat and there'd be=
 no change from using current QEMU (which would issue the grant maps direct=
ly).

  Cheers,

    Paul

>=20
> Wei.
>=20
> >   Paul
> >
> > >
> > > Roger.
> >
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xenproject.org
> > https://lists.xenproject.org/mailman/listinfo/xen-devel
