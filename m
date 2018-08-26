Received: from eggs.gnu.org ([208.118.235.92]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftsjh-0007c8-VE
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftsjh-0004FN-0y
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:57:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftsjg-0004BZ-IP
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 06:57:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so22560122oib.10
	for <qemu-devel@nongnu.org>; Sun, 26 Aug 2018 03:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACPK8Xeqaq2=Ey7cDxjQZrS1nw9mvbVsWd5ObOCDVVAuu0T8eA@mail.gmail.com>
References: <20180816141303.20518-1-joel@jms.id.au>
	<20180816141303.20518-3-joel@jms.id.au>
	<CAFEAcA9N_H2PqVUP-W=Sp-SQ4WYpbu5fqyN5hxkHdHGocX59Mg@mail.gmail.com>
	<CACPK8Xeqaq2=Ey7cDxjQZrS1nw9mvbVsWd5ObOCDVVAuu0T8eA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Aug 2018 11:57:15 +0100
Message-ID: <CAFEAcA_oQ_6Gx2jWAsv1pL28SocRP+TiSEN6Q_6Nj_9deKGAUg@mail.gmail.com>
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
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

On 26 August 2018 at 01:48, Joel Stanley <joel@jms.id.au> wrote:
> I agree that it would be neater to do this. I didn't as the flash is
> part of the NRF51822 SoC, opposed to some external flash that is on
> the microbit board and connected to the SoC. This is mentioned in the
> comment at the start of the file:
>
>  /*
>   * The size and base is for the NRF51822 part. If other parts
>   * are supported in the future, add a sub-class of NRF51SoC for
>   * the specific variants
>   */

Oh, right. I'd assumed it wasn't fixed because it was specified
as a property on the object.

> What would you prefer we do here?

I don't see anything that seems like the really obvious
clean thing, so I suggest just doing something that seems
reasonable. I think Steffen's patchset also had a change in
this area, which might affect the decision.

thanks
-- PMM
