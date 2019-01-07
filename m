Received: from eggs.gnu.org ([209.51.188.92]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggaXf-00069G-Qy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggaXd-0000oW-Sv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:26:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ggaXc-0000iq-5b
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:26:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53CCCC06778B
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:26:26 +0000 (UTC)
Date: Mon, 7 Jan 2019 17:26:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190107192621.GU4157@habkost.net>
References: <20190104032226.21428-1-ehabkost@redhat.com>
	<20190103232012-mutt-send-email-mst@kernel.org>
	<20190104101200.GA2494@work-vm> <20190104175439.GH4157@habkost.net>
	<20190104200952.GI4157@habkost.net>
	<20190104154723-mutt-send-email-mst@kernel.org>
	<20190104210656.GJ4157@habkost.net>
	<20190104161217-mutt-send-email-mst@kernel.org>
	<20190104220050.GK4157@habkost.net>
	<20190107091206.6b5bd772.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107091206.6b5bd772.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] compat: Use explicit type names on
 HW_COMPAT_2_6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On Mon, Jan 07, 2019 at 09:12:06AM +0100, Cornelia Huck wrote:
> On Fri, 4 Jan 2019 20:00:50 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Jan 04, 2019 at 04:13:15PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Jan 04, 2019 at 07:06:56PM -0200, Eduardo Habkost wrote:  
> > > > On Fri, Jan 04, 2019 at 03:48:02PM -0500, Michael S. Tsirkin wrote:  
> > > > > On Fri, Jan 04, 2019 at 06:09:52PM -0200, Eduardo Habkost wrote:  
> 
> > > > > > Anyway, while writing this I noticed another issue: many of the
> > > > > > virtio devices in QEMU 2.6 were already modern-only!
> > > > > > 
> > > > > > Setting disable-modern=off on modern-only devices like virtio-vga
> > > > > > or virtio-tablet-pci doesn't make sense.  This means setting
> > > > > > virtio-pci.disable-modern=off on HW_COMPAT_2_6 was incorrect even
> > > > > > before the -non-transitional and -transitional device types were
> > > > > > introduced.  
> > > > > 
> > > > > 
> > > > > It did create an opportunity to create non working devices.
> > > > > 
> > > > > Whether that's incorrect as such I'm not sure.  
> > > > 
> > > > This is not just creating the opportunity for an user to
> > > > disable-modern=on.  HW_COMPAT_2_6 is actually setting
> > > > disable-modern=on on virtio-vga and other modern-only devices.
> > > > Sounds like a mistake to me.
> > > > 
> > > > Luckily those modern-only devices silently ignore the
> > > > disable-modern/disable-legacy properties, but this might change
> > > > in the future.  
> > > 
> > > Worry about it then?  
> > 
> > Right, we don't need to worry about it today.  But if a solution
> > to the crash reported by Thomas will make the problem go away,
> > that's even better.
> 
> It seems your patch with the modern-only devices removed from the list
> would achieve that?

I think so.  But I think I'll do the removal of modern-only
devices from the list in a separate patch, just to be safe.

-- 
Eduardo
