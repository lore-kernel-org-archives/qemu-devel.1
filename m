Received: from eggs.gnu.org ([2001:4830:134:3::10]:49986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQE88-0000Pp-Bl
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQE86-00073Y-LP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dQE86-00073H-Ep
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:39:42 -0400
Date: Wed, 28 Jun 2017 17:39:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170628171823-mutt-send-email-mst@kernel.org>
References: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
	<35650f4c-8852-2dcd-94f9-13f0105b76cd@redhat.com>
	<865858b6-1e3b-b421-617e-f8656ca36b5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865858b6-1e3b-b421-617e-f8656ca36b5b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, virtio-dev-owner@lists.oasis-open.org

On Wed, Jun 28, 2017 at 08:02:06AM -0500, Eric Blake wrote:
> [meta-comment, replacing virtio-dev with virtio-dev-owner in cc]
> 
> On 06/28/2017 07:22 AM, Eric Blake wrote:
> > On 06/28/2017 12:53 AM, Wei Wang wrote:
> >> Use is_power_of_2(), and remove trailing "." from error_setg().
> >>
> >> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> >> ---
> >>  hw/net/virtio-net.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > 
> 
> I got this rejection letter:
> 
> > 
> >                    The mail system
> > 
> > <virtio-dev@lists.oasis-open.org>: permission denied. Command output: Sorry,
> >     only subscribers may post. If you are a subscriber, please forward this
> >     message to virtio-dev-owner@lists.oasis-open.org to get your new address
> >     included (#5.7.2) ERROR: postqmail-local Error #77
> 
> It's generally considered poor netiquette to cc both an open list and a
> closed list that rejects emails from non-subscribers (note that you do
> NOT have to subscribe to qemu-devel to post to it, although a moderation
> delay may be involved).  It's not necessarily my place to tell the
> virtio-dev list what to do (since I don't subscribe), but it may be
> worth considereing relaxing the list posting policies there to allow
> moderated posts from non-subscribers, especially if it is going to be
> common-place that people want to cc virtio-dev at the same time as
> another open list.

Unfortunately OASIS policies require you to subscribe to post.  I wish
there was a way to request post rights without actually subscribing. It
doesn't look like OASIS mailing list software supports that.  In this
case I'm guessing you can just ignore this, it should not matter that
this specific email did not make it to virtio-dev.


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
