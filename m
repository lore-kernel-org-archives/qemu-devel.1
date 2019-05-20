Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F772C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1D9216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/iISkJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1D9216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqFL-0006mh-6n
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:55:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSq8E-0001qq-2l
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSq8C-0003Qp-QI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:47:42 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSq87-0003Mm-Es; Mon, 20 May 2019 17:47:35 -0400
Received: by mail-lj1-x241.google.com with SMTP id h19so13943350ljj.4;
	Mon, 20 May 2019 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RWYOWsOrlOdSwuuzSXCEp/onxa8x9C68sMRTN0zTses=;
	b=P/iISkJNUP1MuOB0WqG7Xsieo3W2D7CJ695NRq4UiEFDm9T8ffNoVsKox+1sKh/Lfd
	CAiIwfbf1WuBXmEEWJFHN0k8/w4vnN21lf+f4JWp1oEBo59+uffHsaa4nJQNouWEA6IY
	+OauPZtLE4LgXbcve5CrWbDmt8EEnwG0t75mP+Yqo/8mHbjx8HHkNvnQmuhl2BjIJ/Tg
	buCQKmnB/SlerCHYgYnd9OWn8BafWu9E/R3qbzWwtGNzRZmEJYW7CRVwZysIw8h8ZsYE
	lD75NwnMUH502d4Sqi92wDuRqzUOKjZxN4SO5sZX/zhBa4fzakjur3B22hBDzRtcnLwo
	Ylgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RWYOWsOrlOdSwuuzSXCEp/onxa8x9C68sMRTN0zTses=;
	b=nCpUgwYbnh4NGunUYlyXb6BQfFdL+4dgETX3v0J819vRSaacGgLSiQ2KO79Pg/fiEp
	PHYx5A/QUtJOv+FLvt6g0rD2QuW73E0K5zZZZ+9X3N6xCcJtgcSfXaafuykpERTOzKQi
	guVa6KzZqc8aUdx0qKATWRp9nF49aXVDFQeHyOofmD1GVyNM6ctBYQSa6RgzQcrBlWgx
	RkffOf8pgHYbX1jH6Y4XCVxbZje22U2g2orhcuMiUIdUGgJA3LU27es5g4Vo9RHCc/vm
	5XUJJOTFjTLWg2J/L8i+n5zfWqTcHXruVAXd1ndwDNrT2G0A/JPaKqGMlmVzI6OM/3m+
	3Nkg==
X-Gm-Message-State: APjAAAWeQdON/49c4OAj4hb+C85rdJRGdHQ8jGIcvMJFewJwgnC+wRrz
	fsrbItB9jozejWvaPxlJ2fwMHtBbe0h8j3z59Is=
X-Google-Smtp-Source: APXvYqxUSTE0qojR8wkDHnN6cmFd32m7jYvOJ8UDW36QUjUQe9pMMqHYg5UnMjVbPBIrxh/RgyVjKWf8eoK6s8G4wjY=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr32951788ljj.159.1558388853245;
	Mon, 20 May 2019 14:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190518205428.90532-1-like.xu@linux.intel.com>
	<20190518205428.90532-6-like.xu@linux.intel.com>
In-Reply-To: <20190518205428.90532-6-like.xu@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 14:45:18 -0700
Message-ID: <CAKmqyKO93cWjh88sHMDmBHmOTrxB5Dwgz=goLOb2xoMLQ_GP8A@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 05/10] hw/riscv: Replace global smp
 variables with machine smp properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 19, 2019 at 5:56 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> The global smp variables in riscv are replaced with smp machine properties.
>
> A local variable of the same name would be introduced in the declaration
> phase if it's used widely in the context OR replace it on the spot if it's
> only used once. No semantic changes.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c    | 6 ++++--
>  hw/riscv/sifive_plic.c | 3 +++
>  hw/riscv/sifive_u.c    | 6 ++++--
>  hw/riscv/spike.c       | 2 ++
>  hw/riscv/virt.c        | 1 +
>  5 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index b1cd11363c..ae86a63c04 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -137,6 +137,7 @@ static void riscv_sifive_e_init(MachineState *machine)
>
>  static void riscv_sifive_e_soc_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveESoCState *s = RISCV_E_SOC(obj);
>
>      object_initialize_child(obj, "cpus", &s->cpus,
> @@ -144,12 +145,13 @@ static void riscv_sifive_e_soc_init(Object *obj)
>                              &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
>  }
>
>  static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      const struct MemmapEntry *memmap = sifive_e_memmap;
>
>      SiFiveESoCState *s = RISCV_E_SOC(dev);
> @@ -179,7 +181,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_E_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_E_PLIC].size);
>      sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
> -        memmap[SIFIVE_E_CLINT].size, smp_cpus,
> +        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
>      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 07a032d93d..d4010a1f39 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -23,6 +23,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/sysbus.h"
>  #include "hw/pci/msi.h"
> +#include "hw/boards.h"
>  #include "target/riscv/cpu.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/riscv/sifive_plic.h"
> @@ -438,6 +439,8 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
>
>  static void sifive_plic_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->smp.cpus;
>      SiFivePLICState *plic = SIFIVE_PLIC(dev);
>      int i;
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 5ecc47cea3..43bf256946 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -321,13 +321,14 @@ static void riscv_sifive_u_init(MachineState *machine)
>
>  static void riscv_sifive_u_soc_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s = RISCV_U_SOC(obj);
>
>      object_initialize_child(obj, "cpus", &s->cpus, sizeof(s->cpus),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
>      object_property_set_str(OBJECT(&s->cpus), SIFIVE_U_CPU, "cpu-type",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
> +    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
>
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> @@ -336,6 +337,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
>
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s = RISCV_U_SOC(dev);
>      const struct MemmapEntry *memmap = sifive_u_memmap;
>      MemoryRegion *system_memory = get_system_memory();
> @@ -371,7 +373,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
> -        memmap[SIFIVE_U_CLINT].size, smp_cpus,
> +        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
>
>      for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 2a000a5800..6a747ff22e 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -171,6 +171,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      int i;
> +    unsigned int smp_cpus = machine->smp.cpus;
>
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> @@ -253,6 +254,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      int i;
> +    unsigned int smp_cpus = machine->smp.cpus;
>
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fc4c6b306e..b3f1962384 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -395,6 +395,7 @@ static void riscv_virt_board_init(MachineState *machine)
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      int i;
> +    unsigned int smp_cpus = machine->smp.cpus;
>      void *fdt;
>
>      /* Initialize SOC */
> --
> 2.21.0
>

