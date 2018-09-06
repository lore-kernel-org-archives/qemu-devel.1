Received: from eggs.gnu.org ([2001:4830:134:3::10]:40834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fxrTp-0004GL-1Y
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fxrTl-0006Pp-S1
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:25:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2282 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fxrTl-00061Z-F4
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 06:25:37 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 6 Sep 2018 10:25:20 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Some confusion about live migration of usb device
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

Hi, Gerd

I'm going through relevant codes about live migration of usb devices, it se=
ems that we will not save/load USBpacket in any vmstate, so pending usb pac=
kets will be lost after live migration, is it a problem?
