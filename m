Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E700CC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 16:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4387520709
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtE8O7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4387520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kExMN-0003X5-7W
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kExLY-0002x1-AT; Sun, 06 Sep 2020 12:16:52 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kExLW-0007XS-Cj; Sun, 06 Sep 2020 12:16:51 -0400
Received: by mail-io1-xd43.google.com with SMTP id h4so11754739ioe.5;
 Sun, 06 Sep 2020 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aIpmbdaLWoPexlIzZVbHNWpQNe4CUFhooFPjYEtny8A=;
 b=BhtE8O7WCUJOBd0JCDNm+lgZaVPUXSOymH3tdUECKDEQ4MKjCMROtZYnOyNs2Y6/kZ
 3CG9A85G5WJKCF//hylTQINk1CyINFwRCfqW1F3NzNFB5oCFjKq39u14B4CwcBcXQB4Y
 0EV2lWiqP7aVDBvwSxjSBEonk75bffrEEESMJZlY61e9wacLoZNp+Wtx8mwnUxy2LDd/
 b8NUc2cNVTCBMn8+5SbRzR3yOOshtNh1T16Jg990MBGY9CyXgiB/b09fHEdgcsWx5ozD
 EQFqkDmIISEQ8JCPkh8TApDbiwisuj5BcimbnsPwxWL2lMYwaxI4J2b2jlYf9zvo6v2a
 K4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aIpmbdaLWoPexlIzZVbHNWpQNe4CUFhooFPjYEtny8A=;
 b=QW/FNXSVupztJ7oURxktXE/6+b9j7YgQruYgvaQHxUjRp2cRgAVhCrxHvxyTwqBj5r
 TyUy+t81cyD4iwKUgkMkjpMtXFspPusuMriUgDt9wFkjl66NDoAdJv7Sv7BSf0tQNjll
 8Fao+Btv70zZrNfrvbqtZhqAG/LDle0TSBN8T7zdWA2qxszyo5UL4Dm+gGxfkY9w9u4G
 FH6xh0H2z2VeV6Yj9385hCP0yHQIWcodeiTeypa1ypWh44sJ5PR0Hnk0FOnRvgwRjOfM
 UutRIq0/6Oq9JptA5b+ObeUn+bOKixz5Trkj95saa5LYDP5ikNM/7bq3c8Ly80MU9lmy
 6PUw==
X-Gm-Message-State: AOAM5328VO++Kx8syivtQ8LzXBIVm5bPfh4UZbmIOQGq2je6H5V2dNVv
 nFF6CgGpV+sC/4IkMlFr+FAnyo3Ts+6HX5BVPzk=
X-Google-Smtp-Source: ABdhPJwbGk/miDL/6u+Z/P2GZg4RW3ciZGyFVr6koAe4qJmLduV30hulMUWuqZNoilACyJftC+g9pOHqyZhvpa3vGvE=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr14476320ios.176.1599409008587; 
 Sun, 06 Sep 2020 09:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 6 Sep 2020 09:05:50 -0700
Message-ID: <CAKmqyKMOoSn6rgTvK7KF5f48PpsWberDtAmUyGJ1M3zXHquomA@mail.gmail.com>
Subject: Re: [PATCH 00/12] hw/riscv: Clean up the directory
To: Bin Meng <bmeng.cn@gmail.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 3:41 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Peripheral models for a specific SoC are moved to its
> corresponding hw/* subdirectories.
>
> This series should be applied after the PolarFire SoC series:
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=198727
>
>
> Bin Meng (12):
>   hw/riscv: Move sifive_e_prci model to hw/misc
>   hw/riscv: Move sifive_u_prci model to hw/misc
>   hw/riscv: Move sifive_u_otp model to hw/misc
>   hw/riscv: Move sifive_gpio model to hw/gpio
>   hw/riscv: Move sifive_clint model to hw/intc
>   hw/riscv: Move sifive_plic model to hw/intc
>   hw/riscv: Move riscv_htif model to hw/char
>   hw/riscv: Move sifive_uart model to hw/char
>   hw/riscv: Move sifive_test model to hw/misc
>   hw/riscv: Always build riscv_hart.c
>   hw/riscv: Drop CONFIG_SIFIVE
>   hw/riscv: Sort the Kconfig options in alphabetical order

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  {include/hw/riscv => hw/intc}/sifive_plic.h |  0
>  hw/riscv/trace.h                            |  1 -
>  include/hw/{riscv => char}/riscv_htif.h     |  0
>  include/hw/{riscv => char}/sifive_uart.h    |  0
>  include/hw/{riscv => gpio}/sifive_gpio.h    |  0
>  include/hw/{riscv => intc}/sifive_clint.h   |  0
>  include/hw/{riscv => misc}/sifive_e_prci.h  |  0
>  include/hw/{riscv => misc}/sifive_test.h    |  0
>  include/hw/{riscv => misc}/sifive_u_otp.h   |  0
>  include/hw/{riscv => misc}/sifive_u_prci.h  |  0
>  include/hw/riscv/sifive_e.h                 |  2 +-
>  include/hw/riscv/sifive_u.h                 |  6 +--
>  hw/{riscv => char}/riscv_htif.c             |  2 +-
>  hw/{riscv => char}/sifive_uart.c            |  2 +-
>  hw/{riscv => gpio}/sifive_gpio.c            |  2 +-
>  hw/{riscv => intc}/sifive_clint.c           |  2 +-
>  hw/{riscv => intc}/sifive_plic.c            |  2 +-
>  hw/{riscv => misc}/sifive_e_prci.c          |  2 +-
>  hw/{riscv => misc}/sifive_test.c            |  2 +-
>  hw/{riscv => misc}/sifive_u_otp.c           |  2 +-
>  hw/{riscv => misc}/sifive_u_prci.c          |  2 +-
>  hw/riscv/microchip_pfsoc.c                  |  4 +-
>  hw/riscv/sifive_e.c                         |  8 ++--
>  hw/riscv/sifive_u.c                         |  6 +--
>  hw/riscv/spike.c                            |  4 +-
>  hw/riscv/virt.c                             |  6 +--
>  hw/char/Kconfig                             |  6 +++
>  hw/char/meson.build                         |  2 +
>  hw/gpio/Kconfig                             |  3 ++
>  hw/gpio/meson.build                         |  1 +
>  hw/gpio/trace-events                        |  6 +++
>  hw/intc/Kconfig                             |  6 +++
>  hw/intc/meson.build                         |  2 +
>  hw/misc/Kconfig                             | 12 +++++
>  hw/misc/meson.build                         |  6 +++
>  hw/riscv/Kconfig                            | 74 +++++++++++++++--------------
>  hw/riscv/meson.build                        | 11 +----
>  hw/riscv/trace-events                       |  7 ---
>  meson.build                                 |  1 -
>  39 files changed, 110 insertions(+), 82 deletions(-)
>  rename {include/hw/riscv => hw/intc}/sifive_plic.h (100%)
>  delete mode 100644 hw/riscv/trace.h
>  rename include/hw/{riscv => char}/riscv_htif.h (100%)
>  rename include/hw/{riscv => char}/sifive_uart.h (100%)
>  rename include/hw/{riscv => gpio}/sifive_gpio.h (100%)
>  rename include/hw/{riscv => intc}/sifive_clint.h (100%)
>  rename include/hw/{riscv => misc}/sifive_e_prci.h (100%)
>  rename include/hw/{riscv => misc}/sifive_test.h (100%)
>  rename include/hw/{riscv => misc}/sifive_u_otp.h (100%)
>  rename include/hw/{riscv => misc}/sifive_u_prci.h (100%)
>  rename hw/{riscv => char}/riscv_htif.c (99%)
>  rename hw/{riscv => char}/sifive_uart.c (99%)
>  rename hw/{riscv => gpio}/sifive_gpio.c (99%)
>  rename hw/{riscv => intc}/sifive_clint.c (99%)
>  rename hw/{riscv => intc}/sifive_plic.c (99%)
>  rename hw/{riscv => misc}/sifive_e_prci.c (99%)
>  rename hw/{riscv => misc}/sifive_test.c (98%)
>  rename hw/{riscv => misc}/sifive_u_otp.c (99%)
>  rename hw/{riscv => misc}/sifive_u_prci.c (99%)
>  delete mode 100644 hw/riscv/trace-events
>
> --
> 2.7.4
>
>

