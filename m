Received: from eggs.gnu.org ([2001:4830:134:3::10]:39044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eQrKj-0001ua-Dk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eQrKd-0007l0-Cx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:03:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:4439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eQrKc-0007iJ-Kr
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:03:31 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 18 Dec 2017 09:03:16 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4ED5D3@DGGEMA505-MBX.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

Ping...

Fan (working for DPDK parts) is waiting for those patches upstreamed. :)

Thanks,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Tuesday, November 28, 2017 5:03 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C);
> stefanha@redhat.com; Zhoujian (jay); pasic@linux.vnet.ibm.com; longpeng;
> xin.zeng@intel.com; roy.fan.zhang@intel.com; Gonglei (Arei)
> Subject: [PATCH 0/4] cryptodev: add vhost support
>=20
> I posted the RFC verion five months ago for DPDK
> vhost-crypto implmention, and now it's time to send
> the formal version. Because we need an user space scheme
> for better performance.
>=20
> The vhost user crypto server side patches had been
> sent to DPDK community, pls see
>=20
> [RFC PATCH 0/6] lib/librte_vhost: introduce new	vhost_user crypto backend
> support
> http://dpdk.org/ml/archives/dev/2017-November/081048.html
>=20
> You also can get virtio-crypto polling mode driver from:
>=20
> [PATCH] virtio: add new driver for crypto devices
> http://dpdk.org/ml/archives/dev/2017-November/081985.html
>=20
>=20
> Gonglei (4):
>   cryptodev: add vhost-user as a new cryptodev backend
>   cryptodev: add vhost support
>   cryptodev-vhost-user: add crypto session handler
>   cryptodev-vhost-user: set the key length
>=20
>  backends/Makefile.objs                |   4 +
>  backends/cryptodev-builtin.c          |   1 +
>  backends/cryptodev-vhost-user.c       | 381
> ++++++++++++++++++++++++++++++++++
>  backends/cryptodev-vhost.c            | 297
> ++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt           |  19 ++
>  hw/virtio/vhost-user.c                |  89 ++++++++
>  hw/virtio/virtio-crypto.c             |  70 +++++++
>  include/hw/virtio/vhost-backend.h     |   8 +
>  include/hw/virtio/virtio-crypto.h     |   1 +
>  include/sysemu/cryptodev-vhost-user.h |  47 +++++
>  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
>  include/sysemu/cryptodev.h            |   8 +
>  qemu-options.hx                       |  21 ++
>  vl.c                                  |   4 +
>  14 files changed, 1104 insertions(+)
>  create mode 100644 backends/cryptodev-vhost-user.c
>  create mode 100644 backends/cryptodev-vhost.c
>  create mode 100644 include/sysemu/cryptodev-vhost-user.h
>  create mode 100644 include/sysemu/cryptodev-vhost.h
>=20
> --
> 1.8.3.1
>=20
