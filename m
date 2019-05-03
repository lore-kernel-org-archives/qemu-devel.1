Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDA1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5688D2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVDm2S5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5688D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYdi-0004Me-LV
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:54:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYco-0003yz-AG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYcn-0002Ub-D3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:18 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYcn-0002Tj-8L
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:53:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id g24so5360385otq.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=coI8qeRfQRfOBo8Ln73qnlqpPAY7Th2sRgVvcHuxN8U=;
	b=jVDm2S5iUc98G5bF9JOrEnJFNMnGpB2tMIXNuNZ+8DWkuLc0ftSExFCsJylkj9iSNT
	ZMkPyiPCfPQyzppqoS33q2QniIt8MnAlgl7YQHNlPO33bHAACzDjv/LDQJxroOe2Kkl2
	CBauLm8gHtzBH+3wo+PiCgcMQUQ0Q9/LJItS63OUXTF4y7f2naeUtw0HBh07B/+xsPnH
	HuR6nK1LGzJacxvCyY7bY9Tm3WCXSROzuDethXENdc5ZVW/6DvJRMcQmD5MqDKCC0d2e
	urlcT+oQFDkoxjHh2wkUu1CstlS8B9aNU7iZ9BuP05hbIoRna/y1SJ6lgwn6WTUSd5Ea
	rBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=coI8qeRfQRfOBo8Ln73qnlqpPAY7Th2sRgVvcHuxN8U=;
	b=TsG94QseuobSEtZs7qOkh4E0x+DwnvpoibeF0GYdaAxBJx6YaQDPqxsKPb6q1wpo9B
	Ydjd69KN1qZtOleNQPec9uFGK6MBfTTURbVPJRnjcFxceoiiWtNgnIcdCvvuRWxJFTkv
	4uPr6zIz/qY9XtcYXuPrqwJApwItwQa36J7NQPNR+mdINqMn0dXgLSMFFU9Er+kXm8pw
	qjRnzMTnNq+5xOf8Wuk1ESgP6GRITo/ffzKUJpcOwsyrRkj1bsH+BduevpEqz7W6JqQ8
	ccFqBIWzRPzpVXzsGwxJlXWKGgnq9lWGn3OeXWnePYDZkLhBqJWGEtxl7p/BGsb5Nswn
	57GA==
X-Gm-Message-State: APjAAAV7/dz6V7GZEJxLGMm8A9/gY9/E43Zy2EVyXWmmObhWaQ1+FODd
	ch8S08o7uozmH3r9RLnhI3HGW3dbipBPhfeUA2a9vw==
X-Google-Smtp-Source: APXvYqx6zVo1rLlfUe7p6aR4bEwA2NRFLEfTuZLZOJF38fJWjZ2QGLCbdPMijshskOOH3XeIsEJxL3YEhTxeoE2v3RQ=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr6767043otb.238.1556891595994; 
	Fri, 03 May 2019 06:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556774049.git.alistair@alistair23.me>
	<PSXP216MB0277BAE3697B1BBFCE662671DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277BAE3697B1BBFCE662671DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:53:05 +0100
Message-ID:
 <CAFEAcA_UWXDbzSeGUAx58oOzFnp8gA+TUnVC1CHqMishg9p1ow@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Message-ID: <20190503135305.WWVTkcmwkG2dnHfT0xYLSwFfFeV0jsJ42rrK1zqGlwM@z>

On Thu, 2 May 2019 at 06:41, Alistair Francis <alistair@alistair23.me> wrote:
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
> +    entry = armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +                       FLASH_SIZE);
> +
> +    reset_args = (ARMV7MResetArgs) {
> +        .cpu = ARM_CPU(first_cpu),
> +        .reset_pc = entry,
> +        .reset_sp = (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
> +    };
> +    qemu_register_reset(armv7m_reset,
> +                        g_memdup(&reset_args, sizeof(reset_args)));
> +}

I still don't really like having this board interpret -kernel
in a different way to all the other M-profile boards. I'd be
much happier if it just behaved the same way the others do.

thanks
-- PMM

