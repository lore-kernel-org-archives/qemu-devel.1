Received: from eggs.gnu.org ([2001:4830:134:3::10]:40528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dGbh6-0008Ra-73
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 21:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dGbh5-0002ug-Fw
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 21:48:04 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <b3375e1d-a304-237c-124c-21b7f482b6ab@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 09:47:41 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] NVME: is there any plan to support SGL data transfer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi,

When going through NVMe specification and hw/block/nvme.c,
I found that it seems that NVMe qemu implementation only support PRP for 
sq entry.
And NvmeRwCmd doesn't even use union to define DPTR, but just prp1 and prp2.

Although I am just a newbie, but I'm quite interested in NVMe and want 
to try to implement SGL support for qemu NVMe.

Is there anyone already doing such work? Or is there any plan on 
implement such feature?

Thanks,
Qu
