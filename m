Received: from eggs.gnu.org ([2001:4830:134:3::10]:35099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctypL-0004Tv-GU
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ctypI-0007uM-AK
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ctypI-0007sz-0k
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:51:00 -0400
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<ea171d6c-871b-2cf0-148c-ca7cd85c0ecd@vmware.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <fccdf2e4-54f5-e3db-0abb-4f93850f3083@redhat.com>
Date: Fri, 31 Mar 2017 18:50:53 +0300
MIME-Version: 1.0
In-Reply-To: <ea171d6c-871b-2cf0-148c-ca7cd85c0ecd@vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pvrdma: Proposal of a new pvrdma
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adit Ranadive <aditr@vmware.com>, Doug Ledford <dledford@redhat.com>, Leon Romanovsky <leon@kernel.org>
Cc: qemu-devel@nongnu.org, linux-rdma@vger.kernel.org, yuval.shaia@oracle.com

On 03/31/2017 02:38 AM, Adit Ranadive wrote:
> On Thu Mar 30 2017 13:28:21 GMT-0700 (PDT), Doug Ledford wrote:
>> On 3/30/17 9:13 AM, Leon Romanovsky wrote:
>>> On Thu, Mar 30, 2017 at 02:12:21PM +0300, Marcel Apfelbaum wrote:
>>>> From: Yuval Shaia <yuval.shaia@oracle.com>
>>>>
>>>>  Hi,
>>>>
>>>>  General description
>>>>  ===================
>>>>  This is a very early RFC of a new RoCE emulated device
>>>>  that enables guests to use the RDMA stack without having
>>>>  a real hardware in the host.
>>>>
>>>>  The current implementation supports only VM to VM communication
>>>>  on the same host.
>>>>  Down the road we plan to make possible to be able to support
>>>>  inter-machine communication by utilizing physical RoCE devices
>>>>  or Soft RoCE.
>>>>
>>>>  The goals are:
>>>>  - Reach fast and secure loos-less Inter-VM data exchange.
>>>>  - Support remote VMs or bare metal machines.
>>>>  - Allow VMs migration.
>>>>  - Do not require to pin all VM memory.
>>>>
>>>>
>>>>  Objective
>>>>  =========
>>>>  Have a QEMU implementation of the PVRDMA device. We aim to do so without
>>>>  any change in the PVRDMA guest driver which is already merged into the
>>>>  upstream kernel.
>>>>
>>>>
>>>>  RFC status
>>>>  ===========
>>>>  The project is in early development stages and supports
>>>>  only basic send/receive operations.
>>>>
>>>>  We present it so we can get feedbacks on design,
>>>>  feature demands and to receive comments from the
>>>>  community pointing us to the "right" direction.
>>>
>>> If to judge by the feedback which you got from RDMA community
>>> for kernel proposal [1], this community failed to understand:
>>> 1. Why do you need new module?
>>
>> In this case, this is a qemu module to allow qemu to provide a virt rdma device to guests that is compatible with the device provided by VMWare's ESX product.  Right now, the vmware_pvrdma driver works only when the guest is running on a VMWare ESX server product, this would change that.  Marcel mentioned that they are currently making it compatible because that's the easiest/quickest thing to do, but in the future they might extend beyond what VMWare's virt rdma driver provides/uses and might then need to either modify it to work with their extensions or fork and create their own virt client driver.
>>
>>> 2. Why existing solutions are not enough and can't be extended?
>>
>> This patch is against the qemu source code, not the kernel.  There is no other solution in the qemu source code, so there is no existing solution to extend.
>>
>>> 3. Why RXE (SoftRoCE) can't be extended to perform this inter-VM
>>>    communication via virtual NIC?
>>
>> Eventually they want this to work on real hardware, and to be more or less transparent to the guest.  They will need to make it independent of the kernel hardware/driver in use.  That means their own virt driver, then the virt driver will eventually hook into whatever hardware is present on the system, or failing that, fall back to soft RoCE or soft iWARP if that ever makes it in the kernel.
>>
>

Hi Adit,

> Hmm, this looks quite interesting.

Thanks!!

> Though I'm not surprised, the PVRDMA
> device spec is relatively straightforward.

Indeed, the pvrdma driver is clear and well documented,
which made our development much easier.

> I would have definitely mentioned this (if I knew about it) during my
> OFA workshop talk a couple of days ago :).
>

There is always a next OFA workshop :)

Thanks,
Marcel & Yval

> Doug's right. I mean basically, this looks like a QEMU version of our PVRDMA
> backend.
>
> Thanks,
> Adit
>
