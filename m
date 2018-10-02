Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7INE-0006O4-4O
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7IFk-0002ws-BL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:50:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7IFj-0002uk-Oe
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:50:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id m23-v6so1429182otf.0
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:50:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180921161939.822-5-clg@kaod.org>
References: <20180921161939.822-1-clg@kaod.org>
	<20180921161939.822-5-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:49:45 +0100
Message-ID: <CAFEAcA_NmJO1OiE51ypZXek6D-_hqtBX+Gi2=kzEBtZ5fzo_Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/11] hw/arm/aspeed: add a
 'execute-in-place' property to boot directly from CE0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 21 September 2018 at 17:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The overhead for the OpenBMC firmware images using the a custom U-Boot
> is around 2 seconds, which is fine, but with a U-Boot from mainline,
> it takes an extra 50 seconds or so to reach Linux. A quick survey on
> the number of reads performed on the flash memory region gives the
> following figures :
>
>   OpenBMC U-Boot      922478 (~ 3.5 MBytes)
>   Mainline U-Boot   20569977 (~ 80  MBytes)
>
> QEMU must be trashing the TCG TBs and reloading text very often. Some
> addresses are read more than 250.000 times. Until we find a solution
> to improve boot time, execution from MMIO is not activated by default.
>
> Setting this option also breaks migration compatibility.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
