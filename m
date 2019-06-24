Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DCC4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FB620665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkhtqR30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FB620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYNR-00032D-3A
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hfYMU-0002Ye-9i
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hfYMT-0003E7-2z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:26:58 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hfYMS-00039v-QH; Mon, 24 Jun 2019 19:26:57 -0400
Received: by mail-lf1-x141.google.com with SMTP id z15so11214699lfh.13;
 Mon, 24 Jun 2019 16:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0/LZ/asxgiIN9ULCQF8lNsJR5KgS/OSQ+ryje2z59Wc=;
 b=QkhtqR30H01rb8oxWOb2bNjtLDqkB7ByskBigJesn4jbVZ8NG7TvIzMuLM1iyLQ/Zm
 Bwh/oG2/DkC7/XYjS2L5zs0/UwIskTPdQvfqPOeMkfZDGqzgKMDmKBFVmO8nXxdC5qKC
 jMM/0AlpfBrNYPFsxRVp48heVzQqGsC6w7/UpyFB4V5t5zlFl5JhClsYRi0zn9K3+1On
 +URNJhm+vVC6JvzpdYolpQ8X+UQEdwT4K8hw8YfwMmoYN3RKO1JpxrrMIVy4O3sYpAUM
 muBubh2zZPIDtob4zE/WC6N4EVbdY8PbAsAazHcOu7fMANf6C8LWnzeodnqxk7VTN1qG
 IWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0/LZ/asxgiIN9ULCQF8lNsJR5KgS/OSQ+ryje2z59Wc=;
 b=pYXeyh7PIy+iQNdLl+WroP3kegH9KputvHt9Ck2UBAJ+wXhZR95WjlaEqSXwMTS5Aw
 Bq7XG0WlZtn4l9i9FRqWC4/9pPK87TLfJNdK2+oZi0kfrWRqSe1SqYeBvQ1Qi7Z6vClo
 4dvDWVVO3dJPKNyPMHoyxl3MbdszvM//7DdbvwuXZqGsrtJtYVYEG41zHOvdMZx9KgNB
 20LjEcdWFQePAYX3eV1Ely6/E1VpM9/iKDIXpYcYHvabLJKX2xPNjNRX1sp50FOTGoyO
 PJBjoXJEK9Qja2pEr2Kq48WNvm6+jIhcNlwWsKA+eBBoh2twC+ZeaWhV3mMgxgBqQ/8x
 ER5Q==
X-Gm-Message-State: APjAAAWrp40Gl/lLHBB5OxLFnXJD220slRBKP7tv96EkA73DDbQyvKI5
 B9/fTX/OejZC812wc/Hi9PVkJ+ASLEuLrZOgNyc=
X-Google-Smtp-Source: APXvYqyFzpRUDsdjaNkn4MwJNkY9MZ6/UZwJVGirKpswKecBzdiEmw/ncuTnm4oB3wY6HsMYpYAiRU6DCJiBPCJx29Y=
X-Received: by 2002:a19:bec1:: with SMTP id o184mr46524544lff.86.1561418815298; 
 Mon, 24 Jun 2019 16:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190624225446.22597-1-atish.patra@wdc.com>
In-Reply-To: <20190624225446.22597-1-atish.patra@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Jun 2019 16:24:00 -0700
Message-ID: <CAKmqyKO28WO3QzQOOzJnFOA5J2Wjeg-MF5+BcoWWF+qO=+UTNA@mail.gmail.com>
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Add cpu-topology DT node.
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 3:57 PM Atish Patra <atish.patra@wdc.com> wrote:
>
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
> ---
>  hw/riscv/virt.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 84d94d0c42d8..da0b8aa18747 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -203,9 +203,12 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
>          qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
>          qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
> +        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
> +        qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", cpu_phandle);
> +        int intc_phandle = phandle++;

Don't declare variables in the middle of code. The variable must be
declared at the start of a block.

With that fixed:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>          qemu_fdt_add_subnode(fdt, intc);
> -        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
> -        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
> +        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
> +        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", intc_phandle);
>          qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
>          qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
>          qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
> @@ -214,6 +217,20 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
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
> --
> 2.21.0
>
>

