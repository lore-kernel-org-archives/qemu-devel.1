Received: from eggs.gnu.org ([2001:4830:134:3::10]:47801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZc5M-0001zz-Ls
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZc5L-0008RY-Qa
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 07:35:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 11 Jan 2018 13:35:48 +0100
From: Jean-Christophe Dubois <jcd@tribudubois.net>
In-Reply-To: <a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
Message-ID: <548464fa8211307b397a5f50122abd3d@tribudubois.net>
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien Chouteau <chouteau@adacore.com>
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>

Thanks Fabien,

Now, as a side question, could you tell me which reference LEON3 
platform is implemented by Qemu in leon3_generic?

It doesn't seem to match the one emulated by tsim.

Thanks.

JC

Le 2018-01-11 12:48, Fabien Chouteau a écrit :
> On 10/01/2018 21:43, Jean-Christophe Dubois wrote:
>> With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
>> * Explicitely by software writing to the CLEAR_OFFSET register
>> * Implicitely when the procesor is done running the trap handler 
>> attached
>>   to the IRQ.
>> 
> 
> Thanks Jean-Christophe,
> 
> I tested the patch with our software and it works.
> 
> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
