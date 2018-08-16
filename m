Received: from eggs.gnu.org ([2001:4830:134:3::10]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqKfu-0006k1-8K
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqKfn-0001L0-Sb
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:59:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqKfn-0001JA-3O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:58:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id c13-v6so4615903wrt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:58:53 -0700 (PDT)
References: <20180816151637.24553-1-marcel.apfelbaum@gmail.com>
	<e69c3f04-acce-b6e8-7254-22edd5d04e4e@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9a69b82b-77a3-db58-5fe6-c0f1fccc1aa6@gmail.com>
Date: Thu, 16 Aug 2018 18:58:50 +0300
MIME-Version: 1.0
In-Reply-To: <e69c3f04-acce-b6e8-7254-22edd5d04e4e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V2] config: split PVRDMA from RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, rebecca@bluestop.org, peter.maydell@linaro.org

Hi Thomas,

On 08/16/2018 06:48 PM, Thomas Huth wrote:
> On 08/16/2018 05:16 PM, Marcel Apfelbaum wrote:
>> In some BSD systems RDMA migration is possible while
>> the pvrdma device can't be used because the mremap system call
>> is missing.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> ---
>>   configure             | 55 ++++++++++++++++++++++++++++++++++++++++++-
>>   hw/rdma/Makefile.objs |  2 +-
>>   2 files changed, 55 insertions(+), 2 deletions(-)
> [...]
>> diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
>> index 3504c39d21..bd36cbf51c 100644
>> --- a/hw/rdma/Makefile.objs
>> +++ b/hw/rdma/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -ifeq ($(CONFIG_RDMA),y)
>> +ifeq ($(CONFIG_PVRDMA),y)
>>   obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
>>   obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
>>                        vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
>>

> Again:

Sorry for not seeing the comment earlier.

>   Shouldn't the CONFIG_PVRDMA only guard the second line? I thought
> the first list should be fine with CONFIG_RDMA?

Indeed, theoretically the first line can be compiled  with CONFIG_RDMA,
however the only code that utilize the first line .o files is the pvrdma 
code.
So we will simply have a bigger binary without any reason.

Thanks,
Marcel

>   Thomas
