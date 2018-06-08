Received: from eggs.gnu.org ([2001:4830:134:3::10]:51054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR6fb-0001Ay-Ra
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR6fX-00068O-W2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fR6fX-00066r-Oo
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 21:58:23 -0400
Date: Fri, 8 Jun 2018 04:58:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608045316-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com>
	<20180607031732.GG7815@xz-mi> <5B18C2B2.30709@intel.com>
	<20180607065808.GB750@xz-mi> <5B191EA6.3020004@intel.com>
	<20180608013723.GQ750@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608013723.GQ750@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Fri, Jun 08, 2018 at 09:37:23AM +0800, Peter Xu wrote:
> > > Asked since I see this in virtio spec (v1.0, though I guess it won't
> > > change) in chapter "2.2.1 Driver Requirements: Feature Bits":
> > > 
> > > "The driver MUST NOT accept a feature which the device did not offer"
> > > 
> > > Then I'm curious what would happen if:
> > > 
> > > - a emulator (not QEMU) only offered F_FREE_PAGE_HINT, not F_POISON
> > > - a guest that enabled PAGE_POISON
> > > 
> > > Then how the driver could tell the host that PAGE_POISON is enabled
> > > considering that guest should never set that feature bit if the
> > > emulation code didn't provide it?

It wouldn't. It just has to deal with the fact that host can discard
writes to hinted pages. Right now driver deals with it simply by
disabling F_FREE_PAGE_HINT.

-- 
MST
