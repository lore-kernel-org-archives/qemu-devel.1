Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebX1l-0003NS-My
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebX1h-00029a-Kj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:36:09 -0500
Received: from chuckie.co.uk ([82.165.15.123]:51025
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ebX1h-00025Q-DW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 14:36:05 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<c8bc330c-d03e-4b2e-87dd-5c5b4d66499f@ilande.co.uk>
	<c710275e-a7c6-8356-0de1-9869d1b1a245@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <70f971e3-0120-c58d-9ddc-f718d117574a@ilande.co.uk>
Date: Tue, 16 Jan 2018 19:35:47 +0000
MIME-Version: 1.0
In-Reply-To: <c710275e-a7c6-8356-0de1-9869d1b1a245@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien Chouteau <chouteau@adacore.com>, Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-devel@nongnu.org

On 16/01/18 10:21, Fabien Chouteau wrote:

> On 15/01/2018 19:16, Mark Cave-Ayland wrote:
>> On 11/01/18 11:48, Fabien Chouteau wrote:
>>
>>> On 10/01/2018 21:43, Jean-Christophe Dubois wrote:
>>>> With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
>>>> * Explicitely by software writing to the CLEAR_OFFSET register
>>>> * Implicitely when the procesor is done running the trap handler attached
>>>>     to the IRQ.
>>>>
>>>
>>> Thanks Jean-Christophe,
>>>
>>> I tested the patch with our software and it works.
>>>
>>> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
>>
>> Thanks Fabien. Does that mean you would like me to take this patch for my qemu-sparc branch?
>>
> 
> Yes please :)
> 
> Should I use Acked-by?

I already have your Reviewed-by from a previous email so that's fine 
with me.


ATB,

Mark.
