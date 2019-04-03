Received: from eggs.gnu.org ([209.51.188.92]:57581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hBaNk-0006pz-RY
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1hBaNj-0002b3-Sv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:32:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41438 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1hBaNj-0002Yl-FK
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:32:23 -0400
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
Date: Wed, 3 Apr 2019 15:32:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Question: can we hot plug a PCIe switch on machine
 "virt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: wanghaibin 00208455 <wanghaibin.wang@huawei.com>

Hi folks,

In physical world, a PCIe switch including one upstream port and several downstream ports is a single physical device, however we treat each port as a device in qemu world. In qemu docs/pcie.txt, we have below statements:

Line 230: Be aware that PCI Express Downstream Ports can't be hot-plugged into
Line 231: an existing PCI Express Upstream Port.

To my understanding, it implies PCIe downstream ports *can* be hot-plugged into something which is not an existing upstream port. If it is true, how can we do that? AFAIK monitor command device_add can only add one device at a time.

Please help to show the truth.

Thanks,

Heyi
