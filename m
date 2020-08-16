Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158FFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13E72065C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiWg1WhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13E72065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7EUp-00025O-4k
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7EUH-0001dc-NX; Sun, 16 Aug 2020 04:57:57 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7EUG-000536-3p; Sun, 16 Aug 2020 04:57:57 -0400
Received: by mail-yb1-xb41.google.com with SMTP id y134so7720113yby.2;
 Sun, 16 Aug 2020 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=36rCjXFqPUMM23mWsdy/cSfLuwzX2cC9UJ1/ah97Wes=;
 b=BiWg1WhMsgceMqK8HzHlQXw+mlA+igPSnWqp64EKnB2pQGWR9K3qSdYVUwOkayTmaw
 rld3+7ZEBVJeuRici2kPG9J8xDV2VxpTlJtHqa6p/n06enYn+sPkLpuHmVmKWSHwIXhh
 gtpOo3QDMU2Y3C7dBcxNSgN730GLzDNS4LRW7kYMSRzqyMLQ3MWKwfwyuM5zzrJ3GB59
 hIsX8ggaazB3w0PhAviJtbEHiYzhHVmI45GKAh7D5RAxigSTM50t2NreTS17zjzGEYjJ
 LsDLafmd9asLegWpHMs6Ha70D0ck+D1Zd3/POnBjFWOEpSgO/5xgLxUtaHKaJK9Ke4KO
 qYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=36rCjXFqPUMM23mWsdy/cSfLuwzX2cC9UJ1/ah97Wes=;
 b=MU1XhJA9jTqVBpxS+wiQOgZ0fH3XkAvsSwY32G7lJnqJl4UtrAE/c/kWx2Lbe6Ub5c
 PI5ZtkObUzYqnE6BZiM0LLOqEE4ZLYKFdPYFy1H0c8B1KzlwUXHOkihmuORxPJ+8RxGG
 diDsReaZFK7TUh1FBn/8lYGlLGwye+UIpt4Pih4cr6Of86swq/B7QWqDSRWHiEZu5O5u
 5TLhleB/kD2BpnZL7MHtb0EMIcjtYnipavTMw+O5WAMkkzcbYJEhbhaKKk42MwtZnqXd
 2OchseFAi3i1oVhi0KVCA5M0GrXuyKINjD7vXW2ej/D6VZ6mGj2rfXgp9jlhsCqpivrl
 j05w==
X-Gm-Message-State: AOAM531JFHU8rozeHBcVrqK6VnVmAdzIZcfyzFUCiAR1iPgwWRiL6ZNA
 CQ8ybg5deaE+Pg0jU4jH2q2IFzNyuD3GG4t6PP4=
X-Google-Smtp-Source: ABdhPJzUEQLObM+7nMlNVfff+Jp3ntsnopXhmZ/Rf02xe+NZlGW92b9f4ojJM17XmiqqHXOk0BdJ8qY6VPjy1sEHJEI=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr13824556ybe.152.1597568274736; 
 Sun, 16 Aug 2020 01:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-14-git-send-email-bmeng.cn@gmail.com>
 <e96742b4-3d58-e9b7-def9-3fb1fb89f750@amsat.org>
In-Reply-To: <e96742b4-3d58-e9b7-def9-3fb1fb89f750@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 16 Aug 2020 16:57:43 +0800
Message-ID: <CAEUhbmUx_bpR_aKgJN-VTp-vJyy_YwnwLogoOxacPzOWj3_x2g@mail.gmail.com>
Subject: Re: [PATCH 13/18] hw/riscv: microchip_pfsoc: Connect a DMA controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sat, Aug 15, 2020 at 5:00 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 8/14/20 6:40 PM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Connect a DMA controller to Microchip PolarFire SoC. Note interrupt
> > has not been connected due to missing information in the manual how
> > interrupts are routed to PLIC.
> >
> > On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
> > controller to move the 2nd stage bootloader in the system memory.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/riscv/Kconfig                   |  1 +
> >  hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
> >  include/hw/riscv/microchip_pfsoc.h |  3 +++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 7412db9..9323701 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
> >      select SIFIVE
> >      select UNIMP
> >      select MCHP_PFSOC_MMUART
> > +    select MCHP_PFSOC_DMA
> >      select CADENCE_SDHCI
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 7c09078..1c67cbc 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -13,6 +13,7 @@
> >   * 2) eNVM (Embedded Non-Volatile Memory)
> >   * 3) MMUARTs (Multi-Mode UART)
> >   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
> > + * 5) DMA (Direct Memory Access Controller)
> >   *
> >   * This board currently generates devicetree dynamically that indicate=
s at least
> >   * two harts and up to five harts.
> > @@ -71,6 +72,7 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_BUSERR_UNIT4] =3D    {  0x1704000,     0x1000 },
> >      [MICROCHIP_PFSOC_CLINT] =3D           {  0x2000000,    0x10000 },
> >      [MICROCHIP_PFSOC_L2CC] =3D            {  0x2010000,     0x1000 },
> > +    [MICROCHIP_PFSOC_DMA] =3D             {  0x3000000,   0x100000 },
> >      [MICROCHIP_PFSOC_L2LIM] =3D           {  0x8000000,  0x2000000 },
> >      [MICROCHIP_PFSOC_PLIC] =3D            {  0xc000000,  0x4000000 },
> >      [MICROCHIP_PFSOC_MMUART0] =3D         { 0x20000000,     0x1000 },
> > @@ -114,6 +116,9 @@ static void microchip_pfsoc_soc_instance_init(Objec=
t *obj)
> >                           TYPE_RISCV_CPU_SIFIVE_U54);
> >      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR)=
;
> >
> > +    object_initialize_child(obj, "dma-controller", &s->dma,
> > +                            TYPE_MCHP_PFSOC_DMA);
> > +
> >      object_initialize_child(obj, "sd-controller", &s->sdhci,
> >                              TYPE_CADENCE_SDHCI);
>
> I haven't looked at the chip specs, but maybe you can add the SD
> controller after the DMA controller so so you can directly link
> a DMA address space to it.
>

I am not sure I understand what you meant about adding the SD
controller after the DMA controller. The Cadence SD controller has its
own built-in DMA and does not depend on this DMA controller.

Regards,
Bin

