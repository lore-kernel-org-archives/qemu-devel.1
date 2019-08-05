Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E27C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3102075B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8McU0JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3102075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hugNS-0005gg-23
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 13:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fintelia@gmail.com>) id 1hugMg-00050V-Fc
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1hugMe-0000AR-Tj
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 13:01:42 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1hugMe-0000A0-J3; Mon, 05 Aug 2019 13:01:40 -0400
Received: by mail-lf1-x141.google.com with SMTP id x3so4808099lfn.6;
 Mon, 05 Aug 2019 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O4vED/Px4TsmV1kmjJ6cY1xYEE+NYEHIDRkGEtFxaf4=;
 b=s8McU0JIy003O4Dbdm8gf9tGdInrB/wF83mVmlFcvP7uUuOH70aVvJBvqToRCyeZ27
 pZqM7eoSyiNOnLmNHKUNOoNjew5eEa4PcnaF+nMpMVslYmkx7BpvrEk2HRoqkkzHDHR8
 PuwIhoAktIJhcNihtXa+5FYZu4IBBDC3iLVf4c2DOkZFbzZ+K2gs73d1UxWLnpCulZ6I
 +3KoX4SNGc+f7u+HNLUoBKJU9dApJJ4J8QYtUpDJ2JK7X56ag2A2AO5zW4olcxeb/kWu
 8ubC95s47RyaGG6gso+KJ77xWoYbYu/Ar9UQwvwvpwk3ps3LRu42FAh3tFK00903iNqS
 pv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O4vED/Px4TsmV1kmjJ6cY1xYEE+NYEHIDRkGEtFxaf4=;
 b=pq03msv/Phaj4vs6e55A6qZlKzicCJEL/WiI3dmwN1SmROchLcAQl0CUOtbDt/wrB2
 nx/C+KEozvEKTdND8PxgDy8jz+IXrQR4k6Wr6QxtDlaEr3P3A0ho3BTF3VEAPRAjVhHM
 TfJzVzFDZZ2gbTisZDkH+1E0zKyeOIp02h9QXOJNGlttwWv7gmF/FPlonDi/gX9GBgBv
 Xveg6+vrAG8r54udWaMBUeCy9yvXgpBZIyAu8cJPeN/u3mgGopM+NFAfoHT4C+uhgWMZ
 ON0TSxWjkpnlX15DW7NbLczJePkDyVCeb0qo4LvbxR+92R4wcTFdJni7rBcvm/i3fupX
 40iA==
X-Gm-Message-State: APjAAAUw1z/U+N4Hu8uPpoXu3+lBTPcZHJnzIVhxYaHIfshl2OLPAPc2
 cE8OV88na5FSOlp29ee8yKSGsy1xbMmTND8EqJk=
X-Google-Smtp-Source: APXvYqwWgNT4x4TGgPTgW6WGzbnsOqNWaQl+In8vbraZWD40tWfrKK2LMDuhm3XnNJmSDcudnexoOCYXyo3tHYQVcd0=
X-Received: by 2002:a19:7006:: with SMTP id h6mr71058166lfc.5.1565024498346;
 Mon, 05 Aug 2019 10:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-27-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-27-git-send-email-bmeng.cn@gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Mon, 5 Aug 2019 13:00:52 -0400
Message-ID: <CANnJOVHi4sZr5PQzhbOCBPs3-pvH-8Nk=j-g+Y4841dNOs63RQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 26/28] riscv: hw: Update PLIC
 device tree
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

I was a little surprised to see the "riscv,max-priority" element removed,
but there is no mention of it in the kernel documentation
<https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt>
so I guess that max-priority=7 is now assumed.

Reviewed-by: Jonathan Behrens <fintelia@gmail.com>

On Mon, Aug 5, 2019 at 12:10 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> This removes "reg-names" and "riscv,max-priority" properties of the
> PLIC node from device tree, and updates its compatible string, to
> keep in sync with the Linux kernel device tree.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_u.c | 4 +---
>  hw/riscv/virt.c     | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index d77b3c3..5ded3a0 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -229,15 +229,13 @@ static void create_fdt(SiFiveUState *s, const struct
> MemmapEntry *memmap,
>          (long)memmap[SIFIVE_U_PLIC].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> "sifive,plic-1.0.0");
>      qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
>      qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
>          cells, s->soc.cpus.num_harts * sizeof(uint32_t) * 4);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_PLIC].base,
>          0x0, memmap[SIFIVE_U_PLIC].size);
> -    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", 0x35);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 127f005..f662100 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -237,15 +237,13 @@ static void *create_fdt(RISCVVirtState *s, const
> struct MemmapEntry *memmap,
>                            FDT_PLIC_ADDR_CELLS);
>      qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
>                            FDT_PLIC_INT_CELLS);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> "sifive,plic-1.0.0");
>      qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
>      qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
>          cells, s->soc.num_harts * sizeof(uint32_t) * 4);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_PLIC].base,
>          0x0, memmap[VIRT_PLIC].size);
> -    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>      plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
> --
> 2.7.4
>
>
>
