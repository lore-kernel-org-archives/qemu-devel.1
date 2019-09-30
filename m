Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9314EC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1772B20842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO3eOfC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1772B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEveT-00088j-II
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvaL-0003rY-Mt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEvaJ-0004Pp-Nh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:19:29 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEvaI-0004Or-QV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:19:26 -0400
Received: by mail-oi1-x242.google.com with SMTP id o205so11021781oib.12
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvF2rhjIU40oHZTkD8AiJlAuhk6N45ACdpW2yo/HLqU=;
 b=PO3eOfC/q3wl/KRr0kWCAelNHERyjJNf3sYliZiXHahyxh4ZRx2ySTuhPxn1dLYQtz
 Ye7DkO0wnQTjwjmUaxO8t8JgHdk/PerRiFSCyrNFh5SbjlOxqUbk17JiIevIdEtWEmqn
 D+03S22BPz+8zeYwZv2Bei/nLUk1RNyudNjaeErSn+O9FIlqczoufsYOsZOoGm5F3MtH
 oAOfw9c/il8g2OxXfN5HbM+5V+PC16ESN+8dUaf3o354nFgG9uXH+SoowTtN6gelXjGF
 2f7a0ilmT8oGOJV2PKIB+OsJ1h0c3lxdDtGuZ78Fa7qJuhxDICK5hsWj3CFXe07wW8IK
 nuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvF2rhjIU40oHZTkD8AiJlAuhk6N45ACdpW2yo/HLqU=;
 b=mgIlghk9hqXLS3z7XzWuoSu/UB+HPh/FMLjb9vz3gUe1x7EmZK1Id0FV2wU+k6Yf0N
 Op0p3D71lMChrGtLY+vKeMYenBXbaBlmowUQGMwhFQEAHRlhFSOXzRKB1l/I99eu8ZP4
 KQGfgJ2Yb9WovdjoS6KTbjbhhOGXG2IglQDhxWVer5BUWFIKjuOdPRa3LlNYviADBtef
 C+JOx3JfVFKlPoSEdcKTRJY/XHKPvsHOvVFnlGi8+zGb5zshNuN+MllVVVE7DxMVGfFs
 TnN6UlLITa9IJa9nf+IYGuURMujnuAGXa+j3bIYVbNXl9qVkq+kQrxRPC0huu4XGWbuP
 1dbw==
X-Gm-Message-State: APjAAAW2sijRkXiOe5f+Z3Nu0rP7RIKBo0eN3wzZ5kxxTGidqobiqzWs
 DVE/XuXuO4bjVfkVYM8Y4zBC6CYmCGd5RsIDVMaOPA==
X-Google-Smtp-Source: APXvYqxkDA2j7mElW4UnsVMO8OvEuYOnFf4j7HG8KejxC44MOi2OBa9meGhMJ+mXVoFqHVS5fsi1jnMYUOeVkuK8Ih4=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr18336111oif.98.1569849565968; 
 Mon, 30 Sep 2019 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-8-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1569338511-3572-8-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 14:19:15 +0100
Message-ID: <CAFEAcA9ZHs=GdJ-_Ap1PWdgDjSDBnnRqG1UkMGx_FiqCJ5ZyGw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] arm/sdei: override qemu_irq handler when
 binding interrupt
To: Heyi Guo <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 16:23, Heyi Guo <guoheyi@huawei.com> wrote:
>
> Override qemu_irq handler to support trigger SDEI event transparently
> after guest binds interrupt to SDEI event. We don't have good way to
> get GIC device and to guarantee SDEI device is initialized after GIC,
> so we search GIC in system bus when the first SDEI request happens or
> in VMSTATE post_load().
>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>


> +static void override_qemu_irq(QemuSDEState *s, int32_t event, uint32_t intid)
> +{
> +    qemu_irq irq;
> +    QemuSDE *sde;
> +    CPUState *cs;
> +    int cpu;
> +
> +    /* SPI */
> +    if (intid >= GIC_INTERNAL) {
> +        cs = arm_get_cpu_by_id(0);
> +        irq = qdev_get_gpio_in(s->gic_dev,
> +                               gic_int_to_irq(s->num_irq, intid, 0));
> +        if (irq) {
> +            qemu_irq_intercept_in(&irq, qemu_sdei_irq_handler, 1);
> +        }

I'm not sure what this code is trying to do, but
qemu_irq_intercept_in() is a function for internal use
by the qtest testing infrastructure, so it shouldn't be
used in 'real' QEMU code.

> +        sde = get_sde_no_check(s, event, cs);
> +        sde->irq = irq;
> +        put_sde(sde, cs);
> +        return;
> +    }

> @@ -1042,6 +1152,17 @@ void sdei_handle_request(CPUState *cs, struct kvm_run *run)
>          return;
>      }
>
> +    if (!sde_state->gic_dev) {
> +        /* Search for ARM GIC device */
> +        qbus_walk_children(sysbus_get_default(), dev_walkerfn,
> +                           NULL, NULL, NULL, sde_state);
> +        if (!sde_state->gic_dev) {
> +            error_report("Cannot find ARM GIC device!");
> +            run->hypercall.args[0] = SDEI_NOT_SUPPORTED;
> +            return;
> +        }
> +    }

Walking through the qbus tree looking for particular devices
isn't really something I'd recommend either.

thanks
-- PMM

