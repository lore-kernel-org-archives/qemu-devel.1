Received: from eggs.gnu.org ([2001:4830:134:3::10]:45807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFiqb-0001a6-R2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFiqW-0005Xt-Mw
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:46:29 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59475
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFiqW-0005UL-Dq
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:46:24 -0500
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8DL4TPp+Re3KZdOtQk-96apxXoxp_CuXd6w9ZqyqTKJBg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <571ce1b3-2a9b-fe59-d0f4-6f570324b64e@ilande.co.uk>
Date: Fri, 17 Nov 2017 15:46:10 +0000
MIME-Version: 1.0
In-Reply-To: <CACXAS8DL4TPp+Re3KZdOtQk-96apxXoxp_CuXd6w9ZqyqTKJBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/15] sun4u: move ISABus inside of
 EBusState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 17/11/17 14:53, Artyom Tarasenko wrote:

> On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> Since the EBus is effectively a PCI-ISA bridge then the underlying ISA bus
>> should be contained within the PCI bridge itself.
> 
> While it's like that on the Sabre chipset, the Spitfire chipset (which
> I hope to add at some point) has the EBus, but no PCI, so maybe it's
> better to model it separately.
> On the other hand, the Spitfire has different EBus devices
> (particularly different type of the serial ports), so I'm not sure.

Oh I didn't realise you had more plans in this area :)  Any idea when
you'll be able to work on the them? TBH as you probably already know,
even the patchset in its current form with the ISA bus encapsulation is
so much better than what is already there, so I'd prefer to merge it and
help you work through any problems later unless you feel particularly
strongly?


ATB,

Mark.
