Received: from eggs.gnu.org ([2001:4830:134:3::10]:36468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1gXr4Q-0002cE-3H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1gXr4L-0007j8-Bc
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1gXr4L-0007g7-3R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:16:09 -0500
Date: Fri, 14 Dec 2018 09:16:06 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA8Z+g8HQq=HeY=2YbY1ToPyNpL8FO2mvfACS=sK-SBGfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1812140915400.12259@sstabellini-ThinkPad-X260>
References: <20181119162658.30358-1-peter.maydell@linaro.org>
	<20181126150307.GM2448@perard.uk.xensource.com>
	<CAFEAcA8Z+g8HQq=HeY=2YbY1ToPyNpL8FO2mvfACS=sK-SBGfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/xen/xen_pt_graphics: Don't
 trust the BIOS ROM contents so much
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, 14 Dec 2018, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 15:03, Anthony PERARD <anthony.perard@citrix.com> wrote:
> >
> > On Mon, Nov 19, 2018 at 04:26:58PM +0000, Peter Maydell wrote:
> > > Coverity (CID 796599) points out that xen_pt_setup_vga() trusts
> > > the rom->size field in the BIOS ROM from a PCI passthrough VGA
> > > device, and uses it as an index into the memory which contains
> > > the BIOS image. A corrupt BIOS ROM could therefore cause us to
> > > index off the end of the buffer.
> > >
> > > Check that the size is within bounds before we use it.
> > >
> > > We are also trusting the pcioffset field, and assuming that
> > > the whole rom_header is present; Coverity doesn't notice these,
> > > but check them too.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > Disclaimer: compile tested only, as I don't have a Xen setup,
> > > let alone one with pass-through PCI graphics.
> > >
> > > Note that https://xenbits.xen.org/xsa/advisory-124.html
> > > defines that bugs which are only exploitable by a malicious
> > > piece of hardware that is passed through to the guest are
> > > not security vulnerabilities as far as the Xen Project is
> > > concerned, and are treated like normal non-security-related bugs.
> > > So this is just a bugfix, not a security issue.
> > >
> > > Marked "for-3.1" because it would let us squash another Coverity
> > > issue, and it is a bug fix; on the other hand it's an obscure
> > > corner case and has been this way since forever.
> >
> > I haven't tested that patch either, but the changes looks fine, so:
> >
> > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> Ping! Would the Xen folks like to test this and/or send it in
> via a xen pullreq now that 4.0 has reopened for development?
> 
> Alternatively I can put it in via a pullreq I'm currently
> doing in its current "not tested but looks fine" state :-)

Hi Peter,

I know that Anthony is preparing a pretty large pull request for you.
You should see something coming your way soon.

Cheers,

Stefano
