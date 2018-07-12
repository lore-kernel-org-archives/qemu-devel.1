Received: from eggs.gnu.org ([2001:4830:134:3::10]:47226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddzf-0005L2-6r
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddze-0005S2-Dg
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:58:59 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fddze-0005RN-95
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:58:58 -0400
Received: by mail-oi0-x241.google.com with SMTP id l10-v6so10023138oii.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 08:58:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709143524.17480-1-andrew@aj.id.au>
References: <20180709143524.17480-1-andrew@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:58:37 +0100
Message-ID: <CAFEAcA9GHFwscBzRGRbqAN+nWWYYbSZB-M0Kt+r=fFFG3xfm8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] aspeed: Implement write-1-{set,
 clear} for AST2500 strapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm <qemu-arm@nongnu.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On 9 July 2018 at 15:35, Andrew Jeffery <andrew@aj.id.au> wrote:
> The AST2500 SoC family changes the runtime behaviour of the hardware
> strapping register (SCU70) to write-1-set/write-1-clear, with
> write-1-clear implemented on the "read-only" SoC revision register
> (SCU7C). For the the AST2400, the hardware strapping is
> runtime-configured with read-modify-write semantics.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---

Hi -- is this a bugfix suitable for 3.0, or something you'd
like to wait until 3.1 ? The commit message sounds like a bugfix...

thanks
-- PMM
