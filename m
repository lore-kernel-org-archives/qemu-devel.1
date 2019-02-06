Received: from eggs.gnu.org ([209.51.188.92]:34860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grT6A-0001MQ-Pe
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grT3z-0002Bc-LS
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:40:53 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grT3y-00029a-Sa
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:40:51 -0500
Received: by mail-ot1-x342.google.com with SMTP id n8so14045530otl.6
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 11:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190205151810.571-1-peter.maydell@linaro.org>
	<b8c414fe-e0cb-29ea-84cd-1f4386e6a10b@linaro.org>
	<20190206155547.GA13624@flamenco>
In-Reply-To: <20190206155547.GA13624@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Feb 2019 19:40:35 +0000
Message-ID: <CAFEAcA93+JnWz9h0tBhM016Qu7afAYs3vkdTWNTLPm-3u-ehsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Howard Spoelstra <hsp.cat7@gmail.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 6 Feb 2019 at 15:55, Emilio G. Cota <cota@braap.org> wrote:
>
> On Wed, Feb 06, 2019 at 03:15:26 +0000, Richard Henderson wrote:
> > > Does anybody know why tb_lookup__cpu_state() has that odd
> > > double-underscore in the middle of its name?
> >
> > I'm inclined to think typo...  Emilio?
>
> It's not a typo -- it's there to separate "tb lookup" and
> "cpu state" to avoid ambiguity when guessing what
> the function does based on its name.

OK, I wouldn't have guessed that -- my assumption was
"accidentally removed a name component with sed" or
"just a typo", and I didn't assign any semantic meaning
to the double underscore...

thanks
-- PMM
