Received: from eggs.gnu.org ([209.51.188.92]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuN4-0000Uh-3L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuN3-0002yG-5H
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghuN2-0002xu-TC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:49:01 -0500
References: <20190110083753.GA31730@yangzhon-Virtual>
	<20190110103636.GG19025@stefanha-x1.localdomain>
	<20190111054604.GA1038@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7e15215-e2df-309b-b1f6-6741bfff7247@redhat.com>
Date: Fri, 11 Jan 2019 11:48:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190111054604.GA1038@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] If Qemu support NVMe over Fabrics ?y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, keith.busch@intel.com

On 11/01/19 06:46, Yang Zhong wrote:
> On Thu, Jan 10, 2019 at 10:36:37AM +0000, Stefan Hajnoczi wrote:
>> On Thu, Jan 10, 2019 at 04:37:53PM +0800, Yang Zhong wrote:
>>> Do you know if Qemu support NVMe over Fabrics(NVMe-oF)?
>>> https://nvmexpress.org/wp-content/uploads/NVMe_Over_Fabrics.pdf
>>>
>>> The Qemu has enabled RDMA in last year, and i am not sure if Qemu 
>>> should support NVME-oF. If Qemu support it, would you please share
>>> me the qemu related command or guides? thanks a lot!
>>
>> QEMU supports many different storage configurations.  Can you be more
>> specific?
>>
>> For example, if your host has NVMe-oF set up then you can give the NVMe
>> block devices to QEMU just like any other host block device (-drive
>> file=/dev/sdc,...).
>>
>> But maybe you are thinking about other configurations, like exposing
>> NVMe-oF to the guest?
>>
>   Thanks Stefan's comments. We only want Qemu as NVMe-oF initiator to
>   access remote target's resource.
> 
>   I checked the block/nvme.c and hw/block/nvme.c code, which seems do
>   not support NVMe-oF . If i am wrong please correct me.
> 
>   If Qemu support NVMe-oF initiator, please share me how to use it. 
>   If Qemu does not support it, please tell me if community has plan 
>   to implement it. thanks a lot!

QEMU's native NVMe driver only supports NVMe over PCI, but it should be
possible to extract common code if you want to add a native NVMe over
RDMA driver to QEMU.  There are currently no plans to add such a driver,
but it would certainly be a welcome addition.

Paolo
