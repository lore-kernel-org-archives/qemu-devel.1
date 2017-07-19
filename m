Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXotx-000745-Ez
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dXotu-0006Cv-8z
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:29 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dXotu-0006Bv-2Q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:20:26 -0400
Received: by mail-lf0-x242.google.com with SMTP id p11so4292589lfd.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 06:20:24 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Wed, 19 Jul 2017 16:20:12 +0300
Message-Id: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] Allow RedHat PCI bridges reserve more
 buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, marcel@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Now PCI bridges (and PCIE root port too) get a bus range number in system init,
basing on currently plugged devices. That's why when one wants to hotplug another bridge,
it needs his child bus, which the parent is unable to provide.
The suggested workaround is to have vendor-specific capability in RedHat generic pcie-root-port
that contains number of additional bus to reserve on BIOS PCI init.

Aleksandr Bezzubikov (2):
  pci: add support for direct usage of bdf for capability lookup
  pci: enable RedHat pci bridges to reserve more buses

 src/fw/pciinit.c   | 12 ++++++++++--
 src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
 src/hw/pcidevice.h |  1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.7.4
