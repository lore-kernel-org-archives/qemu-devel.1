Received: from eggs.gnu.org ([2001:4830:134:3::10]:40124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fxtCX-0007CF-9P
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fxt15-0005Bu-Dk
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:04:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fxt15-0005Ba-8y
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 08:04:07 -0400
Date: Thu, 6 Sep 2018 14:04:04 +0200
From: gerd hoffmann <kraxel@redhat.com>
Message-ID: <20180906120404.zuvf3kkgmzwkb6a3@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] Some confusion about live migration of usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: CheneyLin <linzc@zju.edu.cn>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Sep 06, 2018 at 10:25:20AM +0000, linzhecheng wrote:
> Hi, Gerd
> 
> I'm going through relevant codes about live migration of usb devices,
> it seems that we will not save/load USBpacket in any vmstate, so
> pending usb packets will be lost after live migration, is it a
> problem?

With usb-host or usb-redir?

cheers,
  Gerd
