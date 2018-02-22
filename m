Received: from eggs.gnu.org ([2001:4830:134:3::10]:41410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopLJ-00014C-J5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eopLI-00069m-Py
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:47:17 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eopLI-00069L-JX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:47:16 -0500
Received: by mail-oi0-x233.google.com with SMTP id b8so3473525oib.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 03:47:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216022933.10945-6-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
	<20180216022933.10945-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 11:46:55 +0000
Message-ID: <CAFEAcA_9L=FZoyvHpOPQH=kA36=W2ZAx7RukJb3_S0Vr0TNt2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 5/7] hw/sd/pl181: expose a SDBus and
 connect the SDCard to it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>, "open list:ARM PrimeCell and..." <qemu-arm@nongnu.org>

On 16 February 2018 at 02:29, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> using the sdbus_*() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>
> RFC because how pl181_sdbus_create_inplace() doing class_init(SDBus) in
> realize(pl181) seems weird...

In the two other places where we set the set_inserted and set_readonly
methods for the SDBus class (pxa2xx_mmci.c and sdhci.c), we do it by
defining a subclass of TYPE_SD_BUS, whose class init function can then
set up the method pointers. Is there a reason not to do pl181 the
same way as those two examples?

thanks
-- PMM
