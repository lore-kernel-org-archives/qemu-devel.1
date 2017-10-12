Received: from eggs.gnu.org ([2001:4830:134:3::10]:40822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e2hGT-0006Vz-A8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e2hGP-0007hL-8F
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e2hGP-0007gn-1L
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:27:17 -0400
Date: Thu, 12 Oct 2017 10:27:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <0941888f3e184161a54e9c4509a1faab@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.10.1710121026320.3105@sstabellini-ThinkPad-X260>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
	<20171011154718.GQ1771@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710111309400.3105@sstabellini-ThinkPad-X260>
	<e25a3501923944fbad8e3a560c5cf8f3@AMSPEX02CL03.citrite.net>
	<1507800365.26812.11.camel@redhat.com>
	<0941888f3e184161a54e9c4509a1faab@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Gerd Hoffmann' <kraxel@redhat.com>, 'Stefano Stabellini' <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Owen Smith <owen.smith@citrix.com>

On Thu, 12 Oct 2017, Paul Durrant wrote:
> > -----Original Message-----
> > From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> > Sent: 12 October 2017 10:26
> > To: Paul Durrant <Paul.Durrant@citrix.com>; 'Stefano Stabellini'
> > <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>
> > Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Owen Smith
> > <owen.smith@citrix.com>
> > Subject: Re: [Xen-devel] [PATCH 3/3 v4] xenfb: Add [feature|request]-raw-
> > pointer
> > 
> >   Hi,
> > 
> > > It's probably OS specific though. I guess the behaviour changed
> > > because the OS favours absolute pointing devices over relative ones
> > > and how it has two absolute ones to choose from. How it reconciles
> > > those, who knows?
> > 
> > Typically hid emulation calls qemu_input_handler_activate() when the
> > guest initializes the device, which moves the device to the top of the
> > priority list.
> > 
> > Visible effect on a typical guest with ps/2 mouse and usb-tablet is
> > that qemu switches from relative mode (mouse) to absolute mode (tablet)
> >  when the guest loads the usb hid driver.
> > 
> > I suspect pvmouse is doing the same thing.  So it may simply depend on
> > guest driver load order whenever pvmouse or usb-tablet is used.
> > 
> > Simplest fix is probably to only attach the device you plan to use to
> > the guest.  If you can't turn off pvmouse for xen guests then you might
> > want drop the qemu_input_handler_activate() call, so it behaves simliar
> > to the ps/2 mouse (is used in case no other pointer device is present).
> 
> Avoiding the activate call sounds reasonable and should avoid the behavioural change.

+1

Owen, are you up for resubmitting the series with this small change?
