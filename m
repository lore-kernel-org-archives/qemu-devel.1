Received: from eggs.gnu.org ([2001:4830:134:3::10]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8g8-0008FU-K8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8g7-00035i-VQ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:38:04 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH8g7-00035B-NR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:38:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id u130-v6so2508444oie.7
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 07:38:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181025005052.27661-1-jusual@mail.ru>
References: <20181025005052.27661-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 14:37:42 +0000
Message-ID: <CAFEAcA-oZ86C99T8Yutu8L1EsnqM1vNvEK+tEfV7Haw+O5A=7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] arm: Add nRF51 SoC UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>

On 25 October 2018 at 01:50, Julia Suvorova <jusual@mail.ru> wrote:
> This series adds support for the nRF51 SoC UART, that used in
> BBC Micro:bit board, and QTest for it.
>
> v3:
>     * serial_hd() moved to the board code
>     * sysbus_init_child_obj() used for initialization
>     * qemu_chr_fe_accept_input() called after byte popping
>
> v2:
>     * Suspend/Enable functionality added
>     * Connection to SoC moved to a separate patch
>     * Added QTest for checking reception functionality
>     * Mini-kernel test changed to fit current implementation
>     * Addressed review comments on R_*, uart_can_receive, VMState,
>       uart_transmit
>
> Julia Suvorova (3):
>   hw/char: Implement nRF51 SoC UART
>   hw/arm/nrf51_soc: Connect UART to nRF51 SoC
>   tests/boot-serial-test: Add microbit board testcase

Applied to target-arm.next, thanks.

What's the current status of the 'microbit' board with these
patches? Are we missing anything important? Can we run any
interesting guest programs?

thanks
-- PMM
