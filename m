Received: from eggs.gnu.org ([2001:4830:134:3::10]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1fi5Cj-0007wI-Og
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhcwhu@gmail.com>) id 1fi5Ci-00013R-U7
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:50:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:38552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhcwhu@gmail.com>) id 1fi5Ci-00011d-JM
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:50:48 -0400
Received: by mail-lj1-x232.google.com with SMTP id p6-v6so4903485ljc.5
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 14:50:47 -0700 (PDT)
MIME-Version: 1.0
From: Huaicheng Li <lhcwhu@gmail.com>
Date: Tue, 24 Jul 2018 14:50:10 -0700
Message-ID: <CANr0WEc0yTcMA9dRWUPTSpEuWVN_QoFT6VUH4kwB6LRJnLp1SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] When is PCIUnregisterFunc called?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi QEMU developers,

I'm trying to inject some operations during the emulated device teardown
phase.

For an emulated PCIe device, such as NVMe or IVSHMEM, I notice that QEMU
registers PCIDeviceClass pc->init and pc->exit functions for that device.
->init() (e.g. nvme_init(), or ivshmem_init()) are marked as constructors
and called before QEMU main() runs. However, I failed to find when the
->exit() function is called. When I add some printf() into the ->exit()
func, it's not even printed. Could anyone give any pointers on this?

Thanks.

Best,
Huaicheng
