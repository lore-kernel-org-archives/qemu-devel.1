Received: from eggs.gnu.org ([2001:4830:134:3::10]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKBL-00042x-If
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euKBK-00031I-SW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:43:43 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euKBK-00030t-L5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:43:42 -0500
Received: by mail-ot0-x244.google.com with SMTP id w38so9027528ota.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:43:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309153654.13518-9-f4bug@amsat.org>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-9-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 15:43:21 +0000
Message-ID: <CAFEAcA-hPN1DTzP5Zn_xFORXRXeNXc8xyACZF13jpKU4_o6MTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] MAINTAINERS: Add entries for SD (SDHCI, SDBus,
 SDCard)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 15:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> After spending months studying all the different SD Specifications
> from the SD Association, voluntarily add myself as maintainer
> for the SD code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7c4130388..0446724642 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1089,6 +1089,14 @@ M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  S: Maintained
>  F: hw/ssi/xilinx_*
>
> +SD (Secure Card)
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Odd Fixes
> +F: include/hw/sd/sd*
> +F: hw/sd/core.c
> +F: hw/sd/sd*
> +F: tests/sd*
> +
>  USB
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
> --
> 2.16.2

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
