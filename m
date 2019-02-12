Received: from eggs.gnu.org ([209.51.188.92]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtVtt-0008Sv-AI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtVtr-0007Ah-C3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:06:53 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtVtp-00072H-8U
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:06:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id i5so3668385oto.9
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20190212105201.13795-1-peter.maydell@linaro.org>
	<1df0da56-7abd-4688-0fed-6dc2bf10ebb6@redhat.com>
In-Reply-To: <1df0da56-7abd-4688-0fed-6dc2bf10ebb6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 11:06:33 +0000
Message-ID: <CAFEAcA9Jds9wLwJUqe4kJrDszL__KoWpKm5ajh0HCcR+mSH8tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/armsse: Fix miswiring of expansion
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Tue, 12 Feb 2019 at 11:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/12/19 11:52 AM, Peter Maydell wrote:
> > In commit 91c1e9fcbd7548db368 where we added dual-CPU support to
> > the ARMSSE, we set up the wiring of the expansion IRQs via nested
> > loops: the outer loop on 'i' loops for each CPU, and the inner loop
> > on 'j' loops for each interrupt. Fix a typo which meant we were
> > wiring every expansion IRQ line to external IRQ 0 on CPU 0 and
> > to external IRQ 1 on CPU 1.
> >
> > Fixes: 91c1e9fcbd7548db368 ("hw/arm/armsse: Support dual-CPU configurat=
ion")
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > ---
> > It turns out that the ARM-TFM image I was using to test that
> > I hadn't broken the mps2-an505 doesn't actually rely on any
> > interrupts from the external devices...
>
> How did you notice that, simply reviewing? Via 'info qtree'?

I'm working on a model of a different board (Musca) which also
uses the SSE-200, and the test code I had for that does happen
to care about the interrupts.

thanks
-- PMM
