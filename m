Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36380C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35D4206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="F2B8MImA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35D4206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLiqq-0003Fn-1L
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1jLioV-0002I4-Bn
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1jLioT-0006fy-UK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:38:27 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:40771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1jLioQ-0006e9-O5; Tue, 07 Apr 2020 03:38:23 -0400
Received: by mail-qv1-xf41.google.com with SMTP id k9so670863qvw.7;
 Tue, 07 Apr 2020 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yTS6hRvvxXn64hapJKMOlMcAkMMWPD1NjnnO6nw9tE0=;
 b=F2B8MImA2W99gMQ1GqRRFQeOTzeFFpZK9hMByWVBDtFOGVAgKVND2DzqKYiMsCBUcj
 cSq4enSGoYZ1IfdyJd8XaRKoiEVPwf9WqCLLGfSQEtOkX0ciymmYLsAa/W4xOCpDXeW/
 et2Byf4sUz2C+FjWyBPWQjF1ZY2Q20EsFNPvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yTS6hRvvxXn64hapJKMOlMcAkMMWPD1NjnnO6nw9tE0=;
 b=IviGXYEJ9OyxqcMh1cAtsXU745FZsQIG+ujtk4N2FyUacJEDNeF3xuuNFcsXSvpJMb
 1qPi6Px710Wvb2XJY4x3Qz2EzgC6ycNzSivcm3X7OsH45OMq6dtq0nVgm1csFtbtwCXj
 sPU1mbvfIEFAmPCalg5snIrjxVqoIYexO+Zc4chIpeDppXcIxD+wGOiG63p3QRh5ux67
 /rcodO96dJk6DtcsLqRR+cNxKBnN6E50N7V1ndwJ3vob/NNj0OTiT+FU9fHn/dIi+N+Q
 arJFm8s9TKIMa5dSMFby5eAYk24uU0eKC/yxkcm12TihNmn2nYoNs87bQxaDwFDptA7m
 M5GA==
X-Gm-Message-State: AGi0Pub5vCCzoq9d3mx3H4SIQzYY/u0+d0a5tJCro3nfroL0TRs+Yg3Q
 8HlLaBzz/N36hHupYe8JmrLF+FlieQzpurkilTQ=
X-Google-Smtp-Source: APiQypL96ExZOnzr5pprllw9HMBevWNHO+OI0840CjuJdiLJ5mlebnmew5L+Jkb/2VSVYZwXbBu1tV7Ui2HONb/Za3w=
X-Received: by 2002:a0c:f207:: with SMTP id h7mr894166qvk.20.1586245101805;
 Tue, 07 Apr 2020 00:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200407072517.671521-1-joel@jms.id.au>
In-Reply-To: <20200407072517.671521-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Apr 2020 07:38:09 +0000
Message-ID: <CACPK8XfHnE_kEPw++CdLRG9r=xJmLZkuV4WXP7NKTo8mW+dJvA@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add boot stub for smp booting
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 07:25, Joel Stanley <joel@jms.id.au> wrote:
>
> This is a boot stub that is similar to the code u-boot runs, allowing
> the kernel to boot the secondary CPU.
>
> u-boot works as follows:
>
>  1. Initialises the SMP mailbox area in the SCU at 0x1e6e2180 with default values
>
>  2. Copies a stub named 'mailbox_insn' from flash to the SCU, just above the
>     mailbox area
>
>  3. Sets AST_SMP_MBOX_FIELD_READY to a magic value to indicate the
>     secondary can begin execution from the stub
>
>  4. The stub waits until the AST_SMP_MBOX_FIELD_GOSIGN register is set to
>     a magic value
>
>  5. Jumps to the address in AST_SMP_MBOX_FIELD_ENTRY, starting Linux
>
> Linux indicates it is ready by writing the address of its entrypoint
> function to AST_SMP_MBOX_FIELD_ENTRY and the 'go' magic number to
> AST_SMP_MBOX_FIELD_GOSIGN. The secondary CPU sees this at step 4 and
> breaks out of it's loop.
>
> To be compatible, a fixed qemu stub is loaded into the mailbox area. As
> qemu can ensure the stub is loaded before execution starts, we do not
> need to emulate the AST_SMP_MBOX_FIELD_READY behaviour of u-boot. The
> secondary CPU's program counter points to the beginning of the stub,
> allowing qemu to start secondaries at step four.
>
> Reboot behaviour is preserved by resetting AST_SMP_MBOX_FIELD_GOSIGN
> when the secondaries are reset.
>
> This is only configured when the system is booted with -kernel and qemu
> does not execute u-boot first.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/arm/aspeed.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index a6a2102a93cb..bc4386cc6174 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -116,6 +116,58 @@ static const MemoryRegionOps max_ram_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> +#define AST_SMP_MAILBOX_BASE            0x1e6e2180
> +#define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
> +#define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
> +#define AST_SMP_MBOX_FIELD_READY        (AST_SMP_MAILBOX_BASE + 0x8)
> +#define AST_SMP_MBOX_FIELD_POLLINSN     (AST_SMP_MAILBOX_BASE + 0xc)
> +#define AST_SMP_MBOX_CODE               (AST_SMP_MAILBOX_BASE + 0x10)
> +#define AST_SMP_MBOX_GOSIGN             0xabbaab00
> +
> +static void aspeed_write_smpboot(ARMCPU *cpu,
> +                                 const struct arm_boot_info *info)
> +{
> +    static const uint32_t poll_mailbox_ready[] = {
> +        /*
> +         * r2 = per-cpu go sign value
> +         * r1 = AST_SMP_MBOX_FIELD_ENTRY
> +         * r0 = AST_SMP_MBOX_FIELD_GOSIGN
> +         */
> +        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
> +        0xe21000ff,  /* ands    r0, r0, #255          */
> +        0xe59f201c,  /* ldr     r2, [pc, #28]         */
> +        0xe1822000,  /* orr     r2, r2, r0            */
> +
> +        0xe59f1018,  /* ldr     r1, [pc, #24]         */
> +        0xe59f0018,  /* ldr     r0, [pc, #24]         */
> +
> +        0xe320f002,  /* wfe                           */
> +        0xe5904000,  /* ldr     r4, [r0]              */
> +        0xe1520004,  /* cmp     r2, r4                */
> +        0x1afffffb,  /* bne     <wfe>                 */
> +        0xe591f000,  /* ldr     pc, [r1]              */
> +        AST_SMP_MBOX_GOSIGN,
> +        AST_SMP_MBOX_FIELD_ENTRY,
> +        AST_SMP_MBOX_FIELD_GOSIGN,
> +    };
> +
> +    rom_add_blob_fixed("aspeed.smpboot", poll_mailbox_ready,
> +                       sizeof(poll_mailbox_ready),
> +                       info->smp_loader_start);
> +}
> +
> +static void aspeed_reset_secondary(ARMCPU *cpu,
> +                                   const struct arm_boot_info *info)
> +{
> +    AddressSpace *as = arm_boot_address_space(cpu, info);
> +    CPUState *cs = CPU(cpu);
> +
> +    /* info->smp_bootreg_addr */
> +    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
> +                               MEMTXATTRS_UNSPECIFIED, NULL);
> +    cpu_set_pc(cs, info->smp_loader_start);
> +}
> +
>  #define FIRMWARE_ADDR 0x0
>
>  static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
> @@ -270,6 +322,19 @@ static void aspeed_machine_init(MachineState *machine)
>          }
>      }
>
> +    if (machine->kernel_filename) {

I just realised this shouldn't be executed on non-ast2600 platforms.
We could test for the number of CPUs like this:

if (machine->kernel_filename && aspeed_board_binfo.nb_cpus > 1) {

> +        /* With no u-boot we must set up a boot stub for the secondary CPU */
> +        MemoryRegion *smpboot = g_new(MemoryRegion, 1);
> +        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
> +                               0x80, &error_abort);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    AST_SMP_MAILBOX_BASE, smpboot);
> +
> +        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
> +        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
> +        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
> +    }
> +
>      aspeed_board_binfo.ram_size = ram_size;
>      aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
>      aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
> --
> 2.25.1
>

