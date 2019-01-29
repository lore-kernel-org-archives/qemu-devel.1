Received: from eggs.gnu.org ([209.51.188.92]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRyX-0002rD-Gl
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRyV-0008A7-EF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:54:45 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:33565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goRyF-00086U-M7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:54:38 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i20so17638072otl.0
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:54:25 -0800 (PST)
MIME-Version: 1.0
References: <87va27n2l8.fsf@linaro.org>
	<20190129114609.GA25983@lakrids.cambridge.arm.com>
In-Reply-To: <20190129114609.GA25983@lakrids.cambridge.arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 11:54:13 +0000
Message-ID: <CAFEAcA-_ShbUthqPSPgEPmV0EeRUO85n=sC-+76gRAH830co_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Kernel boot regression with PAuth and
 aarch64-softmmu -cpu max and el2 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Rutland <mark.rutland@arm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Kristina Martsenko <kristina.martsenko@arm.com>, "open list:ARM" <qemu-arm@nongnu.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 29 Jan 2019 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jan 29, 2019 at 11:08:19AM +0000, Alex Benn=C3=A9e wrote:
> > The -cpu max enabled a cortex-a57 + whatever extra features we've
> > enabled in QEMU so far. It won't match any "real" CPU but it should be
> > architecturally correct in so far we implement prerequisite features fo=
r
> > any given feature. The cpuid feature bits should also be correct as we
> > test them internally in QEMU to enable features.
>
> Just to check, does this enable VHE?

It does not. (We have no implementation of VHE yet -- as and when
we do implement that "-cpu max" will turn it on, but today it doesn't.)

thanks
-- PMM
