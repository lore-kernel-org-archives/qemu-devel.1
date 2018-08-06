Received: from eggs.gnu.org ([2001:4830:134:3::10]:40021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcST-0000LN-EU
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmcSS-00065N-Ku
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:09:49 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmcSS-00065B-5p
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:09:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id m11-v6so21222027oic.2
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 03:09:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-1-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 11:09:26 +0100
Message-ID: <CAFEAcA90QeDpCzHUsB-dF8KNNisBJgMHtBvwtFjA63+wovP=Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] arm: nRF51 Devices and Microbit Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 6 August 2018 at 11:01, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> w=
rote:
> This series contains additional peripheral devices for the nRF51822
> microcontroller. Furthermore it includes a device to demultiplex
> the row and column strobes used in embedded devices to drive
> 2D LED dot-matrices.
>
> Included devices:
> - Random Number Generator
> - Non-volatile Memories
> - General purpose I/O
> - Timer
>
> Microbit board-level Devices:
> - LED Matrix
>
> Instantiate of the devices is done in an upcoming patch series.

Thanks for gathering together these patches in one series.
This and the other Cortex-M0-related patchsets are on my queue
to review, but I won't be able to get to them for a little bit
as I'm currently dealing with 3.0 release work. Hopefully by
next week that will have calmed down.

thanks
-- PMM
