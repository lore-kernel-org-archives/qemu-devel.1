Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYai6-0001cG-Ui
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYai1-0007Zk-1p
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:23:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-11-f4bug@amsat.org>
	<53a83027-dde9-9728-90ab-b90a92484445@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a77b40e7-8483-c298-6707-59e65adaa904@amsat.org>
Date: Fri, 21 Jul 2017 13:23:15 -0300
MIME-Version: 1.0
In-Reply-To: <53a83027-dde9-9728-90ab-b90a92484445@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/29] net/rocker: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/18/2017 02:51 PM, Eric Blake wrote:
> On 07/18/2017 01:09 AM, Philippe Mathieu-Daudé wrote:
>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/net/rocker/rocker.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
>> index 4f0f6d71e5..55228f2f52 100644
>> --- a/hw/net/rocker/rocker.c
>> +++ b/hw/net/rocker/rocker.c
>> @@ -1419,7 +1419,7 @@ static int pci_rocker_init(PCIDevice *dev)
>>               desc_ring_set_consume(ring, cmd_consume, ROCKER_MSIX_VEC_CMD);
>>           } else if (i == ROCKER_RING_EVENT) {
>>               desc_ring_set_consume(ring, NULL, ROCKER_MSIX_VEC_EVENT);
>> -        } else if (i % 2 == 0) {
>> +        } else if (QEMU_IS_ALIGNED(i, 2)) {
>>               desc_ring_set_consume(ring, tx_consume,
>>                                     ROCKER_MSIX_VEC_TX((i - 2) / 2));
>>           } else if (i % 2 == 1) {
>>
> 
> Given the if chain, I think you don't want this one.

Indeed, dropped. Thanks for your review!
