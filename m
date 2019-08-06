Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D46C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8280621880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 21:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW1xQ7nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8280621880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv7Ez-0006pn-Qt
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 17:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hv7EA-0005jJ-BP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hv7E8-0006YQ-BU
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:42:42 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hv7E7-0006Xu-Ud
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 17:42:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id i21so4251424ljj.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FtRh2JjrvUeL4Lb24K2j4V9ZLagmxBypIX4iiGSsx+c=;
 b=LW1xQ7nSJ2HILJPcxXSFgBhjfbxewXyLTGWWHvZxSGYPdhDEiB3/Th4HFuON0Z9hYL
 +QBui56PZv0fyBOqzZoj0JGJMzGwrVhn+6XFQOgMC5RIkWLu6HiyXDfkaVmHk471S31D
 1CjaKXOWSxrtLTlNOufltnVeltJHi++KbhQZ5WHpc8nw5vdPP++ZF4pqDwaKmAirWDOj
 vzF7s86N2IkoW5I+XmrZp7XZldXWc17vUv2NyCGRRF+RcWztFACzDY3+zHJaw2noMNVk
 ZbFKPM3XLWmBBO7w662jmrwCh/KunumZ8isqKc9ngnyJDRHC6JOFu177T702vUaJKUlj
 naKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FtRh2JjrvUeL4Lb24K2j4V9ZLagmxBypIX4iiGSsx+c=;
 b=Q/ONgVqBF0HCpovk6Oro2hru0QX6EgGv6IY7nXdZ6LTBvZo6ZMRk3IXHKUF9wy5Tuv
 h7bEKc2hSll1tA5ahfMwMNt+BY4T/cULvl0n6z+T+uaUIVu25TgGWVbcjoL45WcRyhUd
 nQyZuBO8fzLhMwvsnVz2Qjl/uwfiNdvR8pD+arNLCJ7/jIezlkZs32LiTxdK88eCdhSG
 TFyYB15DtEopHygoBvfbakPp4dnXYlnQ+IR3L+LMmR3kyrf3fD/KUsBQvpeZrKkgX9Zh
 L9Km33mijPCcn1U0ENtI0KFXvMC7MRK8T9yqxq0iXO+Yf+OLR7o0K31O8+puF9aL3Bva
 W2Ng==
X-Gm-Message-State: APjAAAWm1hT+lJb/8W1kArhihLJbSxDFmbMJmavDe5wvkkLjXxxcqL9j
 J3knwQu6CM+tLgPOzyPiB0wfJNi5+cossZRqnA32mH5p
X-Google-Smtp-Source: APXvYqzkG99hjpmra5MwQcPjLF+VrCy6jmHukMetePx1KS+htfjbBlko3GBaRTNoWkGwSFB2rDISvDzI8SNWcM/CyMQ=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr2870213lja.85.1565127758734;
 Tue, 06 Aug 2019 14:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
In-Reply-To: <20190806151435.10740-28-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2019 14:38:58 -0700
Message-ID: <CAKmqyKMOnYB4W_X1nDqqCJkqai5VXuW_F-ETzMBQ_wsfGeg8KQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 27/29] Include sysemu/sysemu.h a lot less
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 6, 2019 at 8:22 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> In my "build everything" tree, changing sysemu/sysemu.h triggers a
> recompile of some 5400 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).
>
> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
> hw/qdev-core.h is widely included.
>
> Move the declaration of qdev_add_vm_change_state_handler() to
> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
>
> Touching sysemu/sysemu.h now recompiles some 1800 objects.
> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
> smaller improvement: qemu/notify.h drops from 5600 to 5200,
> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
> 5500 to 5000.
>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/kvm/kvm-all.c               | 1 +
>  backends/hostmem.c                | 1 +
>  cpus.c                            | 1 +
>  hw/arm/allwinner-a10.c            | 1 +
>  hw/arm/aspeed_soc.c               | 1 +
>  hw/arm/kzm.c                      | 1 +
>  hw/arm/msf2-soc.c                 | 1 +
>  hw/arm/stm32f205_soc.c            | 1 +
>  hw/char/serial-isa.c              | 1 +
>  hw/char/xen_console.c             | 1 +
>  hw/core/numa.c                    | 1 +
>  hw/core/vm-change-state-handler.c | 1 +
>  hw/display/qxl-render.c           | 1 +
>  hw/i386/xen/xen-hvm.c             | 1 +
>  hw/i386/xen/xen-mapcache.c        | 1 +
>  hw/intc/ioapic.c                  | 1 +
>  hw/pci/pci.c                      | 1 +
>  hw/riscv/sifive_e.c               | 1 +
>  hw/riscv/sifive_u.c               | 1 +
>  hw/riscv/spike.c                  | 1 +
>  hw/riscv/virt.c                   | 1 +
>  hw/sparc64/niagara.c              | 2 +-
>  hw/usb/hcd-ehci.h                 | 1 +
>  hw/xen/xen-common.c               | 1 +
>  hw/xen/xen_devconfig.c            | 1 +
>  hw/xenpv/xen_machine_pv.c         | 1 +
>  include/hw/qdev-core.h            | 5 -----
>  include/sysemu/sysemu.h           | 3 +++
>  migration/global_state.c          | 1 +
>  migration/migration.c             | 1 +
>  migration/savevm.c                | 1 +
>  31 files changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e1a44eccf5..fc38d0b9e3 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -29,6 +29,7 @@
>  #include "exec/gdbstub.h"
>  #include "sysemu/kvm_int.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/sysemu.h"
>  #include "qemu/bswap.h"
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 463102aa15..6d333dc23c 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -12,6 +12,7 @@
>
>  #include "qemu/osdep.h"
>  #include "sysemu/hostmem.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-builtin-visit.h"
> diff --git a/cpus.c b/cpus.c
> index e70cc58e31..a20a9a29c1 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -41,6 +41,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/hax.h"
>  #include "sysemu/hvf.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/whpx.h"
>  #include "exec/exec-all.h"
>
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index 3b0d3eccdd..73810a4440 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -23,6 +23,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/arm/allwinner-a10.h"
>  #include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
>
>  static void aw_a10_init(Object *obj)
>  {
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c6fb3700f2..9ee8104832 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -22,6 +22,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "net/net.h"
> +#include "sysemu/sysemu.h"
>
>  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
>
> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
> index 59d2102dc5..2f052e1f8c 100644
> --- a/hw/arm/kzm.c
> +++ b/hw/arm/kzm.c
> @@ -24,6 +24,7 @@
>  #include "hw/net/lan9118.h"
>  #include "hw/char/serial.h"
>  #include "sysemu/qtest.h"
> +#include "sysemu/sysemu.h"
>
>  /* Memory map for Kzm Emulation Baseboard:
>   * 0x00000000-0x7fffffff See i.MX31 SOC for support
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 8ae763f99f..76cc3e09b0 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -30,6 +30,7 @@
>  #include "hw/irq.h"
>  #include "hw/arm/msf2-soc.h"
>  #include "hw/misc/unimp.h"
> +#include "sysemu/sysemu.h"
>
>  #define MSF2_TIMER_BASE       0x40004000
>  #define MSF2_SYSREG_BASE      0x40038000
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index be8b7df679..f5a5c2d80c 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -29,6 +29,7 @@
>  #include "exec/address-spaces.h"
>  #include "hw/arm/stm32f205_soc.h"
>  #include "hw/qdev-properties.h"
> +#include "sysemu/sysemu.h"
>
>  /* At the moment only Timer 2 to 5 are modelled */
>  static const uint32_t timer_addr[STM_NUM_TIMERS] = { 0x40000000, 0x40000400,
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index 5a0ae02ee7..9e31c51bb6 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/char/serial.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index 8cc9328b3f..63153dfde4 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -24,6 +24,7 @@
>  #include <termios.h>
>
>  #include "qapi/error.h"
> +#include "sysemu/sysemu.h"
>  #include "chardev/char-fe.h"
>  #include "hw/xen/xen-legacy-backend.h"
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 450c522dd8..7a63ddc4c6 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/sysemu.h"
>  #include "exec/cpu-common.h"
>  #include "exec/ramlist.h"
>  #include "qemu/bitmap.h"
> diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
> index e27ea45977..9068d51c9a 100644
> --- a/hw/core/vm-change-state-handler.c
> +++ b/hw/core/vm-change-state-handler.c
> @@ -17,6 +17,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/qdev-core.h"
> +#include "sysemu/sysemu.h"
>
>  static int qdev_get_dev_tree_depth(DeviceState *dev)
>  {
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index 14ad2b352d..473e333475 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -21,6 +21,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qxl.h"
> +#include "sysemu/sysemu.h"
>  #include "trace.h"
>
>  static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 3e15ffc828..ca4659b20f 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -25,6 +25,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/range.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index dc73c86c61..09656f9f11 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -17,6 +17,7 @@
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "qemu/bitmap.h"
>
> +#include "sysemu/sysemu.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index dddd231337..1ede055387 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/i386/x86-iommu.h"
>  #include "trace.h"
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4b6ffab13d..aa05c2b9b2 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -35,6 +35,7 @@
>  #include "monitor/monitor.h"
>  #include "net/net.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
>  #include "qemu/range.h"
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 862903d6b5..792d75a1a3 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -46,6 +46,7 @@
>  #include "hw/riscv/boot.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
> +#include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>
>  static const struct MemmapEntry {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0b3c5dff97..9910fa6708 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -44,6 +44,7 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>
>  #include <libfdt.h>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 9cc786b6b6..7c04bd554f 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -40,6 +40,7 @@
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/qtest.h"
> +#include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>
>  #include <libfdt.h>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c72198b720..9bced28486 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -37,6 +37,7 @@
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/device_tree.h"
> +#include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 1efcff628a..167143bffe 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -35,7 +35,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> -
> +#include "sysemu/sysemu.h"
>
>  typedef struct NiagaraBoardState {
>      MemoryRegion hv_ram;
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 0298238f0b..fdbcfdcbeb 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -21,6 +21,7 @@
>  #include "qemu/timer.h"
>  #include "hw/usb.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/pci/pci.h"
>  #include "hw/sysbus.h"
>
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 32503cfc1c..76621da2f5 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -14,6 +14,7 @@
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "chardev/char.h"
>  #include "sysemu/accel.h"
> +#include "sysemu/sysemu.h"
>  #include "migration/misc.h"
>  #include "migration/global_state.h"
>
> diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
> index 315dbc9c51..46ee4a7f02 100644
> --- a/hw/xen/xen_devconfig.c
> +++ b/hw/xen/xen_devconfig.c
> @@ -2,6 +2,7 @@
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "qemu/option.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/sysemu.h"
>
>  /* ------------------------------------------------------------- */
>
> diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
> index 524d608eab..3a8af1a1e0 100644
> --- a/hw/xenpv/xen_machine_pv.c
> +++ b/hw/xenpv/xen_machine_pv.c
> @@ -28,6 +28,7 @@
>  #include "hw/xen/xen-legacy-backend.h"
>  #include "hw/xen/xen-bus.h"
>  #include "sysemu/block-backend.h"
> +#include "sysemu/sysemu.h"
>
>  static void xen_init_pv(MachineState *machine)
>  {
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index e5b62dd2fc..de70b7a19a 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -5,7 +5,6 @@
>  #include "qemu/bitmap.h"
>  #include "qom/object.h"
>  #include "hw/hotplug.h"
> -#include "sysemu/sysemu.h"
>
>  enum {
>      DEV_NVECTORS_UNSPECIFIED = -1,
> @@ -451,8 +450,4 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
>  void device_listener_register(DeviceListener *listener);
>  void device_listener_unregister(DeviceListener *listener);
>
> -VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
> -                                                     VMChangeStateHandler *cb,
> -                                                     void *opaque);
> -
>  #endif
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 227202999d..908f158677 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -29,6 +29,9 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                       void *opaque);
>  VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>          VMChangeStateHandler *cb, void *opaque, int priority);
> +VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
> +                                                     VMChangeStateHandler *cb,
> +                                                     void *opaque);
>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>  void vm_state_notify(int running, RunState state);
>
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 2c8c447239..7cba868979 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/sysemu.h"
>  #include "qapi/error.h"
>  #include "migration.h"
>  #include "migration/global_state.h"
> diff --git a/migration/migration.c b/migration/migration.c
> index 3a6340f602..2986b8b164 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -21,6 +21,7 @@
>  #include "exec.h"
>  #include "fd.h"
>  #include "socket.h"
> +#include "sysemu/sysemu.h"
>  #include "rdma.h"
>  #include "ram.h"
>  #include "migration/global_state.h"
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b8f734537a..33da39f0ea 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -57,6 +57,7 @@
>  #include "io/channel-buffer.h"
>  #include "io/channel-file.h"
>  #include "sysemu/replay.h"
> +#include "sysemu/sysemu.h"
>  #include "qjson.h"
>  #include "migration/colo.h"
>  #include "qemu/bitmap.h"
> --
> 2.21.0
>
>

