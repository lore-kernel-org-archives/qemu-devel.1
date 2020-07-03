Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D25B207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMcqnOht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D25B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNPi-000113-Ho
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNOg-00081Z-Vv
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:14:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNOf-0003WF-3X
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:14:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id h17so26767262oie.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uQr1ovV/77RGBgM6mZ+pg4X+QZDp7O8J+Oh2NgPuKyw=;
 b=aMcqnOhtcmwbhIlM9TGeW2qdCWe2wTJ7VuwHCug6cHMTnX4LVmxQsdPKx5feXUufx4
 SZD7j1/yzONhDJYx11GfosEFM6HHi3Qxdk3Ft4+goo5F1M0k6ioL5AltXx9eirBSdIPw
 DLvwggevnyf2Paz7pu6LTTR4kxfS8IrQRvLZfielVUkGeP19wqRfEzGJa2x9cmWWMyyo
 PRVOmpveuvM9kN/8mrR8VepwnBNvgYgK8jHb6kNP3Tvi+K7iC0BerRM8mb8Hz2xlRBaY
 Qb1y3rYegOJ/OgCobXgEKLbUm2YW3WJ7FEkH/AWbrtPXAV3H9yw4SrRP0lI2dVLrvkXD
 guaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uQr1ovV/77RGBgM6mZ+pg4X+QZDp7O8J+Oh2NgPuKyw=;
 b=IeV+HtgvubL6VhT8wo+Xs/s/2ibA4LKVc3F8OUbmTB2KD+k57jkddZV5Rmq6sVNqIp
 wuBkMtmWRzb442tVDE7oJ9GCB+xEeqsXsjdxnDGBtyxNMdxMOsVpmUGGgv+VpZDFuAGm
 rdqjalbr12AwByidFlwJpEZzogVfKA2akbcDTkde8bZCZXzcb6dUuh9BpnNhmQ/02tSS
 aputeGscDXli36KmyK1WKjwVGGBLJlkFypl+gi66fwODQXY110ScacoFzynk6j1RbCq/
 ScbiSyfGgHtntKYYitdwOdzxbrMbbw2czlQ8ChBy9p2TL62UbWPQp72kWK3dUwuogHYW
 7PbQ==
X-Gm-Message-State: AOAM530+F82eEcIt1xgX1A59NdGmIzdLZOlZMRR14ug+EPbf/cEDxupj
 NaDKCShv6JaQTof0CrCSdiZ7QmPTTK5a+gFr6yWEDVcyIoI=
X-Google-Smtp-Source: ABdhPJyNC8MaZmBn9Hi1m+C5ncRD1wNz6PKIWGIpYdoxEVsQQuMzD3tio+G254/K/ei81lLVO/00CrtBdbDMkjXQyWU=
X-Received: by 2002:aca:1706:: with SMTP id j6mr878613oii.146.1593789275595;
 Fri, 03 Jul 2020 08:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190201160653.13829-1-peter.maydell@linaro.org>
 <20190201160653.13829-36-peter.maydell@linaro.org>
 <CAFEAcA8ZgeGom6wVmCih9wY-s+kJ-yEsty_=S7+KQ_tkidN-Og@mail.gmail.com>
 <20200701151124.GD2714117@strawberry.localdomain>
In-Reply-To: <20200701151124.GD2714117@strawberry.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 16:14:24 +0100
Message-ID: <CAFEAcA9yoqfjvNMdjGoZnQ2DXvJKhNoLC5A=7mq=WfuxFzDekw@mail.gmail.com>
Subject: Re: [PULL 35/47] target/arm: Send interrupts on PMU counter overflow
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 16:11, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
> Ouch - I'm sorry this slipped through the cracks in my inbox for so
> long.
>
> I assume you mean something like:
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc9c29f998..9b917f9425 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2271,13 +2271,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .access = PL1_RW, .accessfn = access_tpm,
>        .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> -      .writefn = pmintenclr_write, },
> +      .writefn = pmintenclr_write, .raw_writefn = raw_write },
>      { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tpm,
>        .type = ARM_CP_ALIAS | ARM_CP_IO,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> -      .writefn = pmintenclr_write },
> +      .writefn = pmintenclr_write, .raw_writefn = raw_write },
>      { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
>        .access = PL1_R,

For cases like this where you have a 'set' and a 'clr' register
that really are accessing the same state under the hood, the
way to do it is:
 * the 'set' register provides the raw_readfn/raw_writefn
   as raw_read/raw_write
 * the 'clr' register adds ARM_CP_NO_RAW to its .type flags,
   which means "don't do any raw accesses to this, it doesn't
   have any underlying state that's not already synced or
   migrated via some other mechanism".

> One thing I'm trying to figure out (talking non-KVM here) is whether
> skipping calling pmu_update_irq() can mean an interrupt would not be set
> when it should have been. It looks like the ARMCPRegInfo's for
> PMINTENSET already do `.raw_writefn = raw_write`, so I suppose at least
> we would be consistent with this change. But I can never remember - is
> it guaranteed that the raw functions are only ever called when the
> interrupt state would already be taken care of separately (i.e. when
> restoring a checkpoint)?

Yes, the raw writes only happen for migration or for when
we're syncing state from a KVM kernel, so the state of
the device at the other end of the irq line should already
be correct.

thanks
-- PMM

