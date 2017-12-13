Received: from eggs.gnu.org ([2001:4830:134:3::10]:43994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePE7g-0006NF-BN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePE7b-0002hA-FE
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:59:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ePE7b-0002gR-91
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:59:19 -0500
Date: Wed, 13 Dec 2017 22:59:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171213222102-mutt-send-email-mst@kernel.org>
References: <5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

>  * VHOST_USER_SET_VRING_KICK
> 
>    Set up vring kick doorbell (unless bit 8 is set) before sending
>    VHOST_USER_SET_VRING_KICK to the guest.

But guest can't use it, now can it?

What guest needs is a mapping to interrupts.


>  * VHOST_USER_SET_VRING_CALL
> 
>    Set up the vring call doorbell (unless bit 8 is set) before sending
>    VHOST_USER_SET_VRING_CALL to the guest.

Same here. what guest needs is mapping from io to notifications,
right?

---

> > I took a quick look and I doubt we can do something that is both
> > compatible with the existing vhost-user and will make it possible to
> > extend the protocol without qemu changes. Let's assume I pass a new
> > message over the vhost-user channel.  How do we know it's safe to pass
> > it to the guest?
> >
> > That's why we gate any protocol change on a feature bit and must parse
> > all messages.
> 
> QEMU must parse all messages and cannot pass through unknown messages.
> Think of QEMU vhost-pci as both a vhost-user slave to the other VM and
> a vhost-user master to the guest.
> 
> QEMU changes are necessary when the vhost protocol is extended.
> Device interface changes are only necessary if doorbells or shared
> memory regions are added, any other protocol changes do not change the
> device interface.
> 
> Stefan

I guess you have a different definition of a device interface than
myself - I consider it an interface change if a feature bit changes :)

-- 
MST
