Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366E7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF51F20739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX+r/r9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF51F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkua6-0003zs-1S
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuY0-0001Cg-Go; Mon, 15 Jun 2020 15:13:32 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkuXy-0002F5-Sw; Mon, 15 Jun 2020 15:13:32 -0400
Received: by mail-il1-x141.google.com with SMTP id t8so458293ilm.7;
 Mon, 15 Jun 2020 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sLE26D6GRXwt/6Vjqp8Php9rxoUrECziOzI2wlkcK8Q=;
 b=EX+r/r9V3MRg0Pcz86MFBnsLDGBqCCvbxJWX6gkslP2cR+gGplikqkLuiJVoK48iFP
 +JoNcSgTyhnT9vFm9MOR/CHRAybJR7LnCzMhaMxdVlsYh6V7bRUlGuWZVg4iYtkbVc2g
 Ucj2PBAkjXNBnM9Ij3SwRACFO4CkjFL4cvTrQDjp116ntodGpIXgodWcNrpkpVszX1oz
 7FHcJG/Rj/zCrtsQmcjyGAwa2Ls3DLYoTAOTvJpved5qNjhDE/PL4lgbWDgeQRZFnfmb
 XhPRROu1Pb1kZTE2SZib/g89h+waK3OpeHm9UIZD9Caeln6qOBJCYNxVBSkaI0W8sW9O
 4fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sLE26D6GRXwt/6Vjqp8Php9rxoUrECziOzI2wlkcK8Q=;
 b=nvm3x5iXM+6MzOWFAZFOlotsj5fteGLr0rgMhK/AP6K8hRASaVUOiTbA8dg6viqJfA
 9NDQJ+e50GUupcbLSbmiBT3NVj3mVKfdd+791mc1OEXXUTBRzIODsyfCgbwStKbJ82ZG
 98DgGG+PJO+JgdngrYjxs+F98gHV5RkfpRLA+9+EDudGwIz4wbGmZlqjIcjTb7QtRFz8
 dcmx//XTotu6Ma0xwoNdbAHJSHgQ74FrBt44wNk849vO5VGfB4ygBWT1Rw3afaikc4Gq
 DMo84fH1wTj5ZP2IJAWi3rHscYNjiYoI7MBc0MwQbLe6je23p2cpShP/lynuTjChuXSX
 pCXw==
X-Gm-Message-State: AOAM5335VC3gvuhJAEh++KD3ZTCB+FhYeoxg8ek0fRQh3egbYKQwcmO5
 tG3R7D3D6rLjgeRquO65yJjifaM9QQFA/g+V/Bo=
X-Google-Smtp-Source: ABdhPJyXWZWdAHKEvsYDUzldzyVXGD63tpWzXV+qPXRcAKz+unZPbP9+yjgbNRj59GMZEHfzHY4UxCqrhksqhYJqeo4=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr28264646ili.40.1592248409488; 
 Mon, 15 Jun 2020 12:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-14-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-14-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 12:04:06 -0700
Message-ID: <CAKmqyKMF51PJBBe70FHsdC8kDKFyAxKfEMac3nnGMvr8PfeC9Q@mail.gmail.com>
Subject: Re: [PATCH 13/15] hw/riscv: sifive_u: Support different boot source
 per MSEL pin state
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

On Mon, Jun 8, 2020 at 7:28 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> SiFive FU540 SoC supports booting from several sources, which are
> controlled using the Mode Select (MSEL[3:0]) pins on the chip.
> Typically, the boot process runs through several stages before it
> begins execution of user-provided programs.
>
> The SoC supports booting from memory-mapped QSPI flash, which is
> how start_in_flash property is used for at present. This matches
> MSEL = 1 configuration (QSPI0).
>
> Typical booting flows involve the Zeroth Stage Boot Loader (ZSBL).
> It's not necessary for QEMU to implement the full ZSBL ROM codes,
> because we know ZSBL downloads the next stage program into the L2
> LIM at address 0x8000000 and executes from there. We can bypass
> the whole ZSBL execution and use "-bios" to load the next stage
> program directly if MSEL indicates a ZSBL booting flow.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c         | 39 +++++++++++++++++++++++++++++++--------
>  include/hw/riscv/sifive_u.h |  6 ++++++
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0a86ffc..f64aa52 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -408,8 +408,34 @@ static void sifive_u_machine_init(MachineState *machine)
>      /* create device tree */
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
> -    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> -                                 memmap[SIFIVE_U_DRAM].base, NULL);
> +    if (s->start_in_flash) {
> +        /*
> +         * If start_in_flash property is given, assign s->msel to a value
> +         * that representing booting from QSPI0 memory-mapped flash.
> +         *
> +         * This also means that when both start_in_flash and msel properties
> +         * are given, start_in_flash takes the precedence over msel.
> +         *
> +         * Note this is to keep backward compatibility not to break existing
> +         * users that use start_in_flash property.
> +         */
> +        s->msel = MSEL_MEMMAP_QSPI0_FLASH;
> +    }
> +
> +    switch (s->msel) {
> +    case MSEL_MEMMAP_QSPI0_FLASH:
> +        start_addr = memmap[SIFIVE_U_FLASH0].base;
> +        break;
> +    case MSEL_L2LIM_QSPI0_FLASH:
> +    case MSEL_L2LIM_QSPI2_SD:
> +        start_addr = memmap[SIFIVE_U_L2LIM].base;
> +        break;
> +    default:
> +        start_addr = memmap[SIFIVE_U_DRAM].base;
> +        break;
> +    }
> +
> +    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
>
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
> @@ -427,13 +453,9 @@ static void sifive_u_machine_init(MachineState *machine)
>          }
>      }
>
> -    if (s->start_in_flash) {
> -        start_addr = memmap[SIFIVE_U_FLASH0].base;
> -    }
> -
>      /* reset vector */
>      uint32_t reset_vec[8] = {
> -        0x00000000,
> +        s->msel,                       /* MSEL pin state */
>          0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
>          0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
>          0xf1402573,                    /*     csrr   a0, mhartid  */
> @@ -505,7 +527,8 @@ static void sifive_u_machine_instance_init(Object *obj)
>                               sifive_u_machine_set_start_in_flash);
>      object_property_set_description(obj, "start-in-flash",
>                                      "Set on to tell QEMU's ROM to jump to "
> -                                    "flash. Otherwise QEMU will jump to DRAM");
> +                                    "flash. Otherwise QEMU will jump to DRAM "
> +                                    "or L2LIM depending on the msel value");
>
>      s->msel = 0;
>      object_property_add(obj, "msel", "uint32",
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index d82cfe0..5d80f91 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -111,6 +111,12 @@ enum {
>      SIFIVE_U_RTCCLK_FREQ = 1000000
>  };
>
> +enum {
> +    MSEL_MEMMAP_QSPI0_FLASH = 1,
> +    MSEL_L2LIM_QSPI0_FLASH = 6,
> +    MSEL_L2LIM_QSPI2_SD = 11
> +};
> +
>  #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
>  #define SIFIVE_U_COMPUTE_CPU_COUNT      4
>
> --
> 2.7.4
>
>

