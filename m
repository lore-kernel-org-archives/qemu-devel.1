Received: from eggs.gnu.org ([2001:4830:134:3::10]:42343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJYH4-0005pB-IU
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJY6U-00081O-CA
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJY6R-0007qd-My
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 01:11:12 -0500
Date: Mon, 5 Nov 2018 07:11:05 +0100
From: gerd hoffmann <kraxel@redhat.com>
Message-ID: <20181105061105.tova7oyejmavxiyc@sirius.home.kraxel.org>
References: <D9DE8DBB19F2A24080482022C1DE758302D12298@DGGEMM529-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302D12298@DGGEMM529-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] one issue about usb passsthrough devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

On Thu, Nov 01, 2018 at 01:57:15AM +0000, linzhecheng wrote:
> Hi, all
> A found a problem about libusb, the reproducing steps are as followed:
> 1. start up a vm with host-usb devices
> 2. kill -9 `pgrep qemu`
> We can not see the usb device on host any more, I think this is because qemu has no chance to release
> resources to kernel in this case.

Yes.

> How can we recover environment if we encounter this problem?

Unplug device, plug it again?
Use -TERM instead of -KILL, so it doesn't happen in the first place?

cheers,
  Gerd
