Received: from eggs.gnu.org ([2001:4830:134:3::10]:37015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl7M-0008ET-4M
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl7L-0007BO-9p
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:54:12 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSl7L-0007B6-3a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:54:11 -0500
Received: by mail-oi1-x241.google.com with SMTP id h25so5120004oig.1
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:54:10 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-9-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-9-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:53:59 +0000
Message-ID: <CAFEAcA91j803VhAKrey3pvHC+L139EGVvkN1rULbUD-JAFWBdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 8/9] hw/misc/pvpanic: realize the
 configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 03:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Add configure interface for pvpanic-mmio. In qemu command line
> use -device pvpanic-mmio to enable the device.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/arm/virt-acpi-build.c | 5 ++++-
>  hw/arm/virt.c            | 7 +++----
>  hw/misc/pvpanic.c        | 1 +
>  3 files changed, 8 insertions(+), 5 deletions(-)


> @@ -1330,6 +1328,9 @@ void virt_machine_done(Notifier *notifier, void *data)
>      struct arm_boot_info *info = &vms->bootinfo;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
>
> +    if (pvpanic_mmio()) {
> +        create_pvpanic_device(vms);
> +    }
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes
>       * already are integrated there. This corresponds to a use case where
> @@ -1551,8 +1552,6 @@ static void machvirt_init(MachineState *machine)
>
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>
> -    create_pvpanic_device(vms);
> -

Please don't make changes in on patch of a patchset
and then undo them in a later patch. It makes the
patchset harder to read and review.

thanks
-- PMM
