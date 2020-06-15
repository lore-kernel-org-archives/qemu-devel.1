Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3938C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B732E20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTzssZeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B732E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuws-0004vg-VS
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuoL-0005u2-N4; Mon, 15 Jun 2020 15:30:25 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuoH-00052Y-D4; Mon, 15 Jun 2020 15:30:25 -0400
Received: by mail-il1-x143.google.com with SMTP id l6so280340ilo.2;
 Mon, 15 Jun 2020 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BlYRvqEWuxR/ZYBa39/RP6Znz9xpxQ6R4urwXV5zTDc=;
 b=JTzssZegRqoHqkv/j+RJugehUxuICoGzFPttDjSCTs5e0Gr02eedaiOU3ttSYnBUpQ
 rqpCO842yc4kI57U3Ck/qhUFFuAJk2JizSil+tL9zI5YCVndOx30yoWbWzA6hATTYT7p
 mX2ANAZa/IaqwVhIVcpE5kUCyiI4QwiMRX3IdxdLuSN//ovN7mS3sBRLqfD6uYYrLrJM
 G0iUo8RhK/S1/E3RDWCUIEwsxFoKgBTmTBfyr2wemJP/cFBD+BA/QHUCTG8lKY2AfiFA
 lCz3seOh9Aga2w/T2iPhdUkA72oj7v0JsD1Vc+VAQnBXyDn4wdZK1sS6DfgO2OlUoRiW
 lHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlYRvqEWuxR/ZYBa39/RP6Znz9xpxQ6R4urwXV5zTDc=;
 b=otp2f3n7hTSvBOFb4fgBS6ZIje3ZhSXFrsPPBN+gpViOR5jXf+o5S9WRJe+AksCY3e
 PgY11IEZDkVJVuSCGf2gJ2TxYlK4kzBtg2BfFdcqM4XITdP+lp/zdQFSNNj3DxQx6hYn
 4y1nKvlpuHE2L1nQ/5qkqj2Wuvs/SvJ5VShXPHawb2iUormnbqXim3Qu0FFSbSZkYCzD
 cRykumuGi7SOa8Qh9FM+MjzTaR7o4YfHCfRWCzW4Eb+CsQMvCfajoG30eaaK98Yj8Dn6
 g8GxX+WRM4fuow2TO/7GQ45xXRyMsQeCVDFrcjjurvkIV9do4mK5ftwNZx1XUdJELpca
 zjQw==
X-Gm-Message-State: AOAM530ZoisL0EdusjDg6FBfbAVr0SbYAIRQzX+Yc0Sok6X9LZWZqXJH
 kXUp3oywmOzA1S0rhcFFzPYQD0RKWnPo8VkY/ZQ=
X-Google-Smtp-Source: ABdhPJzBb0q++Slziex0FS5xoV9V623lYWHrLEZ+z6nVilQTkHvksZU7VOnWoPIqXk6OJYWqZXxtWokjpvM+Lwjlo5Y=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr28329592ili.40.1592249420009; 
 Mon, 15 Jun 2020 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-16-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-16-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 12:20:56 -0700
Message-ID: <CAKmqyKMFTyZqbtNT932Dq8sSR593j=QhvJB=htRKji8mcP0+PA@mail.gmail.com>
Subject: Re: [PATCH 15/15] hw/riscv: sifive_u: Add a dummy DDR memory
 controller device
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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

On Mon, Jun 8, 2020 at 7:29 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> It is enough to simply map the SiFive FU540 DDR memory controller
> into the MMIO space using create_unimplemented_device(), to make
> the upstream U-Boot v2020.07 DDR memory initialization codes happy.
>
> Note we do not generate device tree fragment for the DDR memory
> controller. Since the controller data in device tree consumes a
> very large space (see fu540-hifive-unleashed-a00-ddr.dtsi in the
> U-Boot source), and it is only needed by U-Boot SPL but not any
> operating system, we choose not to generate the fragment here.
> This also means when testing with U-Boot SPL, the device tree has
> to come from U-Boot SPL itself, but not the one generated by QEMU
> on the fly. The memory has to be set to 8GiB to match the real
> HiFive Unleashed board when invoking QEMU (-m 8G).
>
> With this commit, QEMU can boot U-Boot SPL built for SiFive FU540
> all the way up to loading U-Boot proper from MMC:
>
> $ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin
>
> U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
> Trying to boot from MMC1
> Unhandled exception: Load access fault
> EPC: 0000000008009be6 TVAL: 0000000010050014
>
> The above exception is expected because QSPI is unsupported yet.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
>  hw/riscv/sifive_u.c         | 4 ++++
>  include/hw/riscv/sifive_u.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c94ff6f..7923df4 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -82,6 +82,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
>      [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
>      [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
> +    [SIFIVE_U_DMC] =      { 0x100b0000,    0x10000 },
>      [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>  };
> @@ -733,6 +734,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>      create_unimplemented_device("riscv.sifive.u.gem-mgmt",
>          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
> +
> +    create_unimplemented_device("riscv.sifive.u.dmc",
> +        memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
>  }
>
>  static Property sifive_u_soc_props[] = {
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 5d80f91..3e33646 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -78,6 +78,7 @@ enum {
>      SIFIVE_U_UART1,
>      SIFIVE_U_GPIO,
>      SIFIVE_U_OTP,
> +    SIFIVE_U_DMC,
>      SIFIVE_U_FLASH0,
>      SIFIVE_U_DRAM,
>      SIFIVE_U_GEM,
> --
> 2.7.4
>
>

