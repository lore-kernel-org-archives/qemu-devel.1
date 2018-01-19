Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLjp-0000Ow-DR
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLjo-0002Wr-F7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:45:01 -0500
Date: Fri, 19 Jan 2018 02:44:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-8EyPp4AKnnDW647HX3j+a8SfVcr4Y5tiBnzgR+ErUYA@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1801190243380.64978@zero.eik.bme.hu>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
	<20180111045937.2119-4-david@gibson.dropbear.id.au>
	<CAFEAcA-8EyPp4AKnnDW647HX3j+a8SfVcr4Y5tiBnzgR+ErUYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PULL 03/11] sm501: Add some more unimplemented
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, surajjs@au1.ibm.com

On Thu, 18 Jan 2018, Peter Maydell wrote:
> On 11 January 2018 at 04:59, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> These are not really implemented (just return zero or default values)
>> but add these so guests accessing them can run.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/display/sm501.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index b9b611131e..4f7dc59b25 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -795,6 +795,8 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
>>      case SM501_ARBTRTN_CONTROL:
>>          ret = s->arbitration_control;
>>          break;
>> +    case SM501_COMMAND_LIST_STATUS:
>> +        ret = 0x00180002; /* FIFOs are empty, everything idle */
>>      case SM501_IRQ_MASK:
>>          ret = s->irq_mask;
>>          break;
>
> Is this new case missing a "break;" statement? Coverity points
> out that we fall through and overwrite the previous assignment
> to 'ret' (CID 1385154).

Oops, stupid mistake. Indeed, Coverity is right, fall through is not 
intended here. Sent a patch, thank you for spotting it.

Regards,
BALATON Zoltan
