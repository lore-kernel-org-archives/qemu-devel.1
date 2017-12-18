Received: from eggs.gnu.org ([2001:4830:134:3::10]:43660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR22x-0001O4-H9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eR22u-0001Ym-00
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eR22t-0001Y8-PZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:29:55 -0500
Date: Mon, 18 Dec 2017 20:29:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171218202946.GE2440@work-vm>
References: <20171213180807.7066-1-dgilbert@redhat.com>
	<20171213180807.7066-5-dgilbert@redhat.com>
	<20171214162731.50a95633@redhat.com>
	<20171214204310-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214204310-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vhost: add regions to temporary list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, maxime.coquelin@redhat.com, groug@kaod.org

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Dec 14, 2017 at 04:27:31PM +0100, Igor Mammedov wrote:
> > Also it seems that we have a race in current code where
> > region_del() unrefs memory region first and then by the
> > commit time memory region could be gone since old flatview
> > is unreffed before commit callback is called, but guest still
> > uses old memory map until vhost_set_mem_table() is complete.
> > We probably should unref deleted(old) sections after
> > guest gets new memmap.
> 
> Care trying to post a patch for stable? Might be a good idea
> to merge before this rework, for the sake of downstreams.

I think the 1st patch of my v5 might be suitable for that; please
have a look.

Dave

> > 
> > >  }
> > >  
> > >  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
