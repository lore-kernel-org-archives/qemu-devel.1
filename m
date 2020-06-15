Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA0C20714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukzvHSyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA0C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkv0t-00031o-Ey
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuyC-0008HV-M8; Mon, 15 Jun 2020 15:40:36 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuyA-0006i0-Qa; Mon, 15 Jun 2020 15:40:36 -0400
Received: by mail-il1-x143.google.com with SMTP id p5so147602ile.6;
 Mon, 15 Jun 2020 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jp42kBAUA7U2Nm7mn62S8Xlr804bOEMiFEW0kgbKwVI=;
 b=ukzvHSyE0c55e+3LGTVDlSKHcgOygIT/JJGTyjS6zmypAUcKMtEI5NIlMUUD5/9tOV
 8m/doAXv8UGp2NQbsq5I3tEzWEhTwRtFg/pvsI3HxHb4ZoCnlGcKB5OJ/tGyyBAZGdY2
 Q/fW3VoJuin8s6+skLpayTAS9QlL3vH5wHhTcFvTEpBVwSdlku+UvHhWTO9eyN3GG5Oc
 EM1Yb7OzNyZmbbeXyRc6CyskAAzQ3Z7sHoWpuxshmdoB94SMtQ59pVkVpZphKrv8k6mI
 Ft3qjoEUpiS2C69IdlL4Jyv+LbLp+OcE/qdZxZ7FQcQ13qnU1DgIqk2fA4uFIhQf6Lsq
 H5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jp42kBAUA7U2Nm7mn62S8Xlr804bOEMiFEW0kgbKwVI=;
 b=mNtTe3rkJ+tCAc53BjERbrgvkymYXWZo2iqRCOFXU5rw7Kbrv7+UgwG9AiYPJgOhUc
 9zFaKsCogjUtMWTvafgGqe83seFtmmyj09MxIpQxPLBf34OdH0TP4M/dnAtq4LYPVTRj
 4H1h9jneyywHtRvKEJj4XMMEEhe9cHVKE7X0G4SMd/DW6iwp3oblPVLUdXtmqgzD00/e
 qMaCcadRWIF1zOM2587w4b1WnbGLPW6eV/0EJ+LHtPTCvlta8scDsOTh7hF9cpoCXiw9
 F/D3efKVTyK3x1nEz0E8qxktGuCXMO87RvIZz4ptzAVPmjEe6SAw1+kf9ev2zroultjj
 nTxA==
X-Gm-Message-State: AOAM533FsJYO2QsbE5lNQE5XKku8KHR8i5kWbvXj5Ae5PjdHZLDv8b/J
 atUJkTsJbp6g368r2sPzIDIjFkYaKd6tYmYpDZA=
X-Google-Smtp-Source: ABdhPJwzPr1BqWIrmpRv82VTDaH6puajnLzQZrlVAOmYoLH9/lk22G3C94vF3jrqYUT6vEmtToJxj3pV69BUK2mqIeo=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr28365902ili.40.1592250033326; 
 Mon, 15 Jun 2020 12:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 12:31:10 -0700
Message-ID: <CAKmqyKOtX5QpBDY_e+Z93ALqStqRKo8DF_2=ShGEFF6WDy_95w@mail.gmail.com>
Subject: Re: [PATCH 00/15] hw/riscv: sifive_u: Add GPIO and Mode Select
 (MSEL[3:0]) support
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

On Mon, Jun 8, 2020 at 7:18 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This series updates the 'sifive_u' machine support:
>
> - Add GPIO controller support
> - Support reboot functionality via GPIO pin#10
> - Change SiFive E/U series CPU reset vector to 0x1004
> - Support Mode Select (MSEL[3:0]) settings at 0x1000 via a new
>   "msel" machine property
> - Add a dummy DDR memory controller device
>
> The series also does some clean-ups to the existing codes.
>
> With this series, QEMU can boot U-Boot SPL built for SiFive FU540
> all the way up to loading U-Boot proper from MMC:
>
> $ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin
>
> U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
> Trying to boot from MMC1
> Unhandled exception: Load access fault
> EPC: 0000000008009be6 TVAL: 0000000010050014
>
> The last big gap for the 'sifive_u' machine is the QSPI modeling.
>
>
> Bin Meng (15):
>   hw/riscv: sifive_e: Remove the riscv_ prefix of the machine* and soc*
>     functions
>   hw/riscv: opentitan: Remove the riscv_ prefix of the machine* and soc*
>     functions
>   hw/riscv: sifive_u: Simplify the GEM IRQ connect code a little bit
>   hw/riscv: sifive_u: Generate device tree node for OTP
>   hw/riscv: sifive_gpio: Clean up the codes
>   hw/riscv: sifive_gpio: Add a new 'ngpio' property
>   hw/riscv: sifive_u: Hook a GPIO controller
>   hw/riscv: sifive_gpio: Do not blindly trigger output IRQs
>   hw/riscv: sifive_u: Add reset functionality
>   hw/riscv: sifive_u: Rename serial property get/set functions to a
>     generic name
>   hw/riscv: sifive_u: Add a new property msel for MSEL pin state
>   hw/riscv: sifive: Change SiFive E/U CPU reset vector to 0x1004
>   hw/riscv: sifive_u: Support different boot source per MSEL pin state
>   hw/riscv: sifive_u: Sort the SoC memmap table entries
>   hw/riscv: sifive_u: Add a dummy DDR memory controller device

I have applied patches 1 to 11 to the RISC-V branch.

Alistair

>
>  hw/riscv/opentitan.c           |  29 ++++----
>  hw/riscv/sifive_e.c            |  32 +++++----
>  hw/riscv/sifive_gpio.c         |  45 +++++++-----
>  hw/riscv/sifive_u.c            | 158 ++++++++++++++++++++++++++++++++++-------
>  include/hw/riscv/sifive_gpio.h |   8 ++-
>  include/hw/riscv/sifive_u.h    |  27 +++++++
>  target/riscv/cpu.c             |   4 +-
>  7 files changed, 223 insertions(+), 80 deletions(-)
>
> --
> 2.7.4
>
>

