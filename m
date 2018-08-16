Received: from eggs.gnu.org ([2001:4830:134:3::10]:50665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fqFtb-0007SF-4V
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fqFtR-0005oM-9F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:52:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2337 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fqFtP-0005ky-9j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:52:40 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 16 Aug 2018 10:52:23 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CCD9FB@DGGEMM529-MBX.china.huawei.com>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
	<20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
In-Reply-To: <20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] usb-host: insert usb device into hostdevs
 to be scaned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>


> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Thursday, August 16, 2018 6:46 PM
> To: linzhecheng <linzhecheng@huawei.com>
> Cc: qemu-devel@nongnu.org; wangxin (U) <wangxinxin.wang@huawei.com>
> Subject: Re: [PATCH] usb-host: insert usb device into hostdevs to be scan=
ed
>=20
> On Thu, Aug 16, 2018 at 05:43:56PM +0800, linzhecheng wrote:
> > According to the comment of usb_host_post_load_bh, after removing the
> > usb device passed through, we will kick host to scan it again, but the
> > emulated usb device is not added to global list hostdevs, so it can nev=
er be
> discovered then.
> > So just do it before usb_host_auto_check. What's more, it's futile to
> > walk devs in usb_host_auto_check periodically if hostdevs is empty, so =
let's
> delete the usb_auto_timer.
>=20
> Hmm, needs_autoscan is a fixed property of the device (depending on
> configuration), it should not be switched on and off.
>=20
> What problem you are trying to solve?
I'm trying to live migrate a vm to local host, but found the host-usb devic=
e was removed then.
Is it possible not to remove it after migrating vm?
>=20
> cheers,
>   Gerd
