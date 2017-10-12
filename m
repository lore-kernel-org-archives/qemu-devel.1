Received: from eggs.gnu.org ([2001:4830:134:3::10]:54960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=451313a22=anthony.perard@citrix.com>)
	id 1e2asw-00079C-DN
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=451313a22=anthony.perard@citrix.com>)
	id 1e2ast-0000jw-99
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:38:38 -0400
Received: from smtp.citrix.com ([66.165.176.89]:41636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=451313a22=anthony.perard@citrix.com>)
	id 1e2ast-0000gs-2Y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:38:35 -0400
Date: Thu, 12 Oct 2017 11:38:32 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171012103832.GT1771@perard.uk.xensource.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
	<20171011154718.GQ1771@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710111309400.3105@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1710111309400.3105@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH 3/3 v4] xenfb: Add
 [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Owen Smith <owen.smith@citrix.com>, kraxel@redhat.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Wed, Oct 11, 2017 at 01:19:25PM -0700, Stefano Stabellini wrote:
> On Wed, 11 Oct 2017, Anthony PERARD wrote:
> > The only observation I have is that on a Linux guest, when I have
> > usbdevice=tablet, with this series the pv mouse seems to become the
> > primary way of gueting mouse events (without, the tablet is primary).
> > So, on my VNC client instead of having both mouse in the guest and on my
> > desktop being at the same place, there is like a zoom of the mouse (the
> > zoom centered on the top-left corner). (That's better than relative
> > mouse event that we can get with the emulation.)
> 
> Thanks for testing. I am not completely sure about what should be the
> right behavior when both usbdevice=tablet and pvmouse are present.
> Typically, PV devices take precedence over emulated devices, so maybe
> it is OK that PV mouse is the primary device in this case.
> 
> But we would need to document this behavioral change in the commit
> descriptions.

Maybe something like "WARNING: pvmouse is fixed and now works!" :)

I think the change come from the fact that without the second patch, the
pv mouse doesn't work (or at least, I did not manage to make it work).

> The other question is whether the "zoom of the mouse" you are seeing is
> normal or whether we can "fix" it somehow. I guess it has always been
> the case for PV mouse? It is not something new, is it?

Yes, I think it always as been the case for PV mouse. I pretty sure I've
seen this behavior long time ago.

-- 
Anthony PERARD
