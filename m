Received: from eggs.gnu.org ([209.51.188.92]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6c4-0006Am-MP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6c3-00074N-Go
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:42:32 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr6c3-00073N-7T
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:42:31 -0500
Received: by mail-ot1-x342.google.com with SMTP id u16so7805692otk.8
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 19:42:18 +0000
Message-ID: <CAFEAcA8XTc5RTxifOA-cYb2FfRaC5ZMBh3AEcxL8LZqh7qxo7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/17] target/arm: Implement ARMv8.5-MemTag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Will Deacon <will.deacon@arm.com>, Dave P Martin <dave.martin@arm.com>, szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20190110124951.15473-1-richard.henderson@linaro.org
> aka the TBID patch set, which itself is based on the BTI patch set.
>
> The full tree is available at
>
>   https://github.org/rth7680/qemu.git tgt-arm-mte
>
> This extension isl also spelled MTE in the ARM.
>
> This patch set only attempts to implement linux-user emulation.
> For system emulation, I still miss the new cache flushing insns (easy)
> and the out-of-band physical memory for the allocation tags (harder).
>
> From a few mis-steps in writing the test cases for the extension,
> I might suggest that some future kernel's userland ABI for this have
> TCR.TCMA0 = 1, so that legacy code that is *not* MTE aware can use
> a frame pointer without accidentally tripping left over stack tags.
> (As seen in patch 5, SP+OFF is unchecked per the ISA but FP+OFF is not.)
>
> OTOH, depending on the application, that does make it easier for an
> attack vector to clean the tag off the top of a pointer to bypass
> store checking.  So, tricky.

I'm working through review of this, but feel free to rebase on
current master (which has now got a pile of your other patches
in it, since I've just merged target-arm.next) without waiting
for me to finish going through it.

thanks
-- PMM
