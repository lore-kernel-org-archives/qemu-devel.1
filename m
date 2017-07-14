Received: from eggs.gnu.org ([2001:4830:134:3::10]:50379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3IK-0007cr-3x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3IH-0005OS-Ej
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:18:20 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dW3IH-0005O9-97
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:18:17 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f67so27403367wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:18:17 -0700 (PDT)
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-10-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1500029487-14822-10-git-send-email-peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 17:18:14 +0100
Message-ID: <87h8yfuh4p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 9/9] MAINTAINERS: Add entries
 for MPS2 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Add entries to the MAINTAINERS file for the new MPS2
> board and devices.
>
> Since the CMSDK devices are not specific to the MPS2 board,
> extend the existing 'PrimeCell' section to cover CMSDK
> devices as well; in both cases these are devices implemented
> by ARM and provided as RTL that may be used in multiple
> SoCs and boards.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9529c94..10f5cd6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -380,7 +380,7 @@ F: hw/*/allwinner*
>  F: include/hw/*/allwinner*
>  F: hw/arm/cubieboard.c
>
> -ARM PrimeCell
> +ARM PrimeCell and CMSDK devices
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> @@ -394,6 +394,10 @@ F: hw/intc/pl190.c
>  F: hw/sd/pl181.c
>  F: hw/timer/pl031.c
>  F: include/hw/arm/primecell.h
> +F: hw/timer/cmsdk-apb-timer.c
> +F: include/hw/timer/cmsdk-apb-timer.h
> +F: hw/char/cmsdk-apb-uart.c
> +F: include/hw/char/cmsdk-apb-uart.h
>
>  ARM cores
>  M: Peter Maydell <peter.maydell@linaro.org>
> @@ -455,6 +459,14 @@ S: Maintained
>  F: hw/arm/integratorcp.c
>  F: hw/misc/arm_integrator_debug.c
>
> +MPS2
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/arm/mps2.c
> +F: hw/misc/mps2-scc.c
> +F: include/hw/misc/mps2-scc.h
> +
>  Musicpal
>  M: Jan Kiszka <jan.kiszka@web.de>
>  L: qemu-arm@nongnu.org


--
Alex Bennée
