Received: from eggs.gnu.org ([2001:4830:134:3::10]:33680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gP1es-0006kr-Hk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gP1ep-0007v9-D5
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:45:22 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:43522 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gP1ep-0007tc-1y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 03:45:19 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 20 Nov 2018 08:28:00 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D24F62@dggemm509-mbx.china.huawei.com>
References: <20181120011815.10580-1-linzhecheng@huawei.com>
	<20181120082513.t3cvd3vuh7lbp3ha@sirius.home.kraxel.org>
In-Reply-To: <20181120082513.t3cvd3vuh7lbp3ha@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] usb-host: set ifs.detached as true if
 kernel driver is not active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Tuesday, November 20, 2018 4:25 PM
> To: linzhecheng <linzhecheng@huawei.com>
> Cc: qemu-devel@nongnu.org; Zhoujian (jay) <jianjay.zhou@huawei.com>;
> wangxin (U) <wangxinxin.wang@huawei.com>
> Subject: Re: [PATCH] usb-host: set ifs.detached as true if kernel driver =
is not
> active
>=20
> On Tue, Nov 20, 2018 at 09:18:15AM +0800, linzhecheng wrote:
> > If no kernel driver is active, we can already claim and perform I/O on
> > it without detaching it.
> >
> > Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> >
> > diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c index
> > f31e9cbbb8..db4ae1e6e8 100644
> > --- a/hw/usb/host-libusb.c
> > +++ b/hw/usb/host-libusb.c
> > @@ -1119,6 +1119,10 @@ static void
> usb_host_detach_kernel(USBHostDevice *s)
> >      for (i =3D 0; i < USB_MAX_INTERFACES; i++) {
> >          rc =3D libusb_kernel_driver_active(s->dh, i);
> >          usb_host_libusb_error("libusb_kernel_driver_active", rc);
> > +        if (rc =3D=3D 0) {
> > +            s->ifs[i].detached =3D true;
> > +            continue;
> > +        }
> >          if (rc !=3D 1) {
>=20
> Can't we just add detached =3D true here?
Yes, it's better.
>=20
> >              continue;
> >          }
>=20
> cheers,
>   Gerd
