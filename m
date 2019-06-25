Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A28EC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217CA214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217CA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58478 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfig3-0000oy-Ed
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hfiYZ-0000E5-Vh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hfiYY-00030n-GM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hfiYY-0002zZ-8Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:20:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9239077pff.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=eYufa29gR8Qoq691MeFTHr9ktSdVsXgSvRUvOy0sXpM=;
 b=SuTXikpHl+jKC3tQKf5Jw/kmyAL5t4a7mmsToBrEK8rgJmDAHfrIRqbp1YjDRzZ1ZU
 W0Ezxy9winrQbwBjjuhbvxFIwM6uOHRAAGBufeUaLtsJ6YYuU3hg1rpvo++/W37MuM9L
 zfUgprMa/taNXYQdaZ5KeI1X35zYWbVCV1LRP0UEvzZRgv/I2lsg/JgFR/PTm2py81Hp
 PGfMxPEMMPCb1ABPUmCMzJg1pqdulgkRe9jM2qxkGa9f1js9RmejDCkSQm0014AyK28H
 lB7NX62W2SAk+z3WOrs1QLUyEYAxk68rPyg3nQGDpRH/derLTXz/QQ4kQVwIesnBVpMA
 kccg==
X-Gm-Message-State: APjAAAXdM5mbemH+6EVouoWA7Xul5IHdnA/nTlDTn0wVwOAtS0cFa2Eh
 bv3dsU0yqWQr/FsKE4s8MioghA==
X-Google-Smtp-Source: APXvYqyNg+Y5CTHPzBny3L/12ops6+PaQFKzzzwPHDQTZWTYBhXFA5OShJ/UrOo6bLBsTQjNSznQjQ==
X-Received: by 2002:a17:90a:9a83:: with SMTP id
 e3mr30365096pjp.105.1561458004906; 
 Tue, 25 Jun 2019 03:20:04 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id i126sm18198466pfb.32.2019.06.25.03.20.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 03:20:04 -0700 (PDT)
Date: Tue, 25 Jun 2019 03:20:04 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 03:09:31 PDT (-0700)
In-Reply-To: <20190624234144.10768-1-atish.patra@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-7c1a8a81-ee0d-4e95-87b9-ef9543ad121c@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: Re: [Qemu-devel] [PATCH v2] riscv: virt: Add cpu-topology DT node.
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 16:41:44 PDT (-0700), Atish Patra wrote:
> Currently, there is no cpu topology defined in RISC-V.
> Define a device tree node that clearly describes the
> entire topology. This saves the trouble of scanning individual
> cache to figure out the topology.
>
> Here is the linux kernel patch series that enables topology
> for RISC-V.
>
> http://lists.infradead.org/pipermail/linux-riscv/2019-June/005072.html
>
> CPU topology after applying this patch in QEMU & above series in kernel
>
> / # cat /sys/devices/system/cpu/cpu2/topology/thread_siblings_list
> 2
> / # cat /sys/devices/system/cpu/cpu2/topology/physical_package_id
> 0
> / # cat /sys/devices/system/cpu/cpu2/topology/core_siblings_list
> 0-7
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks.  This is in the queue for 4.1, which is just pending Alistar's review
on those two Z patches I reworked.

> ---
>  hw/riscv/virt.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 84d94d0c42d8..45a1edcd6c4a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -191,6 +191,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>
>      for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
>          int cpu_phandle = phandle++;
> +        int intc_phandle;
>          nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
>          char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
>          char *isa = riscv_isa_string(&s->soc.harts[cpu]);
> @@ -203,9 +204,12 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
>          qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
>          qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> +        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
> +        qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", cpu_phandle);
> +        intc_phandle = phandle++;
>          qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
> -        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
> +        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
> +        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", intc_phandle);
>          qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
>          qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>          qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> @@ -214,6 +218,20 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>          g_free(nodename);
>      }
>
> +    /* Add cpu-topology node */
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
> +    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map/cluster0");
> +    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
> +        char *core_nodename = g_strdup_printf("/cpus/cpu-map/cluster0/core%d",
> +                                              cpu);
> +        char *cpu_nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, cpu_nodename);
> +        qemu_fdt_add_subnode(fdt, core_nodename);
> +        qemu_fdt_setprop_cell(fdt, core_nodename, "cpu", intc_phandle);
> +        g_free(core_nodename);
> +        g_free(cpu_nodename);
> +    }
> +
>      cells =  g_new0(uint32_t, s->soc.num_harts * 4);
>      for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
>          nodename =

