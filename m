Received: from eggs.gnu.org ([2001:4830:134:3::10]:39477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqTc-0003Wp-Lv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqTb-0007g2-Sr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:05:56 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXqTb-0007fd-FU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:05:55 -0400
Received: by mail-oi0-x241.google.com with SMTP id k81-v6so2463176oib.4
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:05:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622075700.5923-1-clg@kaod.org>
References: <20180622075700.5923-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:05:33 +0100
Message-ID: <CAFEAcA9-rg_W9AyqDDMVgMR=r2hyEHsJawjrDn6PgJ2tvXErig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: introduce the APB clock
 settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On 22 June 2018 at 08:56, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> The Aspeed SoC clocks are driven by an input source clock which can
> have different frequencies : 24MHz or 25MHz, and also, on the Aspeed
> AST2400 SoC, 48MHz. The H-PLL (CPU) clock is defined from a calculation
> using parameters in the H-PLL Parameter register or from a predefined
> set of frequencies if the setting is strapped by hardware (Aspeed
> AST2400 SoC). The other clocks of the SoC are then defined from the
> H-PLL using dividers.
>
> We first introduce the APB clock because it drives the timer model.
> This fixes a slowdown issue on the palmetto machine (AST2400) when
> running Linux. The latest Linux versions take into account more
> precisely the SoC settings for the clocks and the APB freq is set to
> 48MHz but modeled at 24MHz by QEMU.
>
> Thanks,
>



Applied to target-arm.next, thanks.

-- PMM
