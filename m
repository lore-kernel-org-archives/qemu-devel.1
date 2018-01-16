Received: from eggs.gnu.org ([2001:4830:134:3::10]:58600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSRt-0006oc-8c
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSRs-0000Tm-DV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:42:49 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSRs-0000TV-8k
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:42:48 -0500
Received: by mail-ot0-x232.google.com with SMTP id 53so13794194otj.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:42:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-13-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-13-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:42:27 +0000
Message-ID: <CAFEAcA9VmZQJjvWe=a9V6TO0nMk+L5i1RgrpkkB1EYWDc9fr7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/14] i.MX: Add i.MX7 SOC
 implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> The following interfaces are partially or fully emulated:
>
>     * up to 2 Cortex A9 cores (SMP works with PSCI)
>     * A7 MPCORE (identical to A15 MPCORE)
>     * 4 GPTs modules
>     * 7 GPIO controllers
>     * 2 IOMUXC controllers
>     * 1 CCM module
>     * 1 SVNS module
>     * 1 SRC module
>     * 1 GPCv2 controller
>     * 4 eCSPI controllers
>     * 4 I2C controllers
>     * 7 i.MX UART controllers
>     * 2 FlexCAN controllers
>     * 2 Ethernet controllers (FEC)
>     * 3 SD controllers (USDHC)
>     * 4 WDT modules
>     * 1 SDMA module
>     * 1 GPR module
>     * 2 USBMISC modules
>     * 2 ADC modules
>     * 1 PCIe controller
>
> Tested to boot and work with upstream Linux (4.13+) guest.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
