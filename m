Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B5C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 23:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE742070E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 23:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shc0tNBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE742070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW6pn-0006sZ-Pt
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 19:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW6ov-0006LJ-Pv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 19:50:05 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW6os-0004ZC-Md
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 19:50:05 -0400
Received: by mail-io1-xd43.google.com with SMTP id p7so3967302ioo.6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1zy652d4q65MShhE3bYLwaQHTK2+xfAfd16/aqdTimQ=;
 b=shc0tNBm/frcBeK8/fMghW0uhrNrEMNpuHoRdT32/yhJGmoz2J9rGAKDm0bAGqSB/O
 1BwPHiKCo9doJbhEyMtHf2yCDYtJ/uYMO0FMm9xQgbDuoirKrm3gwIarmyjFRh56Gzqm
 UcBvyV1ULH8kXtLGJZpLYibjQxP2rU4TFKgUXAa24q+ziO8QF7nuNpL/8WQNc69tEFez
 CdVOKCy2Qg0YJ74Z5QqlwmVj5cW0pwid/6zNqbd6BBRAHTo+U8nRIjf5eWKviklG1FoO
 KqpTbH97lLjl78JjHWyUzxR04aU/Ndi5D0THLoeh9trkG1XzzhDi3cK6vYK0Og6Hytjq
 HqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1zy652d4q65MShhE3bYLwaQHTK2+xfAfd16/aqdTimQ=;
 b=n+benZnk1YHx0PcWl9mWv469U1dvszhJHab1lBWBbpF9kSG9s5cz296Ylh2AIFYFVv
 DoUJ3KkemFecMJnLuDX2F6dbp1e67ls75TRXEPxk6UbkiRofTnTm+xiHLE37+PmVzvP2
 5Q6r9EfMCZiN2ybKws0tt1+ck5xXQqnGLt4uh5HU9a4j5wBTxfODhrt6cYlLkYZQ4EZF
 rThzZQ6KVeCWoL2DvhUxRJoFzgG7kTjR2ghXnC71ARYLG1aUeGA5PuJz+huPmNT8alhq
 6Zhnr36VEMQgPkDC+oxgZ7MlNItipfyr4WMeZOmqD37x5OEwOMa2dczGN2SAOr59hmrM
 l6Sg==
X-Gm-Message-State: AOAM531NiQtCY/KkVUvod+UB67bdTpnWHqNH5sxoXHFm9MAWLIhnNOg3
 7qeNTkexm2pGSw7ZJ29fvR9kzLiDHnXnmoOgmN2F8TkmVYs=
X-Google-Smtp-Source: ABdhPJzuYQhQP31tCinhLLCpbZlQqur1k4oGPeUf9EQWUQPv6zuwyW/zCA0orAYJhyw03oydMrIBD8VAlIwQIrkmRMc=
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr3566536iof.175.1603497001803; 
 Fri, 23 Oct 2020 16:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-2-keithp@keithp.com>
In-Reply-To: <20201023214506.917601-2-keithp@keithp.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 16:38:14 -0700
Message-ID: <CAKmqyKN20Fg_cKXmh2-vUaY4gPkE=PtPome5vwoTW9rM1gBTog@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Add sifive test device to sifive_e target
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:45 PM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The SiFive test device provides a mechanism for terminating the qemu
> instance from the emulated system. This patch adds that device to the
> sifive_e target.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  hw/riscv/sifive_e.c         | 4 ++++
>  include/hw/riscv/sifive_e.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index fcfac16816..417e3a5409 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -11,6 +11,7 @@
>   * 3) PRCI (Power, Reset, Clock, Interrupt)
>   * 4) Registers emulated as RAM: AON, GPIO, QSPI, PWM
>   * 5) Flash memory emulated as RAM
> + * 6) TEST (Test device)
>   *
>   * The Mask ROM reset vector jumps to the flash payload at 0x2040_0000.
>   * The OTP ROM and Flash boot code will be emulated in a future version.
> @@ -45,6 +46,7 @@
>  #include "hw/intc/sifive_clint.h"
>  #include "hw/intc/sifive_plic.h"
>  #include "hw/misc/sifive_e_prci.h"
> +#include "hw/misc/sifive_test.h"
>  #include "chardev/char.h"
>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> @@ -57,6 +59,7 @@ static const struct MemmapEntry {
>      [SIFIVE_E_DEV_DEBUG] =    {        0x0,     0x1000 },
>      [SIFIVE_E_DEV_MROM] =     {     0x1000,     0x2000 },
>      [SIFIVE_E_DEV_OTP] =      {    0x20000,     0x2000 },
> +    [SIFIVE_E_DEV_TEST] =     {   0x100000,     0x1000 },

I don't see this mentioned in the FE310 data sheet. Is it included in
the hardware?

Alistair

>      [SIFIVE_E_DEV_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_E_DEV_PLIC] =     {  0xc000000,  0x4000000 },
>      [SIFIVE_E_DEV_AON] =      { 0x10000000,     0x8000 },
> @@ -216,6 +219,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_E_DEV_CLINT].size, 0, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          SIFIVE_CLINT_TIMEBASE_FREQ, false);
> +    sifive_test_create(memmap[SIFIVE_E_DEV_TEST].base);
>      create_unimplemented_device("riscv.sifive.e.aon",
>          memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
>      sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 83604da805..92bab6d0d4 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -56,6 +56,7 @@ enum {
>      SIFIVE_E_DEV_DEBUG,
>      SIFIVE_E_DEV_MROM,
>      SIFIVE_E_DEV_OTP,
> +    SIFIVE_E_DEV_TEST,
>      SIFIVE_E_DEV_CLINT,
>      SIFIVE_E_DEV_PLIC,
>      SIFIVE_E_DEV_AON,
> --
> 2.28.0
>
>

