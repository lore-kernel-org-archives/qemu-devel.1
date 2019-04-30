Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E726C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B3A21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNe9ISlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B3A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVUS-0004tC-CQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:20:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVCm-000768-Ts
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLVCl-0005z0-Rm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:02:04 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLVCl-0005yG-M5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:02:03 -0400
Received: by mail-ot1-x32a.google.com with SMTP id r20so11259163otg.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dyNCtj5gU292e5SAgxjtbKC2vuxYG+NGlq6ortkuw/E=;
	b=XNe9ISlJkENPDe1zJj41Ws3h1dxI5PatrrvxJi/cX/yhQbvGsGCMItD+hBWCfTWJTc
	sWSP8XxyADOemTWujXHHcLejCrbN80BJ5uRafzPBGYopVPyK01teqrOtD0EDK/WRGp7J
	W0FO/D+Wr1CABMd1bhl+DwIwpDkhrOqJV7Ds0Sc0BUT7+RZ1FkB43/eosQ/E8WnDbowx
	NxC4vnySW2oIsd2arfzz4KUafJToic8dwokmXtGUrRB2zxg80w9b6ikXILG651DSiGyk
	7+nxdvGbzuxqoD4EchzRvftm+vUpjmmfLhgCGXCavo+D8BmSShjG143PISgR4icyOTsK
	PlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dyNCtj5gU292e5SAgxjtbKC2vuxYG+NGlq6ortkuw/E=;
	b=dz8D5idKOtPXwgy8RowUnJGD50+FCsPZBC5tKoDxMqyONr1o3vUk80KVNDW74LPJWe
	pIuxu+FwPSM/Gg1+WCjl1vLU6yMLA5o42I52nnbP8ION4+elklH4GxL+9PJLa3/MY/rS
	jSOBig+MFu4GS9tEPGvI6OA0xMlWIqPGv4ykY8qcTCjc/u+RizjMtSvf4gTbvnscueNI
	MpcFxFvTwzXyMRtF6J8xVQQBO2pfgjSpaUBzXkIYGy6rg1cTUUItYQE+a2wFN1Q0Z+FQ
	unFoTMPwW0zffT6CjSdKxEqpC30dBMlnmGvW2L+akY7wCnRK0y5KpJu1MOtQJ7EAO3fe
	xYFQ==
X-Gm-Message-State: APjAAAU/bzXxoocWLLDR8jYOcjDAZtqg53TRvXVaN5zHFI9NSc7xw5c1
	6a1q6+bWD/nR7UVrQo9Owajv5XsTqkyWXuUHTntLNQ==
X-Google-Smtp-Source: APXvYqxnApB1YILdOVJUdIs4/nd0iIJ8S16lx7DS4RFe97e02rWD0Isb5gbig/Mfybt4WuRzTYP7oOrdpNI/dIVgdV8=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr16653313otb.238.1556640122341;
	Tue, 30 Apr 2019 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:01:51 +0100
Message-ID:
 <CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430160151.nlEso1fPqgq3HZBldVoqDAc9O0kI_xjaP1yV6vNALR0@z>

On Mon, 29 Apr 2019 at 06:39, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS                     |  6 +++
>  default-configs/arm-softmmu.mak |  1 +
>  hw/arm/Kconfig                  |  3 ++
>  hw/arm/Makefile.objs            |  1 +
>  hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+)
>  create mode 100644 hw/arm/netduinoplus2.c
>

> +typedef struct ARMV7MResetArgs {
> +    ARMCPU *cpu;
> +    uint32_t reset_sp;
> +    uint32_t reset_pc;
> +} ARMV7MResetArgs;
> +
> +static void armv7m_reset(void *opaque)
> +{
> +    ARMV7MResetArgs *args = opaque;
> +
> +    cpu_reset(CPU(args->cpu));
> +
> +    args->cpu->env.regs[13] = args->reset_sp & 0xFFFFFFFC;
> +    args->cpu->env.thumb = args->reset_pc & 1;
> +    args->cpu->env.regs[15] = args->reset_pc & ~1;
> +}
> +
> +static void netduinoplus2_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    ARMV7MResetArgs reset_args;
> +    uint64_t entry;
> +
> +    dev = qdev_create(NULL, TYPE_STM32F405_SOC);
> +    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
> +    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
> +
> +    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +                       FLASH_SIZE, &entry);
> +
> +    reset_args = (ARMV7MResetArgs) {
> +        .cpu = ARM_CPU(first_cpu),
> +        .reset_pc = entry,
> +        .reset_sp = (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
> +    };
> +    qemu_register_reset(armv7m_reset,
> +                        g_memdup(&reset_args, sizeof(reset_args)));
> +}

Can you explain the purpose of the reset code? None of the other
v7m boards seem to need to do a manual qemu_register_reset().

thanks
-- PMM

