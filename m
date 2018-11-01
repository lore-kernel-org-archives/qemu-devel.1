Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gI2Ev-0004sI-5Q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gI2Er-0007sJ-7Y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:57:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2342 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gI2Ep-0007ne-MM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 21:57:36 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 1 Nov 2018 01:57:15 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D12298@DGGEMM529-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  one issue about usb passsthrough devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: gerd hoffmann <kraxel@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

Hi, all
A found a problem about libusb, the reproducing steps are as followed:
1. start up a vm with host-usb devices
2. kill -9 `pgrep qemu`
We can not see the usb device on host any more, I think this is because qem=
u has no chance to release
resources to kernel in this case. How can we recover environment if we enco=
unter this problem?
