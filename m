Received: from eggs.gnu.org ([2001:4830:134:3::10]:59129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDSs-0007c9-7g
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDSr-0003gc-HN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:40:10 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHDSr-0003fP-At
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:40:09 -0500
Received: by mail-ot0-x243.google.com with SMTP id 18so11385499oty.9
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:40:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171103000109.28244-1-frasse.iglesias@gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:39:48 +0000
Message-ID: <CAFEAcA8OWP=x=YCumVzc4biETn7SbUxaBDasYR3XNx71aabdmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 00/13] Add support for the ZynqMP
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, alistai@xilinx.com, francisco.iglesias@feimtech.se, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 3 November 2017 at 00:00, Francisco Iglesias
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

Hi; just a note to say that I'm assuming the Xilinx folk are going
to review the xilinx_spips patches in this set...

thanks
-- PMM
