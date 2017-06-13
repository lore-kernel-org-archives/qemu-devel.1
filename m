Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dKvzK-0000tU-W2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 20:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dKvzK-0002n9-7B
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 20:16:46 -0400
References: <b3375e1d-a304-237c-124c-21b7f482b6ab@cn.fujitsu.com>
	<20170602135151.GB4948@noname.redhat.com>
	<20170612140530.GA23969@localhost.localdomain>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <2686e824-9d6e-3cfc-6184-1647f274e53b@cn.fujitsu.com>
Date: Tue, 13 Jun 2017 09:25:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170612140530.GA23969@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] NVME: is there any plan to support
 SGL data transfer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



At 06/12/2017 10:05 PM, Keith Busch wrote:
> On Fri, Jun 02, 2017 at 03:51:51PM +0200, Kevin Wolf wrote:
>> Am 02.06.2017 um 03:47 hat Qu Wenruo geschrieben:
>>> When going through NVMe specification and hw/block/nvme.c,
>>> I found that it seems that NVMe qemu implementation only support PRP
>>> for sq entry.
>>> And NvmeRwCmd doesn't even use union to define DPTR, but just prp1 and prp2.
>>>
>>> Although I am just a newbie, but I'm quite interested in NVMe and
>>> want to try to implement SGL support for qemu NVMe.
>>>
>>> Is there anyone already doing such work? Or is there any plan on
>>> implement such feature?
>>
>> Keith, you can probably answer this?
> 
> Hi,
> 
> I personally have no plans to implement it, but would be happy to see it
> added if someone wants to send the patch for review.

Glad to hear that.

I have submitted some preparation patch to update nvme.h for SGL and 
added needed error code for it.

It would be very nice if anyone could review it.

Thanks,
Qu

> 
> Thanks,
> Keith
> 
> 
