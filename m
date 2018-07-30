Received: from eggs.gnu.org ([2001:4830:134:3::10]:57642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkBzF-0006jZ-Ts
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkBzF-0005NT-1e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:29:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkBzE-0005NK-RB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:29:36 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so22736233oiw.8
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-3-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:29:15 +0100
Message-ID: <CAFEAcA-i3PepdAJzDViGHjgDPWTTLiqmGMszNeT41+MmjK-viA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] hw/arm: rename TYPE_ARMV7M to
 TYPE_ARM_M_PROFILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Alistair Francis <alistair@alistair23.me>, Liviu Ionescu <ilg@livius.net>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The TYPE_ARMV7M class is really a container for an ARM M Profile CPU,
> NVIC, and related pieces.  It can also be used for ARMv6-M and ARMv8-M.
> Rename the class since it is not exclusive to ARMv7-M.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/Makefile.objs                         |   1 -
>  include/hw/arm/{armv7m.h => arm-m-profile.h} |  37 ++-
>  include/hw/arm/iotkit.h                      |   4 +-
>  include/hw/arm/msf2-soc.h                    |   4 +-
>  include/hw/arm/stm32f205_soc.h               |   4 +-
>  hw/arm/arm-m-profile.c                       | 271 +++++++++++++++++
>  hw/arm/armv7m.c                              | 290 -------------------
>  hw/arm/iotkit.c                              |   2 +-
>  hw/arm/mps2-tz.c                             |   1 -
>  hw/arm/mps2.c                                |   6 +-
>  hw/arm/msf2-soc.c                            |   2 +-
>  hw/arm/stellaris.c                           |   4 +-
>  hw/arm/stm32f205_soc.c                       |   2 +-
>  13 files changed, 313 insertions(+), 315 deletions(-)
>  rename include/hw/arm/{armv7m.h => arm-m-profile.h} (65%)
>  delete mode 100644 hw/arm/armv7m.c

It would be nice if this rename showed up in the patch as
a rename, rather than a "delete everything and have a new one"...
Reviewing this is going to be painful enough to make me wonder
whether it really matters that we call this "m-profile" rather
than "v7m" (we have a lot of places that use 'v7m' as a somewhat
inaccurate name for "M profile" anyway, including a bunch
of new code I wrote that's really v8m related.)

thanks
-- PMM
