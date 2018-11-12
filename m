Received: from eggs.gnu.org ([2001:4830:134:3::10]:37237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzvG-0003Md-5d
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzvC-00078u-3d
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:17:45 -0500
MIME-Version: 1.0
References: <20181106164118.16184-1-peter.maydell@linaro.org>
In-Reply-To: <20181106164118.16184-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 01:17:06 +0100
Message-ID: <CAAdtpL5vyvWOdh0FCgaJAmCgKhf0SLEU8jFo+2_qzAFh-26AoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.1] target/arm: Remove
 antique TODO comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Tue, Nov 6, 2018 at 5:41 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> Remove a TODO comment about implementing the vectored interrupt
> controller. We have had an implementation of that for a decade;
> it's in hw/intc/pl190.c.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

On Fri, Nov 9, 2018 at 2:49 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> Currently we track the state of the four irq lines from the GIC
> only via the cs->interrupt_request or KVM irq state. That means
> that we assume that an interrupt is asserted if and only if the
> external line is set. This assumption is incorrect for VIRQ
> and VFIQ, because the HCR_EL2.{VI,VF} bits allow assertion
> of VIRQ and VFIQ separately from the state of the external line.
>
> To handle this, start tracking the state of the external lines
> explicitly in a CPU state struct field, as is common practice
> for devices.
>
> The complicated part of this is dealing with inbound migration
> from an older QEMU which didn't have this state. We assume in
> that case that the older QEMU did not implement the HCR_EL2.{VI,VF}
> bits as generating interrupts, and so the line state matches
> the current state in cs->interrupt_request. (This is not quite
> true between commit 8a0fc3a29fc2315325400c7 and its revert, but
> that commit is broken and never made it into any released QEMU
> version.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ec56becc394..851ea9aa977 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8378,7 +8378,6 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *=
cs)
>          return;
>      }
>
> -    /* TODO: Vectored interrupt controller.  */
>      switch (cs->exception_index) {
>      case EXCP_UDEF:
>          new_mode =3D ARM_CPU_MODE_UND;
> --
> 2.19.1
>
>
