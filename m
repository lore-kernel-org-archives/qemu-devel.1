Received: from eggs.gnu.org ([2001:4830:134:3::10]:52095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehcoO-0005rL-NW
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ehcoN-0002r6-Ty
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ehcoN-0002qX-Np
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C4C56E760
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 10:11:46 +0000 (UTC)
Date: Fri, 2 Feb 2018 18:11:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180202101140.GC4666@xz-mi>
References: <20180131092835.GA31397@xz-mi>
	<20180131160214-mutt-send-email-mst@kernel.org>
	<20180201021853.GD31397@xz-mi>
	<20180201042234-mutt-send-email-mst@kernel.org>
	<20180201023350.GF31397@xz-mi>
	<20180201144449-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201144449-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Windows balloon driver PFN issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Thu, Feb 01, 2018 at 02:48:20PM +0200, Michael S. Tsirkin wrote:

[...]

> > > > > PFN is GPA>>12.  Do you have more than 1<<44 bytes of memory in this VM then?
> > > > 
> > > > No.  But isn't it still not good to drop the page at offset zero (and
> > > > drop it NNN times)?
> > > 
> > > Absolutely - looks like a bug. I just don't know why does this happen.
> > 
> > IMHO if we are using a PFN array like this:
> > 
> >    u64 pfn_array[];
> > 
> > In the windows guest driver, then we'll see this (as mentioned
> > above).  But for sure this is wild guess of mine.
> 
> I don't see code like this anywhere in the windows balloon
> driver. It's here:
> https://github.com/virtio-win/kvm-guest-drivers-windows.git

Thanks for the pointer.  I had a quick glance, the PFN array is
defined as:

    PPFN_NUMBER             pfns_table;

But I don't know what's sizeof(PPFN_NUMBER). :(

-- 
Peter Xu
