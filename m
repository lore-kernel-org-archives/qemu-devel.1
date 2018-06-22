Received: from eggs.gnu.org ([2001:4830:134:3::10]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWAPZ-0001fd-El
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWAPY-00069m-PQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:58:49 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180621223946.20738-3-clg@kaod.org>
References: <20180621223946.20738-1-clg@kaod.org>
	<20180621223946.20738-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 22 Jun 2018 10:28:27 +0930
Message-ID: <CACPK8Xd1+qziDk9TG0hjvTdSLfYs7nmTEm54_YDPK8O1x7nuuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] aspeed: initialize the SCU controller
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>

On 22 June 2018 at 08:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The System Control Unit should be initialized first as it drives all
> the configuration of the SoC and other device models.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed_soc.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
