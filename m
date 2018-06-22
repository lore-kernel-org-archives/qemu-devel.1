Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTu6-0005ew-Jr
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTu3-0003hB-Fv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:47:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWTu3-0003gt-C0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:47:35 -0400
Date: Sat, 23 Jun 2018 00:47:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180623004404-mutt-send-email-mst@kernel.org>
References: <20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
	<c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
	<ce4da2b0-88fd-c79b-0567-fe564bb34922@redhat.com>
	<20180621211359-mutt-send-email-mst@kernel.org>
	<CADGSJ216itm89dUuK_vOfuBsBq5bq4485GqMKjB1JXFD_PLZxA@mail.gmail.com>
	<20180622052717-mutt-send-email-mst@kernel.org>
	<CADGSJ210d358_uyNK9LLw9gpP5uXK6T0h=9mR9ryG7ySkVqvkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ210d358_uyNK9LLw9gpP5uXK6T0h=9mR9ryG7ySkVqvkA@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, qemu-devel@nongnu.org

On Fri, Jun 22, 2018 at 12:43:26PM -0700, Siwei Liu wrote:
> > The semantics are that the primary is always used if present in
> > preference to standby.
> OK. If this is the only semantics of what "standby" refers to in
> general, that is fine.
> 
> I just don't want to limit the failover/standby semantics to the
> device model specifics, the "accelerated datapath" thing or whatever.
> I really don't know where the requirements of the "accelerated
> datapath" came from,

It's a way to put it that matches what failover actually provides.

> as the originial problem is migrating vfio
> devices which is in match of QEMU's live migration model.

If you put it this way then it's natural to require that we have a
config with a working vfio device, and that we somehow add virtio for
duration of migration.

> Hyper-V has
> it's limitation to do 1-netdev should not impact how KVM/QEMU should
> be doing it.

That's a linux thing and pretty orthogonal to host/guest interface.

> > Jason said virtio net is sometimes preferable.
> > If that's the case don't make it a standby.
> >
> > More advanced use-cases do exist and e.g. Alexander Duyck
> > suggested using a switch-dev.
> 
> The switchdev case would need a new feature bit, right?
> 
> -Siwei

I think it would need to be a completely new device.

> > failover isn't it though.
> >
> > --
> > MST
