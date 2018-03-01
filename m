Received: from eggs.gnu.org ([2001:4830:134:3::10]:43159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMpi-0003k3-6G
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMph-0001iA-Hl
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:57:10 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:33927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erMph-0001hq-BX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:57:09 -0500
Received: by mail-oi0-x231.google.com with SMTP id c83so4275054oib.1
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 03:57:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1519755964.git.alistair.francis@xilinx.com>
References: <cover.1519755964.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 11:56:48 +0000
Message-ID: <CAFEAcA8LhdPTLmsx5n+HhUr1r9u8gr3s5HkOwcb4ZxYdbHe4qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 0/3] Add and connect the ZynqMP RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 27 February 2018 at 18:52, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> V7:
>  - Move the current_tm to the init() function
>
> V6:
>  - Migrate tick_offset and add a pre_save call
>
> V5:
>  - Recalculate tick_offset after migration
>
> V4:
>  - Use the RegisterAccessInfo .unimp functionality
>
> V3:
>  - Store an offset value
>  - Use mktimegm()
>  - Log unimplemented writes
>
> V2:
>  - Delete unused realise function
>  - Add cover letter
>  - Convert DB_PRINT() macro to trace
>
>
> Alistair Francis (3):
>   xlnx-zynqmp-rtc: Initial commit
>   xlnx-zynqmp-rtc: Add basic time support
>   xlnx-zynqmp: Connect the RTC device



Applied to target-arm.next, thanks.

-- PMM
