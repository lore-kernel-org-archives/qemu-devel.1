Received: from eggs.gnu.org ([2001:4830:134:3::10]:51653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eYdXm-0006Nt-3v
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eYdXf-000812-0N
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:57:14 -0500
Received: from chuckie.co.uk ([82.165.15.123]:56255
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eYdXe-0007zs-Om
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 14:57:06 -0500
References: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4f2f1b89-af18-2d36-8eb5-acf29e180b06@ilande.co.uk>
Date: Mon, 8 Jan 2018 19:56:58 +0000
MIME-Version: 1.0
In-Reply-To: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SPARC] question on LEON IRQMP interrupt
 controller.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 02/01/18 11:13, Jean-Christophe DUBOIS wrote:

> Hi Mark, Artyom,
> 
> I am wondering if the IRQMP code in hw/intc/grlib_irqmp.c is correct 
> when it comes to acknowledging interrupts.
> 
> With the actual code an interrupt can be lowered/acked only by an "ack" 
> from the processor which means that the trap handler related to this 
> external interrupt needs to be run for the ack to happen.
> 
> In particular this means that the interrupt cannot be acked only by 
> software. Even if the software clears the "pending" interrupts (by 
> writing to the CLEAR_OFFSET register before the interrupt handler is 
> run) this does not clear the interrupt to the processor (which is kept 
> asserted until the handler is run and the interrupt acked by the 
> processor). Do you know if this is indeed the intended behavior (I 
> understand that for most operating system the interrupt handler will be 
> run at last and this does not make a difference)?
> 
> I would expect that clearing interrupt through software (by writing to 
> the CLEAR_OFFSET register) would have the same effect as the processor 
> acknowledgment (and could avoid to run the interrupt handler if things 
> have already been taken care of by software).
> 
> Unfortunately the documentation I got (on the web) on the IRQMP is not 
> very clear on the topic.
> 
> Anyway you can find below the patch I'd like to provide for IRQMP.
> 
> Thanks

Thanks for the patch! I'm afraid I don't really have any experience with 
LEON as my focus is sun4m/sun4u, however I'm happy to take patches 
Acked/Reviewed by Fabien as the current LEON maintainer if they don't 
cause any regressions in my own tests.


ATB,

Mark.
