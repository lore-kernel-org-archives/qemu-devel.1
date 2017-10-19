Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=458e5c4de=owen.smith@citrix.com>)
	id 1e56h3-0004Nj-Ry
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=458e5c4de=owen.smith@citrix.com>)
	id 1e56gu-00082h-0e
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:00:45 -0400
Received: from smtp.citrix.com.au ([103.14.252.240]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=458e5c4de=owen.smith@citrix.com>)
	id 1e56gt-0007wt-Cr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:00:35 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Thu, 19 Oct 2017 09:00:27 +0000
Message-ID: <5136b1e64d2c412aab5f5a5264a599e2@AMSPEX02CL02.citrite.net>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
	<20171011154718.GQ1771@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710111309400.3105@sstabellini-ThinkPad-X260>
	<e25a3501923944fbad8e3a560c5cf8f3@AMSPEX02CL03.citrite.net>
	<1507800365.26812.11.camel@redhat.com>
	<0941888f3e184161a54e9c4509a1faab@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1710121026320.3105@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1710121026320.3105@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 3/3 v4] xenfb: Add
 [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Gerd Hoffmann' <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 12 October 2017 18:27
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Gerd Hoffmann' <kraxel@redhat.com>; 'Stefano Stabellini'
> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Owen Smith
> <owen.smith@citrix.com>
> Subject: RE: [Xen-devel] [PATCH 3/3 v4] xenfb: Add [feature|request]-raw-
> pointer
>=20
> On Thu, 12 Oct 2017, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> > > Sent: 12 October 2017 10:26
> > > To: Paul Durrant <Paul.Durrant@citrix.com>; 'Stefano Stabellini'
> > > <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>
> > > Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Owen
> > > Smith <owen.smith@citrix.com>
> > > Subject: Re: [Xen-devel] [PATCH 3/3 v4] xenfb: Add
> > > [feature|request]-raw- pointer
> > >
> > >   Hi,
> > >
> > > > It's probably OS specific though. I guess the behaviour changed
> > > > because the OS favours absolute pointing devices over relative
> > > > ones and how it has two absolute ones to choose from. How it
> > > > reconciles those, who knows?
> > >
> > > Typically hid emulation calls qemu_input_handler_activate() when the
> > > guest initializes the device, which moves the device to the top of
> > > the priority list.
> > >
> > > Visible effect on a typical guest with ps/2 mouse and usb-tablet is
> > > that qemu switches from relative mode (mouse) to absolute mode
> > > (tablet)  when the guest loads the usb hid driver.
> > >
> > > I suspect pvmouse is doing the same thing.  So it may simply depend
> > > on guest driver load order whenever pvmouse or usb-tablet is used.
> > >
> > > Simplest fix is probably to only attach the device you plan to use
> > > to the guest.  If you can't turn off pvmouse for xen guests then you
> > > might want drop the qemu_input_handler_activate() call, so it
> > > behaves simliar to the ps/2 mouse (is used in case no other pointer
> device is present).
> >
> > Avoiding the activate call sounds reasonable and should avoid the
> behavioural change.
>=20
> +1
>=20
> Owen, are you up for resubmitting the series with this small change?

Having just rebuilt my xen / linux host, and checked qemu, it looks like th=
e keycodemapdb patches have gone in, so I'll rebase and re-submit this seri=
es

Owen
