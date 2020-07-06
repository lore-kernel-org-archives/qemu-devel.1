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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE62120760
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2Mofn1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE62120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsW8E-0005mT-1G
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsW7J-0005A8-DA; Mon, 06 Jul 2020 14:45:25 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsW7H-00080N-Ks; Mon, 06 Jul 2020 14:45:25 -0400
Received: by mail-io1-xd42.google.com with SMTP id i4so40400480iov.11;
 Mon, 06 Jul 2020 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LZf3cRbrhmfMKtFd2VXkyzNt4V6sFUPHsbIxjimIwCs=;
 b=o2Mofn1KuY7iUdC654jg4m2gNJ2jMMEwAGg1ZCv2pQvcEPk9j8I1QrrTUtifYH7Ah3
 5OfE7lk3eMmt9inHqPyZ0SdGAlzm5aYE3OiALqAxduqha0kKwcHzb1A3NAdjbZgNChlv
 e/0p1B9vgtqDhu22rCnKGi+8reoXHO6xteML1cH5VH9ykArtFJumPjPG5b2qM+T8vQda
 CW3G9QFmOBgdw4zYPw6o143qcV+Irqxtrsv1f7m+VSwOFcoxTaYt4nT3OgZH+VGUNKBl
 xNDmFOnIGKELeosH+/HjmRIkLidmREAyGg9HD29v4kVPKEmseJbbiUFISFAk+BRXv7DI
 T7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZf3cRbrhmfMKtFd2VXkyzNt4V6sFUPHsbIxjimIwCs=;
 b=QLPw7YXscMkfdECdmLZ4Ee2Vad6WPBetl/y6GS3+hM8DXTECjjei9HcrouLZ/2xqEz
 UakICtQ3Ju1P/X6rGaMBQh5l5b8u2gQXrx/q6lBOR54+6vF5xoMrS2mwIZMUrS9zFmRD
 iu9bKNcF27k2/NCHauWpDe5rAJVDDQXkQQTFilUZMQK7gzFR2MUCebOcBOzEQFH40axa
 Ljq3FEdoabkYWrGo0QLOj20GJYo8+a50hS+08a4W3RW8h9uhhC2k4R6zjsW7NsmiNrNh
 wP+i2wpYgaghtdaVRmc4CvZ4oEwSXrgalBrydsLwCtNFeVV4Mv71Y7uMiFsQch030qFx
 7pWg==
X-Gm-Message-State: AOAM530CiBJjVH8pcYqQ2QOHpchyOD1X8FRun43ArMCGSWViCoirZkWh
 M2jQPp51g3JQekz0pM5YwiAmYVYvnoLeETy95Jc=
X-Google-Smtp-Source: ABdhPJwQEAlp8OaN90vHhCh3zPsQtK4yz4nM9hnprGWzLTQ3gkJXJJvv+svSRPotwU7BMNrsQ6qR2iXjXhaz8s4JlCs=
X-Received: by 2002:a02:5b83:: with SMTP id g125mr54862576jab.91.1594061122093; 
 Mon, 06 Jul 2020 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <1593746511-19517-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1593746511-19517-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 11:35:35 -0700
Message-ID: <CAKmqyKM+KtuHAhY+ZAPoOHH=hC7qzWbHHBi=HUETeYER1AE1vg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: virt: Sort the SoC memmap table entries
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

