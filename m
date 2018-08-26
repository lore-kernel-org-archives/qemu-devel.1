Received: from eggs.gnu.org ([2001:4830:134:3::10]:51322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1ftjDy-0002vb-9O
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 20:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1ftjDx-0006qk-9C
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 20:48:14 -0400
MIME-Version: 1.0
References: <20180816141303.20518-1-joel@jms.id.au>
	<20180816141303.20518-3-joel@jms.id.au>
	<CAFEAcA9N_H2PqVUP-W=Sp-SQ4WYpbu5fqyN5hxkHdHGocX59Mg@mail.gmail.com>
In-Reply-To: <CAFEAcA9N_H2PqVUP-W=Sp-SQ4WYpbu5fqyN5hxkHdHGocX59Mg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Sat, 25 Aug 2018 17:48:01 -0700
Message-ID: <CACPK8Xeqaq2=Ey7cDxjQZrS1nw9mvbVsWd5ObOCDVVAuu0T8eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Hi Peter,

On Thu, 16 Aug 2018 at 07:24, Peter Maydell <peter.maydell@linaro.org> wrote:

> > +static Property nrf51_soc_properties[] = {
> > +    DEFINE_PROP_LINK("memory", NRF51State, board_memory, TYPE_MEMORY_REGION,
> > +                     MemoryRegion *),
> > +    DEFINE_PROP_UINT32("sram-size", NRF51State, sram_size, NRF51822_SRAM_SIZE),
> > +    DEFINE_PROP_UINT32("flash-size", NRF51State, flash_size, NRF51822_FLASH_SIZE),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
>
> Ah, I was wondering how flash_size was handled when I looked at patch 3.
>
> Instead of your patch 3 board model code reaching into the internals
> of the NRF51State struct to pull out the flash_size field, the board
> code should set this property on the object it creates, and then it
> knows how big the flash it's asked for is and can pass that value also
> to the armv7m_load_kernel() function.

Thanks for the review. I've sorted out the other comments relating to
this patch, but I wanted to discuss this one.

I agree that it would be neater to do this. I didn't as the flash is
part of the NRF51822 SoC, opposed to some external flash that is on
the microbit board and connected to the SoC. This is mentioned in the
comment at the start of the file:

 /*
  * The size and base is for the NRF51822 part. If other parts
  * are supported in the future, add a sub-class of NRF51SoC for
  * the specific variants
  */

What would you prefer we do here?

Cheers,

Joel
