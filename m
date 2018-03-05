Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvOz-0006sJ-7M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvOy-0000vV-8M
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:04:01 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvOy-0000v8-1y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:04:00 -0500
Received: by mail-wm0-x22a.google.com with SMTP id x7so17642314wmc.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 11:03:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171026064635.7179-1-aik@ozlabs.ru>
	<13277057-669f-cd77-95f1-f0e54f7ae222@redhat.com>
	<7e694888-43ce-6653-92a0-c0b4c235d4ca@ozlabs.ru>
	<e6a81bdc-a961-d55f-85c4-55149c878988@redhat.com>
	<df85e8f4-23ae-6404-26b8-b45cc7896bbc@reactos.org>
	<d65b171f-0f98-a28f-e0d0-c122ff4bba34@amsat.org>
Message-ID: <4dfab917-1e05-546e-8f85-acc961521e72@amsat.org>
Date: Mon, 5 Mar 2018 16:03:57 -0300
MIME-Version: 1.0
In-Reply-To: <d65b171f-0f98-a28f-e0d0-c122ff4bba34@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, John Snow <jsnow@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/05/2018 07:29 AM, Philippe Mathieu-Daudé wrote:
> On 10/26/2017 03:46 AM, Alexey Kardashevskiy wrote:
>> A "powernv" machine type defines an ISA bus but it does not add any
>> DMA
>> controller to it so it is possible to hit assert(fdctrl->dma) by
>> adding "-machine powernv -device isa-fdc".
> 
> The same happens with the Alpha machine.
> 
> On 12/13/2017 03:19 AM, Hervé Poussineau wrote:
>> Le 08/12/2017 à 22:29, John Snow a écrit :
>> [...]
>>>
>>> It looks like Herve was working on decoupling floppies from i8257, but
>>> perhaps didn't get all the way through -- I'm not actually clear on what
>>> work remains to be done here, maybe he can chime in if he's still
>>> interested in the project?
>>>
>>
>> Indeed, I worked on decoupling floppies (and other ISA devices) from
>> i8257, for three reasons:
>> 1) having a working floppy on MIPS Magnum machine. fdc is PC-compatible,
>> but DMA controller is not i8257-compatible.
>> 2) reimplement another ISA bus with a somewhat i8257-compatible DMA
>> 3) for fun, support multiple ISA buses on a same machine but on
>> different PCI bridges.
>>
>> I failed on point 1), mostly due to lack of documentation.
>> I succeeded on point 2), by having locally some patches for a ISAPNP
>> bus, where IO/IRQ/DMA addresses of ISA devices can change dynamically,
>> and devices can be discovered by operating system.
>> About point 3, most of the patches are ready, but some details are still
>> to be fixed.
> 
> I'm having hard time refactoring all these PC chipsets, I'll make some
> room to send my current work as RFC before soft freeze.

Sorry I misunderstood the problem; my series only modify the Super I/O
devices, being affected by the same problem Alexey has with the ISA DMA :(
