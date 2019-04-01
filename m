Received: from eggs.gnu.org ([209.51.188.92]:40257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqbQ-0004Hc-GV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1hAqbP-0004tw-G3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:39:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1hAqbP-0004tb-4h
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:39:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id t17so10290572wrw.13
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 23:39:27 -0700 (PDT)
References: <20190326125433.475-1-kamalheib1@gmail.com>
	<20190327161857.GE10207@lap1>
From: Kamal Heib <kamalheib1@gmail.com>
Message-ID: <4a0ef3c8-3fb5-aac5-c9ce-4f49ba0b1d33@gmail.com>
Date: Mon, 1 Apr 2019 09:39:22 +0300
MIME-Version: 1.0
In-Reply-To: <20190327161857.GE10207@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pvrdma: Add support for SRQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org



On 3/27/19 6:18 PM, Yuval Shaia wrote:
> On Tue, Mar 26, 2019 at 02:54:29PM +0200, Kamal Heib wrote:
>> This series implements the SRQ (Shared Receive Queue) for the pvrdma
>> device, It also includes all the needed functions and definitions for
>> support SRQ in the backend and resource management layers.
>>
>> Changes from v1->v2:
>> - Handle checkpatch.pl warnings. 
> 
> Hi Kamal,

Hi Yuval,

> I'm done with the review, please check my comments.
> 

Thank you for reviewing the patch set, I'll address the comments in v3.

> Thanks for doing it, this is an advance feature that i wanted to do for
> long time.
> 
I'm very happy to contribute to this project :-)

Thanks,
Kamal

>>
>> Kamal Heib (4):
>>   hw/rdma: Add SRQ support to backend layer
>>   hw/rdma: Add support for managing SRQ resource
>>   hw/rdma: Modify create/destroy QP to support SRQ
>>   hw/pvrdma: Add support for SRQ
>>
>>  hw/rdma/rdma_backend.c      | 125 +++++++++++++++++++++-
>>  hw/rdma/rdma_backend.h      |  18 +++-
>>  hw/rdma/rdma_backend_defs.h |   5 +
>>  hw/rdma/rdma_rm.c           | 106 +++++++++++++++++-
>>  hw/rdma/rdma_rm.h           |  13 ++-
>>  hw/rdma/rdma_rm_defs.h      |   9 ++
>>  hw/rdma/vmw/pvrdma_cmd.c    | 208 ++++++++++++++++++++++++++++++++----
>>  hw/rdma/vmw/pvrdma_main.c   |  16 +++
>>  hw/rdma/vmw/pvrdma_qp_ops.c |  46 +++++++-
>>  hw/rdma/vmw/pvrdma_qp_ops.h |   1 +
>>  10 files changed, 513 insertions(+), 34 deletions(-)
>>
>> -- 
>> 2.20.1
>>
>>
