Received: from eggs.gnu.org ([2001:4830:134:3::10]:37099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiCY-0002Tu-9k
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiCX-00027r-GS
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:53:38 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJiCX-00027l-BO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:53:37 -0500
Received: by mail-ot0-x244.google.com with SMTP id q3so267299oth.2
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 07:53:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171126231634.9531-1-frasse.iglesias@gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 15:53:16 +0000
Message-ID: <CAFEAcA-kD9CbuLw7eRbWVXVGi2gtMaSnscc3V1VKy7j7xBB8wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 00/13] Add support for the ZynqMP
 Generic QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, alistai@xilinx.com, francisco.iglesias@feimtech.se, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 26 November 2017 at 23:16, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Hi,
>
> This patch series is an attempt to add support for the ZynqMP QSPI (consisting
> of the Generic QSPI and the legacy QSPI) to the xlnx-zcu102 board and connect
> Numonyx n25q512a11 flashes to the QSPI. Also some functionality is added to
> m25p80.
>
> The series starts by adding support in m25p80 for continous read out of status
> registers, SST flash READ ID commands, bank address register accesses, bulk
> erase (0x60) and two Numonyx flashes (n25q512a11 and n25q512a13). Thereafter it
> updates the striping behaviour to be bit big endiann in the Xilinx QSPI model
> and adds support for RX discard, zero pumping according transfer register and 4
> byte LQSPI addresses. Finally it adds support for the ZynqMP Generic QSPI and
> adds the ZynqMP QSPI to the xlnx-zcu102 board.
>
> Best regards,
> Francisco Iglesias

Thanks; I have applied this series to target-arm.next ready for when
we reopen the development tree for 2.12.

thanks
-- PMM
