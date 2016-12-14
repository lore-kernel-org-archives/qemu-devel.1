Received: from eggs.gnu.org ([2001:4830:134:3::10]:35247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHD8E-00075t-Ng
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHD88-00023Q-Uv
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:18 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHD88-00023A-QL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:12 -0500
Received: by mail-vk0-f54.google.com with SMTP id x186so37687818vkd.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:14:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480434248-27138-1-git-send-email-clg@kaod.org>
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 17:12:51 +0000
Message-ID: <CAFEAcA96OTfgO9agwKT10XHAPLA1cfme7syA0wTAu5t=zKgyHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/30] Aspeed SoC fixes and model
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 29 November 2016 at 15:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Here is a collection of fixes and improvements on existing models for
> the Aspeed SoCs

I have taken into target-arm.next for 2.9 patches 2-13:

>   m25p80: add support for the mx66l1g45g
>   aspeed: QOMify the CPU object and attach it to the SoC
>   aspeed: remove cannot_destroy_with_object_finalize_yet
>   aspeed: attach the second SPI controller object to the SoC
>   aspeed: extend the board configuration with flash models
>   aspeed: add support for the romulus-bmc board
>   aspeed: add a memory region for SRAM
>   aspeed: add the definitions for the AST2400 A1 SoC
>   aspeed: change SoC revision of the palmetto-bmc machine
>   aspeed/scu: fix SCU region size
>   aspeed/smc: improve segment register support
>   aspeed/smc: set the number of flash modules for the FMC controller

which should at least reduce the size of this patchset for the
next round.

thanks
-- PMM
