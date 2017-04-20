Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1d1JF0-0003QG-Uc
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1d1JEy-0001zy-BU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:03:50 -0400
Received: from mail5.windriver.com ([192.103.53.11]:47944 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1d1JEy-0001xA-3K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:03:48 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v3KL3eui014969
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 14:03:42 -0700
Message-ID: <58F92229.1080402@windriver.com>
Date: Thu, 20 Apr 2017 15:03:37 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] question about block size and virtual disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Suppose the host has a physical disk that only supports 4KB access, with no 512B 
fallback.

If we boot a guest with "cache=none", does the guest need to be able to handle 
disks with 4KB blocks or is qemu able to handle guests trying to access the disk 
with 512B granularity?

Also, does the 4KB block size get "passed-through" to the guest somehow so that 
the guest knows it needs to use 4KB blocks, or does that need to be explicitly 
specified via virtio-blk-pci.logical_block_size and/or 
virtio-blk-pci.physical_block_size parameters?  (Assuming I'm using virtio-blk-pci.)

Thanks,
Chris
