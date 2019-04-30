Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D0C04AA8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4B32080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8/N1dHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4B32080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZXq-0004C6-J1
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:40:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZVT-0002ST-7m
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZNH-0007om-3F
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:29:12 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZNG-0007nC-PO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:29:11 -0400
Received: by mail-lj1-x241.google.com with SMTP id z26so14057795ljj.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=STv8KKZ/Zp0Xp0nIm6Ttz6L90htgplq97Cn6KYroHDE=;
	b=L8/N1dHzfQHYlhmd2iOV9YtEJ5/tryPaTw608yNZOXYqmsnVPCh42FFtEUeCnF4Y7j
	gy7E35CJ5YNaba23V98DeePqKOTjBe0iQK08MZvJVaZJoGcr1sALNrOwiz/UZ2htImrJ
	Xbu8iq4bC6hDV0QvGMmKsCtNc5vNS6Uv9CVuEYcDxLAISWzCCPuKTklcnmhTBAumF3TR
	M3j3Ia7q5LtQQtAn+ZQaUER6Hv1/gm3NHBIND/G+haH0b/7f0KlKg0L2FOxsPDgga7kU
	rIRjRFml3KDuXPXfkl2Z25rP9ZugcsPlF+vRQJsdWt/5RLvne88NxmyLROtgjpSE2DYu
	n/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=STv8KKZ/Zp0Xp0nIm6Ttz6L90htgplq97Cn6KYroHDE=;
	b=FEJJ7VK8F3tenpSRRFLE2PmZ8t3FKmpkQgQCSm82kTNzIogy/Ps2b8IGLi2S4zobp+
	Uup+BzA8eeymLbK3tdpoLbVMX+XBUXMpMYNKtcwWWpdKscfyx57wD7UzbbM2VV/RTflm
	OqpBbmAIVbG8x5asljEN7mpL796bFroMxN7/O4mYfMJmbl9viWj70PTBPPl0Rs8jOmaF
	dMyv6DJkrL739/GYN315hbD0nYkU0yhD5jkI6wB1c5fyBgBvmt4/SB76Az+c5/pkGJoa
	ZQTFx0c/b+52Xb5VdCYVoYsit8tTURnCgNzVOI3E2acPXjfOJ8dZJgq+tO3CnDkKyjCC
	WXWQ==
X-Gm-Message-State: APjAAAV2c4gCeYvJ66hvqsSkCmtaFRzSNn584FyXUHvIY+QL07oqhbzb
	HNDscVsvyJZmbIDrG929Y8w/du542O8gihGr+B8=
X-Google-Smtp-Source: APXvYqzhci0xBdCQvUUtgBFwzoeHXMNEqHoerYrjoM2tctm8DHlopi7H8Xg1X7QkqWnd+qV6dPRaC3MZ6PF/QXFUHUs=
X-Received: by 2002:a2e:2b8c:: with SMTP id r12mr8990206ljr.115.1556656148803; 
	Tue, 30 Apr 2019 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
In-Reply-To: <CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:27:15 -0700
Message-ID:
 <CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430202715.E6K8-nOBi39dibCv79jprpVuN4UMIoZsF2SrN3OuEpo@z>

On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 06:39, Alistair Francis <alistair@alistair23.me> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  MAINTAINERS                     |  6 +++
> >  default-configs/arm-softmmu.mak |  1 +
> >  hw/arm/Kconfig                  |  3 ++
> >  hw/arm/Makefile.objs            |  1 +
> >  hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
> >  5 files changed, 88 insertions(+)
> >  create mode 100644 hw/arm/netduinoplus2.c
> >
>
> > +typedef struct ARMV7MResetArgs {
> > +    ARMCPU *cpu;
> > +    uint32_t reset_sp;
> > +    uint32_t reset_pc;
> > +} ARMV7MResetArgs;
> > +
> > +static void armv7m_reset(void *opaque)
> > +{
> > +    ARMV7MResetArgs *args = opaque;
> > +
> > +    cpu_reset(CPU(args->cpu));
> > +
> > +    args->cpu->env.regs[13] = args->reset_sp & 0xFFFFFFFC;
> > +    args->cpu->env.thumb = args->reset_pc & 1;
> > +    args->cpu->env.regs[15] = args->reset_pc & ~1;
> > +}
> > +
> > +static void netduinoplus2_init(MachineState *machine)
> > +{
> > +    DeviceState *dev;
> > +    ARMV7MResetArgs reset_args;
> > +    uint64_t entry;
> > +
> > +    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
> > +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> > +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> > +
> > +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> > +                       FLASH_SIZE, &entry);
> > +
> > +    reset_args = (ARMV7MResetArgs) {
> > +        .cpu = ARM_CPU(first_cpu),
> > +        .reset_pc = entry,
> > +        .reset_sp = (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
> > +    };
> > +    qemu_register_reset(armv7m_reset,
> > +                        g_memdup(&reset_args, sizeof(reset_args)));
> > +}
>
> Can you explain the purpose of the reset code? None of the other
> v7m boards seem to need to do a manual qemu_register_reset().

The reset code allows the machine to work with the -kernel option.
Without the reset override using -kernel results in the guest starting
at the wrong address. We can use the -device loader option without the
reset code though.

I don't have examples infront of me, I can run it when I'm home and
include the addresses if you want.

Alistair

>
> thanks
> -- PMM

