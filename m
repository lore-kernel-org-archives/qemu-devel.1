Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eSHvS-0007Sw-6E
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eSHvO-00020v-8c
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:39:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2362 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eSHvN-0001pa-RL
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:39:22 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 22 Dec 2017 07:39:04 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4F41A9@DGGEMA505-MBX.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<20171221162459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171221162459-mutt-send-email-mst@kernel.org>
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
> Sent: Thursday, December 21, 2017 10:25 PM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C);
> stefanha@redhat.com; Zhoujian (jay); pasic@linux.vnet.ibm.com; longpeng;
> xin.zeng@intel.com; roy.fan.zhang@intel.com
> Subject: Re: [PATCH 0/4] cryptodev: add vhost support
>=20
> On Tue, Nov 28, 2017 at 05:03:05PM +0800, Gonglei wrote:
> > I posted the RFC verion five months ago for DPDK
> > vhost-crypto implmention, and now it's time to send
> > the formal version. Because we need an user space scheme
> > for better performance.
> >
> > The vhost user crypto server side patches had been
> > sent to DPDK community, pls see
> >
> > [RFC PATCH 0/6] lib/librte_vhost: introduce new	vhost_user crypto
> backend support
> > http://dpdk.org/ml/archives/dev/2017-November/081048.html
> >
> > You also can get virtio-crypto polling mode driver from:
> >
> > [PATCH] virtio: add new driver for crypto devices
> > http://dpdk.org/ml/archives/dev/2017-November/081985.html
> >
>=20
> This makes build on mingw break:
>=20
>   CC      sparc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
> hw/virtio/virtio-crypto.o: In function `virtio_crypto_vhost_status':
> /scm/qemu/hw/virtio/virtio-crypto.c:898: undefined reference to
> `cryptodev_get_vhost'
> /scm/qemu/hw/virtio/virtio-crypto.c:910: undefined reference to
> `cryptodev_vhost_start'
> /scm/qemu/hw/virtio/virtio-crypto.c:917: undefined reference to
> `cryptodev_vhost_stop'
> hw/virtio/virtio-crypto.o: In function `virtio_crypto_guest_notifier_pend=
ing':
> /scm/qemu/hw/virtio/virtio-crypto.c:947: undefined reference to
> `cryptodev_vhost_virtqueue_pending'
> hw/virtio/virtio-crypto.o: In function `virtio_crypto_guest_notifier_mask=
':
> /scm/qemu/hw/virtio/virtio-crypto.c:937: undefined reference to
> `cryptodev_vhost_virtqueue_mask'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:193: qemu-system-i386.exe] Error 1
> make: *** [Makefile:383: subdir-i386-softmmu] Error 2
>=20
>=20
Sorry about that. We'll build it on a cross-compiler environment.

Thanks,
-Gonglei
