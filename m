Received: from eggs.gnu.org ([2001:4830:134:3::10]:38360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gRovp-0002M8-5z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gRovo-0006On-Dr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:46:25 -0500
References: <mhng-22cf4e89-cf9f-4a1d-b254-72b66e51dd82@palmer-si-x1c4>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <57736c8b-767b-aa02-762c-c2d6aed060df@cmss.chinamobile.com>
Date: Wed, 28 Nov 2018 09:46:04 +0800
MIME-Version: 1.0
In-Reply-To: <mhng-22cf4e89-cf9f-4a1d-b254-72b66e51dd82@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] riscv/cpu: use
 device_class_set_parent_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, philmd@redhat.com

Hi, Palmer

On 11/28/18 8:34 AM, Palmer Dabbelt wrote:
> On Mon, 26 Nov 2018 01:06:33 PST (-0800), Bastian Koppelmann wrote:
>> On 11/26/18 4:20 AM, Mao Zhongyi wrote:
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>> ---
>>>   target/riscv/cpu.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>
>> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> 
> Shouldn't we also use device_class_set_parent_reset right below this?  

device_class_set_parent_reset only used for DeviceClass *dc->reset, here
is CPUClass *cc->reset.

Thanks,
Mao

> Either
> way, I'll queue this one for 3.2.
> 
> Thanks!
> 
