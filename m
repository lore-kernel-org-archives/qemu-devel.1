Received: from eggs.gnu.org ([2001:4830:134:3::10]:37987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHwB-0004Wi-41
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faHwA-0007eF-Ed
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:49:31 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:40579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faHwA-0007dw-9G
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:49:30 -0400
Received: by mail-oi0-x232.google.com with SMTP id w126-v6so2543615oie.7
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 02:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703093113.GF16791@stefanha-x1.localdomain>
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
	<20180703093113.GF16791@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 10:49:09 +0100
Message-ID: <CAFEAcA809nThg4NCLMbYZ_syJQHCaEca7Eo_xVwOGoQ0Gmf4SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 3 July 2018 at 10:31, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 01:18:35PM +0100, Peter Maydell wrote:
>> It's not clear to me what this device is doing with its
>> AddressSpace, though; comments that went into more detail
>> about what the device is and what the "memory" property is
>> for might help.
>
> I understand this issue now.  It's the same as qtest.
>
> This device is only visible from cpu->as, it's not visible from
> address_space_memory (system_memory).
>
> The NVMC needs access to the SoC's flash memory region, and that's what
> mr/as achieve here.  I agree that comments explaining the purpose of
> mr/as would be useful.

Is the flash memory region only accessible to the CPU
via the NVMC, or can the CPU get at it both directly
and via the NVMC? (That is, in hardware, does the flash
sit "behind" the NVMC?)

thanks
-- PMM
