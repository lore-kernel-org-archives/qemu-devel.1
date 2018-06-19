Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVNIS-0008K6-Si
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVNIP-0003Zn-LS
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:32:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVNIP-0003Zj-FU
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:32:09 -0400
Date: Tue, 19 Jun 2018 23:32:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180619233001-mutt-send-email-mst@kernel.org>
References: <20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619125453.2d2dfb2d.cohuck@redhat.com>
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

On Tue, Jun 19, 2018 at 12:54:53PM +0200, Cornelia Huck wrote:
> Sorry about dragging mainframes into this, but this will only work for
> homogenous device coupling, not for heterogenous. Consider my vfio-pci
> + virtio-net-ccw example again: The guest cannot find out that the two
> belong together by checking some group ID, it has to either use the MAC
> or some needs-to-be-architectured property.
> 
> Alternatively, we could propose that mechanism as pci-only, which means
> we can rely on mechanisms that won't necessarily work on non-pci
> transports. (FWIW, I don't see a use case for using vfio-ccw to pass
> through a network card anytime in the near future, due to the nature of
> network cards currently in use on s390.)

That's what it boils down to, yes.  If there's need to have this for
non-pci devices, then we should put it in config space.
Cornelia, what do you think?

-- 
MST
