Received: from eggs.gnu.org ([2001:4830:134:3::10]:52798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgla-0000IN-D0
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJglZ-0007iv-Bu
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:26:14 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJglZ-0007YH-1X
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:26:13 -0500
Received: by mail-ot1-x344.google.com with SMTP id 81so8324664otj.2
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:26:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-2-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:25:49 +0000
Message-ID: <CAFEAcA-DZMivo-epUmM6NxPzCUbGCfSU+SxEjszTNLdVaB8UxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.1 v2 1/7] MAINTAINERS: Add an entry
 for the Raspberry Pi machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 00:12, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> So far the Raspi machines use the BCM2836 SoC which includes
> a BCM2835 for the peripherals.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2360efe3e..c41ea5ed3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -683,6 +683,12 @@ F: hw/arm/nrf51_soc.c
>  F: hw/arm/microbit.c
>  F: include/hw/arm/nrf51_soc.h
>
> +Raspberry Pi
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/*/bcm283*
> +F: include/hw/*/bcm283*
> +

We should also have F:hw/arm/raspi.c

Andrew, as the original submitter of the Raspberry Pi code
would you like to be listed as a maintainer for it?

thanks
-- PMM
