Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BFC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B532467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B532467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55695 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7F6Q-0000Co-AL
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1j7F5b-0007i1-RJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1j7F5a-0002Oq-SB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:04:15 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:40813
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1j7F5Y-0002Im-0F; Thu, 27 Feb 2020 04:04:12 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 3D1BC8138E;
 Thu, 27 Feb 2020 10:04:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYypmEaA3E1k; Thu, 27 Feb 2020 10:04:11 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id C5BF98138B;
 Thu, 27 Feb 2020 10:04:10 +0100 (CET)
Subject: Re: [PATCH v1 2/2] hw/arm: versal: Generate xlnx-versal-virt zdma FDT
 nodes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
 <20200227154424.6849-3-edgar.iglesias@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <d921bb4b-0632-cfb6-5275-f25a079ee21e@adacore.com>
Date: Thu, 27 Feb 2020 10:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227154424.6849-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 2/27/20 =C3=A0 4:44 PM, Edgar E. Iglesias a =C3=A9crit=C2=A0:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Generate xlnx-versal-virt zdma FDT nodes.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

> ---
>   hw/arm/xlnx-versal-virt.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>=20
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index e7f4ca8bf9..878a275140 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -229,6 +229,33 @@ static void fdt_add_gem_nodes(VersalVirt *s)
>       }
>   }
>  =20
> +static void fdt_add_zdma_nodes(VersalVirt *s)
> +{
> +    const char clocknames[] =3D "clk_main\0clk_apb";
> +    const char compat[] =3D "xlnx,zynqmp-dma-1.0";
> +    int i;
> +
> +    for (i =3D XLNX_VERSAL_NR_ADMAS - 1; i >=3D 0; i--) {
> +        uint64_t addr =3D MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
> +        char *name =3D g_strdup_printf("/dma@%" PRIx64, addr);
> +
> +        qemu_fdt_add_subnode(s->fdt, name);
> +
> +        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
> +        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> +                               s->phandle.clk_25Mhz, s->phandle.clk_25=
Mhz);
> +        qemu_fdt_setprop(s->fdt, name, "clock-names",
> +                         clocknames, sizeof(clocknames));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0=
 + i,
> +                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> +                                     2, addr, 2, 0x1000);
> +        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(co=
mpat));
> +        g_free(name);
> +    }
> +}
> +
>   static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>   {
>       Error *err =3D NULL;
> @@ -427,6 +454,7 @@ static void versal_virt_init(MachineState *machine)
>       fdt_add_uart_nodes(s);
>       fdt_add_gic_nodes(s);
>       fdt_add_timer_nodes(s);
> +    fdt_add_zdma_nodes(s);
>       fdt_add_cpu_nodes(s, psci_conduit);
>       fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
>       fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
>=20

