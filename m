Received: from eggs.gnu.org ([2001:4830:134:3::10]:45747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVTbD-0002En-Ae
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVTbA-0005ea-05
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:15:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVTb9-0005e0-R5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 23:15:55 -0400
Date: Wed, 20 Jun 2018 06:15:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620061438-mutt-send-email-mst@kernel.org>
References: <1462367134-23894-1-git-send-email-kraxel@redhat.com>
	<20160509144316.GI3372@stefanha-x1.localdomain>
	<1462874939.8035.52.camel@redhat.com>
	<1462879537.8035.53.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462879537.8035.53.camel@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH] Add virtio gpu device
 specification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, May 10, 2016 at 01:25:37PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > Rendered versions are available here:
> > > >   https://www.kraxel.org/virtio/virtio-v1.0-cs03-virtio-gpu.pdf
> > > >   https://www.kraxel.org/virtio/virtio-v1.0-cs03-virtio-gpu.html#x1-2800007
> 
> > > I guess a non-fenced command only completes when the operation has
> > > finished, too (so that a meaningful success/error value can be
> > > produced)?
> > 
> > When stuff is processed asynchronously the command can complete before
> > the operation actually completed.  Current qemu implementation does that
> > only in 3d mode, when offloading stuff to the hardware (and verifies
> > stuff beforehand, so if you try to kick 3d rendering with an invalid
> > context id qemu will throw an error).
> > 
> > I'll try to make that more clear in the text.
> 
> Updated now.
> 
> cheers,
>   Gerd

Is there a chance you could rebase and post?
This is used widely, I think we shoould have it in 1.1
if at all possible.


> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
