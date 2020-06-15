Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391ECC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16E320739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGBbsIE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16E320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuZK-0002iL-47
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuYQ-0001dY-Py; Mon, 15 Jun 2020 15:13:58 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuYP-0002G2-A4; Mon, 15 Jun 2020 15:13:58 -0400
Received: by mail-io1-xd41.google.com with SMTP id r77so19173674ior.3;
 Mon, 15 Jun 2020 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mie1W8ED9wBsurJiopqcHQ76fLIUB6I1Vlo4bhBlg1o=;
 b=AGBbsIE5rlgXnUYOLGKjjD14r1IvwjGB2DiDV0y0ag8FSHDPpZNrW7Cxur6cFK3tEZ
 f3DsEt60gQCIDGehro3PnFgy9UnEm82S5COR0/eifuqszpuREZmmPlAiB5vslDOYMNuP
 cqfc4I4BHXog9A63M24ljmuIX04OXa/jwLDwgONlRrMLABKpDqRHZIAHFYGrwI6iwLin
 rSiqt192j/bJWYNeyVPOl0Emt0uINI7wo0XB42zs2BqJt6tntjb3ikenobjfpTsFCYN4
 DLqcPG43VtCGLQo2bzRmu6RlPMQJ7PD0TWlSuaLLKZvUa4nxYi2GO543Gxsj2KVhhU+C
 5Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mie1W8ED9wBsurJiopqcHQ76fLIUB6I1Vlo4bhBlg1o=;
 b=NrJ4gJTp2vIWxombZf4Q3h6/asxkumNpF9CCmzWMtbsTLVCFzs51KnBPt4shVR+uHE
 Cl0F2RAIf4XB3+IRBb7OYDLBett7sbvapm5Rhx8pO2n39Bn24gkjKKw1ZpvJzORIkyS6
 XXDEyO6POCz6rbA3TJTa2nAWD002kGLzd9b7NDplM2Qp+9J0Lrc5tDS5Xnl6dLI2tWDu
 IM7Aluutwjn+i70kHyyedJKcYg4bb7R3B1IMotPXo/V4d52YYxUIc7Qz5wlN597jOxxU
 4gKvpyGQMVoyNKNcxXqSxntKeu5fbCUFU9Uvy2+N8wjinJQltS5OdZk37Xc9oDqwG4Du
 6s0w==
X-Gm-Message-State: AOAM530rdUva3D1o/RlhIV0ARjcI1RjEYVD7RCvstuFJxiYdFnNiI2Z2
 Y/y2yWSzWEbokw6mMunlWs3en9tSmK0AUoJTpTw=
X-Google-Smtp-Source: ABdhPJxPGEBcxs/KpmUffJdb6ILjHFVU3/YOYFqUzWTnDlTSTzmSCYM/s8/h7P8z1qXnz3hVrHVfaKgLEz6coSSjQw0=
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr28866066ioj.176.1592248436042; 
 Mon, 15 Jun 2020 12:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-15-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-15-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 12:04:32 -0700
Message-ID: <CAKmqyKOAqrQu-s8Sco=bC-JZgemuQN=2N3DVHZ22HCgWCPGz7g@mail.gmail.com>
Subject: Re: [PATCH 14/15] hw/riscv: sifive_u: Sort the SoC memmap table
 entries
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

On Mon, Jun 8, 2020 at 7:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Move the flash and DRAM to the end of the SoC memmap table.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index f64aa52..c94ff6f 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -80,10 +80,10 @@ static const struct MemmapEntry {
>      [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
>      [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
>      [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
> -    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
> -    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>      [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
>      [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
> +    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
> +    [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
>  };
>
>  #define OTP_SERIAL          1
> --
> 2.7.4
>
>

