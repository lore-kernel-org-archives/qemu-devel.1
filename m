Received: from eggs.gnu.org ([2001:4830:134:3::10]:52500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fd7WI-0005OX-Tb
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 01:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fd7WI-0000Dt-6H
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 01:18:30 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180709143524.17480-1-andrew@aj.id.au>
References: <20180709143524.17480-1-andrew@aj.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Jul 2018 15:18:08 +1000
Message-ID: <CACPK8XefwXLyAzga+8ya5i3iWQoV5XpBJ2zqGTFRsD2A45OPqw@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On 10 July 2018 at 00:35, Andrew Jeffery <andrew@aj.id.au> wrote:
> The AST2500 SoC family changes the runtime behaviour of the hardware
> strapping register (SCU70) to write-1-set/write-1-clear, with
> write-1-clear implemented on the "read-only" SoC revision register
> (SCU7C). For the the AST2400, the hardware strapping is
> runtime-configured with read-modify-write semantics.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
