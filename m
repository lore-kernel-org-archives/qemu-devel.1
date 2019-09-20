Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DF62086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwLQyrjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DF62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBO38-0008Hj-Im
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 14:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iBO00-0001cF-CU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iBNzy-0005P1-QJ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 14:51:20 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iBNzw-0005NF-Rn; Fri, 20 Sep 2019 14:51:18 -0400
Received: by mail-lf1-x143.google.com with SMTP id u3so5728404lfl.10;
 Fri, 20 Sep 2019 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/r1z3XdozrSg5hiEdNJT8S+6KbDkz/+rhir16zqnjxc=;
 b=GwLQyrjc4A+E+3Bc1eLxC1I1i8dwbZSRCdX/jJ2eNBjhtJ9u4QNJ/zNcgbWqyVSTpc
 VbmrW6/7+MzCwbmCMoK7rqPgwAYHUc1vpRFYVR7xgDVU0ugOjQbltPytyDHVdHxZAwwd
 juNSixuB/QZaaojLG6lpOOPpOFxZLe/cKs/52oPf4QUE3ySP3t/FNbSUS9EwBVn7yx1N
 tk0IYd7XHjTvt3QX6jstUEAbqqXPqOcn5nOwRWfQJOBLuaBVYOpzLtSIb2jmBVwQnuCS
 rStI9Qx/0Oaq8N3qIUA2+Am5YCPmQuOc+mWYP2Vo5BZJs+xuxWQdc82HRlrFncYK5BUT
 siAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/r1z3XdozrSg5hiEdNJT8S+6KbDkz/+rhir16zqnjxc=;
 b=g0K9kKBUaQQubWpylnMlyO4PLfaONpf4/pmcoUqbVS+ZTJX0FDM7Gv2uD4mDbKI7wX
 GKTBQplTi9SMuFO9/zxgoznCr/QxGyzrUIOtpH1/egs0l8fe1sOqJF4Tu6cPUTjXbPFx
 pOrdP2yiSpg0hFxqLEK6qVw+CP+Y5W5Cpsl6YeT68ReN4QE6rfgaOjEN7tlaa8P85HXn
 Ka+DEy87PLMRsV4DaRlg46kKwVsWP+qeseYARO5HpQ7N6hoNHyhqU6+MENBYJYIl2jru
 kggKEi5VDhgYoW7V46tWt8/Dn5Yl8ymj0a0UhvnjgBjwfvOCTTJmTq6bb4sjVCIaXMpq
 Y+wg==
X-Gm-Message-State: APjAAAUyYnz5dqfKtEUYPPndndBvFPvfpje3vMpB1K5Cj/14ERG1ciMS
 o38IPsq4pqw/dGwS+us6mItWN085uS3x3d6GLBM=
X-Google-Smtp-Source: APXvYqxUGyiFKRPn/dPvuVurZwX+bltpfjaWpomfjfN8ALXfi8JtybY9KdBWbskTfGZ0EWQ0ie172QpBPhrYe5WAF84=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr9599479lfq.5.1569005473978;
 Fri, 20 Sep 2019 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <1568971142-27979-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1568971142-27979-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Sep 2019 11:46:38 -0700
Message-ID: <CAKmqyKMa-kG7zrjFJ7aZd1Ey=7sCRHj2wEkukFz4GkT5gR0fKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: sifive_u: Drop "clock-frequency" property of
 cpu nodes
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 2:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> The "clock-frequency" property of cpu nodes isn't required. Drop it.
>
> This is to keep in sync with Linux kernel commit below:
> https://patchwork.kernel.org/patch/11133031/
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c         | 2 --
>  include/hw/riscv/sifive_u.h | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9f8e84b..02dd761 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -151,8 +151,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>          char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
>          char *isa;
>          qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -                              SIFIVE_U_CLOCK_FREQ);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu != 0) {
>              qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4df298..4850805 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -75,7 +75,6 @@ enum {
>  };
>
>  enum {
> -    SIFIVE_U_CLOCK_FREQ = 1000000000,
>      SIFIVE_U_HFCLK_FREQ = 33333333,
>      SIFIVE_U_RTCCLK_FREQ = 1000000
>  };
> --
> 2.7.4
>
>

