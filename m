Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D4C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F69720776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdiK1M2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F69720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjjN-00057W-JZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 15:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBjYY-0005Q3-RV; Fri, 28 Aug 2020 14:56:58 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kBjYX-0000a5-5C; Fri, 28 Aug 2020 14:56:58 -0400
Received: by mail-il1-x141.google.com with SMTP id w3so1559351ilh.5;
 Fri, 28 Aug 2020 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xvM8jk1gWPdjatEcuODUoU3vMYViBVtMqM7D9BJ9Ua0=;
 b=UdiK1M2R53qAAwhJHfTMR6kl9XVcj2lOZc4ektqSTNo4MwNt/6NHY/8vM7DIG89ck/
 /NLVUcK2Za+h21vO7WWDzxranXKBnSc4UNRvhhmUdrCBExf/OmBJggkOAsr837K+SCvK
 YmYt2R7WXGo2XEcI5Jz4oz9+WC5KJUxXm6Qz/3C9AEF8ZabtOTiqYZu6LDwl+4eBTOeA
 HQbzvHyUgSCf5jXcVeqVLajoJsnYoIew5HbqOLytkbnArVk28m9AgsBaOAN4SOF5Y5P8
 YSOx3PZh7T7DaCfbDUUHFMcUao+YlfBsopo3bj4rxrAzyxcCPN0cNa2amGDenWHPUWEj
 LfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xvM8jk1gWPdjatEcuODUoU3vMYViBVtMqM7D9BJ9Ua0=;
 b=Ao9TEbpSzxH3fdpE1f+u3yleKtdFbJoLUDfnkq2kpOjjqzhjRoepUh/pnEJIHYR8++
 wK5m/RfPZmY+YD+dsGSfTORrhuuGcYt7TPeVv2/MX5aEi9XDUjJTERmnOfspLHZpnmvu
 +mlIEX8za8Es8uNRwZICJIRpa+yB5eXQOEapIRnyGmhinHR5p68HMz74oAayOwHBWrbI
 2K3ftYkVg33oN3KNSEmRsv+B5iqpr72HwnD3cUWXjGnJjy4E0qzhQra4LCjRzGNHsHq0
 TVCq1YoONuN0ZXq30QwI8U0p6/O6bH2YuvbT68OB/ATLaclnD3HaPTWeFuvztNzCZiFO
 9v1g==
X-Gm-Message-State: AOAM5338mRvVg3ET+/eGzwH1oFUMbKBwgqrBWSn47F2YR7VLeJqeeQpQ
 gxqA233tDYiMzEXZrLVuKYY+xNIRLSjcsP3dxszAJFaArd0=
X-Google-Smtp-Source: ABdhPJyxhM+/MU8YbC3ANj40ZVzbrqM2+xn8XJIR0b4s2q57MYd+EEDAqpeNAWHsL1RMR3MfanSKEYdBX8otlucLnME=
X-Received: by 2002:a92:589a:: with SMTP id z26mr239751ilf.267.1598641015468; 
 Fri, 28 Aug 2020 11:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
 <20200828113931.3252489-3-edgar.iglesias@gmail.com>
In-Reply-To: <20200828113931.3252489-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Aug 2020 11:46:08 -0700
Message-ID: <CAKmqyKPuqYdKG9qZo1KJFrWEeXZb+YVPypaTkLzMmq4EOVDn4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/microblaze: Improve transaction failure
 handling
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 4:41 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> When the CPU has exceptions disabled, avoid unwinding CPU
> state and clobbering registers if we're not going to raise
> any exception.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/op_helper.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 13ac476199..190cd96c6a 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -483,22 +483,17 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>      cpu = MICROBLAZE_CPU(cs);
>      env = &cpu->env;
>
> -    cpu_restore_state(cs, retaddr, true);
>      if (!(env->sregs[SR_MSR] & MSR_EE)) {
>          return;
>      }
>
> -    env->sregs[SR_EAR] = addr;
> -    if (access_type == MMU_INST_FETCH) {
> -        if (cpu->cfg.iopb_bus_exception) {
> -            env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
> -            helper_raise_exception(env, EXCP_HW_EXCP);
> -        }
> -    } else {
> -        if (cpu->cfg.dopb_bus_exception) {
> -            env->sregs[SR_ESR] = ESR_EC_DATA_BUS;
> -            helper_raise_exception(env, EXCP_HW_EXCP);
> -        }
> +    if ((access_type == MMU_INST_FETCH && cpu->cfg.iopb_bus_exception) ||
> +        (access_type != MMU_INST_FETCH && cpu->cfg.dopb_bus_exception)) {
> +        cpu_restore_state(cs, retaddr, true);
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ?
> +                             ESR_EC_INSN_BUS : ESR_EC_DATA_BUS;
> +        env->sregs[SR_EAR] = addr;
> +        helper_raise_exception(env, EXCP_HW_EXCP);
>      }
>  }
>  #endif
> --
> 2.25.1
>
>

