Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791AFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 23:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4737F205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 23:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2p2GgUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4737F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwDli-0005ut-E6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 18:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iwDl8-0005Nm-OR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 18:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iwDl7-0007fz-Jy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 18:25:34 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iwDl5-0007ZG-5J; Mon, 27 Jan 2020 18:25:31 -0500
Received: by mail-lj1-x241.google.com with SMTP id j26so12713894ljc.12;
 Mon, 27 Jan 2020 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UE5AqgYvA6UBWpRmfXlp68ySM3Hlmg+yT66iiHh1NxQ=;
 b=Z2p2GgUut9zaIyFlChoqBweMy9z3YKaDzcaU8IQbOLxYG3x9VQQrJxj5iwD5Hh9qPh
 OTL7R/WrWO+oKDPwFFL6JmjNQlWrUWFJSIGig7FO0I5jkGXanzw61RehEAD1LMrd2fy5
 lXHDNASSzRXNNOeb9257UbzISlQcfMCRhr95ghJWvhShn/lk8sL1+qbOmRtdmtVGqne8
 5X7aoqh74/UIL9a0Unjq4zT6TLNmtD6ADc1oHnB+QhflD4AQ7vr46O5kEAe4FA1Zxhia
 A+oEvdNrs2za5k6ekjl79cYhyOLcK5BjWpVch0yBIaxvgY27cfQovqycJ06q10lwPU4Z
 HNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UE5AqgYvA6UBWpRmfXlp68ySM3Hlmg+yT66iiHh1NxQ=;
 b=hdmSUnk2NYSYQ13ox68COk3U33KpHaano9HX3LAeVjsFojiMBjElsm6f/O8g7hWNKS
 eWtcBiGVhuYFLmRrsneFDliA67lx1yVJphsbm9Hwk3NBJ2gayywX8TJyHZufjFiIYYhv
 dOqp0NoZEB8kILLynTKj846Sxdko8px6DMS/RvddXM799ERWB7oxJgpEUkv62zk3AhTe
 bw0zVV13/AQDw8xKMq8Fk6gVnrgc98rU/zYwG/9158UimS5DdABDagfc++son7ejDPSn
 18EL7mDbE4DsyRW+a+REW04ckp9WPYQO8JhtNZ7NtiiIjK/Owm5LMuEsR/NthEqy3Crl
 nfpg==
X-Gm-Message-State: APjAAAWaGl3kp62TOTucz/p2R1kPSD/aiHnGomhByNnVyhozahDbt1Ph
 c/0Dz51lJjeeyk7LBlvZHhrOUYtWp44+kIWdVX8=
X-Google-Smtp-Source: APXvYqzqRcTdngtqgVS/id/aMayGZsOjAlojYN6lPJdkKvoA1RMHlPqsQjlAiQbuYNLTRDWX1dNdYrb8WMNB9l9NHnY=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr11264487ljc.195.1580167529349; 
 Mon, 27 Jan 2020 15:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20200122131641.34953-1-anup.patel@wdc.com>
In-Reply-To: <20200122131641.34953-1-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jan 2020 09:25:02 +1000
Message-ID: <CAKmqyKO1n58Zk_FmmqqjaMwCpLVJeBMc062eS=AEFyaWENPNEA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/virt: Add syscon reboot and poweroff DT nodes
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 11:18 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> The SiFive test device found on virt machine can be used by
> generic syscon reboot and poweroff drivers available in Linux
> kernel.
>
> This patch updates FDT generation in virt machine so that
> Linux kernel can probe and use generic syscon drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes since v1:
>  - Rebased on latest QEMU master commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40
> ---
>  hw/riscv/virt.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index c44b865959..6d682f8a78 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -182,11 +182,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu;
> +    int cpu, i;
>      uint32_t *cells;
>      char *nodename;
> -    uint32_t plic_phandle, phandle = 1;
> -    int i;
> +    uint32_t plic_phandle, test_phandle, phandle = 1;
>      hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
>
> @@ -356,16 +355,35 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      create_pcie_irq_map(fdt, nodename, plic_phandle);
>      g_free(nodename);
>
> +    test_phandle = phandle++;
>      nodename = g_strdup_printf("/test@%lx",
>          (long)memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      {
> -        const char compat[] = "sifive,test1\0sifive,test0";
> +        const char compat[] = "sifive,test1\0sifive,test0\0syscon";
>          qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
>      }
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
> +    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/uart@%lx",
> --
> 2.17.1
>
>

