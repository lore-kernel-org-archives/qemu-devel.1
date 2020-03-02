Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E98AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4803E2086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb2Ovmrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8l1d-0007KE-Bh
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8l10-0006dy-4R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8l0y-0006sO-U6
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:21:45 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8l0y-0006rZ-OI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:21:44 -0500
Received: by mail-oi1-x242.google.com with SMTP id 5so4635989oiy.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lgi8huHg7JypWseRljj3J6mY8B1BwBwq3IJ94gGxoA0=;
 b=Xb2OvmrmYu9aAncfEJ3FXgchR8e6EecGnmNUXBG6Ok3T2ViMI9ws6DXys8b8jXaXXA
 /fCwfq67aZNnFJzLUFyRu8BRB3Olno2JFv+LLYDj0fTtMSvEmRWtIR43l7fiD5zCpeho
 BrnFfM1ydCr/ooWvUaB9CSa0LGj+kHAukOmREbLVr6sNbuptr+EWjnax5VDAcc87kSg7
 dIDv6x3CcUoRo6SXebg5eaNLNnkOOsAoYOBtQFOMzu8urXCXjZZjZfeTRLyxWpR2HLKm
 63KZoWfVTD5EtGSmiqkZ6yMJJQDgJS//eO/hUUVd3BgVj9axE8pAf9qb8Pi2s0Ck9uLW
 5HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lgi8huHg7JypWseRljj3J6mY8B1BwBwq3IJ94gGxoA0=;
 b=K9GdkPt1aZktTinBMxlEEWl27QijyoYDiPZt7mtRAzZ0ZVtfGxVECRg4o7gcfGJC/e
 uStzBEUUXgb00nHpMRLvH+1O87zHLG7ADShedJ5aBkPefD5PY+nY9bkPUSw/AlZPvVOX
 qLOSnP7Z86SZC35TI4rvrfqiUgcLapN8vZ7Tc7bU6pwWj81GapcLBE6LGrO3hNAj78Rj
 4ZUm6IhR5oJ4jumjDVCOmsfhfPx3MyPVqdxjjJD8Zahu38y+3wQj2N2llLO5iMfB7F60
 MwxiKPk0Cl+iBpM/M4RLdqewc1+wOwJy1ueAQq12Ho0TtUZd4v7ve/nBn2BnesMdeqWW
 YKfg==
X-Gm-Message-State: APjAAAX4s3fKS8PYlTjmME3hUG3Ve9rsbgeGKlW01WEdClLHwW3ANtlh
 ZsAWktmhW8kmUu34O6Po7zAJ7L4v9kpFUQkFm3dgRQ==
X-Google-Smtp-Source: APXvYqx3x7SoA8HTX0unJ2qMGw0FCQwU5FVWcQ9lX5pDXx29oU4SrNv9Bmmc/bGPFwznhlT09cQCqt60V9v7rUvE1vY=
X-Received: by 2002:aca:b2c5:: with SMTP id
 b188mr11625368oif.163.1583155303743; 
 Mon, 02 Mar 2020 05:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-6-pannengyuan@huawei.com>
In-Reply-To: <20200227025055.14341-6-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 13:21:32 +0000
Message-ID: <CAFEAcA8yvrYrBONtW46iswbEvMF-WC-j7fHOOfcoEC_RV66BkQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
To: Pan Nengyuan <pannengyuan@huawei.com>
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 02:35, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
> Meanwhile, add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> ---
> v2->v1:
> - no changes in this patch.
> v3->v2:
> - remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.

Hi; this is really fixing two bugs in one patch:

> ---
>  hw/misc/mac_via.c | 5 +++++
>  hw/misc/mos6522.c | 6 ++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index b7d0012794..1d72d4ef35 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -879,6 +879,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
>      sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
>                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
>
> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
> +                             &error_abort);
> +
>      /* Pass through mos6522 output IRQs */
>      ms = MOS6522(&m->mos6522_via1);
>      object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),

This is fixing a bug in mac_via where it failed to actually
realize devices it was using. That's a dependency for the bug
you're trying to fix, but it's a separate one and should be
in its own patch.

You also want to pass the error back up to the caller, rather
than using error_abort. To do that, at the top of the function:

    Error *err = NULL;

and then here you can do:
    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }

The existing code which inits the mos6522 objects and
calls object_property_add_alias on them which is in
the mac_via realize function should be moved to the init
function. (init should init child objects and set up
properties; realize should realize them.)

This is all fixing the incorrect creation of the mos6522
devices in mac_via (which has been wrong since the mac_via
was first added in commit 6dca62a0000f9), so that can all
be one patch I think.

> +static void mos6522_realize(DeviceState *dev, Error **errp)
> +{
> +    MOS6522State *s = MOS6522(dev);
>
>      s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
>      s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
> @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
>
>      dc->reset = mos6522_reset;
>      dc->vmsd = &vmstate_mos6522;
> +    dc->realize = mos6522_realize;
>      device_class_set_props(dc, mos6522_properties);
>      mdc->parent_reset = dc->reset;
>      mdc->set_sr_int = mos6522_set_sr_int;

The changes to hw/misc/mos_6522.c are good, but should be in
their own patch.

thanks
-- PMM

