Received: from eggs.gnu.org ([2001:4830:134:3::10]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g07n5-0006yC-AR
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g07n1-0002X6-6Z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:14:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g07mz-0002Ux-5J
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:14:50 -0400
Date: Wed, 12 Sep 2018 12:14:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180912121306-mutt-send-email-mst@kernel.org>
References: <20180723045956.27521-1-tiwei.bie@intel.com>
	<20180723045956.27521-4-tiwei.bie@intel.com>
	<20180726144539.740acf4d@t450s.home>
	<20180727015805.GA11247@debian>
	<20180727140300.022d9872@t450s.home>
	<20180730081003.GA10680@debian>
	<20180730121704-mutt-send-email-mst@kernel.org>
	<20180912080400.GA9173@fbsd1.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912080400.GA9173@fbsd1.sh.intel.com>
Subject: Re: [Qemu-devel] [RFC 3/3] vhost-user: support programming VFIO
 group in master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org

On Wed, Sep 12, 2018 at 04:04:00PM +0800, Tiwei Bie wrote:
> On Mon, Jul 30, 2018 at 12:30:58PM +0300, Michael S. Tsirkin wrote:
> [...]
> > 
> > I generally wonder how are restarts of the backend handled
> > with this approach: closing the VFIO device tends to reset
> > the whole device.
> 
> Hi Michael,
> 
> I missed this comment previously.. This is a good point!
> In this RFC, before sending the VFIO group fd to QEMU,
> backend needs to close the VFIO device and unset the VFIO
> container first. Otherwise, QEMU won't be able to set the
> VFIO container for the VFIO group.
> 
> Another option is to share the container fd instead of
> the group fd to QEMU. In this case, backend won't need
> to close any fd. But there is one problem that, it's
> hard to unmap the old mappings, especially when QEMU
> crashes.

What are these old mappings and who creates them?
If you want to just reset everything the way it was
on open, surely it would be easy to add such a reset ioctl.

> Do you have any suggestions? Thanks!
> 
> Best regards,
> Tiwei Bie

Donnu. Alex, any thoughts? Which approach would you prefer?

-- 
MST
