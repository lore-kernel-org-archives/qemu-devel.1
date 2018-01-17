Received: from eggs.gnu.org ([2001:4830:134:3::10]:54767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ebm48-000392-4H
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ebm44-0007CZ-5f
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:39:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2371 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ebm43-000771-OK
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:39:32 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 17 Jan 2018 11:39:16 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA5195BB@DGGEMA505-MBX.china.huawei.com>
References: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
	<1516111613-18988-2-git-send-email-jianjay.zhou@huawei.com>
	<20180116184039-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473AB4A1C9@DGGEMM505-MBS.china.huawei.com>
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB4A1C9@DGGEMM505-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/4] cryptodev: add vhost-user as a new
 cryptodev backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, longpeng <longpeng2@huawei.com>



> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Wednesday, January 17, 2018 1:01 PM
> To: Michael S. Tsirkin
> Cc: pasic@linux.vnet.ibm.com; Huangweidong (C); xin.zeng@intel.com;
> qemu-devel@nongnu.org; Gonglei (Arei); roy.fan.zhang@intel.com;
> stefanha@redhat.com; pbonzini@redhat.com; longpeng
> Subject: RE: [Qemu-devel] [PATCH v3 1/4] cryptodev: add vhost-user as a n=
ew
> cryptodev backend
>=20
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-
> > bounces+jianjay.zhou=3Dhuawei.com@nongnu.org] On Behalf Of Michael S.
> Tsirkin
> > Sent: Wednesday, January 17, 2018 12:41 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: pasic@linux.vnet.ibm.com; Huangweidong (C)
> <weidong.huang@huawei.com>;
> > xin.zeng@intel.com; qemu-devel@nongnu.org; Gonglei (Arei)
> > <arei.gonglei@huawei.com>; roy.fan.zhang@intel.com;
> stefanha@redhat.com;
> > pbonzini@redhat.com; longpeng <longpeng2@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v3 1/4] cryptodev: add vhost-user as a=
 new
> > cryptodev backend
> >
> > On Tue, Jan 16, 2018 at 10:06:50PM +0800, Jay Zhou wrote:
> > > From: Gonglei <arei.gonglei@huawei.com>
> > >
> > > Usage:
> > >  -chardev socket,id=3Dcharcrypto0,path=3D/path/to/your/socket
> > >  -object cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dcharcrypto0
> > >  -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0
> > >
> > > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > ---
> > >  backends/Makefile.objs           |   4 +
> > >  backends/cryptodev-vhost-user.c  | 333
> > +++++++++++++++++++++++++++++++++++++++
> > >  backends/cryptodev-vhost.c       |  73 +++++++++
> > >  include/sysemu/cryptodev-vhost.h | 154 ++++++++++++++++++
> > >  qemu-options.hx                  |  21 +++
> > >  vl.c                             |   4 +
> > >  6 files changed, 589 insertions(+)
> > >  create mode 100644 backends/cryptodev-vhost-user.c  create mode
> > > 100644 backends/cryptodev-vhost.c  create mode 100644
> > > include/sysemu/cryptodev-vhost.h
> > >
> > > diff --git a/backends/Makefile.objs b/backends/Makefile.objs index
> > > 0400799..9e1fb76 100644
> > > --- a/backends/Makefile.objs
> > > +++ b/backends/Makefile.objs
> > > @@ -8,3 +8,7 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-file.o
> > >
> > >  common-obj-y +=3D cryptodev.o
> > >  common-obj-y +=3D cryptodev-builtin.o
> > > +
> > > +ifeq ($(CONFIG_VIRTIO),y)
> > > +common-obj-$(CONFIG_LINUX) +=3D cryptodev-vhost.o
> > > +cryptodev-vhost-user.o endif
> >
> > Shouldn't this depend on CONFIG_VHOST_USER?
>=20
> Yes, you're right. Will fix it soon.
>=20
Hi Michael,

Can we apply this patch set firstly and then fix it on the top with other c=
omments?

Thanks,
-Gonglei
