Received: from eggs.gnu.org ([209.51.188.92]:49196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlIx-0004KS-Lu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlIw-0007GV-V1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:08:51 -0500
MIME-Version: 1.0
References: <20190124140519.13838-1-clg@kaod.org>
	<20190124140519.13838-3-clg@kaod.org>
In-Reply-To: <20190124140519.13838-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Jan 2019 07:08:37 +1100
Message-ID: <CACPK8Xf26pXnP2uosEKAovjNuO7pqNz76j1GCtedsjR1cheKsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] aspeed/smc: define registers for all
 possible CS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, 25 Jan 2019 at 01:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The model should expose one control register per possible CS. When
> testing the validity of the register number in the read operation,
> replace 's->num_cs' by 'ctrl->max_slaves' which represents the maximum
> number of flash devices a controller can handle.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
