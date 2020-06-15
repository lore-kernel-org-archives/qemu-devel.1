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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BB42067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja9TLWo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BB42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksB8-0001w6-J3
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jks7N-0006iU-OT; Mon, 15 Jun 2020 12:37:53 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jks7D-0000hk-7P; Mon, 15 Jun 2020 12:37:53 -0400
Received: by mail-il1-x141.google.com with SMTP id x18so15942825ilp.1;
 Mon, 15 Jun 2020 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=txXM3MgeLbWFZbvN7Of7+o1pSroCioT03fnhDcZg4Ok=;
 b=Ja9TLWo6uJ5AM5x0y5E7VYnyY2rRSFe7ND8EmQhwbsbsJj0bRlwfZ+4kxfU8EN9UrN
 hgyb70deIyhqSuABjCGggSlSxRlLpbklqbdANu4h70s3Z6Z5eJtDqfFdd7WEt8B0Kx3v
 Lup0VXHsmbblDDeAdmBDEhymDVJesQExwp7oUTiIxlxKtJ2ABDBAsK1D7dHJ8TVVvyLp
 6Bx5fPUte1LWsjMXiJ3f9Ev0JACN23uwA31pVUwp+op75NNLY4vGSwh1CcuLeDVSV9Ve
 i5r/6L351HHaKiZZhT+n46N0oQjyvol0Nzb4trLFLVol34pDbbhfn/7GLLf0qouk47A1
 u3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=txXM3MgeLbWFZbvN7Of7+o1pSroCioT03fnhDcZg4Ok=;
 b=QTcMWP4z8XsagxIFzKl/6x7olLvEW2p3uQFtkLrs58dlwd1XX1ks2f/q0+RX5Tth6Z
 ggKS3X/1jI1zL3GbLR+vIE7yCCGzCrjLw+9Ix1ygdeZ3wdZCQPdstb1PkX4+B+V2V8Yg
 YmL5PLEdNQU6XKOiU/GL8bOVXsUwUxp6QNBNs7PpOZxw8xny2pCK99+iU9ASHdnMzdpm
 3vn+/+f54Iu7XBZ4CgkbbomqfLWCWoyiEsVemjh0L3U+XQ1Sq0o3bvjscyHP1TrnfKov
 GionVgEi2klD3nLNcRVHMqBGfElfmE7l5u5teAkJ20+55G/ziU+ggXi4CNyzvTuIXLM5
 sG9A==
X-Gm-Message-State: AOAM532Qvp9tgQe1wxPasdTjBEttugRQFusBHb+qQLpa9JoYXn1OX2ac
 Zf8Q3nsqaWMmjSXUrqc8a6nceu17NapUJdWlOnE=
X-Google-Smtp-Source: ABdhPJy8GuxAXfr6eotHbaemPoTuZCr69J28WcS6++MbyG6KJXB6xTfAqRCbnAAXKI8DBKPuCp6IQyFDlGEzyyg6giY=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr27636180ili.40.1592239061451; 
 Mon, 15 Jun 2020 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-9-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-9-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:28:18 -0700
Message-ID: <CAKmqyKNwobjiCpQAVPhmwsf+y1w88g=P8x+pCT1JESLy8zf+ZA@mail.gmail.com>
Subject: Re: [PATCH 08/15] hw/riscv: sifive_gpio: Do not blindly trigger
 output IRQs
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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

On Mon, Jun 8, 2020 at 7:24 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the GPIO output IRQs are triggered each time any GPIO
> register is written. However this is not correct. We should only
> trigger the output IRQ when the pin is configured as output enable.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_gpio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
> index 0d0fd2b..aac6b44 100644
> --- a/hw/riscv/sifive_gpio.c
> +++ b/hw/riscv/sifive_gpio.c
> @@ -76,7 +76,9 @@ static void update_state(SIFIVEGPIOState *s)
>              actual_value = pull;
>          }
>
> -        qemu_set_irq(s->output[i], actual_value);
> +        if (output_en) {
> +            qemu_set_irq(s->output[i], actual_value);
> +        }
>
>          /* Input value */
>          ival = input_en && actual_value;
> --
> 2.7.4
>
>

