Received: from eggs.gnu.org ([209.51.188.92]:52223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlSo-0000Y4-KF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlSn-0005OZ-Ur
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:19:02 -0500
MIME-Version: 1.0
References: <20181211031044.27628-1-joel@jms.id.au>
	<20181211031044.27628-3-joel@jms.id.au>
	<CAFEAcA-KoxgDuWtCfZqzGgMgQrxRiMYfwt31eU12CQOPW_pSMg@mail.gmail.com>
In-Reply-To: <CAFEAcA-KoxgDuWtCfZqzGgMgQrxRiMYfwt31eU12CQOPW_pSMg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Jan 2019 07:18:45 +1100
Message-ID: <CACPK8XeM9c2xFbeXb6kqOJGczL6aW2K0hoEaK=x_AiN_mejPkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] aspeed/scu: Implement power off
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 03:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 11 Dec 2018 at 03:11, Joel Stanley <joel@jms.id.au> wrote:
> >
> > This register does not exist in hardware. It is here to allow the guest
> > code to cause Qemu to exit when required.
> >
> > The register address chosen is unused in the emulated machines
> > datasheets.

> I'm always a bit dubious about adding things to QEMU devices
> which don't exist in the real hardware we're emulating. If we
> do want to do that, I think we should clearly flag them up as
> being QEMU-specific with suitable comments and naming of
> the #define, etc.

Since writing this patch I was made aware of -no-reboot. That flag
solves the problem I had so we can drop these patches for now.

Cheers,

Joel
