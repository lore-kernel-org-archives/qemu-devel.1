Received: from eggs.gnu.org ([2001:4830:134:3::10]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhlj-0001ka-4x
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhli-0000Ki-As
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:40:03 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhli-0000KA-6C
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:40:02 -0500
Received: by mail-ot0-x243.google.com with SMTP id s3so2925524otc.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:40:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-6-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:39:40 +0000
Message-ID: <CAFEAcA8+fQ7QiygiM0C5kgesNSpiFnJDCjnAyjAtm=zt2cRnAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Add
 aa32_vfp_dreg/aa64_vfp_qreg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Helpers that return a pointer into env->vfp.regs so that we isolate
> the logic of how to index the regs array for different cpu modes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 20 +++++++++++++++++++-
>  linux-user/signal.c        | 22 ++++++++++++----------
>  target/arm/arch_dump.c     |  8 +++++---
>  target/arm/helper-a64.c    | 13 +++++++------
>  target/arm/helper.c        | 32 ++++++++++++++++++++------------
>  target/arm/kvm32.c         |  4 ++--
>  target/arm/kvm64.c         | 31 ++++++++++---------------------
>  target/arm/machine.c       |  2 +-
>  target/arm/translate-a64.c | 25 ++++++++-----------------
>  target/arm/translate.c     | 16 +++++++++-------
>  10 files changed, 93 insertions(+), 80 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 7a705a09a1..e1a8e2880d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -493,7 +493,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explicitly
>           * map these registers when changing states.
>           */
> -        float64 regs[64] QEMU_ALIGNED(16);
> +        uint64_t regs[64] QEMU_ALIGNED(16);

Why are we changing the type of this field ?

thanks
-- PMM
