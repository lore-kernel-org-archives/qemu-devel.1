Received: from eggs.gnu.org ([2001:4830:134:3::10]:38513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIKK-0006zJ-2o
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIKJ-0006Lq-7U
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:47:00 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diIKJ-0006LN-0l
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:46:59 -0400
Received: by mail-wr0-x22c.google.com with SMTP id b65so39924429wrd.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 03:46:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170809062828.3673-1-andrew@aj.id.au>
References: <20170809062828.3673-1-andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 11:46:37 +0100
Message-ID: <CAFEAcA-fQ+=ckEJJrOWDVLdEpEi_UxFZ0yySkhD7=k6dHrFCfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11 v2 0/2] wdt_aspeed: Support reset
 width patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, ryan_chen@aspeedtech.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On 9 August 2017 at 07:28, Andrew Jeffery <andrew@aj.id.au> wrote:
> Hello,
>
> These two patches add support for the reset width configuration register in the
> Aspeed watchdog. Initially this was just one patch[1], but I've reworked it as
> two to explicitly support the varying capabilities between Aspeed SoC versions.
>
> Andrew
>
> [1] http://patchwork.ozlabs.org/patch/796039/
>
> Andrew Jeffery (2):
>   watchdog: wdt_aspeed: Add support for the reset width register
>   aspeed_soc: Propagate silicon-rev to watchdog



Applied to target-arm.next ready for when 2.11 development opens, thanks.

-- PMM
