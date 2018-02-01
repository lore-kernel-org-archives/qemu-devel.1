Received: from eggs.gnu.org ([2001:4830:134:3::10]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehD3g-0007Jk-71
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehD3c-0004E1-AE
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:29:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2373 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ehD3b-0004Bh-TK
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:29:32 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Thu, 1 Feb 2018 11:29:15 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB6F5B2@DGGEMM505-MBS.china.huawei.com>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
In-Reply-To: <cover.1516538887.git.arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

Hi Michael,
I am wondering whether this version is OK for you?
Any comment will be appreciated, thanks.

Regards,
Jay

> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Sunday, January 21, 2018 8:55 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; stefanha@redhat.com; Zhoujian (jay)
> <jianjay.zhou@huawei.com>; pasic@linux.vnet.ibm.com; longpeng
> <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.com; Gong=
lei
> (Arei) <arei.gonglei@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com=
>
> Subject: [PATCH v6 0/4] cryptodev: add vhost support
>=20
> From: Gonglei <arei.gonglei@huawei.com>
>=20
> I posted the RFC verion a few months ago for DPDK vhost-crypto implmentio=
n,
> and now it's time to send the formal version. Because we need an user spa=
ce
> scheme for better performance.
>=20
> The vhost user crypto server side patches had been sent to DPDK community=
,
> pls see
>=20
> [RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
> support http://dpdk.org/ml/archives/dev/2017-November/081048.html
>=20
> You also can get virtio-crypto polling mode driver from:
>=20
> [PATCH] virtio: add new driver for crypto devices
> http://dpdk.org/ml/archives/dev/2017-November/081985.html
>=20
> v5 -> v6:
>   Fix compile error about backends/cryptodev-vhost-user.o and rebase on
>   the master
> v4 -> v5:
>   squash [PATCH v4 5/5] into previous patches [Michael]
> v3 -> v4:
>   "[PATCH v4 5/5] cryptodev-vhost-user: depend on CONFIG_VHOST_CRYPTO
>   and CONFIG_VHOST_USER" newly added to fix compilation dependency [Micha=
el]
> v2 -> v3:
>   New added vhost user messages should be sent only when feature
>   has been successfully negotiated [Michael]
> v1 -> v2:
>   Fix compile error on mingw32
>=20
> Gonglei (4):
>   cryptodev: add vhost-user as a new cryptodev backend
>   cryptodev: add vhost support
>   cryptodev-vhost-user: add crypto session handler
>   cryptodev-vhost-user: set the key length
>=20
>  backends/Makefile.objs                |   6 +
>  backends/cryptodev-builtin.c          |   1 +
>  backends/cryptodev-vhost-user.c       | 379
> ++++++++++++++++++++++++++++++++++
>  backends/cryptodev-vhost.c            | 347 ++++++++++++++++++++++++++++=
+++
>  configure                             |  15 ++
>  docs/interop/vhost-user.txt           |  26 +++
>  hw/virtio/Makefile.objs               |   2 +-
>  hw/virtio/vhost-user.c                | 104 ++++++++++
>  hw/virtio/virtio-crypto.c             |  70 +++++++
>  include/hw/virtio/vhost-backend.h     |   8 +
>  include/hw/virtio/virtio-crypto.h     |   1 +
>  include/sysemu/cryptodev-vhost-user.h |  47 +++++
>  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
>  include/sysemu/cryptodev.h            |   8 +
>  qemu-options.hx                       |  21 ++
>  vl.c                                  |   6 +
>  16 files changed, 1194 insertions(+), 1 deletion(-)  create mode 100644
> backends/cryptodev-vhost-user.c  create mode 100644 backends/cryptodev-
> vhost.c  create mode 100644 include/sysemu/cryptodev-vhost-user.h
>  create mode 100644 include/sysemu/cryptodev-vhost.h
>=20
> --
> 1.8.3.1
>=20
