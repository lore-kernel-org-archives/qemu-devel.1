Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4323720773
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYMCVDl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4323720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsWBl-00089l-IX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsWBD-0007ib-6B; Mon, 06 Jul 2020 14:49:27 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsWBB-00009o-LS; Mon, 06 Jul 2020 14:49:26 -0400
Received: by mail-io1-xd41.google.com with SMTP id v6so26811036iob.4;
 Mon, 06 Jul 2020 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cQsmIkOSDLPbF1rwN2rsz6MizLe502CiYFhs1QJ5zoA=;
 b=UYMCVDl2hupJPXBMo32HPMmLkLlRVveTcCTn74Ov8jcHt1YvqkMF1FJXm+qQqit9ig
 RGMz//LCozLGTigEklXiTJpxZrA5/beSegC30eAn/IrSgv4ta4kJp1L12tQrM0SS6RG8
 HUGDI9NdK6QC7/sUSfB3HiNucXYYH1DxYrUsnRkUaqLtGsHvEuVRjNJBfkcbUPqc0xeQ
 RW5iJpjYXNds0h8v4/5+LI3z15koeSIOQrI50bWv12AE3md8crL1h+zB9Zd7SnOAcNNY
 FWmpR2zCnGlRTRQwsFblxuRj5FHhPQ9SekOH4E58J5Z4em1FKr4J6Xgk4HCfZ51C1MCw
 UYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cQsmIkOSDLPbF1rwN2rsz6MizLe502CiYFhs1QJ5zoA=;
 b=Fa2yZI0KgmLWepmjyZOQ0cwfqP3F69e4nKvDdgp74Gn+O/ePdxZwb7PKh+tkD19kYp
 eJHRxfai7F/vbf00VxNwriaiB8vwwXDYTHwwG+CL2jQVeHyek7o7toW0RSLJ7OrE1l5s
 +on/rxG9VpVHqTpiEzfPAA/Dr5yKSJyYUnNJ20IifLOCpNBnN7Qgeb0gBigUlN3KyYuh
 r+on6F0xVYnprP3FWifJTs7W5YRcToQLCJjzT295CzLAVxZSpt43/yzqe2ABQUDWLCYn
 pEwsUJKhpcQp+0UOtgwqao1eujGL4IB7ESijqwGjRBIbre/Pj0DPl5f5Wng9E5zQtKqk
 PZcg==
X-Gm-Message-State: AOAM531UPoxQpMUWXju82Gten8zhycGSVCtortzTrkJ/2w2QVZn8Mrxs
 7pCipj9CV4JVyNJrQtIazT9Hp4gs1RgHXNuVFGpoDdpRKFw=
X-Google-Smtp-Source: ABdhPJzEr+7dxLE8Wyufyj1D4zI0VXPihc4Ev134Dphhtf3jYJyCRd2bXPZk3uIdso0iY1bWmZnlGGEz6kJ/p410v5k=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr26827705iod.118.1594061364251; 
 Mon, 06 Jul 2020 11:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <1593746511-19517-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1593746511-19517-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 11:39:37 -0700
Message-ID: <CAKmqyKNFpq+Ko=6obUkG26uRJYYOLT8m2RwRWELwnKaGznSq2A@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: virt: Sort the SoC memmap table entries
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 2, 2020 at 8:23 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Adjust the PCIe memory maps to follow the order.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
>  hw/riscv/virt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 5ca49c5..aacfbda 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,14 +57,14 @@ static const struct MemmapEntry {
>      [VIRT_TEST] =        {   0x100000,        0x1000 },
>      [VIRT_RTC] =         {   0x101000,        0x1000 },
>      [VIRT_CLINT] =       {  0x2000000,       0x10000 },
> +    [VIRT_PCIE_PIO] =    {  0x3000000,       0x10000 },
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
>      [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
> -    [VIRT_DRAM] =        { 0x80000000,           0x0 },
> -    [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
> -    [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
>      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
> +    [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
> +    [VIRT_DRAM] =        { 0x80000000,           0x0 },
>  };
>
>  #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> --
> 2.7.4
>
>

