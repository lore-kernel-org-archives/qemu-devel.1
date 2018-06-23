Received: from eggs.gnu.org ([2001:4830:134:3::10]:55252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWoom-00077t-Tz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWoom-00008i-0X
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:07:32 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWool-00008Y-Rf
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:07:31 -0400
Received: by mail-oi0-x241.google.com with SMTP id f79-v6so9090994oib.7
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 13:07:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8eaf7bd5e178b897765f99abac553a664663193c.1529695276.git.alistair.francis@wdc.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
	<8eaf7bd5e178b897765f99abac553a664663193c.1529695276.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Jun 2018 21:07:10 +0100
Message-ID: <CAFEAcA_mvKsVAbSt0kw_zJ3G1f8CaRi2UHHy=7kMGhfPNa72hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/riscv/virt: Connect the Xilinx
 PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>

On 22 June 2018 at 20:30, Alistair Francis <alistair.francis@wdc.com> wrote:
> Connect the Xilinx PCIe device based on the device tree included in the
> HiFive Unleashed ROM.

Did you consider using the 'gpex' generic PCIe controller here?

thanks
-- PMM
