Received: from eggs.gnu.org ([2001:4830:134:3::10]:34472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRWoD-0000wW-Mn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRWo9-0006Fv-OO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:25:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2353 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gRWo8-0006CD-DO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:25:17 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 27 Nov 2018 06:24:58 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D359A6@DGGEMM529-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302D358E6@DGGEMM529-MBX.china.huawei.com>
	<20181127060836.hfvzjga4rdnpb4ws@sirius.home.kraxel.org>
In-Reply-To: <20181127060836.hfvzjga4rdnpb4ws@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [BUG] qemu stuck when detach host-usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "libusb-devel@lists.sourceforge.net" <libusb-devel@lists.sourceforge.net>, "weiqi (C)" <weiqi4@huawei.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Tuesday, November 27, 2018 2:09 PM
> To: linzhecheng <linzhecheng@huawei.com>
> Cc: qemu-devel@nongnu.org; wangxin (U) <wangxinxin.wang@huawei.com>;
> Zhoujian (jay) <jianjay.zhou@huawei.com>; libusb-devel@lists.sourceforge.=
net
> Subject: Re: [Qemu-devel] [BUG] qemu stuck when detach host-usb device
>=20
> On Tue, Nov 27, 2018 at 01:26:24AM +0000, linzhecheng wrote:
> > Description of problem:
> > The guest has a host-usb device(Kingston Technology DataTraveler 100
> > G3/G4/SE9 G2), which is attached to xhci controller(on host). Qemu will=
 stuck
> if I detach it from guest.
> >
> > How reproducible:
> > 100%
> >
> > Steps to Reproduce:
> > 1.            Use usb stick to copy files in guest , make it busy worki=
ng.
> > 2.            virsh detach-device vm_name usb.xml
> >
> > Then qemu will stuck for 20s, I found this is because libusb_release_in=
terface
> block for 20s.
> > Dmesg prints:
> >
> > [35442.034861] usb 4-2.1: Disable of device-initiated U1 failed.
> > [35447.034993] usb 4-2.1: Disable of device-initiated U2 failed.
> > [35452.035131] usb 4-2.1: Set SEL for device-initiated U1 failed.
> > [35457.035259] usb 4-2.1: Set SEL for device-initiated U2 failed.
> >
> > Is this a hardware error or software's bug?
>=20
> I'd guess software error, could be is libusb or (host) linux kernel.
> Cc'ing libusb-devel.
Perhaps it's usb driver's bug. Could you also reproduce it?
>=20
> cheers,
>   Gerd
