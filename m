Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25772C433E3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AD2207FB
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6KW+VUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AD2207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjlk-00056v-QK
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjkh-00047P-N4
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:41:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfjkf-0004qT-HC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:41:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id a137so8739884oii.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7cQwu++5r97GefBBbzXmn7DEQRMqtA0rO8DZSn+gEpo=;
 b=G6KW+VUiLGIR6D2R8dhWyJ8YxJrD4RLr/E/DFzz22yFJ5wAB+bZmKCR/i2uIcyLIOi
 dMACfGV8ca8aJ4y3lxkva+LUdk1TwEENIYABdiJaacgPN7Knx7jgZAK5+lVKzdbtkq6q
 rrTFUbRkvY/4GhGrEsYgnP2QJfHuUE+HajOrMFws4Hg9tagFQ7uirJlC54iYCwzvt5iH
 sViC/IMgu+upMKlgJz8YuDmHM83z3k51zmdThm6nwL5WLFjJgFCeF2EguOZBcFPwzdI3
 fR0h7D9hUPVMWa1qxJiWERp1tEmcOFJzkDoKaqCnXn83Oi/39RiPi0Iz2i1pSgavA8XQ
 MxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7cQwu++5r97GefBBbzXmn7DEQRMqtA0rO8DZSn+gEpo=;
 b=hLNt1NNrC3cwb+7uFnza2U4lcOZRElmQZpC80K4R0bC5l/usKT7swWrBIVJJbrC/47
 ZANuXCNWhaqfvWi3JJp9pSjQ3pI/a55rrBdmaWPz57xTjS9XralzcFTRMaXGnLMBb0jG
 IB/plCiEn8valwN/U6h+20krFUjxa6ZjNBcBMyBBrEXZY0nf4N3f6ifcY3winqID10SN
 DzdzK4RP5TdqH2YVKQUoTXbSwVXar1B9M3hLq7KwgXg8DmBSF30ko2daRuN0HYhZR7oc
 L7FDoGJi3pyqI0htmRoJBM1H6r9g1psNDI58zA5K4gsY7bSXELq/zecp2Vpqzqum0bRU
 4Z9g==
X-Gm-Message-State: AOAM5303Velh7+a3Okp43EKuxp9O7vFObGUbqgBky2nXBmj0EbBLV+LL
 tscz7s0VXsO8vqxW2t0fWhf3vv8c3aIuYrCLp0PjoYBs4BQ=
X-Google-Smtp-Source: ABdhPJwfNRNd84DfrB4SmvQ3sbqcDHqbpxeHpjQj7M0mZ6ibGBjnuNs9d6GvujSjUTB2MpvTc4Yrzw0w/VW10iBhn28=
X-Received: by 2002:aca:5152:: with SMTP id f79mr3697194oib.146.1591015272318; 
 Mon, 01 Jun 2020 05:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200530092204.1746-1-fangying1@huawei.com>
In-Reply-To: <20200530092204.1746-1-fangying1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 13:41:01 +0100
Message-ID: <CAFEAcA91gsTpkeH6SVPoGKDFOgCJVxV=wvBOT57eagcYeMiarQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/cpu: adjust virtual time for cortex series cpu
To: Ying Fang <fangying1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 May 2020 at 10:22, Ying Fang <fangying1@huawei.com> wrote:
>
> Virtual time adjustment was implemented for virt-5.0 machine type,
> but the cpu property was enabled only for host-passthrough and
> max cpu model. Let's add it for arm cortex series cpu which has
> the gernic timer feature enabled.
>
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 32bec156f2..a564141b22 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1973,6 +1973,9 @@ static void cortex_a7_initfn(Object *obj)
>      cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
>      cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
>      define_arm_cp_regs(cpu, cortexa15_cp_reginfo); /* Same as A15 */
> +    if (kvm_enabled()) {
> +        kvm_arm_add_vcpu_properties(obj);
> +    }
>  }

If we have the same bit of code in all these initfns,
that suggests we should probably actually be doing this
in some more generic place conditional on some cpu feature
or other test. The commit message suggests we should add
this property for every CPU which is using KVM and has
the generic timers, in which case we could perhaps
have the call to kvm_arm_add_vcpu_properties moved to
arm_cpu_post_init(), and then have the kvm_arm_add_vcpu_properties
function check the ARM_FEATURE_GENERIC_TIMER flag to see
whether to add the property or not.

thanks
-- PMM

