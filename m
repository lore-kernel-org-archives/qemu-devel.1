Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9BFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283BB206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwJSp3x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283BB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjbd-0003n0-FC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jsjam-0001PJ-Rw; Tue, 07 Jul 2020 05:08:44 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jsjal-0007NG-3g; Tue, 07 Jul 2020 05:08:44 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a30so4909297ybj.5;
 Tue, 07 Jul 2020 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6+gRvNoE8S1z/mxk8ZMSzXMftWS1IFjV+yoc1Jeu7To=;
 b=jwJSp3x87HqzrLnDOfPUvkbKTufmEHZrTnN4MIY01tD9OS4mFeFfC53ojJoRfqyMm+
 hHbR7/09/HsPq3RSW7DNG7TYMZHAz2qZgRdLAgdsVyLIXgmgbCLu03QW618ASQ01rSU+
 mkUjpEPhy7NFU7PaKgYWn7mOd+47LQPmhXiW9gVS8oNkCvqlYba9f9JwJSS17/X1nPqu
 GczQWaTEzNghfkV7zfPKP1MepT2fXpjQQuqZX0ZzXSaZmDBaNmJvbMim5zDnJM9oogiA
 bVAOz6hW6cakXBhWGi+yL/gW5803t06OUwlKZLhEMxEk6xo+scspMPPiXb+eHOkGlDfi
 ns9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6+gRvNoE8S1z/mxk8ZMSzXMftWS1IFjV+yoc1Jeu7To=;
 b=A5qFUVVvUuRse8CkabYB2j5SCv5WQi8JzE82Xa8wbrEhFQUIBv+/w4+s61y1igNLXu
 QlHOZHk6bIf5nPjAzoB/mvlKXx9kYB4XWjvyeSzS5fyaHbw2mrqX6q9o805YfZLduVqr
 HVNQyvm4j2k/P2hREQUQ8oUKutRfUDpFo4FPkbydzoKHCK1h0uITmEPXM1OrSY8gydRU
 JJBVv9K6nIylGoLjvHcMSoC3AOnhkWz6nlq+nO2cECCkarm9YNRrFuxQxHW2yjPgaF08
 do7RkQsrDofLsL6Wi8gl5VWdE1QawgjVWAOW4/9v8atRJwtXGfrBjQFn9ORDm2aDnJvg
 +HIA==
X-Gm-Message-State: AOAM530zOMbQ3UgQgyLzoI8AH8Kk7H1gBWAE1oDODwmIIy5TZvwf9DOm
 VP0SuNHN/y2Vq37VcNcg52ewsNDKHgyabqCw5lM=
X-Google-Smtp-Source: ABdhPJy/eTQYISmkFC5sl9jb3YRDb0g2f8jrGwBiN3jzIHHjbEsXtoYFgYC/mcFHs45MrZMV+U+TkEYJq4oDPvYWQ+4=
X-Received: by 2002:a25:aea5:: with SMTP id b37mr27142530ybj.239.1594112921338; 
 Tue, 07 Jul 2020 02:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707020728.23420-1-jcfaracco@gmail.com>
In-Reply-To: <20200707020728.23420-1-jcfaracco@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 7 Jul 2020 17:08:30 +0800
Message-ID: <CAEUhbmUXV_xUUuph3FmNbLAUUtMtBvQATOYvp4Ou1iytSDY1TA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add OpenTitan Big Number (OTBN) device address
To: Julio Faracco <jcfaracco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 7, 2020 at 10:08 AM Julio Faracco <jcfaracco@gmail.com> wrote:
>
> This commit adds basics skecthes to implemente a OTBN unit.

typo: skecthes, implemente

> OTBN has address 0x50000000 and size 0x400000.
> For further reference, see OTBN docummentation:

typo: docummentation

> https://docs.opentitan.org/hw/ip/otbn/doc/
>
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  hw/riscv/opentitan.c         | 5 ++++-
>  include/hw/riscv/opentitan.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 19223e4c29..8a5d060b57 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -50,7 +50,8 @@ static const struct MemmapEntry {
>      [IBEX_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
>      [IBEX_NMI_GEN] =        {  0x40140000,  0x10000 },
>      [IBEX_USBDEV] =         {  0x40150000,  0x10000 },
> -    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 }
> +    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 },
> +    [IBEX_OTBN] =           {  0x50000000, 0x400000 }
>  };
>
>  static void opentitan_board_init(MachineState *machine)
> @@ -183,6 +184,8 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
>          memmap[IBEX_USBDEV].base, memmap[IBEX_USBDEV].size);
>      create_unimplemented_device("riscv.lowrisc.ibex.padctrl",
>          memmap[IBEX_PADCTRL].base, memmap[IBEX_PADCTRL].size);
> +    create_unimplemented_device("riscv.lowrisc.ibex.otbn",
> +        memmap[IBEX_PADCTRL].base, memmap[IBEX_OTBN].size);
>  }
>
>  static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 8f29b9cbbf..c739d44fbc 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -68,6 +68,7 @@ enum {
>      IBEX_NMI_GEN,
>      IBEX_USBDEV,
>      IBEX_PADCTRL,
> +    IBEX_OTBN,
>  };

Other than that,
Reviewed-by: Bin Meng <bin.meng@windriver.com>

