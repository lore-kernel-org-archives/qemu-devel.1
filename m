Received: from eggs.gnu.org ([209.51.188.92]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRpz-0006lK-Mr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goRpz-0004GN-23
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:45:55 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goRpy-0004G6-T9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:45:54 -0500
Received: by mail-oi1-x241.google.com with SMTP id c206so15920382oib.0
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20190124141147.8416-1-stefanha@redhat.com>
	<CAFEAcA_NBtWFZi8G8goXrX0OHHeHheW6MK3W9ByHVi1DNX3JWw@mail.gmail.com>
In-Reply-To: <CAFEAcA_NBtWFZi8G8goXrX0OHHeHheW6MK3W9ByHVi1DNX3JWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 11:45:42 +0000
Message-ID: <CAFEAcA_jJCXjt8y7G-LBTxMS1OFJYZs-jjYZW0F26FFnZshAhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/microbit-test: Add tests for nRF51
 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Mon, 28 Jan 2019 at 19:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> This assertion fails on PPC64 hosts:
> ERROR:/home/pm215/qemu/tests/microbit-test.c:181:fill_and_erase:
> assertion failed (qtest_readl(qts, base + i * 4) == i): (16777216 ==
> 1)

For the moment I have dropped patches
 hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
 arm: Instantiate NRF51 special NVM's and NVMC
 tests/microbit-test: Add tests for nRF51 NVMC
from target-arm.next (but have kept
 memory: add memory_region_flush_rom_device()
from the nvmc series).

thanks
-- PMM
