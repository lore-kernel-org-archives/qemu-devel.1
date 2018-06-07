Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuZ2-0005VK-0I
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQuZ1-0000eZ-2w
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:02:52 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQuZ0-0000e4-Sd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:02:51 -0400
Received: by mail-ot0-x243.google.com with SMTP id l15-v6so10382593oth.6
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 06:02:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606191801.6331-1-f4bug@amsat.org>
References: <20180606191801.6331-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 14:02:29 +0100
Message-ID: <CAFEAcA9mDByYZixijY8OwbgJQpsh5TztGcJhAyaNFxE_X6o7mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i2c: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Corey Minyard <cminyard@mvista.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Linus Walleij <linus.walleij@linaro.org>

On 6 June 2018 at 20:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> $ qemu-system ... -d trace:i2c_recv,trace:i2c_send
>
> 4486@1528311614.709959:i2c_recv recv(addr:0x50) data:0x00
> 4486@1528311614.709994:i2c_send send(addr:0x50) data:0x05
> 4486@1528311614.710060:i2c_recv recv(addr:0x50) data:0x02
> 4486@1528311614.710161:i2c_recv recv(addr:0x50) data:0x40
> 4486@1528311614.710185:i2c_send send(addr:0x50) data:0x02
> 4486@1528311614.710233:i2c_recv recv(addr:0x50) data:0x08
> 4486@1528311614.710380:i2c_recv recv(addr:0x50) data:0x0d
> 4486@1528311614.710396:i2c_send send(addr:0x50) data:0x1f
> 4486@1528311614.710437:i2c_recv recv(addr:0x50) data:0x40
>
> or
>
> $ qemu-system ... -d trace:i2c\*
>
> 4486@1528311614.698315:i2c_event start(addr:0x50)
> 4486@1528311614.698338:i2c_recv recv(addr:0x50) data:0x82
> 4486@1528311614.698349:i2c_event finish(addr:0x50)
> 4486@1528311614.698354:i2c_event start(addr:0x50)
> 4486@1528311614.698357:i2c_send send(addr:0x50) data:0x11
> 4486@1528311614.698377:i2c_event finish(addr:0x50)
> 4486@1528311614.698380:i2c_event start(addr:0x50)
> 4486@1528311614.698402:i2c_recv recv(addr:0x50) data:0x04
> 4486@1528311614.698485:i2c_event finish(addr:0x50)
>
>  Makefile.objs       |  1 +
>  hw/i2c/core.c       | 25 ++++++++++++++++++-------
>  hw/i2c/trace-events |  7 +++++++
>  3 files changed, 26 insertions(+), 7 deletions(-)
>  create mode 100644 hw/i2c/trace-events



Applied to target-arm.next, thanks.

-- PMM
