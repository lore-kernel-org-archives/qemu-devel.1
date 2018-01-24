Received: from eggs.gnu.org ([2001:4830:134:3::10]:59548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eeR4y-0005Sd-Ny
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eeR4v-0004I0-K7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:51:28 -0500
Received: from chuckie.co.uk ([82.165.15.123]:54731
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eeR4v-000470-DD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:51:25 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a2112b45-6e33-9d91-aa4a-ce424f8ffeb1@ilande.co.uk>
Date: Wed, 24 Jan 2018 19:51:09 +0000
MIME-Version: 1.0
In-Reply-To: <a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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

On 11/01/18 11:48, Fabien Chouteau wrote:

> On 10/01/2018 21:43, Jean-Christophe Dubois wrote:
>> With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
>> * Explicitely by software writing to the CLEAR_OFFSET register
>> * Implicitely when the procesor is done running the trap handler attached
>>    to the IRQ.
>>
> 
> Thanks Jean-Christophe,
> 
> I tested the patch with our software and it works.
> 
> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>

Thanks. I've applied this (with some minor touch-ups to the commit 
message) to my qemu-sparc branch.


ATB,

Mark.
