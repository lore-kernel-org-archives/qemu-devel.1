Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA44C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ED422BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeoZZ+a8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ED422BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6uX-0001LX-IL
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 16:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hr6uI-0000wD-U8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hr6uD-0003UT-DV
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:33:37 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hr6uC-0003RU-Tb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 16:33:33 -0400
Received: by mail-lf1-x143.google.com with SMTP id p197so37903680lfa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SoIC57zXjUNun4Tb2afLXE/MLWf6WEfKBF1pIQt6Rek=;
 b=MeoZZ+a8I3mY0kQKtkoL1H7hJ98p+ezgGYpvfHZwOdyiaT/UzArXVtLe2swNfhnfuD
 SXFIq/BOZzz/Kr4OtftkGTj6aqq47ZZFxZo2N46CthAkuvtz7wV7ch4/22WKGjmtuTPk
 loNnIFlNcZzTfXv4RYAI1bC2g+ZJTzzsTDbY4MvyrbNBiociYMvJtninKlytv5bXAzla
 QWRvPt/dE9CGSitd4BPLU4PcTaoscdO2rLLtRISAKxDn9u1+zvNOt4qHsBuUaHFfaCGO
 6iJUQcVEEU0sM30fZMUPJLUgWr4h1HranyYBSjxllUssguiHN40YqBlYHV3Tm1X+uHGx
 XIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoIC57zXjUNun4Tb2afLXE/MLWf6WEfKBF1pIQt6Rek=;
 b=ijr/mUnDFKf9219rdRrQ3hsV1i0xfMho7ORG6/+AtMCdKMZEgM71ROsUypnrwZn4X5
 XcG0Ivcihb+Nllhyz3C8TDhBL6WXy72/lSYCSKWQkwu7O32OPy6TnxLmTb+wUo+L0c1K
 M4gf1okswakyAmC3JsD+OvU4DJve3DPxwARDlM2bFINNgAC/OCLSgC3ryOhL+maO+W/S
 +7sq0PriBmX7Tkyd1/B0MKSSzDXu053TrDzJL4+TKaK5C0jho7P6qDLyPdSsRsdPRSLl
 Hews/E8H3yRZmZaSzX4b0ENoVsl8O/XjOl6pfN2CuTknNp/PiPHKpiTIWR+h3z8n3pIo
 VZrQ==
X-Gm-Message-State: APjAAAUE4e8Q2iuQ9AWFWORiH6ULQMuIzKNvLNnL1uc/AS1OAMRxw/BX
 Zm0EKFAr112QKInwBzizOREZr/BJfXcexAznfuY=
X-Google-Smtp-Source: APXvYqxGyvx7d5gx4B1hW3B7uSBJJLxfuxUY89tDIzWcIVH01AOlT2NVQ9fmZ/9YsDFOmAwWkc+mrbkTlXs6yQj5/I4=
X-Received: by 2002:a19:7709:: with SMTP id s9mr42809248lfc.86.1564173211281; 
 Fri, 26 Jul 2019 13:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-23-armbru@redhat.com>
In-Reply-To: <20190726120542.9894-23-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jul 2019 13:29:58 -0700
Message-ID: <CAKmqyKMbWCJKPpucLMV3VQuUz2uLCy+j3dPG+R4HqCuKeVj=AQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 22/28] Include hw/boards.h a bit less
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 5:10 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> hw/boards.h pulls in almost 60 headers.  The less we include it into
> headers, the better.  As a first step, drop superfluous inclusions,
> and downgrade some more to what's actually needed.  Gets rid of just
> one inclusion into a header.
>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  backends/cryptodev-builtin.c    | 1 -
>  backends/cryptodev-vhost-user.c | 1 -
>  backends/cryptodev.c            | 1 -
>  exec.c                          | 1 -
>  hw/acpi/cpu.c                   | 1 -
>  hw/acpi/ich9.c                  | 1 +
>  hw/acpi/memory_hotplug.c        | 1 -
>  hw/alpha/dp264.c                | 1 -
>  hw/alpha/typhoon.c              | 1 +
>  hw/arm/boot.c                   | 1 -
>  hw/arm/exynos4210.c             | 2 +-
>  hw/arm/fsl-imx25.c              | 1 -
>  hw/arm/fsl-imx31.c              | 1 -
>  hw/arm/msf2-soc.c               | 1 -
>  hw/arm/nrf51_soc.c              | 1 -
>  hw/arm/omap1.c                  | 1 +
>  hw/arm/omap2.c                  | 1 +
>  hw/arm/smmuv3.c                 | 1 -
>  hw/arm/virt.c                   | 1 +
>  hw/core/machine-qmp-cmds.c      | 1 -
>  hw/core/machine.c               | 1 -
>  hw/core/numa.c                  | 2 ++
>  hw/i386/intel_iommu.c           | 1 -
>  hw/i386/pc_piix.c               | 1 -
>  hw/i386/pc_q35.c                | 1 -
>  hw/i386/pc_sysfw.c              | 1 -
>  hw/i386/x86-iommu.c             | 1 -
>  hw/ppc/e500plat.c               | 1 -
>  hw/ppc/mpc8544ds.c              | 1 -
>  hw/ppc/pnv.c                    | 1 +
>  hw/ppc/ppc405_uc.c              | 1 -
>  hw/ppc/spapr_cpu_core.c         | 1 -
>  hw/ppc/spapr_rtas.c             | 1 -
>  hw/ppc/spapr_vio.c              | 1 -
>  hw/riscv/boot.c                 | 2 +-
>  hw/s390x/s390-stattrib-kvm.c    | 1 -
>  hw/s390x/s390-stattrib.c        | 1 -
>  hw/xtensa/xtensa_memory.c       | 1 -
>  include/hw/mem/pc-dimm.h        | 1 -
>  monitor/qmp-cmds.c              | 1 -
>  target/alpha/machine.c          | 1 -
>  target/arm/kvm.c                | 1 -
>  target/arm/machine.c            | 1 -
>  target/arm/monitor.c            | 1 -
>  target/hppa/machine.c           | 1 -
>  target/i386/hax-all.c           | 1 -
>  target/i386/hvf/hvf.c           | 1 -
>  target/i386/hvf/x86_task.c      | 1 -
>  target/i386/machine.c           | 1 -
>  target/i386/whpx-all.c          | 1 -
>  target/lm32/machine.c           | 1 -
>  target/moxie/machine.c          | 1 -
>  target/openrisc/machine.c       | 1 -
>  target/ppc/machine.c            | 1 -
>  target/sparc/machine.c          | 1 -
>  55 files changed, 10 insertions(+), 48 deletions(-)
>
> diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
> index 9fb0bd57a6..c8ae3b9742 100644
> --- a/backends/cryptodev-builtin.c
> +++ b/backends/cryptodev-builtin.c
> @@ -23,7 +23,6 @@
>
>  #include "qemu/osdep.h"
>  #include "sysemu/cryptodev.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "standard-headers/linux/virtio_crypto.h"
>  #include "crypto/cipher.h"
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index 1052a5d0e9..b344283940 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -22,7 +22,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index f35be377ef..3c071eab95 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -23,7 +23,6 @@
>
>  #include "qemu/osdep.h"
>  #include "sysemu/cryptodev.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qemu/config-file.h"
> diff --git a/exec.c b/exec.c
> index 78f849de99..6d60fdfb1f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -29,7 +29,6 @@
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
>  #if !defined(CONFIG_USER_ONLY)
> -#include "hw/boards.h"
>  #include "hw/xen/xen.h"
>  #endif
>  #include "sysemu/kvm.h"
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 87f30a31d7..d8e531ad64 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -1,5 +1,4 @@
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "migration/vmstate.h"
>  #include "hw/acpi/cpu.h"
>  #include "qapi/error.h"
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 39649cbe6a..c1aaa07d43 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -31,6 +31,7 @@
>  #include "hw/pci/pci.h"
>  #include "migration/vmstate.h"
>  #include "qemu/timer.h"
> +#include "qom/cpu.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/acpi/acpi.h"
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 9483d66e86..b413f491ee 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -2,7 +2,6 @@
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/pc-hotplug.h"
>  #include "hw/mem/pc-dimm.h"
> -#include "hw/boards.h"
>  #include "hw/qdev-core.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 546b89bbcc..51feee8558 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -11,7 +11,6 @@
>  #include "cpu.h"
>  #include "elf.h"
>  #include "hw/loader.h"
> -#include "hw/boards.h"
>  #include "alpha_sys.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 5d7f8f3342..1c0565acc1 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -11,6 +11,7 @@
>  #include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "hw/boards.h"
>  #include "hw/irq.h"
>  #include "sysemu/sysemu.h"
>  #include "alpha_sys.h"
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c9e1e844b8..e1640c4e62 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -18,7 +18,6 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> -#include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "sysemu/device_tree.h"
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index 0e403f3e78..a9f8a5c868 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -27,7 +27,7 @@
>  #include "cpu.h"
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/irq.h"
> -#include "hw/boards.h"
> +#include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/boot.h"
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 098e84c84d..532d088298 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -28,7 +28,6 @@
>  #include "hw/arm/fsl-imx25.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> -#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "chardev/char.h"
>
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index 093ad40984..1a37a7b997 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -25,7 +25,6 @@
>  #include "hw/arm/fsl-imx31.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> -#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "chardev/char.h"
>
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 4e5251c92e..8ae763f99f 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -28,7 +28,6 @@
>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
>  #include "hw/irq.h"
> -#include "hw/boards.h"
>  #include "hw/arm/msf2-soc.h"
>  #include "hw/misc/unimp.h"
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index fc067cd8ee..d9e54fefbb 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -12,7 +12,6 @@
>  #include "qapi/error.h"
>  #include "hw/arm/boot.h"
>  #include "hw/sysbus.h"
> -#include "hw/boards.h"
>  #include "hw/misc/unimp.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 19fca4159a..d28ad2b9ff 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -29,6 +29,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/arm/boot.h"
>  #include "hw/arm/omap.h"
> +#include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/soc_dma.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index dccb5707f8..e0a9c2da83 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -22,6 +22,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "sysemu/blockdev.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/reset.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0634a398d2..0ccc772390 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -17,7 +17,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "hw/irq.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e9fddec058..226e810d06 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -34,6 +34,7 @@
>  #include "qemu/option.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> +#include "hw/boards.h"
>  #include "hw/arm/boot.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/arm/virt.h"
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index d8284671f0..c83e8954e1 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -9,7 +9,6 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c58a8e594e..2c9c93983a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -15,7 +15,6 @@
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/replay.h"
>  #include "qemu/units.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "qapi/visitor.h"
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 67548064ee..d817f06ead 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -32,8 +32,10 @@
>  #include "qapi/opts-visitor.h"
>  #include "qapi/qapi-visit-machine.h"
>  #include "sysemu/qtest.h"
> +#include "qom/cpu.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "migration/vmstate.h"
> +#include "hw/boards.h"
>  #include "hw/mem/memory-device.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 75ca6f9c70..6c5cd306fc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -31,7 +31,6 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic-msidef.h"
> -#include "hw/boards.h"
>  #include "hw/i386/x86-iommu.h"
>  #include "hw/pci-host/q35.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2fbb581c46..9e187f856a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -35,7 +35,6 @@
>  #include "hw/pci/pci_ids.h"
>  #include "hw/usb.h"
>  #include "net/net.h"
> -#include "hw/boards.h"
>  #include "hw/ide.h"
>  #include "hw/irq.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8777c9618b..be3464f485 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -33,7 +33,6 @@
>  #include "hw/loader.h"
>  #include "sysemu/arch_init.h"
>  #include "hw/i2c/smbus_eeprom.h"
> -#include "hw/boards.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/xen/xen.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 235928452b..a9983f0bfb 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -32,7 +32,6 @@
>  #include "qemu/units.h"
>  #include "hw/sysbus.h"
>  #include "hw/i386/pc.h"
> -#include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 1eaf2dd1bc..a621f30f5b 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -19,7 +19,6 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "hw/boards.h"
>  #include "hw/i386/x86-iommu.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/i386/pc.h"
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 2b82a58592..7078386300 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -13,7 +13,6 @@
>  #include "qemu/units.h"
>  #include "e500.h"
>  #include "hw/net/fsl_etsec/etsec.h"
> -#include "hw/boards.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/kvm.h"
>  #include "hw/sysbus.h"
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 6a4657c3cd..c2c5e11fa1 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -11,7 +11,6 @@
>
>  #include "qemu/osdep.h"
>  #include "e500.h"
> -#include "hw/boards.h"
>  #include "sysemu/device_tree.h"
>  #include "hw/ppc/openpic.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index cf31830655..fc7d24830a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -45,6 +45,7 @@
>  #include "hw/ppc/pnv_xscom.h"
>
>  #include "hw/isa/isa.h"
> +#include "hw/boards.h"
>  #include "hw/char/serial.h"
>  #include "hw/timer/mc146818rtc.h"
>
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index ba092f2931..381720aced 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -27,7 +27,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "hw/ppc/ppc.h"
> -#include "hw/boards.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
>  #include "hw/irq.h"
>  #include "ppc405.h"
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 920bc365ef..bf47fbdf6f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -14,7 +14,6 @@
>  #include "migration/vmstate.h"
>  #include "target/ppc/cpu.h"
>  #include "hw/ppc/spapr.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "sysemu/cpus.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 558d702833..5fdd4b90e9 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -39,7 +39,6 @@
>  #include "hw/ppc/spapr_rtas.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/ppc.h"
> -#include "hw/boards.h"
>
>  #include <libfdt.h>
>  #include "hw/ppc/spapr_drc.h"
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 31ff0be189..910c57fce5 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -26,7 +26,6 @@
>  #include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/sysbus.h"
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 5dee63011b..84847a79e2 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -22,9 +22,9 @@
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "exec/cpu-defs.h"
> +#include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/riscv/boot.h"
> -#include "hw/boards.h"
>  #include "elf.h"
>
>  #if defined(TARGET_RISCV32)
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index c7e1f35524..947b8df8ff 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -10,7 +10,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "migration/qemu-file.h"
>  #include "hw/s390x/storage-attributes.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 766f2015a4..eda5ca3bb6 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -11,7 +11,6 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> -#include "hw/boards.h"
>  #include "cpu.h"
>  #include "migration/qemu-file.h"
>  #include "migration/register.h"
> diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
> index 394d0cf227..40334db441 100644
> --- a/hw/xtensa/xtensa_memory.c
> +++ b/hw/xtensa/xtensa_memory.c
> @@ -29,7 +29,6 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/boards.h"
>  #include "exec/memory.h"
>  #include "qemu/error-report.h"
>  #include "xtensa_memory.h"
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 66dee284ac..47b246f95c 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -19,7 +19,6 @@
>  #include "exec/memory.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/qdev-core.h"
> -#include "hw/boards.h"
>
>  #define TYPE_PC_DIMM "pc-dimm"
>  #define PC_DIMM(obj) \
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index b9ae40eec7..330558f332 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -35,7 +35,6 @@
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-ui.h"
>  #include "qapi/qmp/qerror.h"
> -#include "hw/boards.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/acpi/acpi_dev_interface.h"
>
> diff --git a/target/alpha/machine.c b/target/alpha/machine.c
> index c288be89f7..a09d754bbf 100644
> --- a/target/alpha/machine.c
> +++ b/target/alpha/machine.c
> @@ -1,6 +1,5 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "migration/cpu.h"
>  #include "migration/vmstate.h"
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 36a1e60bd4..d81aa5a8eb 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -26,7 +26,6 @@
>  #include "hw/pci/pci.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
> -#include "hw/boards.h"
>  #include "hw/irq.h"
>  #include "qemu/log.h"
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 60e0627b89..ac28c0615a 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -1,6 +1,5 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index 6ec6dd04ac..6457c3c87f 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -21,7 +21,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/boards.h"
>  #include "kvm_arm.h"
>  #include "qapi/qapi-commands-misc-target.h"
>
> diff --git a/target/hppa/machine.c b/target/hppa/machine.c
> index 092f8b5bfd..e3b6608cf2 100644
> --- a/target/hppa/machine.c
> +++ b/target/hppa/machine.c
> @@ -19,7 +19,6 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "migration/cpu.h"
>  #include "migration/vmstate.h"
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index bcacdd1d8f..34a9f6f7a9 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -33,7 +33,6 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/main-loop.h"
> -#include "hw/boards.h"
>
>  #define DEBUG_HAX 0
>
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index dc4bb63536..6863cf2de4 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -66,7 +66,6 @@
>
>  #include "exec/address-spaces.h"
>  #include "hw/i386/apic_internal.h"
> -#include "hw/boards.h"
>  #include "qemu/main-loop.h"
>  #include "sysemu/accel.h"
>  #include "sysemu/sysemu.h"
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index 7099335e89..73cd5d2817 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -27,7 +27,6 @@
>  #include <Hypervisor/hv_vmx.h>
>
>  #include "hw/i386/apic_internal.h"
> -#include "hw/boards.h"
>  #include "qemu/main-loop.h"
>  #include "sysemu/accel.h"
>  #include "sysemu/sysemu.h"
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index dd5a72ba00..ff0d33b9db 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -1,7 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "hw/boards.h"
>  #include "hw/i386/pc.h"
>  #include "hw/isa/isa.h"
>  #include "migration/cpu.h"
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 2cf66f7804..b57d1c6683 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -18,7 +18,6 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/cpus.h"
>  #include "qemu/main-loop.h"
> -#include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> diff --git a/target/lm32/machine.c b/target/lm32/machine.c
> index 18a1820f22..c6d82a4cfe 100644
> --- a/target/lm32/machine.c
> +++ b/target/lm32/machine.c
> @@ -1,6 +1,5 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "migration/cpu.h"
>  #include "migration/vmstate.h"
>
> diff --git a/target/moxie/machine.c b/target/moxie/machine.c
> index e6f639ee97..37b15e6d60 100644
> --- a/target/moxie/machine.c
> +++ b/target/moxie/machine.c
> @@ -1,6 +1,5 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "machine.h"
>  #include "migration/cpu.h"
>  #include "migration/vmstate.h"
> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index a7bfbbe3b2..296dc70a92 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -19,7 +19,6 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/boards.h"
>  #include "migration/cpu.h"
>  #include "migration/vmstate.h"
>
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 74e003cf46..7846c09e71 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -1,7 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "hw/boards.h"
>  #include "sysemu/kvm.h"
>  #include "helper_regs.h"
>  #include "mmu-hash64.h"
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index aeeca69a2d..bea694c973 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -1,7 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
> -#include "hw/boards.h"
>  #include "qemu/timer.h"
>
>  #include "migration/cpu.h"
> --
> 2.21.0
>
>

