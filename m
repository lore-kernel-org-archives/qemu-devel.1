Received: from eggs.gnu.org ([209.51.188.92]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCet-0001PX-Ka
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCet-0000Ls-0M
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:44:55 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkCes-0000JP-SJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:44:54 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so7009349oif.2
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20190111125759.31577-1-clg@kaod.org>
In-Reply-To: <20190111125759.31577-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 18:44:42 +0000
Message-ID: <CAFEAcA_x+4ReaCrW5CYmYqyJkbW72J-t7svthGKt325A1PGL=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ftgmac100: implement the new MDIO
 interface on Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>

On Fri, 11 Jan 2019 at 12:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The PHY behind the MAC of an Aspeed SoC can be controlled using two
> different MDC/MDIO interfaces. The same registers PHYCR (MAC60) and
> PHYDATA (MAC64) are involved but they have a different layout.
>
> BIT31 of the Feature Register (MAC40) controls which MDC/MDIO
> interface is active.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---



Applied to target-arm.next, thanks.

-- PMM
