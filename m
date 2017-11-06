Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eBkeX-0002vA-6A
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eBkeU-0001OJ-Eg
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:53:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eBkeU-0001O9-8I
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:53:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 349537853F
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 16:53:33 +0000 (UTC)
Date: Mon, 6 Nov 2017 18:53:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171106185150-mutt-send-email-mst@kernel.org>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
	<1509693637.31823.7.camel@redhat.com>
	<CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
	<20171103170426-mutt-send-email-mst@kernel.org>
	<CABdb734DG_itxuUjCiANz_ps+j5EdJj287HXrd8Xa_akyGAsaA@mail.gmail.com>
	<1509959887.30277.8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509959887.30277.8.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>

On Mon, Nov 06, 2017 at 10:18:07AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > So in my humble opinion the right thing for people to do is simply
> > > to
> > > avoid legacy devices. Is something preventing that?
> > 
> > The same reasons why the concept of transitional devices exists at
> > all?
> 
> We discussing future driver versions running on future qemu versions,
> so we should have virtio 1.0 support on both ends.  So IMO the question
>  isn't that silly ...
> 
> But by default qemu uses transitional by default for non-express
> devices, i.e. for all i440fx machines types.  Which implies virtio-
> legacy compatible pci ids.
> 
> If we want change this we need a transitional/modern virtio config
> switch.  Not only in qemu, but for the whole management stack too.
> I don't think it is a good idea to go that route.
> 
> cheers,
>   Gerd

I think we already have that in libvirt.

Right now we just ignore the subsystem IDs if supplied but
maybe the right thing to do is to just disable legacy
mode if they are supplied.

Seems cleaner than ignoring the subsystem id but using the
subsystem vendor id.

-- 
MST
