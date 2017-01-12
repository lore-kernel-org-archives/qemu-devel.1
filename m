Received: from eggs.gnu.org ([2001:4830:134:3::10]:49796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRV1w-0005BX-By
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRV1t-0004S3-8m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:22:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cRV1t-0004RC-2p
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:22:17 -0500
Date: Thu, 12 Jan 2017 10:22:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170112022212.GA26504@lemon>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
	<e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
	<20170104144458.GC8194@stefanha-x1.localdomain>
	<e1a9afaf-74c0-77f1-72e9-c61cf225122e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a9afaf-74c0-77f1-72e9-c61cf225122e@gmail.com>
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Junkang Fu <fujunkang@gmail.com>, qemu-devel@nongnu.org

On Thu, 01/12 09:22, Yang Zhang wrote:
> On 2017/1/4 22:44, Stefan Hajnoczi wrote:
> > On Tue, Jan 03, 2017 at 10:53:06AM -0600, Eric Blake wrote:
> > > On 12/29/2016 08:41 PM, Junkang Fu wrote:
> > > > >From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> > > > From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> > > > Date: Wed, 24 Aug 2016 19:36:53 +0800
> > > > Subject: [PATCH] virtio-blk: add disk-name device property
> > > > 
> > > > Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> > > > target dev
> > > > name specified in libvirt xml file. For example, we may get disk name
> > > > /dev/vdb in
> > > > VM while target dev specified in libvirt xml is vdc.
> > > 
> > > It's not really libvirt's fault.  The libvirt XML names are for
> > > convenience, but nothing on the host side requires the guest to pick the
> > > same naming scheme as the host.
> > > 
> > > I guess your proposal is to enhance the virtio spec such that clients
> > > that are new enough to honor the new addition to the virtio spec will
> > > change their name-picking algorithm to use the name provided by the
> > > host, rather than their current approach of picking whatever name they
> > > feel like, and then enhance libvirt to pass the XML name on down to the
> > > guest?  It might work, but as others have pointed out, it will require a
> > > virtio spec change first.
> > 
> > This change is unnecessary.  The -device virtio-blk-pci,serial= property
> > already exists for this purpose.
> 
> how about the /dev/vdabc? I guess lots of people prefer to use it instead of
> /dev/disk/by-id/xxx?

I disagree. Using /dev/sdX has exactly the same issue and that's why fstab and
boot loader etc almost always use UUID or disk label by default because they are
more stable.

Fam
