Received: from eggs.gnu.org ([209.51.188.92]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1It-0008Pb-0A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Is-00051h-8z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:42 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1Is-0004zh-41
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:01:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so24693163otj.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:01:38 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1544173675-14217-3-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 11:49:44 +0000
Message-ID: <CAFEAcA9mF+WiPLW4yyv1aEMLTg2QK2krZvxyjCSsMziJtzx3Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] hw/arm: add Arm SBSA reference
 machine, devices part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Fri, 7 Dec 2018 at 09:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> Following the previous patch, this patch adds peripheral devices to the
> newly introduced SBSA-ref machine.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 421 insertions(+)

Most of this code looks good, thanks.

> +
> +static void sbsa_ref_machine_done(Notifier *notifier, void *data)
> +{
> +    VirtMachineState *vms = container_of(notifier, VirtMachineState,
> +                                         machine_done);
> +    ARMCPU *cpu = ARM_CPU(first_cpu);
> +    struct arm_boot_info *info = &vms->bootinfo;
> +    AddressSpace *as = arm_boot_address_space(cpu, info);
> +
> +    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
> +        exit(1);
> +    }
> +}

I still don't understand why we need this -- it doesn't seem
to be doing anything different from the default behaviour that
boot.c implements if skip_dtb_autoload is false.

thanks
-- PMM
