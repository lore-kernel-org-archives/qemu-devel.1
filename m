Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff396-0003EC-TF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff391-0003QS-4V
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:02:32 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff390-0003Q3-U0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:02:27 -0400
Received: by mail-oi0-x242.google.com with SMTP id 13-v6so74589141ois.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:02:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e9073530-a6ef-0e93-dcef-f3c3e91df01f@adacore.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<e9073530-a6ef-0e93-dcef-f3c3e91df01f@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:02:05 +0100
Message-ID: <CAFEAcA-b7nzcjAyofRh5S6RxjZ08==PdN83e2sgKW9d=1Za2xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] accel/tcg: Support execution from MMIO
 and small MMU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 16 July 2018 at 13:30, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> Hi Peter,
>
> Nice! Thanks for that.
>
> A little question though.. What will happen in the case where the
> CPU start executing code at random place because of eg: a badly
> configured kernel?
>
> Seeing the patch 5 I guess it will really execute stuff.. So
> maybe this is less user-friendly?

Yes, it's true that we will now happily execute from anything
(device, unassigned memory, etc), and do what the real hardware
would do in that situation (random unhelpful things, infinite
loop of taking exceptions). That's a bit unavoidable though I
think, and there are already lots of cases where QEMU will just
sit there with a black screen because the user has loaded in
a bad guest image that goes off into the weeds without printing
anything to a UART.

It's possible we could devise a user-friendliness option that
tried to pick up symptoms of guests being stuck (eg tracking
whether we're continuously taking exceptions) but that gets
into heuristics a bit.

thanks
-- PMM
