Received: from eggs.gnu.org ([2001:4830:134:3::10]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ey4yq-0001jC-43
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ey4yo-0007qH-Sr
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:18:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180319110215.16755-1-peter.maydell@linaro.org>
References: <20180319110215.16755-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Mar 2018 10:17:43 +1000
Message-ID: <CAKmqyKOO8AJooAj4V8zyuAOA-w76kFoMLee4Q6_knCTwtCCpEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/arm/bcm2836: Use the Cortex-A7
 instead of Cortex-A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Patch Tracking <patches@linaro.org>

n Mon, Mar 19, 2018 at 9:02 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The BCM2836 uses a Cortex-A7, not a Cortex-A15. Update the device to
> use the correct CPU.
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2836/QA7_rev3.4.pdf
>
> When the BCM2836 was introduced (bad5623690b) the Cortex-A7 was not
> available, so the very similar Cortex-A15 was used. Since dcf578ed8ce
> we can model the correct core.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> This was originally done by a patch from Alistair:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg00311.html
>
> The refactor of bcm2836 means the code is different, but I'm using
> the same commit message.
>
> Based-on: <20180313153458.26822-1-peter.maydell@linaro.org>
>
> ---
>  hw/arm/bcm2836.c | 2 +-
>  hw/arm/raspi.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 25e74b67d9..8c1e707d9c 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -32,7 +32,7 @@ struct BCM283XInfo {
>  static const BCM283XInfo bcm283x_socs[] = {
>      {
>          .name = TYPE_BCM2836,
> -        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a15"),
> +        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
>          .clusterid = 0xf,
>      },
>      {
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 06f1e08ca9..955a7c4e80 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -226,7 +226,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_parallel = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
>      mc->max_cpus = BCM283X_NCPUS;
>      mc->min_cpus = BCM283X_NCPUS;
>      mc->default_cpus = BCM283X_NCPUS;
> --
> 2.16.2
>
>
