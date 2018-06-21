Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fW4C4-0003pJ-0g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fW4C0-00044K-SS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:20:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fW4C0-00043S-OH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:20:24 -0400
Date: Thu, 21 Jun 2018 21:20:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180621211712-mutt-send-email-mst@kernel.org>
References: <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621165913.7e3f4faa.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:
> On Wed, 20 Jun 2018 22:48:58 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jun 20, 2018 at 06:06:19PM +0200, Cornelia Huck wrote:
> > > In any case, I'm not sure anymore why we'd want the extra uuid.  
> > 
> > It's mostly so we can have e.g. multiple devices with same MAC
> > (which some people seem to want in order to then use
> > then with different containers).
> > 
> > But it is also handy for when you assign a PF, since then you
> > can't set the MAC.
> > 
> 
> OK, so what about the following:
> 
> - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
>   that we have a new uuid field in the virtio-net config space
> - in QEMU, add a property for virtio-net that allows to specify a uuid,
>   offer VIRTIO_NET_F_STANDBY_UUID if set
> - when configuring, set the property to the group UUID of the vfio-pci
>   device
> - in the guest, use the uuid from the virtio-net device's config space
>   if applicable; else, fall back to matching by MAC as done today
> 
> That should work for all virtio transports.

True. I'm a bit unhappy that it's virtio net specific though
since down the road I expect we'll have a very similar feature
for scsi (and maybe others).

But we do not have a way to have fields that are portable
both across devices and transports, and I think it would
be a useful addition. How would this work though? Any idea?

-- 
MST
