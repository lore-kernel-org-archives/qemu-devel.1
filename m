Received: from eggs.gnu.org ([2001:4830:134:3::10]:47648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJGE-0005pU-3i
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJGD-00075M-Ey
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:28:25 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJGB-00074C-DS
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:28:25 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so8318411oiw.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180816141303.20518-1-joel@jms.id.au>
References: <20180816141303.20518-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 15:28:02 +0100
Message-ID: <CAFEAcA_u+P7SfuvEMOi-+3brahDnq66ACfyRWJU5QSvQ4Fjo_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] arm: Add nRF51 SoC and micro:bit
 machine
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

On 16 August 2018 at 15:13, Joel Stanley <joel@jms.id.au> wrote:
> v5: Change back to ARMv7M from ARMMProfile
> v4: Fix number of IRQs
> v3: Rebase on Stefan's cortex-m0 series
> v2: Addresses review from Peter and Stefan
>
> Based-on: 20180814162739.11814-1-stefanha@redhat.com
>
> This short series implements a minimal definition of the Nordic
> Semiconductor nRF51, a Cortex-M0 ARM SoC, and the BBC micro:bit, a
> machine that will use this SoC.

Hi Joel; it looks like my review of v4 crossed in the mail
with your sending out v5. I think that my comments on
the v4 patch 3 still applies to v5, though (as does my
reviwed-by tag on patch 1).

thanks
-- PMM
