Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIJk-00060h-2l
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehIJd-0003OP-Qh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:06:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehIJd-0003My-Ir
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:06:25 -0500
Date: Thu, 1 Feb 2018 19:06:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201190537-mutt-send-email-mst@kernel.org>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<B2D15215269B544CADD246097EACE7473AB6F5B2@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB6F5B2@DGGEMM505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

Yes, I plan to merge it in the next pull.
Pls don't assume anything until it's merged upstream though,
some issues surface late.

On Thu, Feb 01, 2018 at 11:29:15AM +0000, Zhoujian (jay) wrote:
> Hi Michael,
> I am wondering whether this version is OK for you?
> Any comment will be appreciated, thanks.
> 
> Regards,
> Jay
> 
> > -----Original Message-----
> > From: Zhoujian (jay)
> > Sent: Sunday, January 21, 2018 8:55 PM
> > To: qemu-devel@nongnu.org
> > Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; stefanha@redhat.com; Zhoujian (jay)
> > <jianjay.zhou@huawei.com>; pasic@linux.vnet.ibm.com; longpeng
> > <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.com; Gonglei
> > (Arei) <arei.gonglei@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>
> > Subject: [PATCH v6 0/4] cryptodev: add vhost support
> > 
> > From: Gonglei <arei.gonglei@huawei.com>
> > 
> > I posted the RFC verion a few months ago for DPDK vhost-crypto implmention,
> > and now it's time to send the formal version. Because we need an user space
> > scheme for better performance.
> > 
> > The vhost user crypto server side patches had been sent to DPDK community,
> > pls see
> > 
> > [RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
> > support http://dpdk.org/ml/archives/dev/2017-November/081048.html
> > 
> > You also can get virtio-crypto polling mode driver from:
> > 
> > [PATCH] virtio: add new driver for crypto devices
> > http://dpdk.org/ml/archives/dev/2017-November/081985.html
> > 
> > v5 -> v6:
> >   Fix compile error about backends/cryptodev-vhost-user.o and rebase on
> >   the master
> > v4 -> v5:
> >   squash [PATCH v4 5/5] into previous patches [Michael]
> > v3 -> v4:
> >   "[PATCH v4 5/5] cryptodev-vhost-user: depend on CONFIG_VHOST_CRYPTO
> >   and CONFIG_VHOST_USER" newly added to fix compilation dependency [Michael]
> > v2 -> v3:
> >   New added vhost user messages should be sent only when feature
> >   has been successfully negotiated [Michael]
> > v1 -> v2:
> >   Fix compile error on mingw32
> > 
> > Gonglei (4):
> >   cryptodev: add vhost-user as a new cryptodev backend
> >   cryptodev: add vhost support
> >   cryptodev-vhost-user: add crypto session handler
> >   cryptodev-vhost-user: set the key length
> > 
> >  backends/Makefile.objs                |   6 +
> >  backends/cryptodev-builtin.c          |   1 +
> >  backends/cryptodev-vhost-user.c       | 379
> > ++++++++++++++++++++++++++++++++++
> >  backends/cryptodev-vhost.c            | 347 +++++++++++++++++++++++++++++++
> >  configure                             |  15 ++
> >  docs/interop/vhost-user.txt           |  26 +++
> >  hw/virtio/Makefile.objs               |   2 +-
> >  hw/virtio/vhost-user.c                | 104 ++++++++++
> >  hw/virtio/virtio-crypto.c             |  70 +++++++
> >  include/hw/virtio/vhost-backend.h     |   8 +
> >  include/hw/virtio/virtio-crypto.h     |   1 +
> >  include/sysemu/cryptodev-vhost-user.h |  47 +++++
> >  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
> >  include/sysemu/cryptodev.h            |   8 +
> >  qemu-options.hx                       |  21 ++
> >  vl.c                                  |   6 +
> >  16 files changed, 1194 insertions(+), 1 deletion(-)  create mode 100644
> > backends/cryptodev-vhost-user.c  create mode 100644 backends/cryptodev-
> > vhost.c  create mode 100644 include/sysemu/cryptodev-vhost-user.h
> >  create mode 100644 include/sysemu/cryptodev-vhost.h
> > 
> > --
> > 1.8.3.1
> > 
