Received: from eggs.gnu.org ([2001:4830:134:3::10]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eWRlV-0000MU-0R
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eWRlR-0003DL-VW
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:58:21 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:59723
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1eWRlR-0003D4-OA
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:58:17 -0500
References: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <beb9b438-53b3-7c5f-7876-89168bf3caa1@adacore.com>
Date: Tue, 2 Jan 2018 19:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>

Hello Jean-Christophe,

I'm the original author of this patch and I add in copy my colleague
Frederic.

On 02/01/2018 12:13, Jean-Christophe DUBOIS wrote:
> I am wondering if the IRQMP code in hw/intc/grlib_irqmp.c is correct
> when it comes to acknowledging interrupts.
>
> With the actual code an interrupt can be lowered/acked only by an
> "ack" from the processor which means that the trap handler related to
> this external interrupt needs to be run for the ack to happen.
>
> In particular this means that the interrupt cannot be acked only by
> software. Even if the software clears the "pending" interrupts (by
> writing to the CLEAR_OFFSET register before the interrupt handler is
> run) this does not clear the interrupt to the processor (which is kept
> asserted until the handler is run and the interrupt acked by the
> processor). Do you know if this is indeed the intended behavior (I
> understand that for most operating system the interrupt handler will
> be run at last and this does not make a difference)?
>
> I would expect that clearing interrupt through software (by writing to
> the CLEAR_OFFSET register) would have the same effect as the processor
> acknowledgment (and could avoid to run the interrupt handler if things
> have already been taken care of by software).
>
> Unfortunately the documentation I got (on the web) on the IRQMP is not
> very clear on the topic.
>

I don't remember all the details of this CPU on top of my head, I worked
on this years ago.

If you have access to a real board the best would be to compare the
behavior of the CPU on it. There's also a cycle accurate simulator of
Leon3, you can download an evaluation version here:
http://www.gaisler.com/index.php/downloads/simulators


> Anyway you can find below the patch I'd like to provide for IRQMP.
>

Can you explain the reason for this change? Why can't you use the
current interrupt handling?

Regards,
