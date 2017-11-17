Received: from eggs.gnu.org ([2001:4830:134:3::10]:52306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFmmd-0007ZW-0h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFmmc-00047Z-3o
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:58:39 -0500
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFmmb-00046l-Tn
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:58:38 -0500
Received: by mail-it0-x22f.google.com with SMTP id u132so5411073ita.0
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 11:58:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <571ce1b3-2a9b-fe59-d0f4-6f570324b64e@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8DL4TPp+Re3KZdOtQk-96apxXoxp_CuXd6w9ZqyqTKJBg@mail.gmail.com>
	<571ce1b3-2a9b-fe59-d0f4-6f570324b64e@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 20:58:16 +0100
Message-ID: <CACXAS8CbC0KznrFrbSSxKHNBagWHoK0+YcpCT_TqRR4E0hSqoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 4:46 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 17/11/17 14:53, Artyom Tarasenko wrote:
>
>> On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>> Since the EBus is effectively a PCI-ISA bridge then the underlying ISA bus
>>> should be contained within the PCI bridge itself.
>>
>> While it's like that on the Sabre chipset, the Spitfire chipset (which
>> I hope to add at some point) has the EBus, but no PCI, so maybe it's
>> better to model it separately.
>> On the other hand, the Spitfire has different EBus devices
>> (particularly different type of the serial ports), so I'm not sure.
>
> Oh I didn't realise you had more plans in this area :)  Any idea when
> you'll be able to work on the them?

After I make AIX boot. :-)

> TBH as you probably already know,
> even the patchset in its current form with the ISA bus encapsulation is
> so much better than what is already there, so I'd prefer to merge it and
> help you work through any problems later unless you feel particularly
> strongly?

Ok, let's do it.

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
