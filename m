Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF3420717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyAIufo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF3420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnVt-0002MW-0b
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnUw-0001k6-FX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnUv-0007FE-1N
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:20:26 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibnUu-0007Ei-Ae
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:20:24 -0500
Received: by mail-io1-xd41.google.com with SMTP id f82so2184676ioa.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D5j5sc6m+3Do9c2vsFcfFanl3eE/9mKLyTDuX+zpAuo=;
 b=RyAIufo82LnEb0ct0nMaUs7kc8wpVYDWbPPW3mKWWlNAsm8EuRwYjJtmjUNhTlP+81
 3zau4PFNO7L8psABWAT60N5D/v3rt1I1WLVcPAfptoodzwRToEvmEETHyjDbq5V6deWK
 hAgB5F66pjxx9bqQtuY7yXkckAS8JCk3+8NvNaH46zxrbd0ZVVHRQF3zm/XRws6huGZj
 zbu2kaCVMCeu5o6r6S2/TiVNk82c5iJc0bGDMe4ORSk7EfcfOduP9bJPs2Iujl7EgA1S
 TTYeZ05x/EW2Kld72q4NBfpiE4ILQ3o7o3oh4bvWWPUiBYU+E6Gsq9Wg2yS8vo4SY2AC
 l3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D5j5sc6m+3Do9c2vsFcfFanl3eE/9mKLyTDuX+zpAuo=;
 b=LeicTlqOR9FsKqJ9eim/l84dC5fk+tkzIRkXaJkpdDUswdc9iGXPua7cn5N0344TuD
 IcLw9LCNLDrkoLb9slNu9nziy286SX5o9vE94YtnGqhLMk4P/cVo+LljzeSou41m42tv
 tHJHKiBWAtMmJIWjkEDbfc4xUwUHmgLab//NaJSDNg59CF4XZpKh7BBRoitw+kjTf6oJ
 TtVJieZad87vI4iVaT0k98lzaiKZ9Ku2vHS1i0WKoh25sp8gKW3VHdgNsxnzbQXeMUii
 rGrXw9/T+X3J+clSWXRMxn+7/m00jbHCAawk6HxFDymxmCtH9iSORqvZ8wQmh/Dr3nZw
 4ldg==
X-Gm-Message-State: APjAAAUJToWYj0kMeQB26iQH6b77upNEpnt/LnCv3i0OGN1ay+DDb6Hh
 6bJvUyykioo/5KZag9v/sf4oNus1ALYkNpEXShArqw==
X-Google-Smtp-Source: APXvYqz9jURPCuTYUUYdTxs7l8hqdgsTr6KuVZR32Hf4iSyJ4sCMw+51Q2VptBfXqOBr9X0qkNVbRuFpgSkJALBzkAY=
X-Received: by 2002:a02:55c3:: with SMTP id
 e186mr28436075jab.143.1575300023375; 
 Mon, 02 Dec 2019 07:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-8-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-8-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 15:20:12 +0000
Message-ID: <CAFEAcA_mmBeVnx5TsdeEaEU=jNnkFR9aa-nziaTQD7par7GpoA@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] hw/misc/zynq_slcr: add clock generation for uarts
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Switch the slcr to multi-phase reset and add some clocks:
> + the main input clock (ps_clk)
> + the reference clock outputs for each uart (uart0 & 1)
>
> The clock frequencies are computed using the internal pll & uart configuration
> registers and the ps_clk frequency.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Review of this and the following two patches by some Xilinx
person would be nice. I've just looked them over for general
issues, and haven't checked against the hardware specs.

> ---


> +/*
> + * return the output frequency of a clock given:
> + * + the frequencies in an array corresponding to mux's indexes
> + * + the register xxx_CLK_CTRL value
> + * + enable bit index in ctrl register
> + *
> + * This function make the assumption that ctrl_reg value is organized as follow:

"makes"; "that the"; "follows"

> + * + bits[13:8] clock divisor
> + * + bits[5:4]  clock mux selector (index in array)
> + * + bits[index] clock enable
> + */
> +static uint64_t zynq_slcr_compute_clock(const uint64_t mux[],
> +                                        uint32_t ctrl_reg,
> +                                        unsigned index)
> +{
> +    uint32_t srcsel = extract32(ctrl_reg, 4, 2); /* bits [5:4] */
> +    uint32_t divisor = extract32(ctrl_reg, 8, 6); /* bits [13:8] */
> +
> +    /* first, check if clock is enabled */
> +    if (((ctrl_reg >> index) & 1u) == 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * according to the Zynq technical ref. manual UG585 v1.12.2 in
> +     * "Clocks" chapter, section 25.10.1 page 705" the range of the divisor
> +     * is [1;63].

Is this the range notation the spec doc uses?

> +     * So divide the source while avoiding division-by-zero.
> +     */
> +    return mux[srcsel] / (divisor ? divisor : 1u);
> +}
> +

> +static const ClockPortInitArray zynq_slcr_clocks = {
> +    QDEV_CLOCK_IN(ZynqSLCRState, ps_clk, zynq_slcr_ps_clk_callback),
> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart0_ref_clk),
> +    QDEV_CLOCK_OUT(ZynqSLCRState, uart1_ref_clk),
> +    QDEV_CLOCK_END
> +};
> +
>  static void zynq_slcr_init(Object *obj)
>  {
>      ZynqSLCRState *s = ZYNQ_SLCR(obj);
> @@ -425,6 +559,8 @@ static void zynq_slcr_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &slcr_ops, s, "slcr",
>                            ZYNQ_SLCR_MMIO_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +
> +    qdev_init_clocks(DEVICE(obj), zynq_slcr_clocks);
>  }
>
>  static const VMStateDescription vmstate_zynq_slcr = {
> @@ -440,9 +576,12 @@ static const VMStateDescription vmstate_zynq_slcr = {
>  static void zynq_slcr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>
>      dc->vmsd = &vmstate_zynq_slcr;
> -    dc->reset = zynq_slcr_reset;
> +    rc->phases.init = zynq_slcr_reset_init;
> +    rc->phases.hold = zynq_slcr_reset_hold;
> +    rc->phases.exit = zynq_slcr_reset_exit;
>  }

We're adding an input clock, so doesn't the migration
state struct need to be updated to migrate it ?

thanks
-- PMM

