Received: from eggs.gnu.org ([209.51.188.92]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL57J-00037W-Kd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL57I-000295-N4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL57I-00028A-I2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:10:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id v23so7898037oif.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
In-Reply-To: <CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:10:28 +0100
Message-ID: <CAFEAcA-7dLEsyhtyNatVYCpsptOB7ZXUYbxPrdXJwdAnHQ714A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed: cleanups and extenstions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On Mon, 29 Apr 2019 at 13:07, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 11 Apr 2019 at 17:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > Hello,
> >
> > Here is a series adding a couple of cleanups to the Aspeed SoCs to
> > prepare ground for extensions and new SoCs.
> >
> > Thanks,
> >
> > C.
> >
> > C=C3=A9dric Le Goater (3):
> >   aspeed: add a per SoC mapping for the interrupt space
> >   aspeed: add a per SoC mapping for the memory space
> >   aspeed: use sysbus_init_child_obj() to initialize children
> >
>
>
>
> Applied to target-arm.next, thanks.

...spoke too soon. Clang doesn't like this:

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/aspeed_soc.c:155:25:
error: initializer element is not a
      compile-time constant
        .sdram_base   =3D aspeed_soc_ast2400_memmap[ASPEED_SDRAM],
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
/home/petmay01/linaro/qemu-from-laptop/qemu/rules.mak:69: recipe for
target 'hw/arm/aspeed_soc.o' failed

thanks
-- PMM
