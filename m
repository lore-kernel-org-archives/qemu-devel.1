Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJiG2-0005RV-Fu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1eJiG1-0003Up-JZ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:57:14 -0500
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:42183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1eJiG1-0003US-Cf
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:57:13 -0500
Received: by mail-pl0-x229.google.com with SMTP id bd8so154446plb.9
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 07:57:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kD9CbuLw7eRbWVXVGi2gtMaSnscc3V1VKy7j7xBB8wg@mail.gmail.com>
References: <20171126231634.9531-1-frasse.iglesias@gmail.com>
	<CAFEAcA-kD9CbuLw7eRbWVXVGi2gtMaSnscc3V1VKy7j7xBB8wg@mail.gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Tue, 28 Nov 2017 16:57:11 +0100
Message-ID: <CAAYMZQv05-FHUmPhLogJ+O7OvaRnrr0QOrZKp0WdXDhONXtDgg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, "alistai@xilinx.com" <alistai@xilinx.com>, "francisco.iglesias@feimtech.se" <francisco.iglesias@feimtech.se>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Thank you very much Peter!

Best regards,
Francisco Iglesias

On Tuesday, 28 November 2017, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 26 November 2017 at 23:16, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
> > Hi,
> >
> > This patch series is an attempt to add support for the ZynqMP QSPI
> (consisting
> > of the Generic QSPI and the legacy QSPI) to the xlnx-zcu102 board and
> connect
> > Numonyx n25q512a11 flashes to the QSPI. Also some functionality is added
> to
> > m25p80.
> >
> > The series starts by adding support in m25p80 for continous read out of
> status
> > registers, SST flash READ ID commands, bank address register accesses,
> bulk
> > erase (0x60) and two Numonyx flashes (n25q512a11 and n25q512a13).
> Thereafter it
> > updates the striping behaviour to be bit big endiann in the Xilinx QSPI
> model
> > and adds support for RX discard, zero pumping according transfer
> register and 4
> > byte LQSPI addresses. Finally it adds support for the ZynqMP Generic
> QSPI and
> > adds the ZynqMP QSPI to the xlnx-zcu102 board.
> >
> > Best regards,
> > Francisco Iglesias
>
> Thanks; I have applied this series to target-arm.next ready for when
> we reopen the development tree for 2.12.
>
> thanks
> -- PMM
>
