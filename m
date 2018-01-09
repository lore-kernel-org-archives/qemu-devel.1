Received: from eggs.gnu.org ([2001:4830:134:3::10]:58738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYyZn-0001EK-UI
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYyZn-0000xN-3y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:24:43 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAAdtpL7bno=1yrRYK6zt4pgDsa8N-8d291pzX0rhNBVqgkKi4g@mail.gmail.com>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-3-f4bug@amsat.org>
	<60c89dbec86c14e2f0883d121872d0f6@walle.cc>
	<CAAdtpL7bno=1yrRYK6zt4pgDsa8N-8d291pzX0rhNBVqgkKi4g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 9 Jan 2018 15:24:41 -0300
Message-ID: <CAAdtpL54UQjG7i5hKtgoKMzvXFL2iuiOEE-2re8YoJ41OCbEpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/sd/milkymist-memcard: split
 realize() out of SysBusDevice init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Xiaoqiang Zhao <zxq_yx_007@163.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

>> Creating the device (milkymist_memcard_create()) fails with an assertion:
>>   sysbus_mmio_map_common: Assertion `n >= 0 && n < dev->num_mmio' failed.
>
> Thanks for trying this.
>
> Odd 'make check-qtest-lm32' didn't catch this...

Oh it actually does... My bad!

  GTESTER check-qtest-lm32
qemu-system-lm32: hw/core/sysbus.c:131: sysbus_mmio_map_common:
Assertion `n >= 0 && n < dev->num_mmio' failed.
Broken pipe
tests/Makefile.include:854: recipe for target 'check-qtest-lm32' failed
make: *** [check-qtest-lm32] Error 1
