Received: from eggs.gnu.org ([2001:4830:134:3::10]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBlkm-0007E1-8H
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBlkj-0000oH-4g
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:36:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fBlki-0000nf-W4
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 949204075A77
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 18:36:20 +0000 (UTC)
Date: Thu, 26 Apr 2018 21:36:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180426213337-mutt-send-email-mst@kernel.org>
References: <20180424063857.29246-1-kraxel@redhat.com>
	<20180426180955-mutt-send-email-mst@kernel.org>
	<20180426153148.rbjgglui2shdlzpg@sirius.home.kraxel.org>
	<20180426184017-mutt-send-email-mst@kernel.org>
	<20180426110028.738cb2f1@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426110028.738cb2f1@w520.home>
Subject: Re: [Qemu-devel] [PATCH] allocate pci id for mdpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Apr 26, 2018 at 11:00:28AM -0600, Alex Williamson wrote:
> On Thu, 26 Apr 2018 18:40:40 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Apr 26, 2018 at 05:31:48PM +0200, Gerd Hoffmann wrote:
> > > On Thu, Apr 26, 2018 at 06:10:48PM +0300, Michael S. Tsirkin wrote:  
> > > > On Tue, Apr 24, 2018 at 08:38:57AM +0200, Gerd Hoffmann wrote:  
> > > > > mdpy is a sample pci device for vfio-mdev.  Not (yet) merged upstream,
> > > > > patch available here:
> > > > > 
> > > > > https://www.kraxel.org/cgit/linux/commit/?h=vfio-sample-display&id=6fd86cff3d7df38ab89625b16fdd6434b1c18749
> > > > > 
> > > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>  
> > > > 
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > I presume this should be merged together with the
> > > > device implementation in qemu, or do you want this
> > > > in tree sooner?  
> > > 
> > > There isn't a device implementation in qemu.  It's a mdev device
> > > provided by the kernel.  Can be used with qemu using vfio. 
> > 
> > Why do we need a define in pci.h then?
> 
> Because we want to allocate the device ID rather than squat on an
> unused one and risk that it later conflicts with an another device.  Do
> we track device ID allocations from the RH vendor ID other than here in
> QEMU?  Thanks,
> 
> Alex

We have pci-ids.txt, yes. Unused macros just might get pruned down
the line. If you like, add a comment in pci.h saying 0xf is reserved for
mdpy.

-- 
MST
