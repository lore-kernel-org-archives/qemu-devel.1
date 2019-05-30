Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB5EC28CC2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E48824590
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkwkZuQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E48824590
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWBX4-0002Qk-Oo
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 23:15:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBWH-0001ua-N5
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBWG-0000fg-T7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:14:21 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hWBWE-0000eE-PL; Wed, 29 May 2019 23:14:19 -0400
Received: by mail-lj1-x244.google.com with SMTP id o13so4591340lji.5;
	Wed, 29 May 2019 20:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hY9X1/q25tGR/jh+8BvIi77iJZffltbcGhe17cKoTcc=;
	b=hkwkZuQbY4JJdpCZeb2ARW4jPtsMELrVbphnfzrfRJI2JuoKyEU1ubccDQs0NhxWdn
	b4CgG8sakh1ZLPimhSu7/agAV22FKAYTz9zz6Fuu4PlQk13tkv2DBpGyg9yksYLkOwyq
	R8SrZ/36LqsfkmVZ53DWPgubvQ+CCf8UjyDbo/mLJprGmnUsMnT/CNl/gYhbhdOpi1lR
	5zfe7MlqgP2bWBSGMzSsCas2N4XwGYFNOGn7/i8DFVUKnGokKhepcEWamJ2+hM95Tn8y
	Ei5Qxp0Y8ex3cnqVHQCpQ0Vo5obmamiYWn07vfp+8AeolCl4IcHD2XnfMFVN+tuiZsTx
	CIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hY9X1/q25tGR/jh+8BvIi77iJZffltbcGhe17cKoTcc=;
	b=O1E//BgK6mBlr/bchDSg/5Ps1hc5PgDJNi3ZQzxsNFnBSLNJ3wC8Yjz/bk5UJ6ahFt
	UKgiHZ9ZvoLtZgdAyrSCYjuvj1bXmS0cH8FDOweRdDD7oNC66yeKFuXEyu+setd7x1Xt
	hwfJHitPrG0TCSihmaXRSfQ6Nf5pTDC2ipJ/r4vOU5cR76o+FWXKnK8QC/pnL6hxCEcF
	PtDSWMXIPY7ow/LICkP2t2CZsgqVKgCTUmccyfc8G90xkLP/wwhhQcP0MzmOtVsABvUV
	Dta9MpW6UatIxMZ4VZYFPE4w9KXAZLTx2lojNlnGN5KwXuEhiJzeTcOC5U+eV/yTpAog
	wUjw==
X-Gm-Message-State: APjAAAWT7weptQhpypJQszzr7EwVu6ofmnOaHtTGhW+AFmXxUuH21QCo
	FGeAH3POj72PxaIPO+FVFWk7AXSkLBmbSfNiPQM=
X-Google-Smtp-Source: APXvYqxBIYcGMxmIW743+1+FLQTTq08tKpbi32oQzMcmDntdwoCT/vQFMBSULE6ueVwu9oQEwHbBvgqs/Gb1LlGMho0=
X-Received: by 2002:a2e:5d9c:: with SMTP id v28mr680487lje.32.1559186057379;
	Wed, 29 May 2019 20:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1559119921-6098-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 May 2019 20:13:49 -0700
Message-ID: <CAKmqyKNAL8KtVgfCx6yhaNYEL=_wnZ5Vf1eSjxwtg0x6_q+UHw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] riscv: virt: Correct pci "bus-range"
 encoding
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 1:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The largest pci bus number should be calculated from ECAM size,
> instead of its base address.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

This seems ok, can you maybe explain what this fixes?

Alistair

> ---
>
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fc4c6b3..d6132d9 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -299,7 +299,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
>      qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
>      qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
> -                           memmap[VIRT_PCIE_ECAM].base /
> +                           memmap[VIRT_PCIE_ECAM].size /
>                                 PCIE_MMCFG_SIZE_MIN - 1);
>      qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
>      qemu_fdt_setprop_cells(fdt, nodename, "reg", 0, memmap[VIRT_PCIE_ECAM].base,
> --
> 2.7.4
>
>

