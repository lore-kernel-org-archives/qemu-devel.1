Received: from eggs.gnu.org ([2001:4830:134:3::10]:40065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fxtCO-00079s-DH
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fxt7A-0007om-7k
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:10:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35548 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fxt79-0007k2-NL
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:10:24 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 6 Sep 2018 12:10:08 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CED55C@DGGEMM529-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
	<20180906120404.zuvf3kkgmzwkb6a3@sirius.home.kraxel.org>
In-Reply-To: <20180906120404.zuvf3kkgmzwkb6a3@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Some confusion about live migration of usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gerd hoffmann <kraxel@redhat.com>
Cc: CheneyLin <linzc@zju.edu.cn>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

You had said that copying vmstate of usb-host is pointless, so just unpulg =
and plug it after migration is all right,
 but will other usb devices like usb-storage devices lose pending USBPacket=
s then? =20

> -----Original Message-----
> From: gerd hoffmann [mailto:kraxel@redhat.com]
> Sent: Thursday, September 06, 2018 8:04 PM
> To: linzhecheng <linzhecheng@huawei.com>
> Cc: CheneyLin <linzc@zju.edu.cn>; wangxin (U)
> <wangxinxin.wang@huawei.com>; qemu-devel@nongnu.org
> Subject: Re: Some confusion about live migration of usb device
>=20
> On Thu, Sep 06, 2018 at 10:25:20AM +0000, linzhecheng wrote:
> > Hi, Gerd
> >
> > I'm going through relevant codes about live migration of usb devices,
> > it seems that we will not save/load USBpacket in any vmstate, so
> > pending usb packets will be lost after live migration, is it a
> > problem?
>=20
> With usb-host or usb-redir?
>=20
> cheers,
>   Gerd
