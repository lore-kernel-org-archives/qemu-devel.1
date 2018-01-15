Received: from eggs.gnu.org ([2001:4830:134:3::10]:50559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb63b-0005ok-0V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb63a-0000y4-7y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:48:15 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:37079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb63a-0000xQ-3y
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:48:14 -0500
Received: by mail-oi0-x232.google.com with SMTP id e144so8430196oib.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:48:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <70091140-1b3e-6000-0add-b4e980db295e@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
	<CAFEAcA9YNOfZW6tY_OWZ+cyF1Gvc9-9Sq81WgdL_JRDUxcfAqw@mail.gmail.com>
	<70091140-1b3e-6000-0add-b4e980db295e@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 14:47:52 +0000
Message-ID: <CAFEAcA9zdxMBosPJOg25vUzg6sdsBORkMRwaVqyAGq6wHxE_Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/14] SDHCI: housekeeping (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On 15 January 2018 at 14:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 01/15/2018 10:51 AM, Peter Maydell wrote:
>> On 13 January 2018 at 05:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>> Since v6:
>>> - addressed Peter reviews
>>>   - do not use an unique Property[] for both sysbus/pci
>>>     Peter didn't recommend me to use the qdev_property_add_static() API=
 since
>>>     it is only used by the ARM cpus and may be due for removal, however=
 I found
>>>     it cleaner.
>>
>> Your cover letter says this but patches 3 and 14 in the v7 you sent
>> to the list use qdev_property_add_static(). Did you send the wrong
>> version of the code?
>
> The cover is not clear, I'll try to reword it:
>
> '''
> Peter recommended me to NON use the qdev_property_add_static() API since
> it is only used by the ARM cpus and may be due for removal.
>
> However I found using qdev_property_add_static() cleaner, and sent this
> series with using the not recommended qdev_property_add_static().
> '''

> Is it possible to share properties without using qdev_property_add_static=
()?

Not very neatly. There's the DEFINE_BLOCK_PROPERTIES approach that
include/hw/block/block.h has.

In this case there aren't very many properties involved so I would
just leave them as two separate Property arrays.

(The Arm cpu models are odd because they dynamically decide which
properties they have based on the CPU model. That isn't the case here:
these devices always have the same set of properties.)

thanks
-- PMM
