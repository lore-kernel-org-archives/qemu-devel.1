Received: from eggs.gnu.org ([2001:4830:134:3::10]:58164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkC0C-00084c-Al
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkC0B-0005ow-GE
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:30:36 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkC0B-0005oV-B2
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:30:35 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so22720776oib.9
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:30:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-2-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:30:14 +0100
Message-ID: <CAFEAcA9M=yy=Cu5pgcVkeBsS_pRmW9dKEV==t2Jd67d2k6gp7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/7] hw/arm: rename armv7m_load_kernel()
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
> ARMv6-M and ARMv8-M need the same kernel loading functionality as
> ARMv7-M.  Rename armv7m_load_kernel() to arm_m_profile_load_kernel() so
> it's clear that this function isn't specific to ARMv7-M.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/Makefile.objs            |  1 +
>  include/hw/arm/arm.h            | 11 +++--
>  hw/arm/arm-m-profile.c          | 81 +++++++++++++++++++++++++++++++++
>  hw/arm/armv7m.c                 | 60 ------------------------
>  hw/arm/mps2-tz.c                |  3 +-
>  hw/arm/mps2.c                   |  4 +-
>  hw/arm/msf2-som.c               |  4 +-
>  hw/arm/netduino2.c              |  4 +-
>  hw/arm/stellaris.c              |  3 +-
>  default-configs/arm-softmmu.mak |  1 +
>  10 files changed, 99 insertions(+), 73 deletions(-)
>  create mode 100644 hw/arm/arm-m-profile.c

Another rename that shows up in the patch as "delete the old
one and have a copy somewhere else". Maybe this can be fixed
with suitable git rename-detection options?

thanks
-- PMM
