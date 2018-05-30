Received: from eggs.gnu.org ([2001:4830:134:3::10]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrJE-000707-RG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrJA-0003PU-17
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:57:56 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrJ9-0003PD-Rv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 22:57:51 -0400
Received: by mail-qk0-x244.google.com with SMTP id h19-v6so13242711qkj.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 19:57:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529220338.10879-1-jusual@mail.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97e86c94-b0f3-be30-627a-19a25783cba6@amsat.org>
Date: Tue, 29 May 2018 23:57:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180529220338.10879-1-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 0/3] nRF51 SoC: Add UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>

Hi Julia,

On 05/29/2018 07:03 PM, Julia Suvorova via Qemu-devel wrote:
> This series adds basic support for the nRF51 SoC UART, that used in
> BBC Micro:bit board, and QTest for it.
> 
> Based-on: <20180503090532.3113-1-joel@jms.id.au>
> 
> Julia Suvorova (3):
>   hw/arm/nrf51_soc: Fix compilation and memory regions

Since Joel's series isn't merged, you can simply take his patches, fix
them, and include them in your following series.  Usually you keep his
Signed-off-by line, add a comment with your changes, then add your
S-o-b, such:

    [PATCH ...] hw/arm: Add Nordic Semiconductor nRF51 SoC

    The nRF51 is a Cortex-M0 microcontroller with an on-board radio module,
    plus other common ARM SoC peripherals.

    This defines a basic model of the CPU and memory, with no peripherals
    implemented at this stage.

    Signed-off-by: Joel Stanley <joel@jms.id.au>
    [Julia: Fixed BBC Micro:bit board ROM/RAM size, added FICR defines]
    Signed-off-by: Julia Suvorova <jusual@mail.ru>

>   hw/char/nrf51_uart: Implement nRF51 SoC UART
>   tests/boot-serial-test: Add support for the microbit board
> 
>  hw/arm/nrf51_soc.c           |  19 ++-
>  hw/char/Makefile.objs        |   1 +
>  hw/char/nrf51_uart.c         | 232 +++++++++++++++++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h   |   2 +
>  include/hw/char/nrf51_uart.h |  54 ++++++++
>  tests/boot-serial-test.c     |  11 ++
>  6 files changed, 314 insertions(+), 5 deletions(-)
>  create mode 100644 hw/char/nrf51_uart.c
>  create mode 100644 include/hw/char/nrf51_uart.h
> 
