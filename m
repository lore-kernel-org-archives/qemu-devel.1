Received: from eggs.gnu.org ([2001:4830:134:3::10]:41710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JEJ-00060T-E3
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JEE-0001N1-KR
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:47:30 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:34173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JEE-0001MC-Cy
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:47:26 -0400
Date: Wed, 11 Oct 2017 16:47:18 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171011154718.GQ1771@perard.uk.xensource.com>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
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

On Tue, Oct 10, 2017 at 04:52:48PM -0700, Stefano Stabellini wrote:
> On Mon, 2 Oct 2017, Anthony PERARD wrote:
> > On Tue, Sep 26, 2017 at 02:43:39PM +0000, Owen Smith wrote:
> > > Writes "feature-raw-pointer" during init to indicate the backend
> > > can pass raw unscaled values for absolute axes to the frontend.
> > > Frontends set "request-raw-pointer" to indicate the backend should
> > > not attempt to scale absolute values to console size.
> > > "request-raw-pointer" is only valid if "request-abs-pointer" is
> > > also set. Raw unscaled pointer values are in the range [0, 0x7fff]
> > > 
> > > Signed-off-by: Owen Smith <owen.smith@citrix.com>
> > 
> > Hi Owen,
> > 
> > Why did you remove the following from the commit description?
> > > "feature-raw-pointer" and "request-raw-pointer" added to Xen
> > > header in commit 7868654ff7fe5e4a2eeae2b277644fa884a5031e
> > 
> > I think that with it, you could have kept stefano's reviewed-by tag.
> 
> Hi Anthony,
> 
> Have you tested this series with a few of different guests? Do you
> consider it safe to merge? If so, we can send it upstream (either via
> xen or via ui as Gerd kindly offered). 

Yes, I think it's fine.

The only observation I have is that on a Linux guest, when I have
usbdevice=tablet, with this series the pv mouse seems to become the
primary way of gueting mouse events (without, the tablet is primary).
So, on my VNC client instead of having both mouse in the guest and on my
desktop being at the same place, there is like a zoom of the mouse (the
zoom centered on the top-left corner). (That's better than relative
mouse event that we can get with the emulation.)

-- 
Anthony PERARD
