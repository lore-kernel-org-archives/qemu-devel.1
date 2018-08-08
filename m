Received: from eggs.gnu.org ([2001:4830:134:3::10]:44346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnKVN-0000VU-9Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnKVM-0007XO-Bt
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:11:45 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnKVM-0007WY-5o
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:11:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id f21-v6so1920880wmc.5
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 02:11:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-5-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-5-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Aug 2018 10:11:42 +0100
Message-ID: <CAJSP0QUkW2A7pWb6zVAZGQk-y6YGsxwicBW4nuhHWPf8yL2_6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] hw/gpio/nrf51_gpio: Add nRF51 GPIO
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> This adds a model of the nRF51 GPIO peripheral.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> The nRF51 series microcontrollers support up to 32 GPIO pins in various c=
onfigurations.
> The pins can be used as input pins with pull-ups or pull-down.
> Furthermore, three different output driver modes per level are
> available (disconnected, standard, high-current).
>
> The GPIO-Peripheral has a mechanism for detecting level changes which is
> not featured in this model.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  Makefile.objs                |   1 +
>  hw/gpio/Makefile.objs        |   1 +
>  hw/gpio/nrf51_gpio.c         | 305 +++++++++++++++++++++++++++++++++++
>  hw/gpio/trace-events         |   7 +
>  include/hw/gpio/nrf51_gpio.h |  57 +++++++
>  5 files changed, 371 insertions(+)
>  create mode 100644 hw/gpio/nrf51_gpio.c
>  create mode 100644 hw/gpio/trace-events
>  create mode 100644 include/hw/gpio/nrf51_gpio.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
