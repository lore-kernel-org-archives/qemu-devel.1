Received: from eggs.gnu.org ([2001:4830:134:3::10]:46278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eRp5C-0003Uw-3b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eRp58-0007ye-0r
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:51:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2360 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eRp57-0007fr-Lk
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:51:29 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 21 Dec 2017 00:51:12 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4F143F@DGGEMA505-MBX.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ED5D3@DGGEMA505-MBX.china.huawei.com>
	<20171220193658-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171220193658-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Thursday, December 21, 2017 1:39 AM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C);
> stefanha@redhat.com; Zhoujian (jay); pasic@linux.vnet.ibm.com; longpeng;
> xin.zeng@intel.com; roy.fan.zhang@intel.com
> Subject: Re: [PATCH 0/4] cryptodev: add vhost support
>=20
> On Mon, Dec 18, 2017 at 09:03:16AM +0000, Gonglei (Arei) wrote:
> > Ping...
> >
> > Fan (working for DPDK parts) is waiting for those patches upstreamed. :=
)
> >
> > Thanks,
> > -Gonglei
>=20
> As far as I am concerned, the main issue is that it says it assumes
> polling.  virtio does not work like this right now.  As long as spec
> does not support interrupt mode, I don't think we can merge this.
>=20
Sorry, Michael. This makes me confused. Because the Qemu part about vhost-u=
ser crypto=20
doesn't do this assumption. The main controversial point is whether session=
 operations
should be added in the vhost-user protocol, raised by Paolo. And we made an=
 explanation.=20

Thanks,
-Gonglei

> >
> > > -----Original Message-----
> > > From: Gonglei (Arei)
> > > Sent: Tuesday, November 28, 2017 5:03 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C);
> > > stefanha@redhat.com; Zhoujian (jay); pasic@linux.vnet.ibm.com;
> longpeng;
> > > xin.zeng@intel.com; roy.fan.zhang@intel.com; Gonglei (Arei)
> > > Subject: [PATCH 0/4] cryptodev: add vhost support
> > >
> > > I posted the RFC verion five months ago for DPDK
> > > vhost-crypto implmention, and now it's time to send
> > > the formal version. Because we need an user space scheme
> > > for better performance.
> > >
> > > The vhost user crypto server side patches had been
> > > sent to DPDK community, pls see
> > >
> > > [RFC PATCH 0/6] lib/librte_vhost: introduce new	vhost_user crypto
> backend
> > > support
> > > http://dpdk.org/ml/archives/dev/2017-November/081048.html
> > >
> > > You also can get virtio-crypto polling mode driver from:
> > >
> > > [PATCH] virtio: add new driver for crypto devices
> > > http://dpdk.org/ml/archives/dev/2017-November/081985.html
> > >
> > >
> > > Gonglei (4):
> > >   cryptodev: add vhost-user as a new cryptodev backend
> > >   cryptodev: add vhost support
> > >   cryptodev-vhost-user: add crypto session handler
> > >   cryptodev-vhost-user: set the key length
> > >
> > >  backends/Makefile.objs                |   4 +
> > >  backends/cryptodev-builtin.c          |   1 +
> > >  backends/cryptodev-vhost-user.c       | 381
> > > ++++++++++++++++++++++++++++++++++
> > >  backends/cryptodev-vhost.c            | 297
> > > ++++++++++++++++++++++++++
> > >  docs/interop/vhost-user.txt           |  19 ++
> > >  hw/virtio/vhost-user.c                |  89 ++++++++
> > >  hw/virtio/virtio-crypto.c             |  70 +++++++
> > >  include/hw/virtio/vhost-backend.h     |   8 +
> > >  include/hw/virtio/virtio-crypto.h     |   1 +
> > >  include/sysemu/cryptodev-vhost-user.h |  47 +++++
> > >  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
> > >  include/sysemu/cryptodev.h            |   8 +
> > >  qemu-options.hx                       |  21 ++
> > >  vl.c                                  |   4 +
> > >  14 files changed, 1104 insertions(+)
> > >  create mode 100644 backends/cryptodev-vhost-user.c
> > >  create mode 100644 backends/cryptodev-vhost.c
> > >  create mode 100644 include/sysemu/cryptodev-vhost-user.h
> > >  create mode 100644 include/sysemu/cryptodev-vhost.h
> > >
> > > --
> > > 1.8.3.1
> > >
