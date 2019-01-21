Received: from eggs.gnu.org ([209.51.188.92]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcK5-0004Bx-3Q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcK4-0006Ko-92
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:21:17 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glcK4-0006Jc-3b
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:21:16 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so21003952otl.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 08:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20190110094020.18354-1-stefanha@redhat.com>
In-Reply-To: <20190110094020.18354-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 16:21:03 +0000
Message-ID: <CAFEAcA8bz7ViuZeZqCBZHy49=dbYxW7Q04MbuVKapEfT5K56ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] arm: Stub out NRF51 TWI
 magnetometer/accelerometer detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>

On Thu, 10 Jan 2019 at 09:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> v2:
>  * Move stub code into a separate device [Peter]
>  * Instantiate stub from microbit board instead of nRF51 SoC since this i=
s
>    microbit-specific.  Other boards using the nRF51 wouldn't necessarily =
want
>    to see these TWI/I2C devices.
>  * Add test case
>
> This series stubs out the microbit's TWI/I2C devices so the microbit-dal
> firmware boots successfully.  The accelerometer and magnetometer are prob=
ed at
> startup.  If they are not found the firmware panics.
>
> Stefan Hajnoczi (1):
>   tests/microbit-test: add TWI stub device test
>
> Steffen G=C3=B6rtz (1):
>   arm: Stub out NRF51 TWI magnetometer/accelerometer detection
>
>  hw/i2c/Makefile.objs          |   1 +
>  include/hw/arm/nrf51.h        |   2 +
>  include/hw/arm/nrf51_soc.h    |   1 +
>  include/hw/i2c/microbit_i2c.h |  42 +++++++++++
>  hw/arm/microbit.c             |  15 ++++
>  hw/i2c/microbit_i2c.c         | 127 ++++++++++++++++++++++++++++++++++
>  tests/microbit-test.c         |  44 ++++++++++++
>  7 files changed, 232 insertions(+)
>  create mode 100644 include/hw/i2c/microbit_i2c.h
>  create mode 100644 hw/i2c/microbit_i2c.c

Applied to target-arm.next, thanks. Can you provide a
MAINTAINERS file update for the new files, please?
(You can send that separately or stick it in another
nrf51 series if you're sending one.)

thanks
-- PMM
