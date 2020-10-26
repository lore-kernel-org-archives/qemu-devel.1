Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079DEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 893AA20715
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeoOnBhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893AA20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX56y-0004zd-FX
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX505-0006UF-38
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:05:38 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX502-0006Bf-Jb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:05:36 -0400
Received: by mail-ed1-x543.google.com with SMTP id t20so9923874edr.11
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lCi9Gjr/DQPf6exP3GPnB6zyYlY38sb7OcN+2XzABr8=;
 b=MeoOnBhHoRwwcd7mSxyPl8l6EriXLXC8b5iy3cXphxub4xY42R88hP/HoLY/K5VQPg
 9JA38NQWqt5dSHyzskHs+OPh1X4Yu6oAuf6gcSnjHMV6nE/aX31FvS3wC+vjECVs621F
 V4HLrTj/GAYmdXOVeDcyUUF4r9Zh0SICz/+okatVSHARlHq5herwu4wn2WUdkbubA/Ac
 T6yZAjVZ91O1kTBgiMqiKeAIyvxSMR2IxyZJraJs7CBgBBOiXCxMMDLTWgJ/xATALvQ8
 zuBPLAbmUXnq/guPYimsAQtPN1WaL4BozHcHx6ulRi8j42VAlHaK6dGfiiNU/OiKAlsz
 gk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lCi9Gjr/DQPf6exP3GPnB6zyYlY38sb7OcN+2XzABr8=;
 b=kqfCyCPPRH2Z8/mdPUFp3yssSqOptjfjytcudQDGbgvLVr9HoFc65YAu/6w+xEsMuh
 EmKGlFU+vqT6ezfLRg7/sJcQ8fHOK4qKtTqvGYnYvGO1c8iBLc/0aCbxGBu7lfeis0hD
 IZJqB4yz0eRmX6V4CAOytiGhBzSLb8AYMCWdreX7j2NEUmem+2aUrrmm5AEiBsYZehWO
 Q8EbfEvuRcnnyeaU085WmpfS6i+EA7zC7fpW9R3G/GGcHBuFeBJPq2urqq/QIT+Y6Rxh
 jzP90pTJHa6iezOKU6lJObXC00AuTNrblHgU7sZ9kYhrKj2c85qg9kV5DqkixCONDLC+
 JDQw==
X-Gm-Message-State: AOAM530YEfajixeglU9kC98U7fn+394UzMgAV3+hgQCjtfF4yeDJmUVK
 V8RxvDUJ3r0iGbYloWhzRxHlUvo6TUExvSCf0afTWg==
X-Google-Smtp-Source: ABdhPJx0yp4UvK1ttrORzlxwIhbOUxU1wRDHngZLXdKwrryFPkb75Iow0+hWtLcRI5DfUSPZShQF2hsJwlLgd9Z4MgI=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr8570016edr.44.1603728333003; 
 Mon, 26 Oct 2020 09:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-4-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1603369056-4168-4-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 16:05:21 +0000
Message-ID: <CAFEAcA8QdJQqkLO47+Z=N6aTX70HNaDVXjw6UTS15_qnMAyxtA@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] Versal: Connect DWC3 controller with virt-versal
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 at 13:11, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> From: Vikram Garhwal <fnu.vikram@xilinx.com>
>
> Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its placed
> in iou of lpd domain and configure it as dual port host controller. Add the
> respective guest dts nodes for "xlnx-versal-virt" machine.
>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>


> +static void versal_create_usbs(Versal *s, qemu_irq *pic)
> +{
> +    DeviceState *dev, *xhci_dev;
> +    MemoryRegion *mr;
> +
> +    object_initialize_child(OBJECT(s), "dwc3-0", &s->lpd.iou.usb.dwc3,
> +                            TYPE_USB_DWC3);
> +    dev = DEVICE(&s->lpd.iou.usb.dwc3);
> +    xhci_dev = DEVICE(&s->lpd.iou.usb.dwc3.sysbus_xhci);

If you find yourself fishing around in the internals of
another device, especially to this depth, then something's
probably not right in the structure of that device.

> +
> +    object_property_set_link(OBJECT(xhci_dev), "dma", OBJECT(&s->mr_ps),
> +                             &error_abort);
> +    qdev_prop_set_uint32(xhci_dev, "intrs", 1);
> +    qdev_prop_set_uint32(xhci_dev, "slots", 2);
> +
> +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0_DWC3_GLOBAL, mr);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(xhci_dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_USB_XHCI_0, mr);

For instance, rather than having to find the xhci device and
map its memory regions and connect its IRQs directly, the
usb-dwc3 device could provide and pass through those MRs and
IRQs, so that board code is only wiring up what the usb-dwc3
provides and doesn't need to know about its internals.


thanks
-- PMM

